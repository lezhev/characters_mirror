BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "race_option_data" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "class_option_data" CASCADE;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "armor_data" DROP CONSTRAINT "armor_data_fk_0";
ALTER TABLE "armor_data" DROP COLUMN "category";
ALTER TABLE "armor_data" DROP COLUMN "_charactersArmorCharactersId";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "background_data" DROP COLUMN "suggestedSkillProficiencies";
ALTER TABLE "background_data" DROP COLUMN "skillProficiencieCount";
ALTER TABLE "background_data" DROP COLUMN "suggestedToolProficiencies";
ALTER TABLE "background_data" DROP COLUMN "toolProficiencieCount";
ALTER TABLE "background_data" DROP COLUMN "suggestedLanguages";
ALTER TABLE "background_data" DROP COLUMN "languageCount";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_class_relation" DROP COLUMN "spellcastingProgression";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_3";
ALTER TABLE "characters" DROP COLUMN "attributes";
ALTER TABLE "characters" DROP COLUMN "alignment";
ALTER TABLE "characters" DROP COLUMN "subclassId";
ALTER TABLE "characters" DROP COLUMN "armorClass";
ALTER TABLE "characters" DROP COLUMN "speed";
ALTER TABLE "characters" DROP COLUMN "coins";
ALTER TABLE "characters" DROP COLUMN "skillProficiencies";
ALTER TABLE "characters" DROP COLUMN "skillExpertises";
ALTER TABLE "characters" DROP COLUMN "maxHp";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_data" DROP CONSTRAINT "class_data_fk_0";
ALTER TABLE "class_data" DROP COLUMN "hitDie";
ALTER TABLE "class_data" DROP COLUMN "savingThrows";
ALTER TABLE "class_data" DROP COLUMN "proficienciesArmor";
ALTER TABLE "class_data" DROP COLUMN "skills";
ALTER TABLE "class_data" DROP COLUMN "spellcasting";
ALTER TABLE "class_data" DROP COLUMN "spellcastingAbility";
ALTER TABLE "class_data" DROP COLUMN "_charactersClassesCharactersId";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_feature_data" DROP CONSTRAINT "class_feature_data_fk_1";
ALTER TABLE "class_feature_data" DROP COLUMN "abilityBonuses";
ALTER TABLE "class_feature_data" DROP COLUMN "proficiencies";
ALTER TABLE "class_feature_data" DROP COLUMN "specialAbilities";
ALTER TABLE "class_feature_data" DROP COLUMN "variantOptions";
ALTER TABLE "class_feature_data" DROP COLUMN "resourceName";
ALTER TABLE "class_feature_data" DROP COLUMN "resourceAmount";
ALTER TABLE "class_feature_data" DROP COLUMN "resourceRegain";
ALTER TABLE "class_feature_data" DROP COLUMN "spellSlots";
ALTER TABLE "class_feature_data" DROP COLUMN "_charactersClassfeaturesCharactersId";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "item_data" DROP CONSTRAINT "item_data_fk_0";
ALTER TABLE "item_data" DROP CONSTRAINT "item_data_fk_1";
ALTER TABLE "item_data" DROP CONSTRAINT "item_data_fk_2";
ALTER TABLE "item_data" DROP COLUMN "_charactersItemsCharactersId";
ALTER TABLE "item_data" DROP COLUMN "_classDataProficienciestoolsClassDataId";
ALTER TABLE "item_data" DROP COLUMN "_classDataStartingequipmentClassDataId";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "magic_item_data" DROP CONSTRAINT "magic_item_data_fk_0";
ALTER TABLE "magic_item_data" DROP COLUMN "_charactersMagicitemsCharactersId";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "spell_data" DROP CONSTRAINT "spell_data_fk_0";
ALTER TABLE "spell_data" DROP CONSTRAINT "spell_data_fk_1";
ALTER TABLE "spell_data" DROP COLUMN "school";
ALTER TABLE "spell_data" DROP COLUMN "availableForClasses";
ALTER TABLE "spell_data" DROP COLUMN "_charactersPreparedspellsCharactersId";
ALTER TABLE "spell_data" DROP COLUMN "_charactersWrittenspellsCharactersId";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_feature_data" DROP COLUMN "abilityBonuses";
ALTER TABLE "subclass_feature_data" DROP COLUMN "proficiencies";
ALTER TABLE "subclass_feature_data" DROP COLUMN "specialAbilities";
ALTER TABLE "subclass_feature_data" DROP COLUMN "variantOptions";
ALTER TABLE "subclass_feature_data" DROP COLUMN "resourceName";
ALTER TABLE "subclass_feature_data" DROP COLUMN "resourceAmount";
ALTER TABLE "subclass_feature_data" DROP COLUMN "resourceRegain";
ALTER TABLE "subclass_feature_data" DROP COLUMN "spellSlots";
ALTER TABLE "subclass_feature_data" DROP COLUMN "knownSpells";
ALTER TABLE "subclass_feature_data" DROP COLUMN "knownCantips";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subrace_data" DROP COLUMN "specialAbilities";
ALTER TABLE "subrace_data" DROP COLUMN "variantOptions";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "weapon_data" DROP CONSTRAINT "weapon_data_fk_0";
ALTER TABLE "weapon_data" DROP CONSTRAINT "weapon_data_fk_1";
ALTER TABLE "weapon_data" DROP COLUMN "isSimple";
ALTER TABLE "weapon_data" DROP COLUMN "isMelee";
ALTER TABLE "weapon_data" DROP COLUMN "damageType";
ALTER TABLE "weapon_data" DROP COLUMN "_charactersWeaponsCharactersId";
ALTER TABLE "weapon_data" DROP COLUMN "_classDataProficienciesweaponsClassDataId";

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260327185418091', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260327185418091', "timestamp" = now();

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
