BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_choice_data" ADD COLUMN "selectionIndex" bigint;
ALTER TABLE "character_choice_data" ADD COLUMN "selectedAbility" text;
ALTER TABLE "character_choice_data" ADD COLUMN "selectedLanguage" text;
ALTER TABLE "character_choice_data" ADD COLUMN "selectedToolKey" text;
ALTER TABLE "character_choice_data" ADD COLUMN "selectedFeatId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" ADD COLUMN "useFlexibleAbilityBonuses" boolean;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_choice_group_data" DROP CONSTRAINT "class_choice_group_data_fk_3";
ALTER TABLE "class_choice_group_data" DROP CONSTRAINT "class_choice_group_data_fk_4";
ALTER TABLE "class_choice_group_data" DROP CONSTRAINT "class_choice_group_data_fk_5";
ALTER TABLE "class_choice_group_data" ADD COLUMN "sourceSubclassFeatureId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_choice_option_data" ADD COLUMN "featId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_6"
    FOREIGN KEY("sourceBackgroundId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_3"
    FOREIGN KEY("sourceSubclassFeatureId")
    REFERENCES "subclass_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_4"
    FOREIGN KEY("sourceRaceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_5"
    FOREIGN KEY("sourceSubraceId")
    REFERENCES "subrace_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "race_choice_option_data"
    ADD CONSTRAINT "race_choice_option_data_fk_2"
    FOREIGN KEY("featId")
    REFERENCES "feat_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260402140112146', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260402140112146', "timestamp" = now();

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
