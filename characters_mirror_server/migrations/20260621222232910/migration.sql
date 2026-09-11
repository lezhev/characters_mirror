BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" ADD COLUMN "customInitiativeBonus" bigint;
ALTER TABLE "characters" ADD COLUMN "customArmorClassBonus" bigint;
ALTER TABLE "characters" ADD COLUMN "walkingSpeed" bigint;
ALTER TABLE "characters" ADD COLUMN "swimmingSpeed" bigint;
ALTER TABLE "characters" ADD COLUMN "climbingSpeed" bigint;
ALTER TABLE "characters" ADD COLUMN "flyingSpeed" bigint;
ALTER TABLE "characters" ADD COLUMN "displayedSpeedKind" bigint;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260621222232910', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260621222232910', "timestamp" = now();

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
