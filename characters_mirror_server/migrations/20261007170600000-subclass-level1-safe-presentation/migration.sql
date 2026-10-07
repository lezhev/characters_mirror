BEGIN;

-- Level-1 subclass features whose mechanics are already data-driven or purely
-- descriptive. Runtime-only/partial features remain untouched.
WITH texts("referenceKey","shortDescription") AS (
  VALUES
    ('cleric_knowledge_domain_spells',
     'Заклинания домена всегда подготовлены и не учитываются в количестве подготовленных вами заклинаний жреца.'),
    ('cleric_knowledge_blessings_of_knowledge',
     'Выберите 2 языка и 2 навыка из Магии, Истории, Природы и Религии. Для выбранных навыков бонус мастерства удваивается.'),
    ('cleric_life_domain_spells',
     'Заклинания домена всегда подготовлены и не учитываются в количестве подготовленных вами заклинаний жреца.'),
    ('cleric_life_bonus_proficiency',
     'Вы получаете владение тяжёлыми доспехами.'),
    ('cleric_light_domain_spells',
     'Заклинания домена всегда подготовлены и не учитываются в количестве подготовленных вами заклинаний жреца.'),
    ('cleric_light_bonus_cantrip',
     'Вы изучаете заговор «Свет», если ещё не знаете его.'),
    ('cleric_nature_domain_spells',
     'Заклинания домена всегда подготовлены и не учитываются в количестве подготовленных вами заклинаний жреца.'),
    ('cleric_nature_acolyte_of_nature',
     'Выберите один заговор друида и получите владение одним из навыков: Уход за животными, Природа или Выживание.'),
    ('cleric_nature_bonus_proficiency',
     'Вы получаете владение тяжёлыми доспехами.'),
    ('cleric_tempest_domain_spells',
     'Заклинания домена всегда подготовлены и не учитываются в количестве подготовленных вами заклинаний жреца.'),
    ('cleric_tempest_bonus_proficiencies',
     'Вы получаете владение воинским оружием и тяжёлыми доспехами.'),
    ('cleric_trickery_domain_spells',
     'Заклинания домена всегда подготовлены и не учитываются в количестве подготовленных вами заклинаний жреца.'),
    ('cleric_war_domain_spells',
     'Заклинания домена всегда подготовлены и не учитываются в количестве подготовленных вами заклинаний жреца.'),
    ('cleric_war_bonus_proficiency',
     'Вы получаете владение воинским оружием и тяжёлыми доспехами.'),
    ('warlock_archfey_expanded_spell_list',
     'Покровитель добавляет дополнительные заклинания в список доступных вам заклинаний колдуна.'),
    ('warlock_fiend_expanded_spell_list',
     'Покровитель добавляет дополнительные заклинания в список доступных вам заклинаний колдуна.'),
    ('warlock_great_old_one_expanded_spell_list',
     'Покровитель добавляет дополнительные заклинания в список доступных вам заклинаний колдуна.'),
    ('warlock_great_old_one_awakened_mind',
     'Вы можете телепатически обращаться к видимому существу в пределах 30 футов. Общий язык не требуется, но существо должно понимать хотя бы один язык.')
)
UPDATE subclass_feature_data f
SET "shortDescription" = t."shortDescription",
    version = coalesce(f.version, 0) + 1,
    "updatedAt" = now()
FROM texts t
WHERE f."referenceKey" = t."referenceKey"
  AND f."shortDescription" IS DISTINCT FROM t."shortDescription";

DO $dark_one_preflight$
DECLARE feature_count integer;
BEGIN
  SELECT count(*) INTO feature_count
  FROM subclass_feature_data
  WHERE "referenceKey" = 'warlock_fiend_dark_ones_blessing';

  IF feature_count <> 1 THEN
    RAISE EXCEPTION
      'Expected exactly one warlock_fiend_dark_ones_blessing feature, found %',
      feature_count;
  END IF;

  IF (
    SELECT count(*)
    FROM feature_display_property_data p
    JOIN subclass_feature_data f ON f.id = p."sourceSubclassFeatureId"
    WHERE f."referenceKey" = 'warlock_fiend_dark_ones_blessing'
      AND p.key = 'temporary_hit_points'
  ) > 1 THEN
    RAISE EXCEPTION 'Duplicate Dark One''s Blessing temporary-hit-point display properties';
  END IF;
END
$dark_one_preflight$;

UPDATE feature_display_property_data p
SET label = 'Временные хиты',
    "valueKind" = 'formula',
    "staticValue" = NULL,
    progression = NULL,
    formula = 'max(1, classLevel + abilityModifier(charisma))',
    "sortOrder" = 0,
    source = f.source,
    version = coalesce(p.version, 0) + 1,
    "updatedAt" = now()
FROM subclass_feature_data f
WHERE p."sourceSubclassFeatureId" = f.id
  AND f."referenceKey" = 'warlock_fiend_dark_ones_blessing'
  AND p.key = 'temporary_hit_points';

INSERT INTO feature_display_property_data (
  "sourceSubclassFeatureId",
  key,
  label,
  "valueKind",
  formula,
  "sortOrder",
  source,
  version,
  "createdAt",
  "updatedAt"
)
SELECT
  f.id,
  'temporary_hit_points',
  'Временные хиты',
  'formula',
  'max(1, classLevel + abilityModifier(charisma))',
  0,
  f.source,
  1,
  now(),
  now()
FROM subclass_feature_data f
WHERE f."referenceKey" = 'warlock_fiend_dark_ones_blessing'
  AND NOT EXISTS (
    SELECT 1
    FROM feature_display_property_data p
    WHERE p."sourceSubclassFeatureId" = f.id
      AND p.key = 'temporary_hit_points'
  );

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
VALUES (
  'characters_mirror',
  '20261007170600000-subclass-level1-safe-presentation',
  now()
)
ON CONFLICT ("module") DO UPDATE SET
  "version" = '20261007170600000-subclass-level1-safe-presentation',
  "timestamp" = now();

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
VALUES ('serverpod', '20240516151843329', now())
ON CONFLICT ("module") DO UPDATE SET
  "version" = '20240516151843329',
  "timestamp" = now();

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
VALUES ('serverpod_auth', '20240520102713718', now())
ON CONFLICT ("module") DO UPDATE SET
  "version" = '20240520102713718',
  "timestamp" = now();

COMMIT;
