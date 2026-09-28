BEGIN;

INSERT INTO "feature_resource_definition_data" (
    "classFeatureId", "key", "name", "kind", "maxRule", "maxValue",
    "resetOn", "activationTrigger", "usageResetOn"
)
SELECT
    120, 'arcaneRecovery', 'Магическое восстановление', 'uses', 'fixed', 1,
    'special', 'shortRest', 'longRest'
WHERE EXISTS (
    SELECT 1 FROM "class_feature_data" WHERE "id" = 120
)
AND NOT EXISTS (
    SELECT 1 FROM "feature_resource_definition_data"
    WHERE "classFeatureId" = 120 AND "key" = 'arcaneRecovery'
);

-- Restore at most ceil(wizard level / 2) slot levels; spell slots above level 5 are excluded.
INSERT INTO "feature_resource_effect_data" (
    "classFeatureId", "type", "targetType", "targetResourceKey", "amountRule"
)
SELECT 120, 'restore', 'spellSlots', 'spellSlots', 'special'
WHERE EXISTS (
    SELECT 1 FROM "class_feature_data" WHERE "id" = 120
)
AND NOT EXISTS (
    SELECT 1 FROM "feature_resource_effect_data"
    WHERE "classFeatureId" = 120
      AND "type" = 'restore'
      AND "targetType" = 'spellSlots'
      AND "targetResourceKey" = 'spellSlots'
      AND "amountRule" = 'special'
);

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260927210000000-arcane-recovery-reference', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260927210000000-arcane-recovery-reference', "timestamp" = now();

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
