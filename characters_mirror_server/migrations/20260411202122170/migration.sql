BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "weapon_data" DROP COLUMN "damageTypeValue";
ALTER TABLE "weapon_data" ADD COLUMN "damageType" text;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260411202122170', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260411202122170', "timestamp" = now();

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
