BEGIN;

-- The local development BackgroundData includes a fixed forgery kit in
-- addition to the Charlatan's disguise kit. Add its canonical ToolData grant
-- without changing the original Stage 6 migration or creating catalog rows.
DO $$
DECLARE
    background_id bigint;
    background_count bigint;
    canonical_tool_count bigint;
    disguise_kit_count bigint;
    pouch_count bigint;
    forgery_kit_count bigint;
    updated_pouch_count bigint;
BEGIN
    SELECT count(*) INTO background_count
    FROM background_data
    WHERE name = 'Шарлатан';

    IF background_count = 0 THEN
        RAISE NOTICE 'No Charlatan BackgroundData found; skipping Stage 6 correction.';
    ELSE
        IF background_count <> 1 THEN
            RAISE EXCEPTION 'Expected exactly one BackgroundData named "Шарлатан", found %', background_count;
        END IF;

        SELECT id INTO background_id
        FROM background_data
        WHERE name = 'Шарлатан';

        SELECT count(*) INTO canonical_tool_count
        FROM tool_data
        WHERE "referenceKey" = 'forgery_kit';
        IF canonical_tool_count <> 1 THEN
            RAISE EXCEPTION 'Expected exactly one canonical ToolData referenceKey "forgery_kit", found %', canonical_tool_count;
        END IF;

        SELECT count(*) INTO disguise_kit_count
        FROM starting_equipment_entry_data
        WHERE "sourceBackgroundId" = background_id
          AND kind = 'fixedLine'
          AND "lineKind" = 'catalogRef'
          AND "catalogType" = 'tool'
          AND "referenceKey" = 'disguise_kit'
          AND source = 'stage6-background-starting-equipment';
        IF disguise_kit_count <> 1 THEN
            RAISE EXCEPTION 'Expected exactly one migrated Charlatan disguise_kit line, found %', disguise_kit_count;
        END IF;

        SELECT count(*) INTO pouch_count
        FROM starting_equipment_entry_data
        WHERE "sourceBackgroundId" = background_id
          AND kind = 'fixedLine'
          AND "referenceKey" = 'pouch'
          AND source = 'stage6-background-starting-equipment';
        IF pouch_count <> 1 THEN
            RAISE EXCEPTION 'Expected exactly one migrated Charlatan pouch line, found %', pouch_count;
        END IF;

        SELECT count(*) INTO forgery_kit_count
        FROM starting_equipment_entry_data
        WHERE "sourceBackgroundId" = background_id
          AND kind = 'fixedLine'
          AND "referenceKey" = 'forgery_kit';
        IF forgery_kit_count <> 0 THEN
            RAISE EXCEPTION 'Charlatan already has a forgery_kit line; refusing to duplicate it.';
        END IF;

        UPDATE starting_equipment_entry_data
        SET "orderIndex" = 4, "updatedAt" = now()
        WHERE "sourceBackgroundId" = background_id
          AND kind = 'fixedLine'
          AND "referenceKey" = 'pouch'
          AND source = 'stage6-background-starting-equipment';
        GET DIAGNOSTICS updated_pouch_count = ROW_COUNT;
        IF updated_pouch_count <> 1 THEN
            RAISE EXCEPTION 'Expected to move exactly one Charlatan pouch line, updated %', updated_pouch_count;
        END IF;

        INSERT INTO starting_equipment_entry_data (
            "sourceBackgroundId", "parentEntryId", kind, "orderIndex",
            "selectionCount", "lineKind", quantity, "catalogType",
            "referenceKey", "allowedItemCategories", source, version,
            "createdAt", "updatedAt"
        ) VALUES (
            background_id, NULL, 'fixedLine', 3,
            NULL, 'catalogRef', 1, 'tool',
            'forgery_kit', NULL, 'stage6-background-starting-equipment', 1,
            now(), now()
        );
    END IF;
END $$;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260927112208460-stage6-charlatan-forgery-kit', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260927112208460-stage6-charlatan-forgery-kit', "timestamp" = now();

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
