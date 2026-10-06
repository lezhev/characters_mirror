-- Read-only reference-data audit after the feature-presentation migration.
-- Reference keys identify missing content; no character/user data is read.
SELECT 'class' AS feature_kind, "referenceKey", name, level
FROM class_feature_data
WHERE NULLIF(BTRIM("shortDescription"), '') IS NULL
UNION ALL
SELECT 'subclass', "referenceKey", name, level
FROM subclass_feature_data
WHERE NULLIF(BTRIM("shortDescription"), '') IS NULL
ORDER BY feature_kind, "referenceKey";

SELECT g."referenceKey" AS group_key, g.name AS group_name, g.type,
       o."optionKey", o.name AS option_name
FROM choice_group_data g
JOIN choice_option_data o ON o."choiceGroupId" = g.id
WHERE NULLIF(BTRIM(o."shortDescription"), '') IS NULL
ORDER BY g."referenceKey", o."sortOrder", o."optionKey";

SELECT "referenceKey", "subclassName", name
FROM subclass_data
WHERE NULLIF(BTRIM("shortDescription"), '') IS NULL
ORDER BY "referenceKey";

SELECT c."referenceKey", c.name, c."subclassChoiceLevel", c."subclassChoiceFeatureId"
FROM class_data c
LEFT JOIN class_feature_data f ON f.id = c."subclassChoiceFeatureId"
WHERE c."subclassChoiceLevel" IS NOT NULL
  AND (f.id IS NULL OR f."parentClassId" <> c.id OR f.level <> c."subclassChoiceLevel")
ORDER BY c."referenceKey";
