BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_spell_selection_data" ADD COLUMN "selectionFilter" json;
ALTER TABLE "character_spell_selection_data" ADD COLUMN "selectionRuleLevel" bigint;
ALTER TABLE "character_spell_selection_data" ADD COLUMN "selectionUnrestricted" boolean;
ALTER TABLE "character_spell_selection_data" ADD COLUMN "spellReplacementHistory" json;

-- An off-school spell could only have used an unrestricted selection. Keep
-- in-school legacy rows unknown because their original slot cannot be inferred.
UPDATE "character_spell_selection_data" selection
SET "selectionFilter" = subclass."spellSelectionFilter",
    "selectionUnrestricted" = TRUE
FROM "character_class_relation" entry,
     "subclass_data" subclass,
     "spell_data" spell
WHERE selection."classEntryId" = entry.id
  AND subclass.id = entry."subclassId"
  AND spell.id = selection."spellId"
  AND selection.kind = 'knownSpell'
  AND subclass."referenceKey" IN (
    'fighter_eldritch_knight',
    'rogue_arcane_trickster'
  )
  AND subclass."spellSelectionFilter" IS NOT NULL
  AND NOT (
    subclass."spellSelectionFilter"::jsonb -> 'schools'
    @> jsonb_build_array(spell."schoolValue")
  );

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261007231250296-spell-selection-provenance', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007231250296-spell-selection-provenance', "timestamp" = now();

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
