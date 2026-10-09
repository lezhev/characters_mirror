BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" ADD COLUMN "spellRecoveryTriggers" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "choice_group_data" ADD COLUMN "autoSelectSingleEligible" boolean;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "feature_resource_effect_data" ADD COLUMN "recoveryPolicy" json;

-- Conditional grants use the same option and grant projection as other choices.
DO $feature_choices$
DECLARE
  feature_id bigint;
  wizard_id bigint;
  group_id bigint;
BEGIN
  SELECT f.id, s."parentClassId" INTO feature_id, wizard_id
  FROM subclass_feature_data f JOIN subclass_data s ON s.id = f."parentSubclassId"
  WHERE f."referenceKey" = 'wizard_illusion_improved_minor_illusion';
  IF feature_id IS NOT NULL THEN
    INSERT INTO choice_group_data ("referenceKey", "name", "sourceSubclassFeatureId",
      "level", "type", "selectionCount", "minimumSelectionCount", "autoSelectSingleEligible",
      "allowDuplicates", "sortOrder", "source", "version", "createdAt", "updatedAt")
    VALUES ('wizard_illusion_improved_minor_illusion_cantrip',
      (SELECT name FROM subclass_feature_data WHERE id = feature_id), feature_id,
      2, 'custom', 1, 1, true, false, 0, 'PHB 2014', 1, now(), now())
    ON CONFLICT ("referenceKey") DO UPDATE SET "autoSelectSingleEligible" = true,
      "minimumSelectionCount" = 1, "selectionCount" = 1, "updatedAt" = now()
    RETURNING id INTO group_id;

    INSERT INTO choice_option_data ("choiceGroupId", "optionKey", "name", "sortOrder",
      "requirements", "grantedSpellKeys", "source", "version", "createdAt", "updatedAt")
    SELECT group_id, s."referenceKey", s.name, row_number() OVER (ORDER BY s.name),
      CASE WHEN s."referenceKey" = 'minor_illusion' THEN
        json_build_array(json_build_object('type', 'knownCantrip', 'referenceKey', 'minor_illusion', 'negate', true))
      ELSE json_build_array(
        json_build_object('type', 'knownCantrip', 'referenceKey', 'minor_illusion'),
        json_build_object('type', 'knownCantrip', 'referenceKey', s."referenceKey", 'negate', true)) END,
      json_build_array(s."referenceKey"), 'PHB 2014', 1, now(), now()
    FROM spell_data s WHERE s.level = 0 AND
      (s."referenceKey" = 'minor_illusion' OR s."availableForClassIds"::jsonb @> jsonb_build_array(wizard_id))
    ON CONFLICT ("choiceGroupId", "optionKey") DO UPDATE SET
      "requirements" = EXCLUDED."requirements", "grantedSpellKeys" = EXCLUDED."grantedSpellKeys",
      "updatedAt" = now();

    DELETE FROM class_spell_grant_data WHERE "sourceSubclassFeatureId" = feature_id
      AND "choiceOptionId" IS NULL AND "spellId" IN
        (SELECT id FROM spell_data WHERE "referenceKey" = 'minor_illusion');
    UPDATE subclass_feature_data SET "grantedSpellKeys" =
      (SELECT coalesce(json_agg(k), '[]') FROM json_array_elements_text("grantedSpellKeys") k WHERE k <> 'minor_illusion')
      WHERE id = feature_id AND "grantedSpellKeys"::jsonb ? 'minor_illusion';
  END IF;
END $feature_choices$;

-- A small recovery policy binds an atomic restore to its canonical resource.
DO $slot_recovery$
DECLARE
  spec record;
  class_feature_id bigint;
  subclass_feature_id bigint;
  policy json;
  budget json;
BEGIN
  SELECT json_agg(json_build_object('k', n, 'v', (n + 1) / 2) ORDER BY n)
    INTO budget FROM generate_series(1, 20) n;
  FOR spec IN SELECT * FROM (VALUES
    ('wizard_arcane_recovery', 'levelBudget', 'arcaneRecovery', 'spellSlots', 'shortRest', 'dawn', 5, NULL::int, NULL::text, NULL::int),
    ('druid_land_natural_recovery', 'levelBudget', 'naturalRecovery', 'spellSlots', 'shortRest', 'longRest', 5, NULL::int, NULL::text, NULL::int),
    ('wizard_divination_expert_divination', 'singleLowerLevel', NULL, 'spellSlots', 'spellCast', NULL, 5, 2, 'divination', NULL::int),
    ('warlock_eldritch_master', 'all', 'eldritchMaster', 'pactSlots', 'manual', 'longRest', 9, NULL::int, NULL::text, 60)
  ) AS v(key, mode, resource, target, trigger, reset, maximum, minimum_cast, school, seconds)
  LOOP
    class_feature_id := NULL;
    subclass_feature_id := NULL;
    SELECT id INTO class_feature_id FROM class_feature_data WHERE "referenceKey" = spec.key;
    SELECT id INTO subclass_feature_id FROM subclass_feature_data WHERE "referenceKey" = spec.key;
    IF class_feature_id IS NULL AND subclass_feature_id IS NULL THEN CONTINUE; END IF;
    policy := jsonb_strip_nulls(jsonb_build_object('mode', spec.mode, 'resourceKey', spec.resource,
      'levelBudgetBySourceLevel', CASE WHEN spec.mode = 'levelBudget' THEN budget ELSE NULL END,
      'maximumSlotLevel', spec.maximum, 'minimumCastLevel', spec.minimum_cast,
      'spellSchool', spec.school, 'activationSeconds', spec.seconds))::json;

    UPDATE feature_resource_effect_data SET "recoveryPolicy" = policy,
      "activationTrigger" = spec.trigger, "usageResetOn" = spec.reset
    WHERE "type" = 'restore' AND "targetType" = spec.target AND "choiceOptionId" IS NULL
      AND ("classFeatureId" = class_feature_id OR "subclassFeatureId" = subclass_feature_id);
    IF NOT FOUND THEN
      INSERT INTO feature_resource_effect_data ("classFeatureId", "subclassFeatureId", "type",
        "targetType", "activationTrigger", "usageResetOn", "recoveryPolicy")
      VALUES (class_feature_id, subclass_feature_id, 'restore', spec.target, spec.trigger, spec.reset, policy);
    END IF;
    IF spec.resource IS NOT NULL THEN
      UPDATE feature_resource_definition_data SET "resetOn" = spec.reset,
        "usageResetOn" = spec.reset, "activationTrigger" = spec.trigger
      WHERE "key" = spec.resource AND "choiceOptionId" IS NULL
        AND ("classFeatureId" = class_feature_id OR "subclassFeatureId" = subclass_feature_id);
      IF NOT FOUND THEN
        INSERT INTO feature_resource_definition_data ("classFeatureId", "subclassFeatureId", "key", "name",
          "kind", "maxRule", "maxValue", "resetOn", "activationTrigger", "usageResetOn")
        VALUES (class_feature_id, subclass_feature_id, spec.resource,
          coalesce((SELECT name FROM class_feature_data WHERE id = class_feature_id),
                   (SELECT name FROM subclass_feature_data WHERE id = subclass_feature_id)),
          'uses', 'fixed', 1, spec.reset, spec.trigger, spec.reset);
      END IF;
    END IF;
  END LOOP;
END $slot_recovery$;

UPDATE subclass_feature_data SET "shortDescription" =
  'Вы изучаете заговор «Малая иллюзия», не учитывая его в количестве известных вам заговоров. Если он уже известен, изучите вместо него другой заговор волшебника. При наложении «Малой иллюзии» вы можете одновременно создать звук и изображение.',
  "version" = coalesce("version", 0) + 1, "updatedAt" = now()
WHERE "referenceKey" = 'wizard_illusion_improved_minor_illusion';
UPDATE subclass_feature_data SET "shortDescription" =
  'Когда вы накладываете заклинание Прорицания 2-го уровня или выше, используя ячейку, восстановите одну потраченную ячейку более низкого уровня, но не выше 5-го.',
  "version" = coalesce("version", 0) + 1, "updatedAt" = now()
WHERE "referenceKey" = 'wizard_divination_expert_divination';
UPDATE class_feature_data SET "shortDescription" =
  'Потратив 1 минуту на обращение к покровителю, восстановите все потраченные ячейки Магии договора. Повторно использовать умение можно после продолжительного отдыха.',
  "version" = coalesce("version", 0) + 1, "updatedAt" = now()
WHERE "referenceKey" = 'warlock_eldritch_master';
UPDATE subclass_feature_data SET "shortDescription" =
  'Когда вы восстанавливаете хиты существу заклинанием 1-го уровня или выше, оно восстанавливает дополнительные хиты.',
  "description" = replace("description", 'заклинание ? 1-го', 'заклинание 1-го'),
  "version" = coalesce("version", 0) + 1, "updatedAt" = now()
WHERE "referenceKey" = 'cleric_life_disciple_of_life';
UPDATE subclass_feature_data SET "shortDescription" =
  'Ваша драконья кровь делает вас более стойким и защищает тело даже без доспехов.',
  "version" = coalesce("version", 0) + 1, "updatedAt" = now()
WHERE "referenceKey" = 'sorcerer_draconic_bloodline_draconic_resilience';

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261007182600000-feature-choice-slot-recovery', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007182600000-feature-choice-slot-recovery', "timestamp" = now();

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
