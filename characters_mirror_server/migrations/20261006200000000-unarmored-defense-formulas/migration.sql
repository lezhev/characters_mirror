BEGIN;

-- Reference data only: do not rely on imported numeric feature IDs.
WITH rules("featureKey", "classKey", "secondaryAbility", "noShield", "rule") AS (
    VALUES
      ('barbarian_unarmored_defense', 'barbarian', 'constitution', false, 'dexterityConstitution'),
      ('monk_unarmored_defense', 'monk', 'wisdom', true, 'dexterityWisdom')
)
UPDATE "class_feature_data" feature
SET "level" = 1,
    "unarmoredDefenseRule" = rules."rule",
    "version" = COALESCE(feature."version", 0) + 1,
    "updatedAt" = now()
FROM rules, "class_data" class
WHERE feature."referenceKey" = rules."featureKey"
  AND feature."parentClassId" = class."id"
  AND class."referenceKey" = rules."classKey"
  AND (feature."level" IS DISTINCT FROM 1 OR feature."unarmoredDefenseRule" IS DISTINCT FROM rules."rule");

WITH rules("featureKey", "classKey", "secondaryAbility", "noShield") AS (
    VALUES
      ('barbarian_unarmored_defense', 'barbarian', 'constitution', false),
      ('monk_unarmored_defense', 'monk', 'wisdom', true)
)
INSERT INTO "feature_modifier_data" (
    "referenceKey", "classFeatureId", "target", "operation", "value", "conditions",
    "source", "version", "createdAt", "updatedAt"
)
SELECT rules."featureKey" || '.armor_class', feature."id", 2, 1,
    json_build_object('kind', 0, 'staticValue', 10,
      'abilityModifiers', json_build_array('dexterity', rules."secondaryAbility")),
    CASE WHEN rules."noShield" THEN '[{"type":0},{"type":1}]'::json ELSE '[{"type":0}]'::json END,
    'phb2014-unarmored-defense', 1, now(), now()
FROM rules
JOIN "class_feature_data" feature ON feature."referenceKey" = rules."featureKey"
JOIN "class_data" class ON class."id" = feature."parentClassId" AND class."referenceKey" = rules."classKey"
ON CONFLICT ("referenceKey") DO UPDATE SET
    "classFeatureId" = EXCLUDED."classFeatureId", "subclassFeatureId" = NULL,
    "target" = EXCLUDED."target", "operation" = EXCLUDED."operation",
    "value" = EXCLUDED."value", "conditions" = EXCLUDED."conditions",
    "source" = EXCLUDED."source", "version" = COALESCE("feature_modifier_data"."version", 0) + 1,
    "updatedAt" = now();

-- MIGRATION VERSION FOR characters_mirror
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261006200000000-unarmored-defense-formulas', now())
    ON CONFLICT ("module") DO UPDATE SET "version" = '20261006200000000-unarmored-defense-formulas', "timestamp" = now();

COMMIT;
