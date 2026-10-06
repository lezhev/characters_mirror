BEGIN;

-- Level 1-3 technical reference-data backfill, batch 5.
-- Descriptive fields are intentionally untouched.

-- Link subclass selection UI to the explicit class feature where such a
-- feature already exists in the catalog.
WITH links("classKey","featureKey") AS (
 VALUES
 ('bard','bard_bard_college'),
 ('druid','druid_circle'),
 ('fighter','fighter_martial_archetype'),
 ('monk','monk_monastic_tradition'),
 ('paladin','paladin_sacred_oath'),
 ('ranger','ranger_ranger_archetype'),
 ('rogue','rogue_roguish_archetype'),
 ('wizard','arcane_tradition')
)
UPDATE "class_data" c
SET "subclassChoiceFeatureId"=f.id,
    version=COALESCE(c.version,0)+1,
    "updatedAt"=now()
FROM links l
JOIN "class_feature_data" f ON f."referenceKey"=l."featureKey"
WHERE c."referenceKey"=l."classKey"
  AND c."subclassChoiceFeatureId" IS DISTINCT FROM f.id;

-- An always-prepared subclass grant is not ordinary subclass spell-list
-- availability. Remove the owning subclass from availableForSubclassIds for
-- all grants active through level 3. Base-class availability remains intact.
WITH active_grants AS (
 SELECT DISTINCT
   g."spellId",
   f."parentSubclassId" AS subclass_id
 FROM "class_spell_grant_data" g
 JOIN "subclass_feature_data" f ON f.id=g."sourceSubclassFeatureId"
 WHERE g."alwaysPrepared" IS TRUE
   AND COALESCE(g."grantedAtLevel",1) <= 3
)
UPDATE "spell_data" sp
SET "availableForSubclassIds"=COALESCE((
  SELECT json_agg(v.value::bigint)
  FROM json_array_elements_text(COALESCE(sp."availableForSubclassIds",'[]'::json)) v(value)
  WHERE NOT EXISTS (
    SELECT 1
    FROM active_grants ag
    WHERE ag."spellId"=sp.id
      AND ag.subclass_id=v.value::bigint
  )
),'[]'::json)
WHERE EXISTS (
 SELECT 1
 FROM active_grants ag
 WHERE ag."spellId"=sp.id
   AND sp."availableForSubclassIds"::jsonb @> to_jsonb(ARRAY[ag.subclass_id])
);

INSERT INTO "serverpod_migrations" ("module","version","timestamp")
VALUES ('characters_mirror','20261006205000000-level3-technical-backfill-5',now())
ON CONFLICT ("module") DO UPDATE SET
 "version"='20261006205000000-level3-technical-backfill-5',
 "timestamp"=now();

COMMIT;
