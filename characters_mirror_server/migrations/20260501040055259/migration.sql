BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_feature_data" ADD COLUMN "shortDescription" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_feature_data" ADD COLUMN "shortDescription" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_feature_data" ADD COLUMN "shortDescription" text;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260501040055259', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260501040055259', "timestamp" = now();

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
