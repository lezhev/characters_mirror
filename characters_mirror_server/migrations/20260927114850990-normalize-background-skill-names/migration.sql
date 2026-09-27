BEGIN;

-- Older reference rows stored Dart enum display strings. The protocol now
-- expects Skill.name, so normalize only known aliases and preserve list order.
DO $$
DECLARE
    unknown_skill record;
    updated_background_count bigint;
BEGIN
    CREATE TEMP TABLE background_skill_alias (
        stored text PRIMARY KEY,
        canonical text NOT NULL
    ) ON COMMIT DROP;

    WITH canonical(name) AS (VALUES
        ('acrobatics'), ('animalHandling'), ('arcana'), ('athletics'),
        ('deception'), ('history'), ('insight'), ('intimidation'),
        ('investigation'), ('medicine'), ('nature'), ('perception'),
        ('performance'), ('persuasion'), ('religion'), ('sleightOfHand'),
        ('stealth'), ('survival')
    )
    INSERT INTO background_skill_alias (stored, canonical)
    SELECT name, name FROM canonical
    UNION ALL
    SELECT 'Skill.' || name, name FROM canonical;

    INSERT INTO background_skill_alias (stored, canonical) VALUES
        ('Skill.animal_handling', 'animalHandling'),
        ('Skill.sleight_of_hand', 'sleightOfHand');

    SELECT background.name, skill.value
    INTO unknown_skill
    FROM background_data AS background
    CROSS JOIN LATERAL json_array_elements_text(
        background."skillProficiencies"
    ) AS skill(value)
    LEFT JOIN background_skill_alias AS alias ON alias.stored = skill.value
    WHERE alias.stored IS NULL
    LIMIT 1;

    IF FOUND THEN
        RAISE EXCEPTION
            'Unknown BackgroundData.skillProficiencies value "%" for "%"',
            unknown_skill.value, unknown_skill.name;
    END IF;

    UPDATE background_data AS background
    SET "skillProficiencies" = (
        SELECT json_agg(alias.canonical ORDER BY skill.ordinality)
        FROM json_array_elements_text(
            background."skillProficiencies"
        ) WITH ORDINALITY AS skill(value, ordinality)
        JOIN background_skill_alias AS alias ON alias.stored = skill.value
    ),
    "updatedAt" = now()
    WHERE EXISTS (
        SELECT 1
        FROM json_array_elements_text(
            background."skillProficiencies"
        ) AS skill(value)
        JOIN background_skill_alias AS alias ON alias.stored = skill.value
        WHERE alias.stored <> alias.canonical
    );

    GET DIAGNOSTICS updated_background_count = ROW_COUNT;
    RAISE NOTICE 'Normalized skill proficiencies for % BackgroundData rows',
        updated_background_count;
END $$;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260927114850990-normalize-background-skill-names', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260927114850990-normalize-background-skill-names', "timestamp" = now();

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
