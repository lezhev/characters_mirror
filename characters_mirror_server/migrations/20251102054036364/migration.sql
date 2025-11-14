BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_data" DROP CONSTRAINT "subclass_data_fk_0";
ALTER TABLE "subclass_data" ALTER COLUMN "parentClassId" SET NOT NULL;
--
-- ACTION DROP TABLE
--
DROP TABLE "subrace_data" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "subrace_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "parentRaceId" bigint NOT NULL,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "abilityBonuses" json,
    "traits" json,
    "specialAbilities" json,
    "skillProficiencies" json,
    "speedBonus" bigint,
    "swimSpeed" bigint,
    "climbSpeed" bigint,
    "flySpeed" bigint,
    "visionType" text,
    "resistances" json,
    "variantOptions" json,
    "ageDescription" text,
    "alignmentDescription" text,
    "physicalDescription" text
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subclass_data"
    ADD CONSTRAINT "subclass_data_fk_1"
    FOREIGN KEY("_charactersSubclassesCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "subclass_data"
    ADD CONSTRAINT "subclass_data_fk_0"
    FOREIGN KEY("parentClassId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subrace_data"
    ADD CONSTRAINT "subrace_data_fk_0"
    FOREIGN KEY("parentRaceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251102054036364', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251102054036364', "timestamp" = now();

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
