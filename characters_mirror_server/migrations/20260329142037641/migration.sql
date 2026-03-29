BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "armor_data" DROP COLUMN "categoryValue";
ALTER TABLE "armor_data" ADD COLUMN "categoryValue" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_choice_data" DROP COLUMN "sourceType";
ALTER TABLE "character_choice_data" ADD COLUMN "sourceType" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_class_relation" DROP COLUMN "hpMode";
ALTER TABLE "character_class_relation" ADD COLUMN "hpMode" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" DROP COLUMN "alignmentValue";
ALTER TABLE "characters" ADD COLUMN "alignmentValue" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_choice_group_data" DROP COLUMN "type";
ALTER TABLE "class_choice_group_data" ADD COLUMN "type" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_data" DROP COLUMN "spellcastingProgression";
ALTER TABLE "class_data" DROP COLUMN "spellcastingAbilityValue";
ALTER TABLE "class_data" ADD COLUMN "spellcastingProgression" text;
ALTER TABLE "class_data" ADD COLUMN "spellcastingAbilityValue" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "dragonborn_ancestry_data" DROP COLUMN "saveAbility";
ALTER TABLE "dragonborn_ancestry_data" ADD COLUMN "saveAbility" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_choice_set_data" DROP COLUMN "kind";
ALTER TABLE "race_choice_set_data" ADD COLUMN "kind" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_feature_spell_grant_data" DROP COLUMN "castingAbility";
ALTER TABLE "race_feature_spell_grant_data" DROP COLUMN "freeCastsPerRest";
ALTER TABLE "race_feature_spell_grant_data" ADD COLUMN "castingAbility" text;
ALTER TABLE "race_feature_spell_grant_data" ADD COLUMN "freeCastsPerRest" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "weapon_data" DROP COLUMN "category";
ALTER TABLE "weapon_data" DROP COLUMN "damageTypeValue";
ALTER TABLE "weapon_data" ADD COLUMN "category" text;
ALTER TABLE "weapon_data" ADD COLUMN "damageTypeValue" text;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260329142037641', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260329142037641', "timestamp" = now();

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
