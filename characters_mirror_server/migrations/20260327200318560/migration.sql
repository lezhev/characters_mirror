BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" ADD COLUMN "age" text;
ALTER TABLE "characters" ADD COLUMN "height" text;
ALTER TABLE "characters" ADD COLUMN "weight" text;
ALTER TABLE "characters" ADD COLUMN "eyes" text;
ALTER TABLE "characters" ADD COLUMN "skin" text;
ALTER TABLE "characters" ADD COLUMN "hair" text;
ALTER TABLE "characters" ADD COLUMN "appearance" text;
ALTER TABLE "characters" ADD COLUMN "backstory" text;
ALTER TABLE "characters" ADD COLUMN "goals" text;
ALTER TABLE "characters" ADD COLUMN "alliesOrganizations" text;
ALTER TABLE "characters" ADD COLUMN "personalityTraits" text;
ALTER TABLE "characters" ADD COLUMN "ideals" text;
ALTER TABLE "characters" ADD COLUMN "bonds" text;
ALTER TABLE "characters" ADD COLUMN "flaws" text;

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


COMMIT;
