BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_9";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_1";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_2";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_3";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_4";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_5";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_6";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_7";
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_8";
ALTER TABLE "characters" ALTER COLUMN "raceId" DROP NOT NULL;
ALTER TABLE "characters" ALTER COLUMN "subraceId" DROP NOT NULL;
ALTER TABLE "characters" ALTER COLUMN "backgroundId" DROP NOT NULL;
ALTER TABLE "characters" ALTER COLUMN "preparedSpellsId" DROP NOT NULL;
ALTER TABLE "characters" ALTER COLUMN "writtenSpellsId" DROP NOT NULL;
ALTER TABLE "characters" ALTER COLUMN "itemsId" DROP NOT NULL;
ALTER TABLE "characters" ALTER COLUMN "magicItemsId" DROP NOT NULL;
ALTER TABLE "characters" ALTER COLUMN "armorId" DROP NOT NULL;
ALTER TABLE "characters" ALTER COLUMN "weaponsId" DROP NOT NULL;
--
-- ACTION CREATE FOREIGN KEY
--
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
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251105000621461', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251105000621461', "timestamp" = now();

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
