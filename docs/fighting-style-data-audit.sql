
\pset pager off
SELECT g."referenceKey",o."optionKey",o.name,o.description
FROM choice_group_data g
JOIN choice_option_data o ON o."choiceGroupId"=g.id
WHERE g."referenceKey" IN ('class_feature_39_fighting_style','class_feature_68_fighting_style','class_feature_81_fighting_style')
ORDER BY g."referenceKey",o."sortOrder",o.id;
