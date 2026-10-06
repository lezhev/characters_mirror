BEGIN;

-- Move Deflect Missiles' numeric reduction formula out of shortDescription
-- into FeatureDisplayPropertyData. Legacy description remains untouched.

UPDATE "class_feature_data"
SET "shortDescription"='Когда по вам попадает дальнобойная атака оружием, реакцией уменьшите получаемый урон. Если урон снижен до 0 и у вас свободна рука, вы можете поймать снаряд и за 1 ци тут же совершить им дальнобойную атаку.',
    version=COALESCE(version,0)+1,
    "updatedAt"=now()
WHERE "referenceKey"='monk_deflect_missiles'
  AND "shortDescription" IS DISTINCT FROM
      'Когда по вам попадает дальнобойная атака оружием, реакцией уменьшите получаемый урон. Если урон снижен до 0 и у вас свободна рука, вы можете поймать снаряд и за 1 ци тут же совершить им дальнобойную атаку.';

UPDATE "feature_display_property_data" p
SET label='Снижение урона',
    "valueKind"='formula',
    "staticValue"=NULL,
    progression=NULL,
    formula='1d10 + abilityModifier(dexterity) + classLevel',
    "sortOrder"=0,
    source=f.source,
    version=COALESCE(p.version,0)+1,
    "updatedAt"=now()
FROM "class_feature_data" f
WHERE p."sourceClassFeatureId"=f.id
  AND f."referenceKey"='monk_deflect_missiles'
  AND p.key='damage_reduction'
  AND (
    p.label IS DISTINCT FROM 'Снижение урона'
    OR p."valueKind" IS DISTINCT FROM 'formula'
    OR p."staticValue" IS NOT NULL
    OR p.progression IS NOT NULL
    OR p.formula IS DISTINCT FROM '1d10 + abilityModifier(dexterity) + classLevel'
    OR p."sortOrder" IS DISTINCT FROM 0
    OR p.source IS DISTINCT FROM f.source
  );

INSERT INTO "feature_display_property_data" (
  "sourceClassFeatureId","key","label","valueKind","formula","sortOrder",
  source,version,"createdAt","updatedAt"
)
SELECT
  f.id,'damage_reduction','Снижение урона','formula',
  '1d10 + abilityModifier(dexterity) + classLevel',0,
  f.source,1,now(),now()
FROM "class_feature_data" f
WHERE f."referenceKey"='monk_deflect_missiles'
  AND NOT EXISTS (
    SELECT 1
    FROM "feature_display_property_data" p
    WHERE p."sourceClassFeatureId"=f.id
      AND p.key='damage_reduction'
  );

INSERT INTO "serverpod_migrations" ("module","version","timestamp")
VALUES ('characters_mirror','20261006208000000-deflect-missiles-presentation',now())
ON CONFLICT ("module") DO UPDATE SET
 "version"='20261006208000000-deflect-missiles-presentation',
 "timestamp"=now();

COMMIT;
