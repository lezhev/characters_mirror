-- Serverpod serializes Map<int,int> as entry lists, including nested JSON.
UPDATE subclass_data SET "spellSelectionFilter" = jsonb_set(
  "spellSelectionFilter"::jsonb, '{unrestrictedChoicesByLevel}',
  '[{"k":3,"v":1},{"k":8,"v":2},{"k":14,"v":3},{"k":20,"v":4}]'::jsonb)
WHERE "referenceKey" IN ('fighter_eldritch_knight', 'rogue_arcane_trickster')
  AND jsonb_typeof("spellSelectionFilter"::jsonb -> 'unrestrictedChoicesByLevel') = 'object';

UPDATE class_spell_grant_data g SET "castingAbility" = 'wisdom'
FROM subclass_feature_data f
WHERE g."sourceSubclassFeatureId" = f.id
  AND f."referenceKey" = 'monk_four_elements_disciple_of_the_elements'
  AND g.activation::jsonb ->> 'resourceKey' = 'ki';
