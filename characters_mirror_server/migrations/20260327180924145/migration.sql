BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "armor_data" ADD COLUMN "categoryValue" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "character_choice_data" (
    "id" bigserial PRIMARY KEY,
    "characterId" bigint NOT NULL,
    "classEntryId" bigint,
    "sourceType" bigint,
    "sourceId" bigint,
    "groupKey" text,
    "optionKey" text,
    "selectedSpellKey" text,
    "selectedItemKey" text,
    "selectedText" text,
    "selectedCount" bigint
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_class_relation" ADD COLUMN "isStartingClass" boolean;
ALTER TABLE "character_class_relation" ADD COLUMN "classOrder" bigint;
ALTER TABLE "character_class_relation" ADD COLUMN "hpMode" bigint;
ALTER TABLE "character_class_relation" ADD COLUMN "hpRolledValues" json;
ALTER TABLE "character_class_relation" ADD COLUMN "notes" text;
ALTER TABLE "character_class_relation" ALTER COLUMN "subclassId" DROP NOT NULL;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "character_sheet_snapshot_data" (
    "id" bigserial PRIMARY KEY,
    "characterId" bigint NOT NULL,
    "totalLevel" bigint,
    "proficiencyBonus" bigint,
    "armorClass" bigint,
    "initiative" bigint,
    "speed" bigint,
    "maxHp" bigint,
    "passivePerception" bigint,
    "passiveInvestigation" bigint,
    "passiveInsight" bigint,
    "savingThrowBonuses" json,
    "skillBonuses" json,
    "spellSlots" json,
    "pactSlots" json,
    "hitDiceSummary" json,
    "senses" json,
    "resistances" json,
    "sheetVersion" bigint,
    "rebuiltAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "character_sheet_snapshot_character_idx" ON "character_sheet_snapshot_data" USING btree ("characterId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_2";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_3";
ALTER TABLE "characters" ADD COLUMN "alignmentValue" bigint;
ALTER TABLE "characters" ADD COLUMN "baseAbilityScores" json;
ALTER TABLE "characters" ADD COLUMN "inspiration" boolean;
ALTER TABLE "characters" ADD COLUMN "notes" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "class_choice_group_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "sourceClassId" bigint,
    "sourceSubclassId" bigint,
    "sourceFeatureId" bigint,
    "sourceRaceId" bigint,
    "sourceSubraceId" bigint,
    "sourceBackgroundId" bigint,
    "level" bigint,
    "type" bigint,
    "selectionCount" bigint,
    "appliesAtCharacterLevel" boolean,
    "exclusiveKey" text,
    "allowDuplicates" boolean,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "class_choice_option_data" (
    "id" bigserial PRIMARY KEY,
    "choiceGroupId" bigint NOT NULL,
    "optionKey" text,
    "name" text,
    "description" text,
    "grantedAbilityBonuses" json,
    "grantedSkills" json,
    "grantedLanguages" json,
    "grantedArmorTraining" json,
    "grantedWeaponTraining" json,
    "grantedToolKeys" json,
    "grantedItemKeys" json,
    "grantedSpellKeys" json,
    "grantedFeatureTags" json,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_data" ADD COLUMN "hitDieValue" bigint;
ALTER TABLE "class_data" ADD COLUMN "primaryAbilities" json;
ALTER TABLE "class_data" ADD COLUMN "savingThrowProficiencies" json;
ALTER TABLE "class_data" ADD COLUMN "armorTraining" json;
ALTER TABLE "class_data" ADD COLUMN "weaponTraining" json;
ALTER TABLE "class_data" ADD COLUMN "toolTraining" json;
ALTER TABLE "class_data" ADD COLUMN "availableSkills" json;
ALTER TABLE "class_data" ADD COLUMN "subclassChoiceLevel" bigint;
ALTER TABLE "class_data" ADD COLUMN "spellcastingProgression" bigint;
ALTER TABLE "class_data" ADD COLUMN "spellcastingAbilityValue" bigint;
ALTER TABLE "class_data" ADD COLUMN "multiclassPrerequisites" json;
ALTER TABLE "class_data" ADD COLUMN "multiclassArmorTraining" json;
ALTER TABLE "class_data" ADD COLUMN "multiclassWeaponTraining" json;
ALTER TABLE "class_data" ADD COLUMN "multiclassToolTraining" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_feature_data" ADD COLUMN "tags" json;
ALTER TABLE "class_feature_data" ADD COLUMN "choiceGroupKey" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "class_level_data" (
    "id" bigserial PRIMARY KEY,
    "classDataId" bigint NOT NULL,
    "level" bigint NOT NULL,
    "featureIds" json,
    "subclassFeatureIds" json,
    "knownCantrips" bigint,
    "knownSpells" bigint,
    "preparedSpellFormula" text,
    "resourceSummary" text,
    "spellSlots" json,
    "notes" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "feat_data" ADD COLUMN "tags" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_feature_data" ADD COLUMN "tags" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "spell_data" ADD COLUMN "schoolValue" bigint;
ALTER TABLE "spell_data" ADD COLUMN "availableForClassIds" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_feature_data" ADD COLUMN "tags" json;
ALTER TABLE "subclass_feature_data" ADD COLUMN "choiceGroupKey" text;
ALTER TABLE "subclass_feature_data" ALTER COLUMN "knownSpells" DROP NOT NULL;
ALTER TABLE "subclass_feature_data" ALTER COLUMN "knownCantips" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "weapon_data" ADD COLUMN "category" bigint;
ALTER TABLE "weapon_data" ADD COLUMN "damageTypeValue" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "character_choice_data"
    ADD CONSTRAINT "character_choice_data_fk_0"
    FOREIGN KEY("characterId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_choice_data"
    ADD CONSTRAINT "character_choice_data_fk_1"
    FOREIGN KEY("classEntryId")
    REFERENCES "character_class_relation"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "character_sheet_snapshot_data"
    ADD CONSTRAINT "character_sheet_snapshot_data_fk_0"
    FOREIGN KEY("characterId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_2"
    FOREIGN KEY("backgroundId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_3"
    FOREIGN KEY("subclassId")
    REFERENCES "subclass_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_0"
    FOREIGN KEY("sourceClassId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_1"
    FOREIGN KEY("sourceSubclassId")
    REFERENCES "subclass_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_2"
    FOREIGN KEY("sourceFeatureId")
    REFERENCES "class_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_3"
    FOREIGN KEY("sourceRaceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_4"
    FOREIGN KEY("sourceSubraceId")
    REFERENCES "subrace_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_5"
    FOREIGN KEY("sourceBackgroundId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "class_choice_option_data"
    ADD CONSTRAINT "class_choice_option_data_fk_0"
    FOREIGN KEY("choiceGroupId")
    REFERENCES "class_choice_group_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "class_level_data"
    ADD CONSTRAINT "class_level_data_fk_0"
    FOREIGN KEY("classDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260327180924145', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260327180924145', "timestamp" = now();

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
