BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "armor_data" ADD COLUMN "_classDataProficienciesarmorClassDataId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_data" DROP COLUMN "proficienciesArmor";
ALTER TABLE "class_data" DROP COLUMN "proficienciesWeapons";
ALTER TABLE "class_data" DROP COLUMN "proficienciesTools";
ALTER TABLE "class_data" DROP COLUMN "startingEquipment";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "item_data" ADD COLUMN "_classDataProficienciestoolsClassDataId" bigint;
ALTER TABLE "item_data" ADD COLUMN "_classDataStartingequipmentClassDataId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_data" DROP COLUMN "features";
ALTER TABLE "subclass_data" ADD COLUMN "subclassFeatures" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "weapon_data" ADD COLUMN "_classDataProficienciesweaponsClassDataId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "armor_data"
    ADD CONSTRAINT "armor_data_fk_0"
    FOREIGN KEY("_classDataProficienciesarmorClassDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "item_data"
    ADD CONSTRAINT "item_data_fk_0"
    FOREIGN KEY("_classDataProficienciestoolsClassDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "item_data"
    ADD CONSTRAINT "item_data_fk_1"
    FOREIGN KEY("_classDataStartingequipmentClassDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "weapon_data"
    ADD CONSTRAINT "weapon_data_fk_0"
    FOREIGN KEY("_classDataProficienciesweaponsClassDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251103114248890', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251103114248890', "timestamp" = now();

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
