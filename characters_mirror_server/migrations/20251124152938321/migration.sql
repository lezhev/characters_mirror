BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_data" DROP COLUMN "powerfulBuild";
ALTER TABLE "race_data" DROP COLUMN "raceOptions";
ALTER TABLE "race_data" DROP COLUMN "ancestry";
--
-- ACTION DROP TABLE
--
DROP TABLE "race_option_data" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "race_option_data" (
    "id" bigserial PRIMARY KEY,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "raceId" bigint NOT NULL,
    "type" text,
    "uses" bigint,
    "options" json
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "race_option_data"
    ADD CONSTRAINT "race_option_data_fk_0"
    FOREIGN KEY("raceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251124152938321', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251124152938321', "timestamp" = now();

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
