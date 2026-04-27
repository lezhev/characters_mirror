BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "background_data" ADD COLUMN "availableSkills" json;
ALTER TABLE "background_data" ADD COLUMN "skillCount" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "character_skill_selection_data" (
    "id" bigserial PRIMARY KEY,
    "syncId" text,
    "characterId" bigint NOT NULL,
    "classEntryId" bigint,
    "classDataId" bigint,
    "backgroundDataId" bigint,
    "skill" text,
    "kind" text,
    "selectionIndex" bigint,
    "updatedAt" timestamp without time zone
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "character_skill_selection_data"
    ADD CONSTRAINT "character_skill_selection_data_fk_0"
    FOREIGN KEY("characterId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_skill_selection_data"
    ADD CONSTRAINT "character_skill_selection_data_fk_1"
    FOREIGN KEY("classEntryId")
    REFERENCES "character_class_relation"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_skill_selection_data"
    ADD CONSTRAINT "character_skill_selection_data_fk_2"
    FOREIGN KEY("classDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_skill_selection_data"
    ADD CONSTRAINT "character_skill_selection_data_fk_3"
    FOREIGN KEY("backgroundDataId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- DATA MIGRATION: move class/background skill choices out of ClassChoiceGroupData
--
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM "class_choice_group_data"
        WHERE "type" = 'skill'
          AND "sourceClassId" IS NULL
          AND "sourceBackgroundId" IS NULL
    ) THEN
        RAISE EXCEPTION 'Unsupported skill choice groups found: only sourceClassId/sourceBackgroundId skill groups can be migrated automatically.';
    END IF;
END $$;

WITH skill_tokens("skill", "tokens") AS (
    VALUES
        ('acrobatics', ARRAY['acrobatics', 'Acrobatics', 'Акробатика']),
        ('animalHandling', ARRAY['animalHandling', 'animal handling', 'Animal Handling', 'Уход за животными']),
        ('arcana', ARRAY['arcana', 'Arcana', 'Магия']),
        ('athletics', ARRAY['athletics', 'Athletics', 'Атлетика']),
        ('deception', ARRAY['deception', 'Deception', 'Обман']),
        ('history', ARRAY['history', 'History', 'История']),
        ('insight', ARRAY['insight', 'Insight', 'Проницательность']),
        ('intimidation', ARRAY['intimidation', 'Intimidation', 'Запугивание']),
        ('investigation', ARRAY['investigation', 'Investigation', 'Анализ']),
        ('medicine', ARRAY['medicine', 'Medicine', 'Медицина']),
        ('nature', ARRAY['nature', 'Nature', 'Природа']),
        ('perception', ARRAY['perception', 'Perception', 'Восприятие']),
        ('performance', ARRAY['performance', 'Performance', 'Выступление']),
        ('persuasion', ARRAY['persuasion', 'Persuasion', 'Убеждение']),
        ('religion', ARRAY['religion', 'Religion', 'Религия']),
        ('sleightOfHand', ARRAY['sleightOfHand', 'sleight of hand', 'Sleight of Hand', 'Ловкость рук']),
        ('stealth', ARRAY['stealth', 'Stealth', 'Скрытность']),
        ('survival', ARRAY['survival', 'Survival', 'Выживание'])
),
skill_options AS (
    SELECT
        g."id" AS "groupId",
        g."sourceClassId",
        g."sourceBackgroundId",
        g."selectionCount",
        o."id" AS "optionId",
        o."optionKey",
        COALESCE(
            (
                SELECT value
                FROM jsonb_array_elements_text(COALESCE(o."grantedSkills", '[]'::json)::jsonb) AS value
                LIMIT 1
            ),
            token_by_option."skill",
            token_by_name."skill"
        ) AS "skill"
    FROM "class_choice_group_data" g
    JOIN "class_choice_option_data" o ON o."choiceGroupId" = g."id"
    LEFT JOIN skill_tokens token_by_option ON o."optionKey" = ANY(token_by_option."tokens")
    LEFT JOIN skill_tokens token_by_name ON o."name" = ANY(token_by_name."tokens")
    WHERE g."type" = 'skill'
      AND (g."sourceClassId" IS NOT NULL OR g."sourceBackgroundId" IS NOT NULL)
),
class_skill_groups AS (
    SELECT
        "sourceClassId",
        MAX("selectionCount") AS "selectionCount",
        json_agg(DISTINCT "skill" ORDER BY "skill") FILTER (WHERE "skill" IS NOT NULL) AS "skills"
    FROM skill_options
    WHERE "sourceClassId" IS NOT NULL
    GROUP BY "sourceClassId"
)
UPDATE "class_data" cd
SET
    "availableSkills" = COALESCE(class_skill_groups."skills", cd."availableSkills"),
    "skillCount" = COALESCE(class_skill_groups."selectionCount", cd."skillCount")
FROM class_skill_groups
WHERE cd."id" = class_skill_groups."sourceClassId";

WITH skill_tokens("skill", "tokens") AS (
    VALUES
        ('acrobatics', ARRAY['acrobatics', 'Acrobatics', 'Акробатика']),
        ('animalHandling', ARRAY['animalHandling', 'animal handling', 'Animal Handling', 'Уход за животными']),
        ('arcana', ARRAY['arcana', 'Arcana', 'Магия']),
        ('athletics', ARRAY['athletics', 'Athletics', 'Атлетика']),
        ('deception', ARRAY['deception', 'Deception', 'Обман']),
        ('history', ARRAY['history', 'History', 'История']),
        ('insight', ARRAY['insight', 'Insight', 'Проницательность']),
        ('intimidation', ARRAY['intimidation', 'Intimidation', 'Запугивание']),
        ('investigation', ARRAY['investigation', 'Investigation', 'Анализ']),
        ('medicine', ARRAY['medicine', 'Medicine', 'Медицина']),
        ('nature', ARRAY['nature', 'Nature', 'Природа']),
        ('perception', ARRAY['perception', 'Perception', 'Восприятие']),
        ('performance', ARRAY['performance', 'Performance', 'Выступление']),
        ('persuasion', ARRAY['persuasion', 'Persuasion', 'Убеждение']),
        ('religion', ARRAY['religion', 'Religion', 'Религия']),
        ('sleightOfHand', ARRAY['sleightOfHand', 'sleight of hand', 'Sleight of Hand', 'Ловкость рук']),
        ('stealth', ARRAY['stealth', 'Stealth', 'Скрытность']),
        ('survival', ARRAY['survival', 'Survival', 'Выживание'])
),
skill_options AS (
    SELECT
        g."id" AS "groupId",
        g."sourceClassId",
        g."sourceBackgroundId",
        g."selectionCount",
        o."id" AS "optionId",
        o."optionKey",
        COALESCE(
            (
                SELECT value
                FROM jsonb_array_elements_text(COALESCE(o."grantedSkills", '[]'::json)::jsonb) AS value
                LIMIT 1
            ),
            token_by_option."skill",
            token_by_name."skill"
        ) AS "skill"
    FROM "class_choice_group_data" g
    JOIN "class_choice_option_data" o ON o."choiceGroupId" = g."id"
    LEFT JOIN skill_tokens token_by_option ON o."optionKey" = ANY(token_by_option."tokens")
    LEFT JOIN skill_tokens token_by_name ON o."name" = ANY(token_by_name."tokens")
    WHERE g."type" = 'skill'
      AND (g."sourceClassId" IS NOT NULL OR g."sourceBackgroundId" IS NOT NULL)
),
background_skill_groups AS (
    SELECT
        "sourceBackgroundId",
        MAX("selectionCount") AS "selectionCount",
        json_agg(DISTINCT "skill" ORDER BY "skill") FILTER (WHERE "skill" IS NOT NULL) AS "skills"
    FROM skill_options
    WHERE "sourceBackgroundId" IS NOT NULL
    GROUP BY "sourceBackgroundId"
)
UPDATE "background_data" bd
SET
    "availableSkills" = COALESCE(background_skill_groups."skills", bd."availableSkills"),
    "skillCount" = COALESCE(background_skill_groups."selectionCount", bd."skillCount")
FROM background_skill_groups
WHERE bd."id" = background_skill_groups."sourceBackgroundId";

WITH skill_tokens("skill", "tokens") AS (
    VALUES
        ('acrobatics', ARRAY['acrobatics', 'Acrobatics', 'Акробатика']),
        ('animalHandling', ARRAY['animalHandling', 'animal handling', 'Animal Handling', 'Уход за животными']),
        ('arcana', ARRAY['arcana', 'Arcana', 'Магия']),
        ('athletics', ARRAY['athletics', 'Athletics', 'Атлетика']),
        ('deception', ARRAY['deception', 'Deception', 'Обман']),
        ('history', ARRAY['history', 'History', 'История']),
        ('insight', ARRAY['insight', 'Insight', 'Проницательность']),
        ('intimidation', ARRAY['intimidation', 'Intimidation', 'Запугивание']),
        ('investigation', ARRAY['investigation', 'Investigation', 'Анализ']),
        ('medicine', ARRAY['medicine', 'Medicine', 'Медицина']),
        ('nature', ARRAY['nature', 'Nature', 'Природа']),
        ('perception', ARRAY['perception', 'Perception', 'Восприятие']),
        ('performance', ARRAY['performance', 'Performance', 'Выступление']),
        ('persuasion', ARRAY['persuasion', 'Persuasion', 'Убеждение']),
        ('religion', ARRAY['religion', 'Religion', 'Религия']),
        ('sleightOfHand', ARRAY['sleightOfHand', 'sleight of hand', 'Sleight of Hand', 'Ловкость рук']),
        ('stealth', ARRAY['stealth', 'Stealth', 'Скрытность']),
        ('survival', ARRAY['survival', 'Survival', 'Выживание'])
),
migrated_groups AS (
    SELECT
        g.*,
        COALESCE(
            NULLIF(g."exclusiveKey", ''),
            'group_' || COALESCE(g."id"::text, g."name", g."type", 'unknown')
        ) AS "groupKey"
    FROM "class_choice_group_data" g
    WHERE g."type" = 'skill'
      AND (g."sourceClassId" IS NOT NULL OR g."sourceBackgroundId" IS NOT NULL)
),
resolved_choices AS (
    SELECT
        c."id" AS "choiceId",
        c."syncId",
        c."characterId",
        c."classEntryId",
        COALESCE(g."sourceClassId", entry."classDataId") AS "classDataId",
        g."sourceBackgroundId" AS "backgroundDataId",
        COALESCE(
            (
                SELECT value
                FROM jsonb_array_elements_text(COALESCE(o."grantedSkills", '[]'::json)::jsonb) AS value
                LIMIT 1
            ),
            token_by_selected_text."skill",
            token_by_option_key."skill",
            token_by_option_name."skill",
            token_by_choice_option."skill"
        ) AS "skill",
        CASE
            WHEN g."sourceBackgroundId" IS NOT NULL THEN 'backgroundSkill'
            ELSE 'classSkill'
        END AS "kind",
        c."selectionIndex",
        c."updatedAt"
    FROM "character_choice_data" c
    JOIN migrated_groups g ON c."groupKey" = g."groupKey"
    LEFT JOIN "class_choice_option_data" o
        ON o."choiceGroupId" = g."id"
       AND o."optionKey" = c."optionKey"
    LEFT JOIN "character_class_relation" entry ON entry."id" = c."classEntryId"
    LEFT JOIN skill_tokens token_by_selected_text ON c."selectedText" = ANY(token_by_selected_text."tokens")
    LEFT JOIN skill_tokens token_by_option_key ON c."optionKey" = ANY(token_by_option_key."tokens")
    LEFT JOIN skill_tokens token_by_option_name ON o."name" = ANY(token_by_option_name."tokens")
    LEFT JOIN skill_tokens token_by_choice_option ON o."optionKey" = ANY(token_by_choice_option."tokens")
)
INSERT INTO "character_skill_selection_data" (
    "syncId",
    "characterId",
    "classEntryId",
    "classDataId",
    "backgroundDataId",
    "skill",
    "kind",
    "selectionIndex",
    "updatedAt"
)
SELECT
    COALESCE("syncId", 'migrated-skill-choice-' || "choiceId"::text),
    "characterId",
    "classEntryId",
    "classDataId",
    "backgroundDataId",
    "skill",
    "kind",
    "selectionIndex",
    "updatedAt"
FROM resolved_choices
WHERE "skill" IS NOT NULL;

WITH migrated_groups AS (
    SELECT
        g.*,
        COALESCE(
            NULLIF(g."exclusiveKey", ''),
            'group_' || COALESCE(g."id"::text, g."name", g."type", 'unknown')
        ) AS "groupKey"
    FROM "class_choice_group_data" g
    WHERE g."type" = 'skill'
      AND (g."sourceClassId" IS NOT NULL OR g."sourceBackgroundId" IS NOT NULL)
)
DELETE FROM "character_choice_data" c
USING migrated_groups g
WHERE c."groupKey" = g."groupKey";

DELETE FROM "class_choice_option_data" o
USING "class_choice_group_data" g
WHERE o."choiceGroupId" = g."id"
  AND g."type" = 'skill'
  AND (g."sourceClassId" IS NOT NULL OR g."sourceBackgroundId" IS NOT NULL);

DELETE FROM "class_choice_group_data" g
WHERE g."type" = 'skill'
  AND (g."sourceClassId" IS NOT NULL OR g."sourceBackgroundId" IS NOT NULL);

DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM "class_choice_group_data"
        WHERE "type" = 'skill'
    ) THEN
        RAISE EXCEPTION 'Skill class choice groups remain after migration.';
    END IF;
END $$;

SELECT setval(
    pg_get_serial_sequence('"character_skill_selection_data"', 'id'),
    COALESCE((SELECT MAX("id") FROM "character_skill_selection_data"), 1)
);


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260427211234016-extract-skill-selections', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260427211234016-extract-skill-selections', "timestamp" = now();

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
