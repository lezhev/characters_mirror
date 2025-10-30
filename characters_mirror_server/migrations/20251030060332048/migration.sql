BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "alignment_data" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "armor_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "category" text,
    "baseAC" bigint,
    "dexBonus" boolean,
    "dexBonusMax" bigint,
    "strengthRequirement" bigint,
    "stealthDisadvantage" boolean,
    "weight" double precision,
    "cost" text
);

--
-- ACTION DROP TABLE
--
DROP TABLE "characters" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "characters" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "experience" bigint,
    "attributes" json,
    "raceId" bigint NOT NULL,
    "subraceId" bigint NOT NULL,
    "characterClassId" bigint NOT NULL,
    "subclassId" bigint NOT NULL,
    "backgroundId" bigint NOT NULL,
    "alignment" text,
    "armorClass" bigint,
    "speed" bigint,
    "coins" bigint,
    "skillProficiencies" json,
    "skillExpertises" json,
    "maxHp" bigint,
    "temporaryHp" bigint,
    "currentHp" bigint,
    "preparedSpellsId" bigint NOT NULL,
    "writtenSpellIdsId" bigint NOT NULL,
    "itemIdsId" bigint NOT NULL,
    "magicItemIdsId" bigint NOT NULL,
    "armorIdsId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "generic_item_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "category" text,
    "weight" double precision,
    "cost" bigint,
    "effects" json
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "magic_item_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "rarity" text,
    "type" text,
    "requiresAttunement" boolean,
    "attunementCondition" text,
    "bonus" json,
    "charges" bigint,
    "rechargeCondition" text,
    "effects" json
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_data" DROP COLUMN "archetypeName";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subrace_data" DROP COLUMN "proficiencies";
ALTER TABLE "subrace_data" ADD COLUMN "skillProficiencies" json;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_0"
    FOREIGN KEY("raceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_1"
    FOREIGN KEY("subraceId")
    REFERENCES "subrace_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_2"
    FOREIGN KEY("characterClassId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_3"
    FOREIGN KEY("subclassId")
    REFERENCES "subclass_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_4"
    FOREIGN KEY("backgroundId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_5"
    FOREIGN KEY("preparedSpellsId")
    REFERENCES "spell_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_6"
    FOREIGN KEY("writtenSpellIdsId")
    REFERENCES "spell_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_7"
    FOREIGN KEY("itemIdsId")
    REFERENCES "item_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_8"
    FOREIGN KEY("magicItemIdsId")
    REFERENCES "magic_item_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_9"
    FOREIGN KEY("armorIdsId")
    REFERENCES "armor_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251030060332048', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251030060332048', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
