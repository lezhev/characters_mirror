BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_choice_data" ADD COLUMN "replacementHistory" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" ADD COLUMN "spellActivationUses" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "choice_group_data" ADD COLUMN "progressionKey" text;
ALTER TABLE "choice_group_data" ADD COLUMN "replacementsAllowed" bigint;
ALTER TABLE "choice_group_data" ADD COLUMN "replacementProgressionKeys" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_data" ADD COLUMN "spellSelectionFilter" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_spell_grant_data" ADD COLUMN "activation" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_feature_spell_grant_data" ADD COLUMN "activation" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_data" ADD COLUMN "spellSelectionFilter" json;

-- Small pilots for the three generic contracts; existing prose is retained.
UPDATE subclass_data SET
  "spellcastingStartLevel" = 3,
  "spellcastingProgression" = 'third',
  "spellSelectionMode" = 'known',
  "spellcastingAbilityValue" = 'intelligence',
  "spellSelectionFilter" = jsonb_build_object(
    'spellListClassKey', 'wizard',
    'schools', CASE WHEN "referenceKey" = 'fighter_eldritch_knight'
      THEN '["abjuration","evocation"]'::jsonb ELSE '["enchantment","illusion"]'::jsonb END,
    'kinds', '["knownSpell"]'::jsonb,
    'unrestrictedChoicesByLevel', '{"3":1,"8":2,"14":3,"20":4}'::jsonb)
WHERE "referenceKey" IN ('fighter_eldritch_knight', 'rogue_arcane_trickster');

INSERT INTO class_level_data ("classDataId", "subclassDataId", level,
  "knownCantrips", "knownSpells", "knownSpellReplacements", source, version)
SELECT s."parentClassId", s.id, l.level,
  CASE WHEN l.level < 10 THEN 2 ELSE 3 END,
  CASE WHEN l.level < 4 THEN 3 WHEN l.level < 7 THEN 4 WHEN l.level < 8 THEN 5
    WHEN l.level < 10 THEN 6 WHEN l.level < 11 THEN 7 WHEN l.level < 13 THEN 8
    WHEN l.level < 14 THEN 9 WHEN l.level < 16 THEN 10 WHEN l.level < 19 THEN 11
    WHEN l.level < 20 THEN 12 ELSE 13 END, 1, s.source, 1
FROM subclass_data s CROSS JOIN generate_series(3,20) l(level)
WHERE s."referenceKey" IN ('fighter_eldritch_knight', 'rogue_arcane_trickster')
  AND NOT EXISTS (SELECT 1 FROM class_level_data p
    WHERE p."subclassDataId" = s.id AND p.level = l.level);

UPDATE choice_group_data SET "progressionKey" = regexp_replace("referenceKey", '_3$', ''),
  "replacementsAllowed" = 0, "allowDuplicates" = false
WHERE "referenceKey" IN ('fighter_battle_master_maneuvers_3', 'monk_four_elements_disciplines_3');

DO $$
DECLARE base_group choice_group_data%ROWTYPE; tier integer; group_id bigint;
BEGIN
  FOR base_group IN SELECT * FROM choice_group_data
    WHERE "referenceKey" IN ('fighter_battle_master_maneuvers_3', 'monk_four_elements_disciplines_3') LOOP
    FOREACH tier IN ARRAY CASE WHEN base_group."referenceKey" = 'fighter_battle_master_maneuvers_3'
      THEN ARRAY[7,10,15] ELSE ARRAY[6,11,17] END LOOP
      SELECT id INTO group_id FROM choice_group_data
        WHERE "referenceKey" = base_group."progressionKey" || '_' || tier;
      IF group_id IS NULL THEN
        group_id := nextval(pg_get_serial_sequence('choice_group_data', 'id'));
        INSERT INTO choice_group_data SELECT (jsonb_populate_record(NULL::choice_group_data,
          to_jsonb(base_group) || jsonb_build_object('id', group_id,
            'referenceKey', base_group."progressionKey" || '_' || tier,
            'level', tier, 'selectionCount', CASE WHEN base_group."selectionCount" = 3 THEN 2 ELSE 1 END,
            'minimumSelectionCount', CASE WHEN base_group."selectionCount" = 3 THEN 2 ELSE 1 END,
            'replacementsAllowed', 1))).*;
      END IF;
      INSERT INTO choice_option_data SELECT (jsonb_populate_record(NULL::choice_option_data,
        to_jsonb(o) || jsonb_build_object('id', nextval(pg_get_serial_sequence('choice_option_data', 'id')),
          'choiceGroupId', group_id))).*
      FROM choice_option_data o WHERE o."choiceGroupId" = base_group.id
        AND NOT EXISTS (SELECT 1 FROM choice_option_data n
          WHERE n."choiceGroupId" = group_id AND n."optionKey" = o."optionKey");
    END LOOP;
  END LOOP;
END $$;

INSERT INTO class_spell_grant_data ("spellId", "sourceSubclassFeatureId",
  "choiceOptionId", "grantedAtLevel", "alwaysPrepared", activation, source, version)
SELECT s.id, g."sourceSubclassFeatureId", o.id, g.level, true,
  jsonb_build_object('canUseStandardSlots', false, 'canUsePactSlots', false,
    'slotless', true, 'atWill', false, 'resourceKey', 'ki', 'resourceCost', 2,
    'castAtSpellLevel', s.level), o.source, 1
FROM choice_option_data o JOIN choice_group_data g ON g.id = o."choiceGroupId"
JOIN spell_data s ON s."referenceKey" = CASE o."optionKey"
  WHEN 'sweeping_cinder_strike' THEN 'burning_hands'
  WHEN 'fist_of_four_thunders' THEN 'thunderwave'
  WHEN 'rush_of_gale_spirits' THEN 'gust_of_wind' END
WHERE g."progressionKey" = 'monk_four_elements_disciplines'
  AND NOT EXISTS (SELECT 1 FROM class_spell_grant_data x
    WHERE x."choiceOptionId" = o.id AND x."spellId" = s.id);


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261007220404658-spell-activation-selection-replacement', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007220404658-spell-activation-selection-replacement', "timestamp" = now();

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
