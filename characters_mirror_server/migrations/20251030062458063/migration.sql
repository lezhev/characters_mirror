BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "generic_item_data" CASCADE;

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
    "writtenSpellsId" bigint NOT NULL,
    "itemsId" bigint NOT NULL,
    "magicItemsId" bigint NOT NULL,
    "armorId" bigint NOT NULL,
    "weaponsId" bigint NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_data" ADD COLUMN "_charactersClassesCharactersId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_feature_data" ADD COLUMN "_charactersClassfeaturesCharactersId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "item_data" DROP COLUMN "type";
ALTER TABLE "item_data" DROP COLUMN "rarity";
ALTER TABLE "item_data" DROP COLUMN "effect";
ALTER TABLE "item_data" ADD COLUMN "category" text;
ALTER TABLE "item_data" ADD COLUMN "effects" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_data" ADD COLUMN "_charactersSubclassesCharactersId" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "weapon_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "category" text,
    "type" text,
    "damage" text,
    "damageType" text,
    "properties" json,
    "weight" double precision,
    "cost" text,
    "rangeNormal" bigint,
    "rangeMax" bigint
);

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
    FOREIGN KEY("backgroundId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_3"
    FOREIGN KEY("preparedSpellsId")
    REFERENCES "spell_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_4"
    FOREIGN KEY("writtenSpellsId")
    REFERENCES "spell_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_5"
    FOREIGN KEY("itemsId")
    REFERENCES "item_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_6"
    FOREIGN KEY("magicItemsId")
    REFERENCES "magic_item_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_7"
    FOREIGN KEY("armorId")
    REFERENCES "armor_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_8"
    FOREIGN KEY("weaponsId")
    REFERENCES "weapon_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "class_data"
    ADD CONSTRAINT "class_data_fk_0"
    FOREIGN KEY("_charactersClassesCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "class_feature_data"
    ADD CONSTRAINT "class_feature_data_fk_1"
    FOREIGN KEY("_charactersClassfeaturesCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subclass_data"
    ADD CONSTRAINT "subclass_data_fk_0"
    FOREIGN KEY("_charactersSubclassesCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251030062458063', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251030062458063', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
