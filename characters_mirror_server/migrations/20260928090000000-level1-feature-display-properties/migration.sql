BEGIN;

WITH properties (
    "featureId", "key", "label", "valueKind", "progression", "formula"
) AS (
    VALUES
        (
            2, 'rage_damage', 'Урон ярости', 'progression',
            '[{"k":1,"v":"+2"},{"k":9,"v":"+3"},{"k":16,"v":"+4"}]'::json,
            NULL::text
        ),
        (
            16, 'inspiration_die', 'Кость вдохновения', 'progression',
            '[{"k":1,"v":"к6"},{"k":5,"v":"к8"},{"k":10,"v":"к10"},{"k":15,"v":"к12"}]'::json,
            NULL::text
        ),
        (
            40, 'second_wind_healing', 'Восстановление хитов', 'formula',
            NULL::json, '1d10 + classLevel'
        ),
        (
            120, 'recoverable_slot_levels', 'Суммарный уровень ячеек', 'formula',
            NULL::json, 'ceil(classLevel / 2)'
        ),
        (
            47, 'martial_arts_die', 'Кость боевых искусств', 'progression',
            '[{"k":1,"v":"к4"},{"k":5,"v":"к6"},{"k":11,"v":"к8"},{"k":17,"v":"к10"}]'::json,
            NULL::text
        ),
        (
            93, 'sneak_attack_damage', 'Урон скрытой атаки', 'progression',
            '[{"k":1,"v":"1к6"},{"k":3,"v":"2к6"},{"k":5,"v":"3к6"},{"k":7,"v":"4к6"},{"k":9,"v":"5к6"},{"k":11,"v":"6к6"},{"k":13,"v":"7к6"},{"k":15,"v":"8к6"},{"k":17,"v":"9к6"},{"k":19,"v":"10к6"}]'::json,
            NULL::text
        )
)
INSERT INTO "feature_display_property_data" (
    "sourceClassFeatureId", "key", "label", "valueKind", "progression",
    "formula", "sortOrder", "source", "version", "createdAt", "updatedAt"
)
SELECT
    properties."featureId",
    properties."key",
    properties."label",
    properties."valueKind",
    properties."progression",
    properties."formula",
    0,
    feature."source",
    feature."version",
    now(),
    now()
FROM properties
JOIN "class_feature_data" feature ON feature."id" = properties."featureId"
WHERE NOT EXISTS (
    SELECT 1
    FROM "feature_display_property_data" existing
    WHERE existing."sourceClassFeatureId" = properties."featureId"
      AND existing."key" = properties."key"
);

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260928090000000-level1-feature-display-properties', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928090000000-level1-feature-display-properties', "timestamp" = now();

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
