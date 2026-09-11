BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" ADD COLUMN "customSpellSaveDcBonus" bigint;
ALTER TABLE "characters" ADD COLUMN "customSpellAttackBonus" bigint;
ALTER TABLE "characters" ADD COLUMN "preparedSpellKeys" json;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260518213743310', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260518213743310', "timestamp" = now();

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
