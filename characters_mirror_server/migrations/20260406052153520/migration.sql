BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "armor_data" ADD COLUMN "referenceKey" text;
CREATE UNIQUE INDEX "armor_reference_key_idx" ON "armor_data" USING btree ("referenceKey");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_choice_data" DROP COLUMN "selectedItemKey";
--
-- ACTION CREATE TABLE
--
CREATE TABLE "character_starting_equipment_resolution_data" (
    "id" bigserial PRIMARY KEY,
    "selectionId" bigint NOT NULL,
    "lineKey" text,
    "catalogType" text,
    "referenceKey" text,
    "quantity" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "character_starting_equipment_selection_data" (
    "id" bigserial PRIMARY KEY,
    "characterId" bigint NOT NULL,
    "sourceType" text,
    "sourceId" bigint,
    "blockKey" text,
    "optionKey" text,
    "selectionIndex" bigint
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_choice_option_data" DROP COLUMN "grantedItemKeys";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "item_data" ADD COLUMN "referenceKey" text;
CREATE UNIQUE INDEX "item_reference_key_idx" ON "item_data" USING btree ("referenceKey");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "magic_item_data" ADD COLUMN "referenceKey" text;
CREATE UNIQUE INDEX "magic_item_reference_key_idx" ON "magic_item_data" USING btree ("referenceKey");
--
-- ACTION CREATE TABLE
--
CREATE TABLE "starting_equipment_block_data" (
    "id" bigserial PRIMARY KEY,
    "blockKey" text,
    "orderIndex" bigint,
    "kind" text,
    "selectionCount" bigint,
    "sourceClassId" bigint,
    "sourceBackgroundId" bigint,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "starting_equipment_line_data" (
    "id" bigserial PRIMARY KEY,
    "blockId" bigint,
    "optionId" bigint,
    "lineKey" text,
    "orderIndex" bigint,
    "kind" text,
    "displayText" text,
    "quantity" bigint,
    "catalogType" text,
    "referenceKey" text,
    "allowedWeaponCategories" json,
    "allowedItemCategories" json,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "starting_equipment_option_data" (
    "id" bigserial PRIMARY KEY,
    "blockId" bigint NOT NULL,
    "optionKey" text,
    "orderIndex" bigint,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "weapon_data" ADD COLUMN "referenceKey" text;
CREATE UNIQUE INDEX "weapon_reference_key_idx" ON "weapon_data" USING btree ("referenceKey");
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "character_starting_equipment_resolution_data"
    ADD CONSTRAINT "character_starting_equipment_resolution_data_fk_0"
    FOREIGN KEY("selectionId")
    REFERENCES "character_starting_equipment_selection_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "character_starting_equipment_selection_data"
    ADD CONSTRAINT "character_starting_equipment_selection_data_fk_0"
    FOREIGN KEY("characterId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "starting_equipment_block_data"
    ADD CONSTRAINT "starting_equipment_block_data_fk_0"
    FOREIGN KEY("sourceClassId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "starting_equipment_block_data"
    ADD CONSTRAINT "starting_equipment_block_data_fk_1"
    FOREIGN KEY("sourceBackgroundId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "starting_equipment_line_data"
    ADD CONSTRAINT "starting_equipment_line_data_fk_0"
    FOREIGN KEY("blockId")
    REFERENCES "starting_equipment_block_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "starting_equipment_line_data"
    ADD CONSTRAINT "starting_equipment_line_data_fk_1"
    FOREIGN KEY("optionId")
    REFERENCES "starting_equipment_option_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "starting_equipment_option_data"
    ADD CONSTRAINT "starting_equipment_option_data_fk_0"
    FOREIGN KEY("blockId")
    REFERENCES "starting_equipment_block_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260406052153520', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260406052153520', "timestamp" = now();

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
