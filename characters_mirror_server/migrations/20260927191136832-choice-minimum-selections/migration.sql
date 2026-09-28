BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "choice_group_data" ADD COLUMN "minimumSelectionCount" bigint;

UPDATE "choice_group_data"
SET "minimumSelectionCount" = 2,
    "description" = 'Выберите два навыка или один навык и владение воровскими инструментами.'
WHERE "referenceKey" = 'class_feature_92_expertise';

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260927191136832-choice-minimum-selections', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260927191136832-choice-minimum-selections', "timestamp" = now();

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
