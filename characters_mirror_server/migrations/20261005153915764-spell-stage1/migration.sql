BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_data" ADD COLUMN "spellSelectionMode" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_level_data" ADD COLUMN "spellbookSpells" bigint;
ALTER TABLE "class_level_data" ADD COLUMN "knownSpellReplacements" bigint;
ALTER TABLE "class_level_data" ADD COLUMN "preparedSpellRule" json;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261005153915764-spell-stage1', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261005153915764-spell-stage1', "timestamp" = now();

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
