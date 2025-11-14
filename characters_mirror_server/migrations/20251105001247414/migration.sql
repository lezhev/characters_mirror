BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "armor_data" ADD COLUMN "_charactersArmorCharactersId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_3";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_4";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_5";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_6";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_7";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_8";
ALTER TABLE "characters" DROP COLUMN "preparedSpellsId";
ALTER TABLE "characters" DROP COLUMN "writtenSpellsId";
ALTER TABLE "characters" DROP COLUMN "itemsId";
ALTER TABLE "characters" DROP COLUMN "magicItemsId";
ALTER TABLE "characters" DROP COLUMN "armorId";
ALTER TABLE "characters" DROP COLUMN "weaponsId";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "item_data" DROP CONSTRAINT "item_data_fk_0";
ALTER TABLE "item_data" DROP CONSTRAINT "item_data_fk_1";
ALTER TABLE "item_data" ADD COLUMN "_charactersItemsCharactersId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "magic_item_data" ADD COLUMN "_charactersMagicitemsCharactersId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "spell_data" ADD COLUMN "_charactersPreparedspellsCharactersId" bigint;
ALTER TABLE "spell_data" ADD COLUMN "_charactersWrittenspellsCharactersId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "weapon_data" DROP CONSTRAINT "weapon_data_fk_0";
ALTER TABLE "weapon_data" ADD COLUMN "_charactersWeaponsCharactersId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "armor_data"
    ADD CONSTRAINT "armor_data_fk_0"
    FOREIGN KEY("_charactersArmorCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "item_data"
    ADD CONSTRAINT "item_data_fk_2"
    FOREIGN KEY("_classDataStartingequipmentClassDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "item_data"
    ADD CONSTRAINT "item_data_fk_0"
    FOREIGN KEY("_charactersItemsCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "item_data"
    ADD CONSTRAINT "item_data_fk_1"
    FOREIGN KEY("_classDataProficienciestoolsClassDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "magic_item_data"
    ADD CONSTRAINT "magic_item_data_fk_0"
    FOREIGN KEY("_charactersMagicitemsCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "spell_data"
    ADD CONSTRAINT "spell_data_fk_0"
    FOREIGN KEY("_charactersPreparedspellsCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "spell_data"
    ADD CONSTRAINT "spell_data_fk_1"
    FOREIGN KEY("_charactersWrittenspellsCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "weapon_data"
    ADD CONSTRAINT "weapon_data_fk_1"
    FOREIGN KEY("_classDataProficienciesweaponsClassDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "weapon_data"
    ADD CONSTRAINT "weapon_data_fk_0"
    FOREIGN KEY("_charactersWeaponsCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251105001247414', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251105001247414', "timestamp" = now();

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
