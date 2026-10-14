BEGIN;

-- PHB 2014: ability score improvement choices, no feats.
-- Five per class, plus fighter 6/14 and rogue 10.
-- Class-feature relations link the existing LevelUpAsiDecision presentation.
DO $$
BEGIN
  IF (SELECT count(*) FROM class_data
      WHERE "referenceKey" IN ('barbarian','bard','cleric','druid','fighter','monk','paladin','ranger','rogue','sorcerer','warlock','wizard')) <> 12 THEN
    RAISE EXCEPTION 'Expected all 12 PHB 2014 classes';
  END IF;
  IF (SELECT count(*) FROM class_feature_data
      WHERE "referenceKey" IN ('barbarian_ability_score_improvement','bard_ability_score_improvement','druid_ability_score_improvement','fighter_ability_score_improvement','monk_ability_score_improvement','paladin_ability_score_improvement','ranger_ability_score_improvement','rogue_ability_score_improvement','sorcerer_ability_score_improvement','warlock_ability_score_improvement','wizard_ability_score_improvement')) <> 11 THEN
    RAISE EXCEPTION 'Expected 11 existing PHB 2014 ASI features';
  END IF;
  IF EXISTS (SELECT 1 FROM class_feature_data
      WHERE "referenceKey"='cleric_ability_score_improvement') THEN
    RAISE EXCEPTION 'Cleric ASI feature already exists; inspect before backfill';
  END IF;
  IF EXISTS (SELECT 1 FROM choice_group_data
      WHERE "referenceKey" LIKE 'asi_phb2014_%') THEN
    RAISE EXCEPTION 'ASI backfill groups already exist; inspect before backfill';
  END IF;
END $$;

-- The standard cleric ASI uses the same PHB 2014 rules as barbarian.
INSERT INTO class_feature_data
  ("parentClassId",level,source,version,"createdAt","updatedAt",
   name,description,tags,"shortDescription","referenceKey")
SELECT cleric.id, 4, exemplar.source, 1, now(),now(),
       exemplar.name,exemplar.description,exemplar.tags,NULL,
       'cleric_ability_score_improvement'
FROM class_data cleric
CROSS JOIN class_feature_data exemplar
WHERE cleric."referenceKey"='cleric'
  AND exemplar."referenceKey"='barbarian_ability_score_improvement';

-- One uniquely named choice group per class milestone.
-- sourceFeatureId is the only source relation, preserving the group invariant.
-- 1-2 choices permitted so +2 is one option, +1/+1 is two.
WITH milestones(class_key, required_level) AS (
  VALUES
    ('barbarian',4),
    ('barbarian',8),
    ('barbarian',12),
    ('barbarian',16),
    ('barbarian',19),
    ('bard',4),
    ('bard',8),
    ('bard',12),
    ('bard',16),
    ('bard',19),
    ('cleric',4),
    ('cleric',8),
    ('cleric',12),
    ('cleric',16),
    ('cleric',19),
    ('druid',4),
    ('druid',8),
    ('druid',12),
    ('druid',16),
    ('druid',19),
    ('fighter',4),
    ('fighter',6),
    ('fighter',8),
    ('fighter',12),
    ('fighter',14),
    ('fighter',16),
    ('fighter',19),
    ('monk',4),
    ('monk',8),
    ('monk',12),
    ('monk',16),
    ('monk',19),
    ('paladin',4),
    ('paladin',8),
    ('paladin',12),
    ('paladin',16),
    ('paladin',19),
    ('ranger',4),
    ('ranger',8),
    ('ranger',12),
    ('ranger',16),
    ('ranger',19),
    ('rogue',4),
    ('rogue',8),
    ('rogue',10),
    ('rogue',12),
    ('rogue',16),
    ('rogue',19),
    ('sorcerer',4),
    ('sorcerer',8),
    ('sorcerer',12),
    ('sorcerer',16),
    ('sorcerer',19),
    ('warlock',4),
    ('warlock',8),
    ('warlock',12),
    ('warlock',16),
    ('warlock',19),
    ('wizard',4),
    ('wizard',8),
    ('wizard',12),
    ('wizard',16),
    ('wizard',19)
)
INSERT INTO choice_group_data
 ("referenceKey",name,description,"sourceFeatureId",level,type,
  "selectionCount","minimumSelectionCount","exclusiveKey",
  "allowDuplicates","sortOrder",source,version,"createdAt","updatedAt")
SELECT
 'asi_phb2014_'||m.class_key||'_'||m.required_level,
 'Увеличение характеристик',
 'Увеличьте одну характеристику на 2 или две разные характеристики на 1. Обычно значение не может превышать 20.',
 f.id,m.required_level,'abilityIncrease',
 2,1,'asi_phb2014_'||m.class_key||'_'||m.required_level,
 FALSE,10,'PHB 2014',1,now(),now()
FROM milestones m
JOIN class_data c ON c."referenceKey"=m.class_key
JOIN class_feature_data f ON f."parentClassId"=c.id
  AND f."referenceKey"=m.class_key||'_ability_score_improvement';

-- All permutations are assembled by the existing ASI UI/validator:
-- one +2 option OR two distinct +1 options.
WITH abilities(ability,display_name,ability_order) AS (
  VALUES
   ('strength','Сила',1),
   ('dexterity','Ловкость',2),
   ('constitution','Телосложение',3),
   ('intelligence','Интеллект',4),
   ('wisdom','Мудрость',5),
   ('charisma','Харизма',6)
), increments(bonus) AS (VALUES (1),(2))
INSERT INTO choice_option_data
 ("choiceGroupId","optionKey",name,"shortDescription",
  "grantedAbilityBonuses","sortOrder",source,version,"createdAt","updatedAt")
SELECT g.id,
 a.ability||'_plus_'||n.bonus,
 a.display_name||' +'||n.bonus,
 a.display_name||' +'||n.bonus,
 jsonb_build_object(a.ability,n.bonus),
 (a.ability_order-1)*2+n.bonus,
 'PHB 2014',1,now(),now()
FROM choice_group_data g CROSS JOIN abilities a CROSS JOIN increments n
WHERE g."referenceKey" LIKE 'asi_phb2014_%';

DO $$
BEGIN
  IF (SELECT count(*) FROM choice_group_data
      WHERE "referenceKey" LIKE 'asi_phb2014_%') <> 63 THEN
    RAISE EXCEPTION 'Expected 63 ASI milestone groups';
  END IF;
  IF (SELECT count(*) FROM choice_option_data o
      JOIN choice_group_data g ON g.id=o."choiceGroupId"
      WHERE g."referenceKey" LIKE 'asi_phb2014_%') <> 756 THEN
    RAISE EXCEPTION 'Expected 756 ASI options';
  END IF;
  IF EXISTS (
    SELECT g.id FROM choice_group_data g
    LEFT JOIN choice_option_data o ON o."choiceGroupId"=g.id
    WHERE g."referenceKey" LIKE 'asi_phb2014_%'
    GROUP BY g.id
    HAVING COUNT(o.id) <> 12
  ) THEN
    RAISE EXCEPTION 'Every ASI group must have 12 options';
  END IF;
END $$;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261009120000000-asi-phb2014-choice-groups', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261009120000000-asi-phb2014-choice-groups', "timestamp" = now();

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
