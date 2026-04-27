BEGIN;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "character_spell_selection_data" (
    "id" bigserial PRIMARY KEY,
    "syncId" text,
    "characterId" bigint NOT NULL,
    "classEntryId" bigint,
    "classDataId" bigint,
    "spellId" bigint,
    "spellKey" text,
    "kind" text,
    "selectionIndex" bigint,
    "updatedAt" timestamp without time zone
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "spell_data" ADD COLUMN "referenceKey" text;

--
-- DATA MIGRATION
--
UPDATE "spell_data"
SET "referenceKey" = regexp_replace(
    regexp_replace(lower(trim(coalesce("name", ''))), '[^a-z0-9]+', '_', 'g'),
    '^_+|_+$',
    '',
    'g'
)
WHERE "referenceKey" IS NULL OR trim("referenceKey") = '';

INSERT INTO "character_spell_selection_data" (
    "syncId",
    "characterId",
    "classEntryId",
    "classDataId",
    "spellId",
    "spellKey",
    "kind",
    "selectionIndex",
    "updatedAt"
)
SELECT
    coalesce(choice."syncId", 'spell-selection-' || choice."id"::text),
    choice."characterId",
    choice."classEntryId",
    coalesce(entry."classDataId", choice_group."sourceClassId"),
    spell."id",
    coalesce(spell."referenceKey", resolved."spellKey"),
    CASE
        WHEN choice_group."type" = 'cantrip' THEN 'knownCantrip'
        ELSE 'knownSpell'
    END,
    choice."selectionIndex",
    coalesce(choice."updatedAt", now())
FROM "character_choice_data" choice
JOIN "class_choice_group_data" choice_group
    ON choice_group."exclusiveKey" = choice."groupKey"
    AND choice_group."type" IN ('spell', 'cantrip')
LEFT JOIN "class_choice_option_data" option
    ON option."choiceGroupId" = choice_group."id"
    AND option."optionKey" = choice."optionKey"
LEFT JOIN "character_class_relation" entry
    ON entry."id" = choice."classEntryId"
CROSS JOIN LATERAL (
    SELECT nullif(trim(coalesce(
        choice."selectedSpellKey",
        option."grantedSpellKeys" ->> 0,
        choice."selectedText",
        option."name",
        choice."optionKey"
    )), '') AS "rawSpellKey"
) raw_value
CROSS JOIN LATERAL (
    SELECT regexp_replace(
        regexp_replace(lower(raw_value."rawSpellKey"), '[^a-z0-9]+', '_', 'g'),
        '^_+|_+$',
        '',
        'g'
    ) AS "spellKey"
) resolved
LEFT JOIN "spell_data" spell
    ON lower(spell."referenceKey") = lower(resolved."spellKey")
    OR lower(spell."name") = lower(raw_value."rawSpellKey")
WHERE raw_value."rawSpellKey" IS NOT NULL;

DELETE FROM "character_choice_data" choice
USING "class_choice_group_data" choice_group
WHERE choice_group."exclusiveKey" = choice."groupKey"
    AND choice_group."type" IN ('spell', 'cantrip');

DELETE FROM "class_choice_option_data" option
USING "class_choice_group_data" choice_group
WHERE option."choiceGroupId" = choice_group."id"
    AND choice_group."type" IN ('spell', 'cantrip');

DELETE FROM "class_choice_group_data"
WHERE "type" IN ('spell', 'cantrip');

DO $$
DECLARE
    sequence_row record;
BEGIN
    FOR sequence_row IN
        SELECT
            table_schema,
            table_name,
            column_name,
            pg_get_serial_sequence(
                format('%I.%I', table_schema, table_name),
                column_name
            ) AS sequence_name
        FROM information_schema.columns
        WHERE table_schema = 'public'
            AND column_default LIKE 'nextval(%'
    LOOP
        IF sequence_row.sequence_name IS NOT NULL THEN
            EXECUTE format(
                'SELECT setval(%L, coalesce((SELECT max(%I) FROM %I.%I), 0) + 1, false)',
                sequence_row.sequence_name,
                sequence_row.column_name,
                sequence_row.table_schema,
                sequence_row.table_name
            );
        END IF;
    END LOOP;
END $$;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_choice_data" DROP COLUMN "selectedSpellKey";
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "character_spell_selection_data"
    ADD CONSTRAINT "character_spell_selection_data_fk_0"
    FOREIGN KEY("characterId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_spell_selection_data"
    ADD CONSTRAINT "character_spell_selection_data_fk_1"
    FOREIGN KEY("classEntryId")
    REFERENCES "character_class_relation"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_spell_selection_data"
    ADD CONSTRAINT "character_spell_selection_data_fk_2"
    FOREIGN KEY("classDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_spell_selection_data"
    ADD CONSTRAINT "character_spell_selection_data_fk_3"
    FOREIGN KEY("spellId")
    REFERENCES "spell_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260426231929971-extract-class-spell-selections', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260426231929971-extract-class-spell-selections', "timestamp" = now();

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
