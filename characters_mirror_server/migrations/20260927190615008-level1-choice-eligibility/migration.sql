BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "choice_option_data" ADD COLUMN "grantedExpertiseSkills" json;
ALTER TABLE "choice_option_data" ADD COLUMN "grantedExpertiseToolKeys" json;
ALTER TABLE "choice_option_data" ADD COLUMN "requiredExistingSkill" text;
ALTER TABLE "choice_option_data" ADD COLUMN "requiredExistingToolKey" text;

-- Keep the level-1 reference-data changes limited to the requested class features.
UPDATE "class_feature_data"
SET "grantedLanguages" = (
    SELECT json_agg(language ORDER BY language)
    FROM (
        SELECT json_array_elements_text(
            COALESCE("class_feature_data"."grantedLanguages", '[]'::json)
        ) AS language
        UNION
        SELECT 'druidic'
    ) AS languages
)
WHERE "id" = 31 AND "level" = 1;

UPDATE "class_feature_data"
SET "grantedLanguages" = (
    SELECT json_agg(language ORDER BY language)
    FROM (
        SELECT json_array_elements_text(
            COALESCE("class_feature_data"."grantedLanguages", '[]'::json)
        ) AS language
        UNION
        SELECT 'thievesCant'
    ) AS languages
)
WHERE "id" = 94 AND "level" = 1;

UPDATE "class_feature_data"
SET "unarmoredDefenseRule" = 'dexterityConstitution'
WHERE "id" = 1 AND "level" = 1;

UPDATE "class_feature_data"
SET "unarmoredDefenseRule" = 'dexterityWisdom'
WHERE "id" = 46 AND "level" = 1;

WITH feature_group AS (
    INSERT INTO "choice_group_data" (
        "referenceKey", "name", "sourceFeatureId", "level", "type",
        "selectionCount", "allowDuplicates", "sortOrder", "source"
    ) SELECT
        'class_feature_39_fighting_style', 'Боевой стиль', 39, 1,
        'fightingStyle', 1, false, 10, 'class-feature-migration'
    WHERE EXISTS (
        SELECT 1 FROM "class_feature_data" WHERE "id" = 39 AND "level" = 1
    )
    ON CONFLICT ("referenceKey") DO UPDATE SET
        "name" = EXCLUDED."name",
        "sourceFeatureId" = EXCLUDED."sourceFeatureId",
        "sourceSubclassFeatureId" = NULL,
        "sourceClassId" = NULL,
        "sourceSubclassId" = NULL,
        "sourceRaceId" = NULL,
        "sourceSubraceId" = NULL,
        "sourceRaceFeatureId" = NULL,
        "sourceBackgroundId" = NULL,
        "level" = EXCLUDED."level",
        "type" = EXCLUDED."type",
        "selectionCount" = EXCLUDED."selectionCount",
        "allowDuplicates" = EXCLUDED."allowDuplicates",
        "sortOrder" = EXCLUDED."sortOrder",
        "source" = EXCLUDED."source"
    RETURNING "id"
)
INSERT INTO "choice_option_data" (
    "choiceGroupId", "optionKey", "name", "sortOrder", "source"
)
SELECT feature_group."id", option."key", option."name", option."sort_order",
       'class-feature-migration'
FROM feature_group
CROSS JOIN (VALUES
    ('archery', 'Стрельба', 1),
    ('defense', 'Оборона', 2),
    ('dueling', 'Дуэлянт', 3),
    ('great_weapon_fighting', 'Сражение большим оружием', 4),
    ('protection', 'Защита', 5),
    ('two_weapon_fighting', 'Сражение двумя оружиями', 6),
    ('interception', 'Перехват', 7),
    ('superior_technique', 'Превосходная техника', 8),
    ('blind_fighting', 'Сражение вслепую', 9),
    ('unarmed_fighting', 'Сражение голыми руками', 10),
    ('thrown_weapon_fighting', 'Сражение метательным оружием', 11)
) AS option("key", "name", "sort_order")
ON CONFLICT ("choiceGroupId", "optionKey") DO UPDATE SET
    "name" = EXCLUDED."name",
    "description" = CASE WHEN EXCLUDED."optionKey" IN (
        'interception', 'superior_technique', 'blind_fighting',
        'unarmed_fighting', 'thrown_weapon_fighting'
    ) THEN 'Опциональный вариант' ELSE NULL END,
    "sortOrder" = EXCLUDED."sortOrder",
    "source" = EXCLUDED."source";

WITH feature_group AS (
    INSERT INTO "choice_group_data" (
        "referenceKey", "name", "sourceFeatureId", "level", "type",
        "selectionCount", "allowDuplicates", "sortOrder", "source"
    ) SELECT
        'class_feature_92_expertise', 'Компетентность', 92, 1,
        'expertise', 2, false, 10, 'class-feature-migration'
    WHERE EXISTS (
        SELECT 1 FROM "class_feature_data" WHERE "id" = 92 AND "level" = 1
    )
    ON CONFLICT ("referenceKey") DO UPDATE SET
        "name" = EXCLUDED."name",
        "sourceFeatureId" = EXCLUDED."sourceFeatureId",
        "sourceSubclassFeatureId" = NULL,
        "sourceClassId" = NULL,
        "sourceSubclassId" = NULL,
        "sourceRaceId" = NULL,
        "sourceSubraceId" = NULL,
        "sourceRaceFeatureId" = NULL,
        "sourceBackgroundId" = NULL,
        "level" = EXCLUDED."level",
        "type" = EXCLUDED."type",
        "selectionCount" = EXCLUDED."selectionCount",
        "allowDuplicates" = EXCLUDED."allowDuplicates",
        "sortOrder" = EXCLUDED."sortOrder",
        "source" = EXCLUDED."source"
    RETURNING "id"
)
INSERT INTO "choice_option_data" (
    "choiceGroupId", "optionKey", "name", "sortOrder",
    "grantedExpertiseSkills", "requiredExistingSkill", "source"
)
SELECT feature_group."id", option."key", option."name", option."sort_order",
       to_json(ARRAY[option."key"]), option."key", 'class-feature-migration'
FROM feature_group
CROSS JOIN (VALUES
    ('acrobatics', 'Акробатика', 1),
    ('animalHandling', 'Уход за животными', 2),
    ('arcana', 'Магия', 3),
    ('athletics', 'Атлетика', 4),
    ('deception', 'Обман', 5),
    ('history', 'История', 6),
    ('insight', 'Проницательность', 7),
    ('intimidation', 'Запугивание', 8),
    ('investigation', 'Расследование', 9),
    ('medicine', 'Медицина', 10),
    ('nature', 'Природа', 11),
    ('perception', 'Внимательность', 12),
    ('performance', 'Выступление', 13),
    ('persuasion', 'Убеждение', 14),
    ('religion', 'Религия', 15),
    ('sleightOfHand', 'Ловкость рук', 16),
    ('stealth', 'Скрытность', 17),
    ('survival', 'Выживание', 18)
) AS option("key", "name", "sort_order")
ON CONFLICT ("choiceGroupId", "optionKey") DO UPDATE SET
    "name" = EXCLUDED."name",
    "sortOrder" = EXCLUDED."sortOrder",
    "grantedExpertiseSkills" = EXCLUDED."grantedExpertiseSkills",
    "requiredExistingSkill" = EXCLUDED."requiredExistingSkill",
    "source" = EXCLUDED."source";

WITH feature_group AS (
    SELECT "id" FROM "choice_group_data"
    WHERE "referenceKey" = 'class_feature_92_expertise'
)
INSERT INTO "choice_option_data" (
    "choiceGroupId", "optionKey", "name", "sortOrder",
    "grantedExpertiseToolKeys", "requiredExistingToolKey", "source"
)
SELECT feature_group."id", 'thieves_tools', 'Воровские инструменты', 19,
       '["thieves_tools"]'::json, 'thieves_tools', 'class-feature-migration'
FROM feature_group
ON CONFLICT ("choiceGroupId", "optionKey") DO UPDATE SET
    "name" = EXCLUDED."name",
    "sortOrder" = EXCLUDED."sortOrder",
    "grantedExpertiseToolKeys" = EXCLUDED."grantedExpertiseToolKeys",
    "requiredExistingToolKey" = EXCLUDED."requiredExistingToolKey",
    "source" = EXCLUDED."source";

WITH feature_group AS (
    INSERT INTO "choice_group_data" (
        "referenceKey", "name", "sourceFeatureId", "level", "type",
        "selectionCount", "allowDuplicates", "sortOrder", "source"
    ) SELECT
        'class_feature_79_favored_enemy', 'Избранный враг', 79, 1,
        'featureOption', 1, false, 10, 'class-feature-migration'
    WHERE EXISTS (
        SELECT 1 FROM "class_feature_data" WHERE "id" = 79 AND "level" = 1
    )
    ON CONFLICT ("referenceKey") DO UPDATE SET
        "name" = EXCLUDED."name",
        "sourceFeatureId" = EXCLUDED."sourceFeatureId",
        "sourceSubclassFeatureId" = NULL,
        "sourceClassId" = NULL,
        "sourceSubclassId" = NULL,
        "sourceRaceId" = NULL,
        "sourceSubraceId" = NULL,
        "sourceRaceFeatureId" = NULL,
        "sourceBackgroundId" = NULL,
        "level" = EXCLUDED."level",
        "type" = EXCLUDED."type",
        "selectionCount" = EXCLUDED."selectionCount",
        "allowDuplicates" = EXCLUDED."allowDuplicates",
        "sortOrder" = EXCLUDED."sortOrder",
        "source" = EXCLUDED."source"
    RETURNING "id"
)
INSERT INTO "choice_option_data" (
    "choiceGroupId", "optionKey", "name", "sortOrder", "source"
)
SELECT feature_group."id", option."key", option."name", option."sort_order",
       'class-feature-migration'
FROM feature_group
CROSS JOIN (VALUES
    ('aberrations', 'Аберрации', 1),
    ('beasts', 'Звери', 2),
    ('celestials', 'Небожители', 3),
    ('constructs', 'Конструкты', 4),
    ('dragons', 'Драконы', 5),
    ('elementals', 'Элементали', 6),
    ('fey', 'Феи', 7),
    ('fiends', 'Исчадия', 8),
    ('giants', 'Великаны', 9),
    ('monstrosities', 'Монстры', 10),
    ('oozes', 'Слизи', 11),
    ('plants', 'Растения', 12),
    ('undead', 'Нежить', 13),
    ('humanoid_races', 'Две гуманоидные расы', 14)
) AS option("key", "name", "sort_order")
ON CONFLICT ("choiceGroupId", "optionKey") DO UPDATE SET
    "name" = EXCLUDED."name",
    "description" = CASE WHEN EXCLUDED."optionKey" = 'humanoid_races'
        THEN 'Выберите две гуманоидные расы; их названия необходимо указать отдельно.'
        ELSE NULL END,
    "sortOrder" = EXCLUDED."sortOrder",
    "source" = EXCLUDED."source";

WITH feature_group AS (
    INSERT INTO "choice_group_data" (
        "referenceKey", "name", "sourceFeatureId", "level", "type",
        "selectionCount", "allowDuplicates", "sortOrder", "source"
    ) SELECT
        'class_feature_79_favored_enemy_languages', 'Языки избранного врага',
        79, 1, 'language', 2, false, 20, 'class-feature-migration'
    WHERE EXISTS (
        SELECT 1 FROM "class_feature_data" WHERE "id" = 79 AND "level" = 1
    )
    ON CONFLICT ("referenceKey") DO UPDATE SET
        "name" = EXCLUDED."name",
        "sourceFeatureId" = EXCLUDED."sourceFeatureId",
        "sourceSubclassFeatureId" = NULL,
        "sourceClassId" = NULL,
        "sourceSubclassId" = NULL,
        "sourceRaceId" = NULL,
        "sourceSubraceId" = NULL,
        "sourceRaceFeatureId" = NULL,
        "sourceBackgroundId" = NULL,
        "level" = EXCLUDED."level",
        "type" = EXCLUDED."type",
        "selectionCount" = EXCLUDED."selectionCount",
        "allowDuplicates" = EXCLUDED."allowDuplicates",
        "sortOrder" = EXCLUDED."sortOrder",
        "source" = EXCLUDED."source"
    RETURNING "id"
)
INSERT INTO "choice_option_data" (
    "choiceGroupId", "optionKey", "name", "sortOrder",
    "grantedLanguages", "source"
)
SELECT feature_group."id", option."key", option."name", option."sort_order",
       to_json(ARRAY[option."key"]), 'class-feature-migration'
FROM feature_group
CROSS JOIN (VALUES
    ('common', 'Общий', 1),
    ('dwarvish', 'Дварфийский', 2),
    ('elvish', 'Эльфийский', 3),
    ('giant', 'Великаний', 4),
    ('gnomish', 'Гномий', 5),
    ('goblin', 'Гоблинский', 6),
    ('halfling', 'Полуросликов', 7),
    ('orc', 'Орочий', 8),
    ('abyssal', 'Бездны', 9),
    ('celestial', 'Небесный', 10),
    ('draconic', 'Драконий', 11),
    ('deepSpeech', 'Глубинная речь', 12),
    ('infernal', 'Инфернальный', 13),
    ('primordial', 'Первичный', 14),
    ('sylvan', 'Сильван', 15),
    ('undercommon', 'Подземный', 16)
) AS option("key", "name", "sort_order")
ON CONFLICT ("choiceGroupId", "optionKey") DO UPDATE SET
    "name" = EXCLUDED."name",
    "sortOrder" = EXCLUDED."sortOrder",
    "grantedLanguages" = EXCLUDED."grantedLanguages",
    "source" = EXCLUDED."source";

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260927190615008-level1-choice-eligibility', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260927190615008-level1-choice-eligibility', "timestamp" = now();

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
