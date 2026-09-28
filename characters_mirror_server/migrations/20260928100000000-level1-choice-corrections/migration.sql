BEGIN;

UPDATE "choice_option_data" option
SET "source" = CASE option."optionKey"
    WHEN 'archery' THEN 'PHB 2014'
    WHEN 'defense' THEN 'PHB 2014'
    WHEN 'dueling' THEN 'PHB 2014'
    WHEN 'great_weapon_fighting' THEN 'PHB 2014'
    WHEN 'protection' THEN 'PHB 2014'
    WHEN 'two_weapon_fighting' THEN 'PHB 2014'
    ELSE 'Tasha''s Cauldron of Everything'
END
FROM "choice_group_data" group_data
WHERE option."choiceGroupId" = group_data."id"
  AND group_data."referenceKey" = 'class_feature_39_fighting_style'
  AND option."optionKey" IN (
      'archery', 'defense', 'dueling', 'great_weapon_fighting', 'protection',
      'two_weapon_fighting', 'interception', 'superior_technique',
      'blind_fighting', 'unarmed_fighting', 'thrown_weapon_fighting'
  );

UPDATE "choice_group_data"
SET "selectionCount" = 1,
    "minimumSelectionCount" = 1
WHERE "referenceKey" = 'class_feature_79_favored_enemy';

UPDATE "choice_group_data"
SET "selectionCount" = 1,
    "minimumSelectionCount" = 1
WHERE "referenceKey" = 'class_feature_79_favored_enemy_languages';

DELETE FROM "choice_option_data" option
USING "choice_group_data" group_data
WHERE option."choiceGroupId" = group_data."id"
  AND group_data."referenceKey" = 'class_feature_79_favored_enemy'
  AND option."optionKey" = 'humanoid_races';

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260928100000000-level1-choice-corrections', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928100000000-level1-choice-corrections', "timestamp" = now();

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
