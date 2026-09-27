BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "race_choice_set_data" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "race_choice_option_data" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "class_choice_option_data" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "class_choice_group_data" CASCADE;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260926194654038', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260926194654038', "timestamp" = now();

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
