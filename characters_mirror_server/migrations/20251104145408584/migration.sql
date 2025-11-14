BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_feature_data" ADD COLUMN "name" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "class_option_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "prerequisites" json,
    "levelRequired" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "class_option_relation" (
    "id" bigserial PRIMARY KEY,
    "optionId" bigint NOT NULL,
    "classDataId" bigint NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "class_option_relation"
    ADD CONSTRAINT "class_option_relation_fk_0"
    FOREIGN KEY("optionId")
    REFERENCES "class_option_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_option_relation"
    ADD CONSTRAINT "class_option_relation_fk_1"
    FOREIGN KEY("classDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251104145408584', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251104145408584', "timestamp" = now();

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
