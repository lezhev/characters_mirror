BEGIN;

--
-- DATA REPAIR
--
-- The first spell-selection migration could over-match class choice groups by
-- groupKey/exclusiveKey and could classify migrated rows by old group type
-- instead of the actual spell level. Repair the persisted choices in place.
WITH matched_spells AS (
    SELECT
        selection."id" AS "selectionId",
        spell."id" AS "spellId",
        spell."referenceKey",
        spell."level"
    FROM "character_spell_selection_data" selection
    LEFT JOIN "spell_data" existing_spell
        ON existing_spell."id" = selection."spellId"
    LEFT JOIN "spell_data" spell
        ON spell."id" = selection."spellId"
        OR lower(spell."referenceKey") = lower(selection."spellKey")
        OR lower(spell."name") = lower(selection."spellKey")
    WHERE spell."id" IS NOT NULL
)
UPDATE "character_spell_selection_data" selection
SET
    "spellId" = matched_spells."spellId",
    "spellKey" = COALESCE(matched_spells."referenceKey", selection."spellKey"),
    "kind" = CASE
        WHEN matched_spells."level" = 0 THEN 'knownCantrip'
        WHEN matched_spells."level" > 0 THEN 'knownSpell'
        ELSE selection."kind"
    END
FROM matched_spells
WHERE selection."id" = matched_spells."selectionId";

WITH ranked_duplicates AS (
    SELECT
        "id",
        row_number() OVER (
            PARTITION BY "syncId"
            ORDER BY
                CASE WHEN "spellId" IS NULL THEN 1 ELSE 0 END,
                CASE WHEN "classEntryId" IS NULL THEN 1 ELSE 0 END,
                CASE WHEN "classDataId" IS NULL THEN 1 ELSE 0 END,
                "id"
        ) AS duplicate_rank
    FROM "character_spell_selection_data"
    WHERE "syncId" IS NOT NULL
)
DELETE FROM "character_spell_selection_data" selection
USING ranked_duplicates
WHERE selection."id" = ranked_duplicates."id"
  AND ranked_duplicates.duplicate_rank > 1;

WITH ranked_by_limit AS (
    SELECT
        selection."id",
        CASE selection."kind"
            WHEN 'knownCantrip' THEN class_level."knownCantrips"
            WHEN 'knownSpell' THEN class_level."knownSpells"
            ELSE NULL
        END AS selection_limit,
        row_number() OVER (
            PARTITION BY
                selection."characterId",
                COALESCE(selection."classEntryId", 0),
                COALESCE(selection."classDataId", class_entry."classDataId", 0),
                selection."kind"
            ORDER BY
                COALESCE(selection."selectionIndex", 2147483647),
                selection."id"
        ) AS selection_rank
    FROM "character_spell_selection_data" selection
    LEFT JOIN "character_class_relation" class_entry
        ON class_entry."id" = selection."classEntryId"
    LEFT JOIN LATERAL (
        SELECT class_level_row.*
        FROM "class_level_data" class_level_row
        WHERE class_level_row."classDataId" = COALESCE(
            selection."classDataId",
            class_entry."classDataId"
        )
          AND class_level_row."level" <= COALESCE(class_entry."level", 1)
        ORDER BY class_level_row."level" DESC
        LIMIT 1
    ) class_level ON TRUE
    WHERE selection."kind" IN ('knownCantrip', 'knownSpell')
)
DELETE FROM "character_spell_selection_data" selection
USING ranked_by_limit
WHERE selection."id" = ranked_by_limit."id"
  AND ranked_by_limit.selection_limit IS NOT NULL
  AND ranked_by_limit.selection_rank > ranked_by_limit.selection_limit;

WITH normalized_order AS (
    SELECT
        "id",
        row_number() OVER (
            PARTITION BY
                "characterId",
                COALESCE("classEntryId", 0),
                COALESCE("classDataId", 0),
                "kind"
            ORDER BY COALESCE("selectionIndex", 2147483647), "id"
        ) - 1 AS next_index
    FROM "character_spell_selection_data"
    WHERE "kind" IN ('knownCantrip', 'knownSpell')
)
UPDATE "character_spell_selection_data" selection
SET "selectionIndex" = normalized_order.next_index
FROM normalized_order
WHERE selection."id" = normalized_order."id";


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260428195026924-repair-spell-selections', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260428195026924-repair-spell-selections', "timestamp" = now();

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
