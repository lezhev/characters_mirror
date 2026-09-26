BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_data" ADD COLUMN "weaponProficiencyKeys" json;
UPDATE "race_data"
SET "weaponProficiencyKeys" = "weaponProficiencies";
ALTER TABLE "race_data" DROP COLUMN "weaponProficiencies";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subrace_data" ADD COLUMN "weaponProficiencyKeys" json;
UPDATE "subrace_data"
SET "weaponProficiencyKeys" = "weaponProficiencies";
ALTER TABLE "subrace_data" DROP COLUMN "weaponProficiencies";

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260924095527600', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924095527600', "timestamp" = now();

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
