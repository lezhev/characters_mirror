BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dragonborn_ancestry_data" (
    "id" bigserial PRIMARY KEY,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "name" text,
    "damageType" text,
    "breathShape" text,
    "area" text,
    "damageByLevel" json
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_data" DROP COLUMN "swimSpeed";
ALTER TABLE "race_data" DROP COLUMN "climbSpeed";
ALTER TABLE "race_data" DROP COLUMN "flySpeed";
ALTER TABLE "race_data" DROP COLUMN "specialAbilities";
ALTER TABLE "race_data" DROP COLUMN "ageDescription";
ALTER TABLE "race_data" DROP COLUMN "alignmentDescription";
ALTER TABLE "race_data" DROP COLUMN "physicalDescription";
ALTER TABLE "race_data" ADD COLUMN "raceOptions" json;
ALTER TABLE "race_data" ADD COLUMN "ancestry" json;
ALTER TABLE "race_data" ADD COLUMN "spellcasting" json;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "race_option_data" (
    "id" bigserial PRIMARY KEY,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "type" text,
    "uses" bigint,
    "options" json
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "subrace_data" DROP COLUMN "speedBonus";
ALTER TABLE "subrace_data" DROP COLUMN "swimSpeed";
ALTER TABLE "subrace_data" DROP COLUMN "climbSpeed";
ALTER TABLE "subrace_data" DROP COLUMN "flySpeed";
ALTER TABLE "subrace_data" DROP COLUMN "visionType";
ALTER TABLE "subrace_data" DROP COLUMN "ageDescription";
ALTER TABLE "subrace_data" DROP COLUMN "alignmentDescription";
ALTER TABLE "subrace_data" DROP COLUMN "physicalDescription";
ALTER TABLE "subrace_data" DROP COLUMN "variantOptions";
ALTER TABLE "subrace_data" ADD COLUMN "variantOptions" json;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251120180453384', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251120180453384', "timestamp" = now();

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
