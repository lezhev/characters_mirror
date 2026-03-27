BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_feature_data" DROP COLUMN "mechanicalType";
ALTER TABLE "race_feature_data" ALTER COLUMN "raceId" DROP NOT NULL;
ALTER TABLE "race_feature_data" ALTER COLUMN "subraceId" DROP NOT NULL;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251119164808835', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251119164808835', "timestamp" = now();

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
