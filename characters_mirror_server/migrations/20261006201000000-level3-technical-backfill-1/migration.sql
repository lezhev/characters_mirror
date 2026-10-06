BEGIN;

-- Level 1-3 technical reference-data backfill, batch 1.
-- Descriptive fields are intentionally untouched.

-- Fixed feature grants.
UPDATE "subclass_feature_data"
SET "grantedArmorTraining" = '["medium","shield"]'::json,
    "grantedWeaponTraining" = '["martialMelee","martialRanged"]'::json,
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "referenceKey" = 'bard_valor_bonus_proficiencies'
  AND (
    "grantedArmorTraining"::jsonb IS DISTINCT FROM '["medium","shield"]'::jsonb OR
    "grantedWeaponTraining"::jsonb IS DISTINCT FROM '["martialMelee","martialRanged"]'::jsonb
  );

UPDATE "subclass_feature_data"
SET "grantedArmorTraining" = '["heavy"]'::json,
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "referenceKey" IN (
  'cleric_life_bonus_proficiency',
  'cleric_nature_bonus_proficiency'
)
  AND "grantedArmorTraining"::jsonb IS DISTINCT FROM '["heavy"]'::jsonb;

UPDATE "subclass_feature_data"
SET "grantedArmorTraining" = '["heavy"]'::json,
    "grantedWeaponTraining" = '["martialMelee","martialRanged"]'::json,
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "referenceKey" IN (
  'cleric_tempest_bonus_proficiencies',
  'cleric_war_bonus_proficiency'
)
  AND (
    "grantedArmorTraining"::jsonb IS DISTINCT FROM '["heavy"]'::jsonb OR
    "grantedWeaponTraining"::jsonb IS DISTINCT FROM '["martialMelee","martialRanged"]'::jsonb
  );

UPDATE "subclass_feature_data"
SET "grantedToolKeys" = '["disguise_kit","poisoner_kit"]'::json,
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "referenceKey" = 'rogue_assassin_bonus_proficiencies'
  AND "grantedToolKeys"::jsonb IS DISTINCT FROM '["disguise_kit","poisoner_kit"]'::jsonb;

UPDATE "subclass_feature_data"
SET "grantedSpellKeys" = '["light"]'::json,
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "referenceKey" = 'cleric_light_bonus_cantrip'
  AND "grantedSpellKeys"::jsonb IS DISTINCT FROM '["light"]'::jsonb;

-- Obvious source-text typo only; no descriptive rewriting.
UPDATE "subclass_feature_data"
SET name = 'Заклинания клятвы преданности',
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "referenceKey" = 'paladin_devotion_oath_spells'
  AND name = 'Заклинания клятвы предонности';

-- Cleric 1st-level domain spells: always prepared.
WITH grants("featureKey", "spellKey", "grantedAtLevel") AS (
  VALUES
    ('cleric_knowledge_domain_spells', 'command', 1),
    ('cleric_knowledge_domain_spells', 'identify', 1),
    ('cleric_life_domain_spells', 'bless', 1),
    ('cleric_life_domain_spells', 'cure_wounds', 1),
    ('cleric_light_domain_spells', 'burning_hands', 1),
    ('cleric_light_domain_spells', 'faerie_fire', 1),
    ('cleric_nature_domain_spells', 'animal_friendship', 1),
    ('cleric_nature_domain_spells', 'speak_with_animals', 1),
    ('cleric_tempest_domain_spells', 'fog_cloud', 1),
    ('cleric_tempest_domain_spells', 'thunderwave', 1),
    ('cleric_trickery_domain_spells', 'charm_person', 1),
    ('cleric_trickery_domain_spells', 'disguise_self', 1),
    ('cleric_war_domain_spells', 'divine_favor', 1),
    ('cleric_war_domain_spells', 'shield_of_faith', 1)
)
INSERT INTO "class_spell_grant_data" (
  "spellId",
  "sourceSubclassFeatureId",
  "grantedAtLevel",
  "alwaysPrepared",
  source,
  version,
  "createdAt",
  "updatedAt"
)
SELECT
  spell.id,
  feature.id,
  grants."grantedAtLevel",
  true,
  'PHB 2014',
  1,
  now(),
  now()
FROM grants
JOIN "subclass_feature_data" feature
  ON feature."referenceKey" = grants."featureKey"
JOIN "spell_data" spell
  ON spell."referenceKey" = grants."spellKey"
WHERE NOT EXISTS (
  SELECT 1
  FROM "class_spell_grant_data" existing
  WHERE existing."sourceSubclassFeatureId" = feature.id
    AND existing."spellId" = spell.id
    AND COALESCE(existing."grantedAtLevel", 1) = grants."grantedAtLevel"
    AND existing."alwaysPrepared" IS TRUE
);

-- Paladin 3rd-level oath spells: always prepared.
WITH grants("featureKey", "spellKey", "grantedAtLevel") AS (
  VALUES
    ('paladin_devotion_oath_spells', 'protection_from_evil_and_good', 3),
    ('paladin_devotion_oath_spells', 'sanctuary', 3),
    ('paladin_ancients_oath_spells', 'ensnaring_strike', 3),
    ('paladin_ancients_oath_spells', 'speak_with_animals', 3),
    ('paladin_vengeance_oath_spells', 'bane', 3),
    ('paladin_vengeance_oath_spells', 'hunters_mark', 3)
)
INSERT INTO "class_spell_grant_data" (
  "spellId",
  "sourceSubclassFeatureId",
  "grantedAtLevel",
  "alwaysPrepared",
  source,
  version,
  "createdAt",
  "updatedAt"
)
SELECT
  spell.id,
  feature.id,
  grants."grantedAtLevel",
  true,
  'PHB 2014',
  1,
  now(),
  now()
FROM grants
JOIN "subclass_feature_data" feature
  ON feature."referenceKey" = grants."featureKey"
JOIN "spell_data" spell
  ON spell."referenceKey" = grants."spellKey"
WHERE NOT EXISTS (
  SELECT 1
  FROM "class_spell_grant_data" existing
  WHERE existing."sourceSubclassFeatureId" = feature.id
    AND existing."spellId" = spell.id
    AND COALESCE(existing."grantedAtLevel", 1) = grants."grantedAtLevel"
    AND existing."alwaysPrepared" IS TRUE
);

-- MIGRATION VERSION FOR characters_mirror
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
VALUES ('characters_mirror', '20261006201000000-level3-technical-backfill-1', now())
ON CONFLICT ("module")
DO UPDATE SET
  "version" = '20261006201000000-level3-technical-backfill-1',
  "timestamp" = now();

COMMIT;
