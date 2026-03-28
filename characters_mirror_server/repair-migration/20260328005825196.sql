BEGIN;

--
-- ACTION ALTER TABLE
--
--
-- ACTION ALTER TABLE
--
--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_feature_data" DROP CONSTRAINT "race_feature_data_fk_0";
ALTER TABLE "race_feature_data" DROP CONSTRAINT "race_feature_data_fk_1";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subrace_data" DROP CONSTRAINT "subrace_data_fk_0";
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_0"
    FOREIGN KEY("raceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_1"
    FOREIGN KEY("subraceId")
    REFERENCES "subrace_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_3"
    FOREIGN KEY("sourceRaceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_4"
    FOREIGN KEY("sourceSubraceId")
    REFERENCES "subrace_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "race_feature_data"
    ADD CONSTRAINT "race_feature_data_fk_0"
    FOREIGN KEY("raceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "race_feature_data"
    ADD CONSTRAINT "race_feature_data_fk_1"
    FOREIGN KEY("subraceId")
    REFERENCES "subrace_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subrace_data"
    ADD CONSTRAINT "subrace_data_fk_0"
    FOREIGN KEY("parentRaceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260327200318560', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260327200318560', "timestamp" = now();

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

--
-- MIGRATION VERSION FOR _repair
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('_repair', '20260328005825196', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260328005825196', "timestamp" = now();


COMMIT;
