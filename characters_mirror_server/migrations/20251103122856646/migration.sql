BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "armor_data" DROP CONSTRAINT "armor_data_fk_0";
ALTER TABLE "armor_data" DROP COLUMN "_classDataProficienciesarmorClassDataId";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_data" ADD COLUMN "proficienciesArmor" json;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251103122856646', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251103122856646', "timestamp" = now();

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
