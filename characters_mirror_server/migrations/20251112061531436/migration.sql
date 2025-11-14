BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "class_option_relation" CASCADE;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_option_data" DROP COLUMN "prerequisites";
ALTER TABLE "class_option_data" ADD COLUMN "parentClassId" json;
ALTER TABLE "class_option_data" ADD COLUMN "isOptional" boolean;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251112061531436', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251112061531436', "timestamp" = now();

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
