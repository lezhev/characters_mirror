BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_data" DROP COLUMN "primaryAbility";
ALTER TABLE "class_data" DROP COLUMN "proficiencies";
ALTER TABLE "class_data" DROP COLUMN "hitDie";
ALTER TABLE "class_data" ADD COLUMN "proficienciesArmor" json;
ALTER TABLE "class_data" ADD COLUMN "proficienciesWeapons" json;
ALTER TABLE "class_data" ADD COLUMN "proficienciesTools" json;
ALTER TABLE "class_data" ADD COLUMN "skills" json;
ALTER TABLE "class_data" ADD COLUMN "skillCount" bigint;
ALTER TABLE "class_data" ADD COLUMN "spellcastingAbility" text;
ALTER TABLE "class_data" ADD COLUMN "startingEquipment" json;
ALTER TABLE "class_data" ADD COLUMN "hitDie" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "class_feature_data" (
    "id" bigserial PRIMARY KEY,
    "parentClassId" bigint NOT NULL,
    "level" bigint NOT NULL,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "abilityBonuses" json,
    "proficiencies" json,
    "specialAbilities" json,
    "variantOptions" json,
    "resourceName" text,
    "resourceAmount" bigint,
    "resourceRegain" text,
    "spellSlots" json
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "feat_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "abilityBonuses" json,
    "traits" json,
    "specialAbilities" json,
    "proficiencies" json,
    "prerequisites" json
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_data" ADD COLUMN "visionType" text;
ALTER TABLE "race_data" ADD COLUMN "swimSpeed" bigint;
ALTER TABLE "race_data" ADD COLUMN "climbSpeed" bigint;
ALTER TABLE "race_data" ADD COLUMN "flySpeed" bigint;
ALTER TABLE "race_data" ADD COLUMN "resistances" json;
ALTER TABLE "race_data" ADD COLUMN "skillProficiencies" json;
ALTER TABLE "race_data" ADD COLUMN "armorProficiencies" json;
ALTER TABLE "race_data" ADD COLUMN "weaponProficiencies" json;
ALTER TABLE "race_data" ADD COLUMN "toolProficiencies" json;
ALTER TABLE "race_data" ADD COLUMN "powerfulBuild" boolean;
ALTER TABLE "race_data" ADD COLUMN "specialAbilities" json;
ALTER TABLE "race_data" ADD COLUMN "ageDescription" text;
ALTER TABLE "race_data" ADD COLUMN "alignmentDescription" text;
ALTER TABLE "race_data" ADD COLUMN "physicalDescription" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subrace_data" DROP COLUMN "parentRaceId";
ALTER TABLE "subrace_data" DROP COLUMN "extraTraits";
ALTER TABLE "subrace_data" ADD COLUMN "traits" json;
ALTER TABLE "subrace_data" ADD COLUMN "specialAbilities" json;
ALTER TABLE "subrace_data" ADD COLUMN "proficiencies" json;
ALTER TABLE "subrace_data" ADD COLUMN "speedBonus" bigint;
ALTER TABLE "subrace_data" ADD COLUMN "swimSpeed" bigint;
ALTER TABLE "subrace_data" ADD COLUMN "climbSpeed" bigint;
ALTER TABLE "subrace_data" ADD COLUMN "flySpeed" bigint;
ALTER TABLE "subrace_data" ADD COLUMN "visionType" text;
ALTER TABLE "subrace_data" ADD COLUMN "resistances" json;
ALTER TABLE "subrace_data" ADD COLUMN "variantOptions" json;
ALTER TABLE "subrace_data" ADD COLUMN "ageDescription" text;
ALTER TABLE "subrace_data" ADD COLUMN "alignmentDescription" text;
ALTER TABLE "subrace_data" ADD COLUMN "physicalDescription" text;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "class_feature_data"
    ADD CONSTRAINT "class_feature_data_fk_0"
    FOREIGN KEY("parentClassId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251029152634283', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251029152634283', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
