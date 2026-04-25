BEGIN;

UPDATE "characters"
SET "equipment" = (
    SELECT CASE
        WHEN COUNT(*) = 0 THEN NULL
        ELSE json_agg(
            jsonb_set(
                jsonb_set(
                    value::jsonb,
                    '{type}',
                    CASE
                        WHEN jsonb_typeof(value::jsonb -> 'type') = 'number' THEN value::jsonb -> 'type'
                        WHEN jsonb_typeof(value::jsonb -> 'type') = 'string' THEN to_jsonb(
                            CASE value::jsonb ->> 'type'
                                WHEN 'weapon' THEN 0
                                WHEN 'armor' THEN 1
                                WHEN 'item' THEN 2
                                WHEN 'magicItem' THEN 3
                                WHEN 'custom' THEN 4
                                ELSE 4
                            END
                        )
                        ELSE to_jsonb(4)
                    END,
                    true
                ),
                '{quantity}',
                CASE
                    WHEN jsonb_typeof(value::jsonb -> 'quantity') = 'number' THEN to_jsonb(
                        GREATEST((value::jsonb ->> 'quantity')::int, 1)
                    )
                    WHEN jsonb_typeof(value::jsonb -> 'quantity') = 'string'
                        AND NULLIF(
                            regexp_replace(value::jsonb ->> 'quantity', '[^0-9-]', '', 'g'),
                            ''
                        ) IS NOT NULL THEN to_jsonb(
                            GREATEST(
                                (
                                    NULLIF(
                                        regexp_replace(
                                            value::jsonb ->> 'quantity',
                                            '[^0-9-]',
                                            '',
                                            'g'
                                        ),
                                        ''
                                    )
                                )::int,
                                1
                            )
                        )
                    ELSE to_jsonb(1)
                END,
                true
            )
        )
    END
    FROM json_array_elements(COALESCE("equipment", '[]'::json)) AS item(value)
)
WHERE "equipment" IS NOT NULL
  AND EXISTS (
    SELECT 1
    FROM json_array_elements(COALESCE("equipment", '[]'::json)) AS item(value)
    WHERE jsonb_typeof(value::jsonb -> 'type') = 'string'
       OR jsonb_typeof(value::jsonb -> 'quantity') = 'string'
       OR value::jsonb -> 'type' IS NULL
       OR value::jsonb -> 'quantity' IS NULL
  );

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260425043015312', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260425043015312', "timestamp" = now();

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
