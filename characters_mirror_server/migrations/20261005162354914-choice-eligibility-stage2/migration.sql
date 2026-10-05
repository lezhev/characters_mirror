BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "choice_option_data" ADD COLUMN "requirements" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_data" ADD COLUMN "referenceKey" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_feature_data" ADD COLUMN "referenceKey" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_feature_data" ADD COLUMN "referenceKey" text;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261005162354914-choice-eligibility-stage2', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261005162354914-choice-eligibility-stage2', "timestamp" = now();

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
