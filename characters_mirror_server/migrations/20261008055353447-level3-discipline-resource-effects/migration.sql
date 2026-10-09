BEGIN;

-- Complete manual ki spending metadata across level-up choice snapshots.
INSERT INTO feature_resource_effect_data (
 "subclassFeatureId", "choiceOptionId", type, "targetType", "targetResourceKey",
 "amountRule", "amountValue", "activationTrigger"
)
SELECT f.id, o.id, 'spend', 'featureResource', 'ki', 'fixed',
  CASE o."optionKey"
    WHEN 'fangs_of_fire_snake' THEN 1
    WHEN 'shape_flowing_river' THEN 1
    WHEN 'water_whip' THEN 2
    WHEN 'fist_of_unbroken_air' THEN 2
  END,
  'manual'
FROM choice_option_data o
JOIN choice_group_data g ON g.id=o."choiceGroupId"
JOIN subclass_feature_data f ON f.id=g."sourceSubclassFeatureId"
WHERE g."referenceKey" IN (
 'monk_four_elements_disciplines_6',
 'monk_four_elements_disciplines_11',
 'monk_four_elements_disciplines_17'
)
AND f."referenceKey"='monk_four_elements_disciple_of_the_elements'
AND o."optionKey" IN (
 'fangs_of_fire_snake', 'shape_flowing_river', 'water_whip', 'fist_of_unbroken_air'
)
AND NOT EXISTS (
 SELECT 1 FROM feature_resource_effect_data old
 WHERE old."subclassFeatureId"=f.id AND old."choiceOptionId"=o.id
 AND old.type='spend' AND old."targetType"='featureResource'
 AND old."targetResourceKey"='ki'
);



--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261008055353447-level3-discipline-resource-effects', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008055353447-level3-discipline-resource-effects', "timestamp" = now();

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
