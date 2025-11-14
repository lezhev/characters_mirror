BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_data" DROP COLUMN "subclassFeatures";
ALTER TABLE "subclass_data" ADD COLUMN "subclassFeaturesId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subclass_data"
    ADD CONSTRAINT "subclass_data_fk_1"
    FOREIGN KEY("subclassFeaturesId")
    REFERENCES "subclass_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251114042041775', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251114042041775', "timestamp" = now();

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
