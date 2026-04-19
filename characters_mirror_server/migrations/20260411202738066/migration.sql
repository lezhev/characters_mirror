BEGIN;

--
-- ACTION NORMALIZE DATA
--
UPDATE "spell_data"
SET "damageType" = CASE nullif(
        lower(
            regexp_replace(
                regexp_replace(
                    regexp_replace(
                        regexp_replace(
                            "damageType",
                            '(^[[:space:]]*["'']|["''][[:space:]]*$)',
                            '',
                            'g'
                        ),
                        '^[[:space:]]*DamageType\.',
                        '',
                        'i'
                    ),
                    '^[[:space:]]*damage_type\.',
                    '',
                    'i'
                ),
                '[[:space:]_-]+',
                '',
                'g'
            )
        ),
        ''
    )
    WHEN '0' THEN 'acid'
    WHEN '1' THEN 'bludgeoning'
    WHEN '2' THEN 'cold'
    WHEN '3' THEN 'fire'
    WHEN '4' THEN 'force'
    WHEN '5' THEN 'lightning'
    WHEN '6' THEN 'necrotic'
    WHEN '7' THEN 'piercing'
    WHEN '8' THEN 'poison'
    WHEN '9' THEN 'psychic'
    WHEN '10' THEN 'radiant'
    WHEN '11' THEN 'slashing'
    WHEN '12' THEN 'thunder'
    WHEN 'none' THEN NULL
    WHEN 'null' THEN NULL
    WHEN 'нет' THEN NULL
    WHEN 'varies' THEN NULL
    WHEN 'variable' THEN NULL
    WHEN 'various' THEN NULL
    WHEN 'choice' THEN NULL
    ELSE nullif(
        lower(
            regexp_replace(
                regexp_replace(
                    regexp_replace(
                        regexp_replace(
                            "damageType",
                            '(^[[:space:]]*["'']|["''][[:space:]]*$)',
                            '',
                            'g'
                        ),
                        '^[[:space:]]*DamageType\.',
                        '',
                        'i'
                    ),
                    '^[[:space:]]*damage_type\.',
                    '',
                    'i'
                ),
                '[[:space:]_-]+',
                '',
                'g'
            )
        ),
        ''
    )
END
WHERE "damageType" IS NOT NULL;

DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM "spell_data"
        WHERE "damageType" IS NOT NULL
          AND "damageType" NOT IN (
              'acid',
              'bludgeoning',
              'cold',
              'fire',
              'force',
              'lightning',
              'necrotic',
              'piercing',
              'poison',
              'psychic',
              'radiant',
              'slashing',
              'thunder'
          )
    ) THEN
        RAISE EXCEPTION 'spell_data.damageType contains values that cannot be converted to DamageType: %',
            (
                SELECT string_agg(DISTINCT "damageType", ', ' ORDER BY "damageType")
                FROM "spell_data"
                WHERE "damageType" IS NOT NULL
                  AND "damageType" NOT IN (
                      'acid',
                      'bludgeoning',
                      'cold',
                      'fire',
                      'force',
                      'lightning',
                      'necrotic',
                      'piercing',
                      'poison',
                      'psychic',
                      'radiant',
                      'slashing',
                      'thunder'
                  )
            );
    END IF;
END $$;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260411202738066', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260411202738066', "timestamp" = now();

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
