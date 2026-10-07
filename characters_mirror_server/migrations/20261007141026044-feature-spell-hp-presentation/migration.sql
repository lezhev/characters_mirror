BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "feature_modifier_data" ADD COLUMN "spellKey" text;
ALTER TABLE "feature_modifier_data" ADD COLUMN "minimumCastLevel" bigint;

-- Three-feature presentation backfill. No character/resource rows are changed.
DO $feature_preflight$
DECLARE feature_key text; feature_count integer;
BEGIN
  LOCK TABLE class_feature_data, subclass_feature_data IN SHARE ROW EXCLUSIVE MODE;
  FOREACH feature_key IN ARRAY ARRAY[
    'cleric_life_disciple_of_life',
    'sorcerer_draconic_bloodline_draconic_resilience',
    'cleric_tempest_wrath_of_the_storm'
  ] LOOP
    SELECT count(*) INTO feature_count FROM (
      SELECT id FROM class_feature_data WHERE "referenceKey" = feature_key
      UNION ALL
      SELECT id FROM subclass_feature_data WHERE "referenceKey" = feature_key
    ) sources;
    IF feature_count <> 1 OR
       (SELECT count(*) FROM subclass_feature_data WHERE "referenceKey" = feature_key) <> 1 THEN
      RAISE EXCEPTION 'Expected exactly one subclass feature for %, found %', feature_key, feature_count;
    END IF;
  END LOOP;
  IF EXISTS (
    SELECT 1 FROM feature_modifier_data m
    WHERE (m."referenceKey" = 'cleric_life_disciple_of_life.spell_healing' AND
      (m."classFeatureId" IS NOT NULL OR m."subclassFeatureId" IS DISTINCT FROM
        (SELECT id FROM subclass_feature_data WHERE "referenceKey" = 'cleric_life_disciple_of_life')))
    OR (m."referenceKey" = 'sorcerer_draconic_resilience.hit_point_maximum' AND
      (m."classFeatureId" IS NOT NULL OR m."subclassFeatureId" IS DISTINCT FROM
        (SELECT id FROM subclass_feature_data WHERE "referenceKey" = 'sorcerer_draconic_bloodline_draconic_resilience')))
  ) THEN
    RAISE EXCEPTION 'Modifier reference key belongs to an unexpected source';
  END IF;
  IF (SELECT count(*) FROM feature_display_property_data p JOIN subclass_feature_data f
      ON p."sourceSubclassFeatureId" = f.id
      WHERE f."referenceKey" = 'cleric_tempest_wrath_of_the_storm' AND p.key = 'damage') > 1 THEN
    RAISE EXCEPTION 'Duplicate Wrath of the Storm damage display properties';
  END IF;
END
$feature_preflight$;

-- Enums retain their original byIndex serialization; new values are appended.
INSERT INTO feature_modifier_data (
  "referenceKey", "subclassFeatureId", target, operation, value,
  "spellKey", "minimumCastLevel", source, version, "createdAt", "updatedAt"
)
SELECT 'cleric_life_disciple_of_life.spell_healing', id, 6, 0,
  '{"kind":4,"staticValue":2}'::jsonb, NULL, 1, source, 1, now(), now()
FROM subclass_feature_data WHERE "referenceKey" = 'cleric_life_disciple_of_life'
ON CONFLICT ("referenceKey") DO UPDATE SET
  target = EXCLUDED.target, operation = EXCLUDED.operation, value = EXCLUDED.value,
  "spellKey" = EXCLUDED."spellKey", "minimumCastLevel" = EXCLUDED."minimumCastLevel",
  version = coalesce(feature_modifier_data.version, 0) + 1, "updatedAt" = now();

INSERT INTO feature_modifier_data (
  "referenceKey", "subclassFeatureId", target, operation, value,
  source, version, "createdAt", "updatedAt"
)
SELECT 'sorcerer_draconic_resilience.hit_point_maximum', id, 5, 0,
  jsonb_build_object('kind', 1, 'progression',
    (SELECT jsonb_agg(jsonb_build_object('k', level, 'v', level) ORDER BY level)
       FROM generate_series(1, 20) AS level)), source, 1, now(), now()
FROM subclass_feature_data WHERE "referenceKey" = 'sorcerer_draconic_bloodline_draconic_resilience'
ON CONFLICT ("referenceKey") DO UPDATE SET
  target = EXCLUDED.target, operation = EXCLUDED.operation, value = EXCLUDED.value,
  version = coalesce(feature_modifier_data.version, 0) + 1, "updatedAt" = now();

UPDATE feature_display_property_data p SET
  label = 'Урон', "valueKind" = 'formula', formula = '2d8',
  "staticValue" = NULL, progression = NULL, "sortOrder" = 0,
  version = coalesce(p.version, 0) + 1, "updatedAt" = now()
FROM subclass_feature_data f
WHERE p."sourceSubclassFeatureId" = f.id AND p.key = 'damage'
  AND f."referenceKey" = 'cleric_tempest_wrath_of_the_storm';

INSERT INTO feature_display_property_data (
  "sourceSubclassFeatureId", key, label, "valueKind", formula, "sortOrder",
  source, version, "createdAt", "updatedAt"
)
SELECT id, 'damage', 'Урон', 'formula', '2d8', 0, source, 1, now(), now()
FROM subclass_feature_data f WHERE "referenceKey" = 'cleric_tempest_wrath_of_the_storm'
  AND NOT EXISTS (SELECT 1 FROM feature_display_property_data p
    WHERE p."sourceSubclassFeatureId" = f.id AND p.key = 'damage');

-- Preserve reference wording; remove only the numeric dice from full prose.
UPDATE subclass_feature_data SET
  description = replace(description, '2к8 урона', 'урон'),
  "shortDescription" = 'Если существо в пределах 5 футов от вас, которое вы можете видеть, успешно попадает по вам атакой, вы можете реакцией заставить существо совершить спасбросок Ловкости. Существо получает урон звуком или электричеством (по вашему выбору), если провалит спасбросок, и половину этого урона если преуспеет.',
  version = coalesce(version, 0) + 1, "updatedAt" = now()
WHERE "referenceKey" = 'cleric_tempest_wrath_of_the_storm';

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261007141026044-feature-spell-hp-presentation', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007141026044-feature-spell-hp-presentation', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
