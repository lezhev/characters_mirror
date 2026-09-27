BEGIN;

-- Repoint only the legacy Bard/Rogue catalog entries and Bard instrument
-- category marker. Keep ItemData itself intact for unrelated consumers.
DO $$
DECLARE
    matching_rows bigint;
BEGIN
    SELECT count(*) INTO matching_rows
    FROM "starting_equipment_entry_data" entry
    JOIN "class_data" class ON class."id" = entry."sourceClassId"
    WHERE lower(class."name") IN ('bard', 'бард')
      AND entry."kind" = 'optionLine'
      AND entry."lineKind" = 'catalogRef'
      AND entry."catalogType" = 'item'
      AND entry."referenceKey" = 'lute';
    IF matching_rows > 1 THEN
        RAISE EXCEPTION 'Expected at most one Bard lute item catalog entry, found %', matching_rows;
    END IF;

    UPDATE "starting_equipment_entry_data" entry
    SET "catalogType" = 'tool'
    FROM "class_data" class
    WHERE class."id" = entry."sourceClassId"
      AND lower(class."name") IN ('bard', 'бард')
      AND entry."kind" = 'optionLine'
      AND entry."lineKind" = 'catalogRef'
      AND entry."catalogType" = 'item'
      AND entry."referenceKey" = 'lute';
END $$;

DO $$
DECLARE
    matching_rows bigint;
BEGIN
    SELECT count(*) INTO matching_rows
    FROM "starting_equipment_entry_data"
    WHERE "kind" = 'fixedLine'
      AND "lineKind" = 'catalogRef'
      AND "catalogType" = 'item'
      AND "referenceKey" = 'thieves_tools';
    IF matching_rows > 1 THEN
        RAISE EXCEPTION 'Expected at most one thieves_tools item catalog entry, found %', matching_rows;
    END IF;

    UPDATE "starting_equipment_entry_data"
    SET "catalogType" = 'tool'
    WHERE "kind" = 'fixedLine'
      AND "lineKind" = 'catalogRef'
      AND "catalogType" = 'item'
      AND "referenceKey" = 'thieves_tools';
END $$;

DO $$
DECLARE
    matching_rows bigint;
BEGIN
    SELECT count(*) INTO matching_rows
    FROM "starting_equipment_entry_data" entry
    JOIN "class_data" class ON class."id" = entry."sourceClassId"
    WHERE lower(class."name") IN ('bard', 'бард')
      AND entry."kind" = 'optionLine'
      AND entry."lineKind" = 'itemCategory'
      AND entry."allowedItemCategories"::jsonb = '["MusicalInstrument"]'::jsonb;
    IF matching_rows > 1 THEN
        RAISE EXCEPTION 'Expected at most one Bard MusicalInstrument category choice, found %', matching_rows;
    END IF;

    UPDATE "starting_equipment_entry_data" entry
    SET "catalogType" = 'tool',
        "allowedItemCategories" = '["musicalInstrument"]'::json
    FROM "class_data" class
    WHERE class."id" = entry."sourceClassId"
      AND lower(class."name") IN ('bard', 'бард')
      AND entry."kind" = 'optionLine'
      AND entry."lineKind" = 'itemCategory'
      AND entry."allowedItemCategories"::jsonb = '["MusicalInstrument"]'::jsonb;
END $$;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260927090431637-starting-equipment-tool-catalog', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260927090431637-starting-equipment-tool-catalog', "timestamp" = now();

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
