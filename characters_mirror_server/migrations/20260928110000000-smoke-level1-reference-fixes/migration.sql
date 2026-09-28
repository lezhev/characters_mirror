BEGIN;

-- The canonical shield is an armor catalog row; both server and offline AC use bonusAC.
UPDATE "armor_data"
SET "bonusAC" = 2
WHERE "referenceKey" = 'shield' AND "categoryValue" = 'shield'
  AND "bonusAC" IS DISTINCT FROM 2;

WITH bonus_group AS (
  INSERT INTO "choice_group_data" (
    "referenceKey", "name", "sourceRaceId", "type", "selectionCount",
    "minimumSelectionCount", "allowDuplicates", "sortOrder", "source"
  )
  SELECT 'half_elf_ability_score_increase', 'Увеличение характеристик', 7,
         'abilityIncrease', 2, 2, false, 10, 'PHB 2014'
  WHERE EXISTS (SELECT 1 FROM "race_data" WHERE "id" = 7)
  ON CONFLICT ("referenceKey") DO UPDATE SET
    "sourceRaceId" = EXCLUDED."sourceRaceId",
    "sourceRaceFeatureId" = NULL,
    "sourceFeatureId" = NULL,
    "sourceSubraceId" = NULL,
    "sourceClassId" = NULL,
    "sourceSubclassId" = NULL,
    "sourceSubclassFeatureId" = NULL,
    "sourceBackgroundId" = NULL,
    "type" = EXCLUDED."type",
    "selectionCount" = EXCLUDED."selectionCount",
    "minimumSelectionCount" = EXCLUDED."minimumSelectionCount",
    "allowDuplicates" = EXCLUDED."allowDuplicates",
    "sortOrder" = EXCLUDED."sortOrder",
    "source" = EXCLUDED."source"
  RETURNING "id"
)
INSERT INTO "choice_option_data" (
  "choiceGroupId", "optionKey", "name", "sortOrder",
  "grantedAbilityBonuses", "source"
)
SELECT bonus_group."id", ability."key", ability."name",
       ability."sort_order", json_build_object(ability."key", 1), 'PHB 2014'
FROM bonus_group
CROSS JOIN (VALUES
  ('strength', 'Сила', 1),
  ('dexterity', 'Ловкость', 2),
  ('constitution', 'Телосложение', 3),
  ('intelligence', 'Интеллект', 4),
  ('wisdom', 'Мудрость', 5)
) AS ability("key", "name", "sort_order")
ON CONFLICT ("choiceGroupId", "optionKey") DO UPDATE SET
  "sortOrder" = EXCLUDED."sortOrder",
  "grantedAbilityBonuses" = EXCLUDED."grantedAbilityBonuses",
  "source" = EXCLUDED."source";

WITH terrain_group AS (
  INSERT INTO "choice_group_data" (
    "referenceKey", "name", "sourceFeatureId", "level", "type",
    "selectionCount", "minimumSelectionCount", "allowDuplicates",
    "sortOrder", "source"
  )
  SELECT 'class_feature_80_favored_terrain', 'Избранная местность', 80, 1,
         'featureOption', 1, 1, false, 10, 'PHB 2014'
  WHERE EXISTS (SELECT 1 FROM "class_feature_data" WHERE "id" = 80 AND "level" = 1)
  ON CONFLICT ("referenceKey") DO UPDATE SET
    "name" = EXCLUDED."name",
    "sourceFeatureId" = EXCLUDED."sourceFeatureId",
    "level" = EXCLUDED."level",
    "type" = EXCLUDED."type",
    "selectionCount" = EXCLUDED."selectionCount",
    "minimumSelectionCount" = EXCLUDED."minimumSelectionCount",
    "allowDuplicates" = EXCLUDED."allowDuplicates",
    "sortOrder" = EXCLUDED."sortOrder",
    "source" = EXCLUDED."source"
  RETURNING "id"
)
INSERT INTO "choice_option_data" (
  "choiceGroupId", "optionKey", "name", "sortOrder", "source"
)
SELECT terrain_group."id", terrain."key", terrain."name",
       terrain."sort_order", 'PHB 2014'
FROM terrain_group
CROSS JOIN (VALUES
  ('arctic', 'Арктика', 1),
  ('swamp', 'Болота', 2),
  ('mountain', 'Горы', 3),
  ('forest', 'Леса', 4),
  ('grassland', 'Луга', 5),
  ('coast', 'Побережье', 6),
  ('underdark', 'Подземье', 7),
  ('desert', 'Пустыня', 8)
) AS terrain("key", "name", "sort_order")
ON CONFLICT ("choiceGroupId", "optionKey") DO UPDATE SET
  "name" = EXCLUDED."name",
  "sortOrder" = EXCLUDED."sortOrder",
  "source" = EXCLUDED."source";

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
VALUES ('characters_mirror', '20260928110000000-smoke-level1-reference-fixes', now())
ON CONFLICT ("module") DO UPDATE SET
  "version" = EXCLUDED."version", "timestamp" = now();

COMMIT;
