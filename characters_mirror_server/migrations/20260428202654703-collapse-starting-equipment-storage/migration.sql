BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "background_data" ADD COLUMN "startingEquipmentBlocks" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_starting_equipment_selection_data" ADD COLUMN "resolutions" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_data" ADD COLUMN "startingEquipmentBlocks" json;

--
-- VALIDATE LEGACY STARTING EQUIPMENT SOURCE GRAPH
--
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM "starting_equipment_option_data" option
        LEFT JOIN "starting_equipment_block_data" block ON block."id" = option."blockId"
        WHERE block."id" IS NULL
    ) THEN
        RAISE EXCEPTION 'Cannot migrate starting equipment: orphan option rows exist.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM "starting_equipment_line_data" line
        WHERE line."blockId" IS NOT NULL
          AND NOT EXISTS (
              SELECT 1
              FROM "starting_equipment_block_data" block
              WHERE block."id" = line."blockId"
          )
    ) THEN
        RAISE EXCEPTION 'Cannot migrate starting equipment: orphan fixed line rows exist.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM "starting_equipment_line_data" line
        WHERE line."optionId" IS NOT NULL
          AND NOT EXISTS (
              SELECT 1
              FROM "starting_equipment_option_data" option
              WHERE option."id" = line."optionId"
          )
    ) THEN
        RAISE EXCEPTION 'Cannot migrate starting equipment: orphan option line rows exist.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM "starting_equipment_block_data" block
        WHERE block."sourceClassId" IS NULL
          AND block."sourceBackgroundId" IS NULL
    ) THEN
        RAISE EXCEPTION 'Cannot migrate starting equipment: source-less block rows exist.';
    END IF;
END $$;

--
-- MIGRATE CLASS STARTING EQUIPMENT SOURCES INTO EMBEDDED JSON
--
WITH class_blocks AS (
    SELECT
        block."sourceClassId" AS class_id,
        json_agg(
            json_strip_nulls(json_build_object(
                'blockKey', block."blockKey",
                'orderIndex', block."orderIndex",
                'kind', block."kind",
                'selectionCount', block."selectionCount",
                'name', block."name",
                'description', block."description",
                'fixedLines', COALESCE(fixed_lines.items, '[]'::json),
                'options', COALESCE(options.items, '[]'::json),
                'source', block."source",
                'version', block."version",
                'createdAt', block."createdAt",
                'updatedAt', block."updatedAt"
            ))
            ORDER BY block."orderIndex", block."id"
        ) AS blocks
    FROM "starting_equipment_block_data" block
    LEFT JOIN LATERAL (
        SELECT json_agg(
            json_strip_nulls(json_build_object(
                'lineKey', line."lineKey",
                'orderIndex', line."orderIndex",
                'kind', line."kind",
                'displayText', line."displayText",
                'quantity', line."quantity",
                'catalogType', line."catalogType",
                'referenceKey', line."referenceKey",
                'allowedWeaponCategories', line."allowedWeaponCategories",
                'allowedItemCategories', line."allowedItemCategories",
                'source', line."source",
                'version', line."version",
                'createdAt', line."createdAt",
                'updatedAt', line."updatedAt"
            ))
            ORDER BY line."orderIndex", line."id"
        ) AS items
        FROM "starting_equipment_line_data" line
        WHERE line."blockId" = block."id"
    ) fixed_lines ON TRUE
    LEFT JOIN LATERAL (
        SELECT json_agg(
            json_strip_nulls(json_build_object(
                'optionKey', option."optionKey",
                'orderIndex', option."orderIndex",
                'name', option."name",
                'description', option."description",
                'lines', COALESCE(option_lines.items, '[]'::json),
                'source', option."source",
                'version', option."version",
                'createdAt', option."createdAt",
                'updatedAt', option."updatedAt"
            ))
            ORDER BY option."orderIndex", option."id"
        ) AS items
        FROM "starting_equipment_option_data" option
        LEFT JOIN LATERAL (
            SELECT json_agg(
                json_strip_nulls(json_build_object(
                    'lineKey', line."lineKey",
                    'orderIndex', line."orderIndex",
                    'kind', line."kind",
                    'displayText', line."displayText",
                    'quantity', line."quantity",
                    'catalogType', line."catalogType",
                    'referenceKey', line."referenceKey",
                    'allowedWeaponCategories', line."allowedWeaponCategories",
                    'allowedItemCategories', line."allowedItemCategories",
                    'source', line."source",
                    'version', line."version",
                    'createdAt', line."createdAt",
                    'updatedAt', line."updatedAt"
                ))
                ORDER BY line."orderIndex", line."id"
            ) AS items
            FROM "starting_equipment_line_data" line
            WHERE line."optionId" = option."id"
        ) option_lines ON TRUE
        WHERE option."blockId" = block."id"
    ) options ON TRUE
    WHERE block."sourceClassId" IS NOT NULL
    GROUP BY block."sourceClassId"
)
UPDATE "class_data" class_data
SET "startingEquipmentBlocks" = class_blocks.blocks
FROM class_blocks
WHERE class_data."id" = class_blocks.class_id;

--
-- MIGRATE BACKGROUND STARTING EQUIPMENT SOURCES INTO EMBEDDED JSON
--
WITH background_blocks AS (
    SELECT
        block."sourceBackgroundId" AS background_id,
        json_agg(
            json_strip_nulls(json_build_object(
                'blockKey', block."blockKey",
                'orderIndex', block."orderIndex",
                'kind', block."kind",
                'selectionCount', block."selectionCount",
                'name', block."name",
                'description', block."description",
                'fixedLines', COALESCE(fixed_lines.items, '[]'::json),
                'options', COALESCE(options.items, '[]'::json),
                'source', block."source",
                'version', block."version",
                'createdAt', block."createdAt",
                'updatedAt', block."updatedAt"
            ))
            ORDER BY block."orderIndex", block."id"
        ) AS blocks
    FROM "starting_equipment_block_data" block
    LEFT JOIN LATERAL (
        SELECT json_agg(
            json_strip_nulls(json_build_object(
                'lineKey', line."lineKey",
                'orderIndex', line."orderIndex",
                'kind', line."kind",
                'displayText', line."displayText",
                'quantity', line."quantity",
                'catalogType', line."catalogType",
                'referenceKey', line."referenceKey",
                'allowedWeaponCategories', line."allowedWeaponCategories",
                'allowedItemCategories', line."allowedItemCategories",
                'source', line."source",
                'version', line."version",
                'createdAt', line."createdAt",
                'updatedAt', line."updatedAt"
            ))
            ORDER BY line."orderIndex", line."id"
        ) AS items
        FROM "starting_equipment_line_data" line
        WHERE line."blockId" = block."id"
    ) fixed_lines ON TRUE
    LEFT JOIN LATERAL (
        SELECT json_agg(
            json_strip_nulls(json_build_object(
                'optionKey', option."optionKey",
                'orderIndex', option."orderIndex",
                'name', option."name",
                'description', option."description",
                'lines', COALESCE(option_lines.items, '[]'::json),
                'source', option."source",
                'version', option."version",
                'createdAt', option."createdAt",
                'updatedAt', option."updatedAt"
            ))
            ORDER BY option."orderIndex", option."id"
        ) AS items
        FROM "starting_equipment_option_data" option
        LEFT JOIN LATERAL (
            SELECT json_agg(
                json_strip_nulls(json_build_object(
                    'lineKey', line."lineKey",
                    'orderIndex', line."orderIndex",
                    'kind', line."kind",
                    'displayText', line."displayText",
                    'quantity', line."quantity",
                    'catalogType', line."catalogType",
                    'referenceKey', line."referenceKey",
                    'allowedWeaponCategories', line."allowedWeaponCategories",
                    'allowedItemCategories', line."allowedItemCategories",
                    'source', line."source",
                    'version', line."version",
                    'createdAt', line."createdAt",
                    'updatedAt', line."updatedAt"
                ))
                ORDER BY line."orderIndex", line."id"
            ) AS items
            FROM "starting_equipment_line_data" line
            WHERE line."optionId" = option."id"
        ) option_lines ON TRUE
        WHERE option."blockId" = block."id"
    ) options ON TRUE
    WHERE block."sourceBackgroundId" IS NOT NULL
    GROUP BY block."sourceBackgroundId"
)
UPDATE "background_data" background_data
SET "startingEquipmentBlocks" = background_blocks.blocks
FROM background_blocks
WHERE background_data."id" = background_blocks.background_id;

--
-- MIGRATE USER RESOLUTIONS INTO SELECTION ROW JSON
--
WITH resolution_groups AS (
    SELECT
        resolution."selectionId" AS selection_id,
        json_agg(
            json_strip_nulls(json_build_object(
                'id', resolution."syncId",
                'lineKey', resolution."lineKey",
                'catalogType', resolution."catalogType",
                'referenceKey', resolution."referenceKey",
                'quantity', resolution."quantity",
                'updatedAt', resolution."updatedAt"
            ))
            ORDER BY resolution."id"
        ) AS resolutions
    FROM "character_starting_equipment_resolution_data" resolution
    GROUP BY resolution."selectionId"
)
UPDATE "character_starting_equipment_selection_data" selection
SET "resolutions" = resolution_groups.resolutions
FROM resolution_groups
WHERE selection."id" = resolution_groups.selection_id;

--
-- ACTION DROP TABLE
--
DROP TABLE "character_starting_equipment_resolution_data" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "starting_equipment_line_data" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "starting_equipment_option_data" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "starting_equipment_block_data" CASCADE;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260428202654703-collapse-starting-equipment-storage', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260428202654703-collapse-starting-equipment-storage', "timestamp" = now();

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
