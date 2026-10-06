BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_feature_data" ADD COLUMN "grantedSkills" json;
ALTER TABLE "class_feature_data" ADD COLUMN "grantedExpertiseSkills" json;
ALTER TABLE "class_feature_data" ADD COLUMN "grantedArmorTraining" json;
ALTER TABLE "class_feature_data" ADD COLUMN "grantedWeaponTraining" json;
ALTER TABLE "class_feature_data" ADD COLUMN "grantedToolKeys" json;
ALTER TABLE "class_feature_data" ADD COLUMN "grantedExpertiseToolKeys" json;
ALTER TABLE "class_feature_data" ADD COLUMN "grantedSpellKeys" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_level_data" ADD COLUMN "subclassDataId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_spell_grant_data" ADD COLUMN "choiceOptionId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "feature_resource_definition_data" ADD COLUMN "choiceOptionId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "feature_resource_effect_data" ADD COLUMN "choiceOptionId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_data" ADD COLUMN "spellcastingStartLevel" bigint;
ALTER TABLE "subclass_data" ADD COLUMN "spellcastingProgression" text;
ALTER TABLE "subclass_data" ADD COLUMN "spellSelectionMode" text;
ALTER TABLE "subclass_data" ADD COLUMN "spellcastingAbilityValue" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_feature_data" ADD COLUMN "grantedSkills" json;
ALTER TABLE "subclass_feature_data" ADD COLUMN "grantedExpertiseSkills" json;
ALTER TABLE "subclass_feature_data" ADD COLUMN "grantedLanguages" json;
ALTER TABLE "subclass_feature_data" ADD COLUMN "grantedArmorTraining" json;
ALTER TABLE "subclass_feature_data" ADD COLUMN "grantedWeaponTraining" json;
ALTER TABLE "subclass_feature_data" ADD COLUMN "grantedToolKeys" json;
ALTER TABLE "subclass_feature_data" ADD COLUMN "grantedExpertiseToolKeys" json;
ALTER TABLE "subclass_feature_data" ADD COLUMN "grantedSpellKeys" json;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "class_level_data"
    ADD CONSTRAINT "class_level_data_fk_1"
    FOREIGN KEY("subclassDataId")
    REFERENCES "subclass_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "class_spell_grant_data"
    ADD CONSTRAINT "class_spell_grant_data_fk_5"
    FOREIGN KEY("choiceOptionId")
    REFERENCES "choice_option_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "feature_resource_definition_data"
    ADD CONSTRAINT "feature_resource_definition_data_fk_3"
    FOREIGN KEY("choiceOptionId")
    REFERENCES "choice_option_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "feature_resource_effect_data"
    ADD CONSTRAINT "feature_resource_effect_data_fk_3"
    FOREIGN KEY("choiceOptionId")
    REFERENCES "choice_option_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261006152223489-feature-grant-contracts', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006152223489-feature-grant-contracts', "timestamp" = now();

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
