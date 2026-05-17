BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "spell_class_availability_data" CASCADE;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "spell_data" ADD COLUMN "availableForClassIds" json;
ALTER TABLE "spell_data" ADD COLUMN "availableForSubclassIds" json;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260516223950752', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260516223950752', "timestamp" = now();

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
