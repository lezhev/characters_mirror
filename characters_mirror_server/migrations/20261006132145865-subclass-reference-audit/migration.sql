BEGIN;

--
-- ACTION ALTER TABLE
--
CREATE UNIQUE INDEX "class_reference_key_idx" ON "class_data" USING btree ("referenceKey");
--
-- ACTION ALTER TABLE
--
CREATE UNIQUE INDEX "class_feature_reference_key_idx" ON "class_feature_data" USING btree ("referenceKey");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_data" ADD COLUMN "referenceKey" text;
CREATE UNIQUE INDEX "subclass_reference_key_idx" ON "subclass_data" USING btree ("referenceKey");
--
-- ACTION ALTER TABLE
--
CREATE UNIQUE INDEX "subclass_feature_reference_key_idx" ON "subclass_feature_data" USING btree ("referenceKey");

-- Backfill stable subclass identities from already-stable subclass feature keys.
-- This is intentionally language-independent: display names remain presentation
-- data and are not used as semantic identifiers.
WITH subclass_keys("referenceKey", "featurePrefix") AS (
    VALUES
        ('barbarian_berserker', 'barbarian_berserker_'),
        ('barbarian_totem_warrior', 'barbarian_totem_warrior_'),
        ('bard_valor', 'bard_valor_'),
        ('bard_lore', 'bard_lore_'),
        ('cleric_tempest', 'cleric_tempest_'),
        ('cleric_war', 'cleric_war_'),
        ('cleric_life', 'cleric_life_'),
        ('cleric_knowledge', 'cleric_knowledge_'),
        ('cleric_trickery', 'cleric_trickery_'),
        ('cleric_nature', 'cleric_nature_'),
        ('cleric_light', 'cleric_light_'),
        ('druid_land', 'druid_land_'),
        ('druid_moon', 'druid_moon_'),
        ('fighter_battle_master', 'fighter_battle_master_'),
        ('fighter_eldritch_knight', 'fighter_eldritch_knight_'),
        ('fighter_champion', 'fighter_champion_'),
        ('monk_open_hand', 'monk_open_hand_'),
        ('monk_shadow', 'monk_shadow_'),
        ('monk_four_elements', 'monk_four_elements_'),
        ('paladin_devotion', 'paladin_devotion_'),
        ('paladin_ancients', 'paladin_ancients_'),
        ('paladin_vengeance', 'paladin_vengeance_'),
        ('ranger_hunter', 'ranger_hunter_'),
        ('ranger_beast_master', 'ranger_beast_master_'),
        ('rogue_thief', 'rogue_thief_'),
        ('rogue_assassin', 'rogue_assassin_'),
        ('rogue_arcane_trickster', 'rogue_arcane_trickster_'),
        ('sorcerer_draconic_bloodline', 'sorcerer_draconic_bloodline_'),
        ('sorcerer_wild_magic', 'sorcerer_wild_magic_'),
        ('warlock_archfey', 'warlock_archfey_'),
        ('warlock_fiend', 'warlock_fiend_'),
        ('warlock_great_old_one', 'warlock_great_old_one_'),
        ('wizard_evocation', 'wizard_evocation_'),
        ('wizard_conjuration', 'wizard_conjuration_'),
        ('wizard_illusion', 'wizard_illusion_'),
        ('wizard_necromancy', 'wizard_necromancy_'),
        ('wizard_abjuration', 'wizard_abjuration_'),
        ('wizard_enchantment', 'wizard_enchantment_'),
        ('wizard_transmutation', 'wizard_transmutation_'),
        ('wizard_divination', 'wizard_divination_')
)
UPDATE "subclass_data" s
SET "referenceKey" = k."referenceKey",
    "version" = COALESCE(s."version", 0) + 1,
    "updatedAt" = CURRENT_TIMESTAMP
FROM subclass_keys k
WHERE NULLIF(trim(s."referenceKey"), '') IS NULL
  AND EXISTS (
      SELECT 1
      FROM "subclass_feature_data" f
      WHERE f."parentSubclassId" = s.id
        AND f."referenceKey" LIKE k."featurePrefix" || '%'
  );

-- Parser drift: paladin oaths are chosen at level 3, matching
-- ClassData.subclassChoiceLevel and their first subclass features.
UPDATE "subclass_data" s
SET "levelRequired" = 3,
    "version" = COALESCE(s."version", 0) + 1,
    "updatedAt" = CURRENT_TIMESTAMP
WHERE s."parentClassId" = (
        SELECT id FROM "class_data" WHERE "referenceKey" = 'paladin'
    )
  AND s."levelRequired" IS DISTINCT FROM 3;

-- Parser drift: Ki-Empowered Strikes is a 6th-level monk feature in PHB 2014.
UPDATE "class_feature_data"
SET level = 6,
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = CURRENT_TIMESTAMP
WHERE "referenceKey" = 'monk_ki_empowered_strikes'
  AND level IS DISTINCT FROM 6;

-- Imported feature rows used explicit IDs and left their PostgreSQL
-- sequences behind. Repair both feature sequences before any new inserts.
SELECT setval(
    pg_get_serial_sequence('class_feature_data', 'id'),
    COALESCE((SELECT MAX(id) FROM "class_feature_data"), 0) + 1,
    false
);
SELECT setval(
    pg_get_serial_sequence('subclass_feature_data', 'id'),
    COALESCE((SELECT MAX(id) FROM "subclass_feature_data"), 0) + 1,
    false
);

-- The PHB 2014 monk catalog was missing Purity of Body entirely.
INSERT INTO "class_feature_data" (
    "parentClassId",
    name,
    "referenceKey",
    description,
    "shortDescription",
    level,
    source,
    version,
    "createdAt",
    "updatedAt"
)
SELECT
    c.id,
    'Чистота тела',
    'monk_purity_of_body',
    'На 10 уровне мастерство ци делает монаха невосприимчивым к болезням и ядам.',
    'Иммунитет к болезням и ядам.',
    10,
    'PHB 2014',
    1,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM "class_data" c
WHERE c."referenceKey" = 'monk'
  AND NOT EXISTS (
      SELECT 1
      FROM "class_feature_data" f
      WHERE f."referenceKey" = 'monk_purity_of_body'
  );

-- These optional class features come from Tasha's Cauldron of Everything,
-- not PHB 2014. Keep the rows, but fix their source metadata.
UPDATE "class_feature_data"
SET source = 'Tasha''s Cauldron of Everything',
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = CURRENT_TIMESTAMP
WHERE "referenceKey" IN (
    'barbarian_instinctive_pounce',
    'sorcerer_sorcerous_versatility',
    'sorcerer_magical_guidance'
)
  AND source IS DISTINCT FROM 'Tasha''s Cauldron of Everything';

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261006132145865-subclass-reference-audit', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006132145865-subclass-reference-audit', "timestamp" = now();

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
