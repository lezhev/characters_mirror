BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "spell_class_availability_data" DROP CONSTRAINT "spell_class_availability_data_fk_2";
ALTER TABLE "spell_class_availability_data" DROP COLUMN "_spellDataClassavailabilitySpellDataId";

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260328140501398', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260328140501398', "timestamp" = now();

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
