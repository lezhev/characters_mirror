BEGIN;

-- Feature-backed choice groups are rendered as part of the feature that owns
-- them. Keep the choice-group level: one feature can unlock additional choices
-- on later class levels (for example Eldritch Invocations).

DO $$
DECLARE
  warlock_id bigint;
  warlock_count integer;
  invocation_feature_id bigint;
  invocation_feature_count integer;
  pact_boon_feature_id bigint;
  pact_boon_feature_count integer;
BEGIN
  IF EXISTS (
    SELECT 1
    FROM "choice_group_data"
    WHERE "referenceKey" IN (
      'warlock_eldritch_invocations_2',
      'warlock_eldritch_invocations_5',
      'warlock_eldritch_invocations_7',
      'warlock_eldritch_invocations_9',
      'warlock_eldritch_invocations_12',
      'warlock_eldritch_invocations_15',
      'warlock_eldritch_invocations_18',
      'warlock_pact_boon'
    )
  ) THEN
    SELECT count(*), min(id)
    INTO warlock_count, warlock_id
    FROM "class_data"
    WHERE "referenceKey" = 'warlock'
       OR lower(trim(name)) IN ('warlock', 'колдун');

    IF warlock_count <> 1 THEN
      RAISE EXCEPTION
        'Expected exactly one Warlock/Колдун ClassData while linking feature choices; found %.',
        warlock_count;
    END IF;
  END IF;

  IF EXISTS (
    SELECT 1
    FROM "choice_group_data"
    WHERE "referenceKey" LIKE 'warlock_eldritch_invocations_%'
  ) THEN
    SELECT count(*), min(id)
    INTO invocation_feature_count, invocation_feature_id
    FROM "class_feature_data"
    WHERE "parentClassId" = warlock_id
      AND level = 2
      AND (
        "referenceKey" = 'eldritch_invocations'
        OR lower(trim(name)) LIKE '%воззван%'
        OR lower(trim(name)) LIKE '%eldritch invocation%'
      );

    IF invocation_feature_count <> 1 THEN
      RAISE EXCEPTION
        'Expected exactly one Warlock Eldritch Invocations feature while linking choice groups; found %.',
        invocation_feature_count;
    END IF;

    UPDATE "class_feature_data"
    SET "referenceKey" = 'eldritch_invocations',
        version = COALESCE(version, 0) + 1,
        "updatedAt" = CURRENT_TIMESTAMP
    WHERE id = invocation_feature_id
      AND NULLIF(trim("referenceKey"), '') IS NULL;

    UPDATE "choice_group_data"
    SET "sourceClassId" = NULL,
        "sourceSubclassId" = NULL,
        "sourceFeatureId" = invocation_feature_id,
        "sourceSubclassFeatureId" = NULL,
        "sourceRaceId" = NULL,
        "sourceSubraceId" = NULL,
        "sourceRaceFeatureId" = NULL,
        "sourceBackgroundId" = NULL,
        version = COALESCE(version, 0) + 1,
        "updatedAt" = CURRENT_TIMESTAMP
    WHERE "referenceKey" LIKE 'warlock_eldritch_invocations_%'
      AND "sourceFeatureId" IS DISTINCT FROM invocation_feature_id;
  END IF;

  IF EXISTS (
    SELECT 1
    FROM "choice_group_data"
    WHERE "referenceKey" = 'warlock_pact_boon'
  ) THEN
    SELECT count(*), min(id)
    INTO pact_boon_feature_count, pact_boon_feature_id
    FROM "class_feature_data"
    WHERE "parentClassId" = warlock_id
      AND level = 3
      AND (
        "referenceKey" = 'pact_boon'
        OR lower(trim(name)) LIKE '%договор%'
        OR lower(trim(name)) LIKE '%пакт%'
        OR lower(trim(name)) LIKE '%pact boon%'
      );

    IF pact_boon_feature_count <> 1 THEN
      RAISE EXCEPTION
        'Expected exactly one Warlock Pact Boon feature while linking choice groups; found %.',
        pact_boon_feature_count;
    END IF;

    UPDATE "class_feature_data"
    SET "referenceKey" = 'pact_boon',
        version = COALESCE(version, 0) + 1,
        "updatedAt" = CURRENT_TIMESTAMP
    WHERE id = pact_boon_feature_id
      AND NULLIF(trim("referenceKey"), '') IS NULL;

    UPDATE "choice_group_data"
    SET "sourceClassId" = NULL,
        "sourceSubclassId" = NULL,
        "sourceFeatureId" = pact_boon_feature_id,
        "sourceSubclassFeatureId" = NULL,
        "sourceRaceId" = NULL,
        "sourceSubraceId" = NULL,
        "sourceRaceFeatureId" = NULL,
        "sourceBackgroundId" = NULL,
        version = COALESCE(version, 0) + 1,
        "updatedAt" = CURRENT_TIMESTAMP
    WHERE "referenceKey" = 'warlock_pact_boon'
      AND "sourceFeatureId" IS DISTINCT FROM pact_boon_feature_id;
  END IF;
END $$;

-- Existing feature-owned groups should remain feature-owned. These updates are
-- intentionally idempotent and also repair databases that imported the catalog
-- before the source links were added.
UPDATE "choice_group_data"
SET "sourceClassId" = NULL,
    "sourceSubclassId" = NULL,
    "sourceFeatureId" = 39,
    "sourceSubclassFeatureId" = NULL,
    "sourceRaceId" = NULL,
    "sourceSubraceId" = NULL,
    "sourceRaceFeatureId" = NULL,
    "sourceBackgroundId" = NULL
WHERE "referenceKey" = 'class_feature_39_fighting_style'
  AND EXISTS (SELECT 1 FROM "class_feature_data" WHERE id = 39)
  AND "sourceFeatureId" IS DISTINCT FROM 39;

UPDATE "choice_group_data"
SET "sourceClassId" = NULL,
    "sourceSubclassId" = NULL,
    "sourceFeatureId" = 92,
    "sourceSubclassFeatureId" = NULL,
    "sourceRaceId" = NULL,
    "sourceSubraceId" = NULL,
    "sourceRaceFeatureId" = NULL,
    "sourceBackgroundId" = NULL
WHERE "referenceKey" = 'class_feature_92_expertise'
  AND EXISTS (SELECT 1 FROM "class_feature_data" WHERE id = 92)
  AND "sourceFeatureId" IS DISTINCT FROM 92;

UPDATE "choice_group_data"
SET "sourceClassId" = NULL,
    "sourceSubclassId" = NULL,
    "sourceFeatureId" = 79,
    "sourceSubclassFeatureId" = NULL,
    "sourceRaceId" = NULL,
    "sourceSubraceId" = NULL,
    "sourceRaceFeatureId" = NULL,
    "sourceBackgroundId" = NULL
WHERE "referenceKey" IN (
    'class_feature_79_favored_enemy',
    'class_feature_79_favored_enemy_languages'
  )
  AND EXISTS (SELECT 1 FROM "class_feature_data" WHERE id = 79)
  AND "sourceFeatureId" IS DISTINCT FROM 79;

UPDATE "choice_group_data"
SET "sourceClassId" = NULL,
    "sourceSubclassId" = NULL,
    "sourceFeatureId" = 80,
    "sourceSubclassFeatureId" = NULL,
    "sourceRaceId" = NULL,
    "sourceSubraceId" = NULL,
    "sourceRaceFeatureId" = NULL,
    "sourceBackgroundId" = NULL
WHERE "referenceKey" = 'class_feature_80_favored_terrain'
  AND EXISTS (SELECT 1 FROM "class_feature_data" WHERE id = 80)
  AND "sourceFeatureId" IS DISTINCT FROM 80;

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
VALUES ('characters_mirror', '20261006010000000-feature-choice-links', now())
ON CONFLICT ("module") DO UPDATE SET
  "version" = EXCLUDED."version",
  "timestamp" = now();

COMMIT;
