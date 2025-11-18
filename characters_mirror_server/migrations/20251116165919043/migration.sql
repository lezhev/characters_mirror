BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "race_feature_data" (
    "id" bigserial PRIMARY KEY,
    "raceId" bigint NOT NULL,
    "subraceId" bigint NOT NULL,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "level" bigint,
    "mechanicalType" text,
    "spells" json,
    "usesPerRest" text,
    "usesFormula" text
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_data" DROP CONSTRAINT "subclass_data_fk_1";
ALTER TABLE "subclass_data" DROP COLUMN "subclassFeaturesId";
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "race_feature_data"
    ADD CONSTRAINT "race_feature_data_fk_0"
    FOREIGN KEY("raceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "race_feature_data"
    ADD CONSTRAINT "race_feature_data_fk_1"
    FOREIGN KEY("subraceId")
    REFERENCES "subrace_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251116165919043', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251116165919043', "timestamp" = now();

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
