BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "starting_equipment_entry_data" (
    "id" bigserial PRIMARY KEY,
    "sourceClassId" bigint,
    "sourceBackgroundId" bigint,
    "parentEntryId" bigint,
    "kind" text,
    "orderIndex" bigint,
    "selectionCount" bigint,
    "lineKind" text,
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

CREATE TEMP TABLE "_starting_equipment_entry_migration" (
    "id" bigint PRIMARY KEY,
    "sourceType" text NOT NULL,
    "sourceId" bigint NOT NULL,
    "sourceClassId" bigint,
    "sourceBackgroundId" bigint,
    "parentEntryId" bigint,
    "blockKey" text,
    "optionKey" text,
    "lineKey" text,
    "kind" text,
    "orderIndex" bigint,
    "selectionCount" bigint,
    "lineKind" text,
    "quantity" bigint,
    "catalogType" text,
    "referenceKey" text,
    "allowedWeaponCategories" json,
    "allowedItemCategories" json,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
) ON COMMIT DROP;

WITH source_blocks AS (
    SELECT
        'classData'::text AS "sourceType",
        c."id" AS "sourceId",
        c."id" AS "sourceClassId",
        NULL::bigint AS "sourceBackgroundId",
        block.value AS block
    FROM "class_data" c
    CROSS JOIN LATERAL jsonb_array_elements(
        COALESCE(c."startingEquipmentBlocks"::jsonb, '[]'::jsonb)
    ) AS block(value)
    UNION ALL
    SELECT
        'background'::text AS "sourceType",
        b."id" AS "sourceId",
        NULL::bigint AS "sourceClassId",
        b."id" AS "sourceBackgroundId",
        block.value AS block
    FROM "background_data" b
    CROSS JOIN LATERAL jsonb_array_elements(
        COALESCE(b."startingEquipmentBlocks"::jsonb, '[]'::jsonb)
    ) AS block(value)
)
INSERT INTO "_starting_equipment_entry_migration" (
    "id", "sourceType", "sourceId", "sourceClassId", "sourceBackgroundId",
    "blockKey", "kind", "orderIndex", "selectionCount"
)
SELECT
    nextval(pg_get_serial_sequence('"starting_equipment_entry_data"', 'id')),
    "sourceType",
    "sourceId",
    "sourceClassId",
    "sourceBackgroundId",
    block ->> 'blockKey',
    'choiceGroup',
    NULLIF(block ->> 'orderIndex', '')::bigint,
    NULLIF(block ->> 'selectionCount', '')::bigint
FROM source_blocks
WHERE block ->> 'kind' = 'choice';

WITH source_blocks AS (
    SELECT
        'classData'::text AS "sourceType",
        c."id" AS "sourceId",
        c."id" AS "sourceClassId",
        NULL::bigint AS "sourceBackgroundId",
        block.value AS block
    FROM "class_data" c
    CROSS JOIN LATERAL jsonb_array_elements(
        COALESCE(c."startingEquipmentBlocks"::jsonb, '[]'::jsonb)
    ) AS block(value)
    UNION ALL
    SELECT
        'background'::text AS "sourceType",
        b."id" AS "sourceId",
        NULL::bigint AS "sourceClassId",
        b."id" AS "sourceBackgroundId",
        block.value AS block
    FROM "background_data" b
    CROSS JOIN LATERAL jsonb_array_elements(
        COALESCE(b."startingEquipmentBlocks"::jsonb, '[]'::jsonb)
    ) AS block(value)
)
INSERT INTO "_starting_equipment_entry_migration" (
    "id", "sourceType", "sourceId", "sourceClassId", "sourceBackgroundId",
    "blockKey", "lineKey", "kind", "orderIndex", "lineKind", "quantity",
    "catalogType", "referenceKey", "allowedWeaponCategories",
    "allowedItemCategories"
)
SELECT
    nextval(pg_get_serial_sequence('"starting_equipment_entry_data"', 'id')),
    "sourceType",
    "sourceId",
    "sourceClassId",
    "sourceBackgroundId",
    block ->> 'blockKey',
    line.value ->> 'lineKey',
    'fixedLine',
    NULLIF(line.value ->> 'orderIndex', '')::bigint,
    line.value ->> 'kind',
    NULLIF(line.value ->> 'quantity', '')::bigint,
    line.value ->> 'catalogType',
    line.value ->> 'referenceKey',
    (line.value -> 'allowedWeaponCategories')::json,
    (line.value -> 'allowedItemCategories')::json
FROM source_blocks
CROSS JOIN LATERAL jsonb_array_elements(
    COALESCE(block -> 'fixedLines', '[]'::jsonb)
) AS line(value)
WHERE block ->> 'kind' = 'fixedGrant';

WITH source_blocks AS (
    SELECT
        'classData'::text AS "sourceType",
        c."id" AS "sourceId",
        block.value AS block
    FROM "class_data" c
    CROSS JOIN LATERAL jsonb_array_elements(
        COALESCE(c."startingEquipmentBlocks"::jsonb, '[]'::jsonb)
    ) AS block(value)
    UNION ALL
    SELECT
        'background'::text AS "sourceType",
        b."id" AS "sourceId",
        block.value AS block
    FROM "background_data" b
    CROSS JOIN LATERAL jsonb_array_elements(
        COALESCE(b."startingEquipmentBlocks"::jsonb, '[]'::jsonb)
    ) AS block(value)
)
INSERT INTO "_starting_equipment_entry_migration" (
    "id", "sourceType", "sourceId", "sourceClassId", "sourceBackgroundId",
    "parentEntryId", "blockKey", "optionKey", "kind", "orderIndex"
)
SELECT
    nextval(pg_get_serial_sequence('"starting_equipment_entry_data"', 'id')),
    sb."sourceType",
    sb."sourceId",
    parent."sourceClassId",
    parent."sourceBackgroundId",
    parent."id",
    sb.block ->> 'blockKey',
    option.value ->> 'optionKey',
    'choiceOption',
    NULLIF(option.value ->> 'orderIndex', '')::bigint
FROM source_blocks sb
JOIN "_starting_equipment_entry_migration" parent
    ON parent."sourceType" = sb."sourceType"
    AND parent."sourceId" = sb."sourceId"
    AND parent."blockKey" = (sb.block ->> 'blockKey')
    AND parent."kind" = 'choiceGroup'
CROSS JOIN LATERAL jsonb_array_elements(
    COALESCE(sb.block -> 'options', '[]'::jsonb)
) AS option(value)
WHERE sb.block ->> 'kind' = 'choice';

WITH source_blocks AS (
    SELECT
        'classData'::text AS "sourceType",
        c."id" AS "sourceId",
        block.value AS block
    FROM "class_data" c
    CROSS JOIN LATERAL jsonb_array_elements(
        COALESCE(c."startingEquipmentBlocks"::jsonb, '[]'::jsonb)
    ) AS block(value)
    UNION ALL
    SELECT
        'background'::text AS "sourceType",
        b."id" AS "sourceId",
        block.value AS block
    FROM "background_data" b
    CROSS JOIN LATERAL jsonb_array_elements(
        COALESCE(b."startingEquipmentBlocks"::jsonb, '[]'::jsonb)
    ) AS block(value)
)
INSERT INTO "_starting_equipment_entry_migration" (
    "id", "sourceType", "sourceId", "sourceClassId", "sourceBackgroundId",
    "parentEntryId", "blockKey", "optionKey", "lineKey", "kind",
    "orderIndex", "lineKind", "quantity", "catalogType", "referenceKey",
    "allowedWeaponCategories", "allowedItemCategories"
)
SELECT
    nextval(pg_get_serial_sequence('"starting_equipment_entry_data"', 'id')),
    sb."sourceType",
    sb."sourceId",
    option_entry."sourceClassId",
    option_entry."sourceBackgroundId",
    option_entry."id",
    sb.block ->> 'blockKey',
    option.value ->> 'optionKey',
    line.value ->> 'lineKey',
    'optionLine',
    NULLIF(line.value ->> 'orderIndex', '')::bigint,
    line.value ->> 'kind',
    NULLIF(line.value ->> 'quantity', '')::bigint,
    line.value ->> 'catalogType',
    line.value ->> 'referenceKey',
    (line.value -> 'allowedWeaponCategories')::json,
    (line.value -> 'allowedItemCategories')::json
FROM source_blocks sb
CROSS JOIN LATERAL jsonb_array_elements(
    COALESCE(sb.block -> 'options', '[]'::jsonb)
) AS option(value)
JOIN "_starting_equipment_entry_migration" option_entry
    ON option_entry."sourceType" = sb."sourceType"
    AND option_entry."sourceId" = sb."sourceId"
    AND option_entry."blockKey" = (sb.block ->> 'blockKey')
    AND option_entry."optionKey" = (option.value ->> 'optionKey')
    AND option_entry."kind" = 'choiceOption'
CROSS JOIN LATERAL jsonb_array_elements(
    COALESCE(option.value -> 'lines', '[]'::jsonb)
) AS line(value)
WHERE sb.block ->> 'kind' = 'choice';

INSERT INTO "starting_equipment_entry_data" (
    "id", "sourceClassId", "sourceBackgroundId", "parentEntryId", "kind",
    "orderIndex", "selectionCount", "lineKind", "quantity", "catalogType",
    "referenceKey", "allowedWeaponCategories", "allowedItemCategories",
    "source", "version", "createdAt", "updatedAt"
)
SELECT
    "id", "sourceClassId", "sourceBackgroundId", "parentEntryId", "kind",
    "orderIndex", "selectionCount", "lineKind", "quantity", "catalogType",
    "referenceKey", "allowedWeaponCategories", "allowedItemCategories",
    "source", "version", "createdAt", "updatedAt"
FROM "_starting_equipment_entry_migration"
ORDER BY "id";

SELECT setval(
    pg_get_serial_sequence('"starting_equipment_entry_data"', 'id'),
    COALESCE((SELECT MAX("id") FROM "starting_equipment_entry_data"), 1),
    true
);

-- Indexes
CREATE INDEX "starting_equipment_entry_class_idx" ON "starting_equipment_entry_data" USING btree ("sourceClassId");
CREATE INDEX "starting_equipment_entry_background_idx" ON "starting_equipment_entry_data" USING btree ("sourceBackgroundId");
CREATE INDEX "starting_equipment_entry_parent_idx" ON "starting_equipment_entry_data" USING btree ("parentEntryId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_starting_equipment_selection_data" ADD COLUMN "sourceEntryId" bigint;
ALTER TABLE "character_starting_equipment_selection_data" ADD COLUMN "choiceOptionEntryId" bigint;

UPDATE "character_starting_equipment_selection_data" selection
SET
    "sourceEntryId" = choice_group."id",
    "choiceOptionEntryId" = choice_option."id"
FROM "_starting_equipment_entry_migration" choice_group
JOIN "_starting_equipment_entry_migration" choice_option
    ON choice_option."sourceType" = choice_group."sourceType"
    AND choice_option."sourceId" = choice_group."sourceId"
    AND choice_option."blockKey" = choice_group."blockKey"
    AND choice_option."kind" = 'choiceOption'
WHERE choice_group."kind" = 'choiceGroup'
    AND selection."sourceType" = choice_group."sourceType"
    AND selection."sourceId" = choice_group."sourceId"
    AND selection."blockKey" = choice_group."blockKey"
    AND selection."optionKey" = choice_option."optionKey";

CREATE TABLE "character_starting_equipment_resolution_data" (
    "id" bigserial PRIMARY KEY,
    "syncId" text,
    "selectionId" bigint NOT NULL,
    "sourceLineEntryId" bigint,
    "catalogType" text,
    "referenceKey" text,
    "quantity" bigint,
    "updatedAt" timestamp without time zone
);

INSERT INTO "character_starting_equipment_resolution_data" (
    "syncId", "selectionId", "sourceLineEntryId", "catalogType",
    "referenceKey", "quantity", "updatedAt"
)
SELECT
    COALESCE(resolution.value ->> 'id', selection."syncId" || ':' || (resolution.value ->> 'lineKey')),
    selection."id",
    line_entry."id",
    resolution.value ->> 'catalogType',
    resolution.value ->> 'referenceKey',
    NULLIF(resolution.value ->> 'quantity', '')::bigint,
    selection."updatedAt"
FROM "character_starting_equipment_selection_data" selection
CROSS JOIN LATERAL jsonb_array_elements(
    COALESCE(selection."resolutions"::jsonb, '[]'::jsonb)
) AS resolution(value)
JOIN "_starting_equipment_entry_migration" line_entry
    ON line_entry."sourceType" = selection."sourceType"
    AND line_entry."sourceId" = selection."sourceId"
    AND line_entry."blockKey" = selection."blockKey"
    AND line_entry."optionKey" = selection."optionKey"
    AND line_entry."lineKey" = (resolution.value ->> 'lineKey')
    AND line_entry."kind" = 'optionLine'
WHERE selection."optionKey" IS NOT NULL;

CREATE TEMP TABLE "_starting_equipment_fixed_selection_migration" (
    "oldSelectionId" bigint NOT NULL,
    "newSelectionId" bigint PRIMARY KEY,
    "sourceLineEntryId" bigint NOT NULL,
    "resolution" jsonb NOT NULL
) ON COMMIT DROP;

INSERT INTO "_starting_equipment_fixed_selection_migration" (
    "oldSelectionId", "newSelectionId", "sourceLineEntryId", "resolution"
)
SELECT
    selection."id",
    nextval(pg_get_serial_sequence('"character_starting_equipment_selection_data"', 'id')),
    line_entry."id",
    resolution.value
FROM "character_starting_equipment_selection_data" selection
CROSS JOIN LATERAL jsonb_array_elements(
    COALESCE(selection."resolutions"::jsonb, '[]'::jsonb)
) AS resolution(value)
JOIN "_starting_equipment_entry_migration" line_entry
    ON line_entry."sourceType" = selection."sourceType"
    AND line_entry."sourceId" = selection."sourceId"
    AND line_entry."blockKey" = selection."blockKey"
    AND line_entry."lineKey" = (resolution.value ->> 'lineKey')
    AND line_entry."kind" = 'fixedLine'
WHERE selection."optionKey" IS NULL;

INSERT INTO "character_starting_equipment_selection_data" (
    "id", "syncId", "characterId", "sourceType", "sourceId",
    "sourceEntryId", "choiceOptionEntryId", "selectionIndex", "updatedAt"
)
SELECT
    fixed_map."newSelectionId",
    old_selection."syncId" || ':' || fixed_map."sourceLineEntryId",
    old_selection."characterId",
    old_selection."sourceType",
    old_selection."sourceId",
    fixed_map."sourceLineEntryId",
    NULL,
    old_selection."selectionIndex",
    old_selection."updatedAt"
FROM "_starting_equipment_fixed_selection_migration" fixed_map
JOIN "character_starting_equipment_selection_data" old_selection
    ON old_selection."id" = fixed_map."oldSelectionId";

INSERT INTO "character_starting_equipment_resolution_data" (
    "syncId", "selectionId", "sourceLineEntryId", "catalogType",
    "referenceKey", "quantity", "updatedAt"
)
SELECT
    COALESCE(fixed_map."resolution" ->> 'id', old_selection."syncId" || ':' || fixed_map."sourceLineEntryId"),
    fixed_map."newSelectionId",
    fixed_map."sourceLineEntryId",
    fixed_map."resolution" ->> 'catalogType',
    fixed_map."resolution" ->> 'referenceKey',
    NULLIF(fixed_map."resolution" ->> 'quantity', '')::bigint,
    old_selection."updatedAt"
FROM "_starting_equipment_fixed_selection_migration" fixed_map
JOIN "character_starting_equipment_selection_data" old_selection
    ON old_selection."id" = fixed_map."oldSelectionId";

DELETE FROM "character_starting_equipment_selection_data"
WHERE "id" IN (
    SELECT "oldSelectionId" FROM "_starting_equipment_fixed_selection_migration"
);

DELETE FROM "character_starting_equipment_selection_data"
WHERE "optionKey" IS NULL
    AND "blockKey" IS NOT NULL
    AND "sourceEntryId" IS NULL;

SELECT setval(
    pg_get_serial_sequence('"character_starting_equipment_selection_data"', 'id'),
    COALESCE((SELECT MAX("id") FROM "character_starting_equipment_selection_data"), 1),
    true
);

DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM "character_starting_equipment_selection_data"
        WHERE "sourceEntryId" IS NULL
            AND ("blockKey" IS NOT NULL OR "optionKey" IS NOT NULL)
    ) THEN
        RAISE EXCEPTION 'Unmapped starting equipment selections remain after migration.';
    END IF;
END $$;

ALTER TABLE "background_data" DROP COLUMN "startingEquipmentBlocks";
ALTER TABLE "class_data" DROP COLUMN "startingEquipmentBlocks";
ALTER TABLE "character_starting_equipment_selection_data" DROP COLUMN "blockKey";
ALTER TABLE "character_starting_equipment_selection_data" DROP COLUMN "optionKey";
ALTER TABLE "character_starting_equipment_selection_data" DROP COLUMN "resolutions";

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "character_starting_equipment_resolution_data"
    ADD CONSTRAINT "character_starting_equipment_resolution_data_fk_0"
    FOREIGN KEY("selectionId")
    REFERENCES "character_starting_equipment_selection_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_starting_equipment_resolution_data"
    ADD CONSTRAINT "character_starting_equipment_resolution_data_fk_1"
    FOREIGN KEY("sourceLineEntryId")
    REFERENCES "starting_equipment_entry_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE ONLY "character_starting_equipment_selection_data"
    ADD CONSTRAINT "character_starting_equipment_selection_data_fk_1"
    FOREIGN KEY("sourceEntryId")
    REFERENCES "starting_equipment_entry_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_starting_equipment_selection_data"
    ADD CONSTRAINT "character_starting_equipment_selection_data_fk_2"
    FOREIGN KEY("choiceOptionEntryId")
    REFERENCES "starting_equipment_entry_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE ONLY "starting_equipment_entry_data"
    ADD CONSTRAINT "starting_equipment_entry_data_fk_0"
    FOREIGN KEY("sourceClassId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "starting_equipment_entry_data"
    ADD CONSTRAINT "starting_equipment_entry_data_fk_1"
    FOREIGN KEY("sourceBackgroundId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260429202130163', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260429202130163', "timestamp" = now();

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
