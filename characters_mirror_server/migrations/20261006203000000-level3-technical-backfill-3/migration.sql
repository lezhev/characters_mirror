BEGIN;

-- Level 1-3 technical reference-data backfill, batch 3.
-- Descriptive text is intentionally untouched.

UPDATE "choice_group_data"
SET "minimumSelectionCount" = "selectionCount",
    "version" = COALESCE("version",0)+1,
    "updatedAt" = now()
WHERE "referenceKey" IN ('bard_expertise_level_3','bard_lore_bonus_proficiencies')
  AND "minimumSelectionCount" IS DISTINCT FROM "selectionCount";

-- Knowledge Domain: two languages of choice.
WITH feature AS (
  SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='cleric_knowledge_blessings_of_knowledge'
), grp AS (
  INSERT INTO "choice_group_data" (
    "referenceKey","name","sourceSubclassFeatureId","level","type",
    "selectionCount","minimumSelectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
  )
  SELECT 'cleric_knowledge_languages','Языки',feature.id,1,'language',2,2,false,10,'PHB 2014',1,now(),now()
  FROM feature
  ON CONFLICT ("referenceKey") DO UPDATE SET
    "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=NULL,
    "sourceSubclassFeatureId"=EXCLUDED."sourceSubclassFeatureId",
    "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
    "level"=EXCLUDED."level","type"=EXCLUDED."type","selectionCount"=2,"minimumSelectionCount"=2,
    "allowDuplicates"=false,"sortOrder"=EXCLUDED."sortOrder","source"=EXCLUDED."source",
    "version"=COALESCE("choice_group_data"."version",0)+1,"updatedAt"=now()
  RETURNING id
)
INSERT INTO "choice_option_data" (
  "choiceGroupId","optionKey","name","sortOrder","grantedLanguages","source","version","createdAt","updatedAt"
)
SELECT grp.id,v.key,v.name,v.ord,to_json(ARRAY[v.key]),'PHB 2014',1,now(),now()
FROM grp CROSS JOIN (VALUES
 ('common','Общий',1),('dwarvish','Дварфийский',2),('elvish','Эльфийский',3),
 ('giant','Великаний',4),('gnomish','Гномий',5),('goblin','Гоблинский',6),
 ('halfling','Полуросликов',7),('orc','Орочий',8),('abyssal','Бездны',9),
 ('celestial','Небесный',10),('draconic','Драконий',11),('deepSpeech','Глубинная речь',12),
 ('infernal','Инфернальный',13),('primordial','Первичный',14),('sylvan','Сильван',15),
 ('undercommon','Подземный',16)
) AS v(key,name,ord)
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
  "name"=EXCLUDED."name","sortOrder"=EXCLUDED."sortOrder",
  "grantedLanguages"=EXCLUDED."grantedLanguages","source"=EXCLUDED."source",
  "version"=COALESCE("choice_option_data"."version",0)+1,"updatedAt"=now();

-- Knowledge Domain: choose two of four knowledge skills; gain proficiency + expertise.
WITH feature AS (
  SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='cleric_knowledge_blessings_of_knowledge'
), grp AS (
  INSERT INTO "choice_group_data" (
    "referenceKey","name","sourceSubclassFeatureId","level","type",
    "selectionCount","minimumSelectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
  )
  SELECT 'cleric_knowledge_skills','Навыки знаний',feature.id,1,'featureOption',2,2,false,20,'PHB 2014',1,now(),now()
  FROM feature
  ON CONFLICT ("referenceKey") DO UPDATE SET
    "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=NULL,
    "sourceSubclassFeatureId"=EXCLUDED."sourceSubclassFeatureId",
    "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
    "level"=1,"type"='featureOption',"selectionCount"=2,"minimumSelectionCount"=2,
    "allowDuplicates"=false,"sortOrder"=20,"source"='PHB 2014',
    "version"=COALESCE("choice_group_data"."version",0)+1,"updatedAt"=now()
  RETURNING id
)
INSERT INTO "choice_option_data" (
  "choiceGroupId","optionKey","name","sortOrder","grantedSkills","grantedExpertiseSkills",
  "source","version","createdAt","updatedAt"
)
SELECT grp.id,v.key,v.name,v.ord,to_json(ARRAY[v.key]),to_json(ARRAY[v.key]),'PHB 2014',1,now(),now()
FROM grp CROSS JOIN (VALUES
 ('arcana','Магия',1),('history','История',2),('nature','Природа',3),('religion','Религия',4)
) AS v(key,name,ord)
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
  "name"=EXCLUDED."name","sortOrder"=EXCLUDED."sortOrder",
  "grantedSkills"=EXCLUDED."grantedSkills","grantedExpertiseSkills"=EXCLUDED."grantedExpertiseSkills",
  "source"=EXCLUDED."source","version"=COALESCE("choice_option_data"."version",0)+1,"updatedAt"=now();

-- Battle Master: one artisan tool proficiency.
WITH feature AS (
  SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='fighter_battle_master_student_of_war'
), grp AS (
  INSERT INTO "choice_group_data" (
    "referenceKey","name","sourceSubclassFeatureId","level","type",
    "selectionCount","minimumSelectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
  )
  SELECT 'fighter_battle_master_student_of_war','Ремесленный инструмент',feature.id,3,'tool',1,1,false,10,'PHB 2014',1,now(),now()
  FROM feature
  ON CONFLICT ("referenceKey") DO UPDATE SET
    "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=NULL,
    "sourceSubclassFeatureId"=EXCLUDED."sourceSubclassFeatureId",
    "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
    "level"=3,"type"='tool',"selectionCount"=1,"minimumSelectionCount"=1,
    "allowDuplicates"=false,"sortOrder"=10,"source"='PHB 2014',
    "version"=COALESCE("choice_group_data"."version",0)+1,"updatedAt"=now()
  RETURNING id
)
INSERT INTO "choice_option_data" (
  "choiceGroupId","optionKey","name","sortOrder","grantedToolKeys","source","version","createdAt","updatedAt"
)
SELECT grp.id,t."referenceKey",t.name,row_number() OVER (ORDER BY t.id),to_json(ARRAY[t."referenceKey"]),'PHB 2014',1,now(),now()
FROM grp CROSS JOIN "tool_data" t
WHERE t.category=0
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
  "name"=EXCLUDED."name","sortOrder"=EXCLUDED."sortOrder",
  "grantedToolKeys"=EXCLUDED."grantedToolKeys","source"=EXCLUDED."source",
  "version"=COALESCE("choice_option_data"."version",0)+1,"updatedAt"=now();

-- Hunter's Prey.
WITH feature AS (
 SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='ranger_hunter_hunters_prey'
), grp AS (
 INSERT INTO "choice_group_data" (
   "referenceKey","name","sourceSubclassFeatureId","level","type",
   "selectionCount","minimumSelectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
 )
 SELECT 'ranger_hunter_hunters_prey','Добыча охотника',feature.id,3,'featureOption',1,1,false,10,'PHB 2014',1,now(),now()
 FROM feature
 ON CONFLICT ("referenceKey") DO UPDATE SET
   "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=NULL,
   "sourceSubclassFeatureId"=EXCLUDED."sourceSubclassFeatureId",
   "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
   "level"=3,"type"='featureOption',"selectionCount"=1,"minimumSelectionCount"=1,
   "allowDuplicates"=false,"source"='PHB 2014',"version"=COALESCE("choice_group_data"."version",0)+1,"updatedAt"=now()
 RETURNING id
)
INSERT INTO "choice_option_data" ("choiceGroupId","optionKey","name","sortOrder","source","version","createdAt","updatedAt")
SELECT grp.id,v.key,v.name,v.ord,'PHB 2014',1,now(),now()
FROM grp CROSS JOIN (VALUES
 ('colossus_slayer','Убийца колоссов',1),
 ('giant_killer','Убийца великанов',2),
 ('horde_breaker','Сокрушитель орд',3)
) AS v(key,name,ord)
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
 "name"=EXCLUDED."name","sortOrder"=EXCLUDED."sortOrder","source"=EXCLUDED."source",
 "version"=COALESCE("choice_option_data"."version",0)+1,"updatedAt"=now();

-- Totem Spirit.
WITH feature AS (
 SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='barbarian_totem_warrior_totem_spirit'
), grp AS (
 INSERT INTO "choice_group_data" (
   "referenceKey","name","sourceSubclassFeatureId","level","type",
   "selectionCount","minimumSelectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
 )
 SELECT 'barbarian_totem_spirit','Тотемный дух',feature.id,3,'featureOption',1,1,false,10,'PHB 2014',1,now(),now()
 FROM feature
 ON CONFLICT ("referenceKey") DO UPDATE SET
   "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=NULL,
   "sourceSubclassFeatureId"=EXCLUDED."sourceSubclassFeatureId",
   "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
   "level"=3,"type"='featureOption',"selectionCount"=1,"minimumSelectionCount"=1,
   "allowDuplicates"=false,"source"='PHB 2014',"version"=COALESCE("choice_group_data"."version",0)+1,"updatedAt"=now()
 RETURNING id
)
INSERT INTO "choice_option_data" ("choiceGroupId","optionKey","name","sortOrder","source","version","createdAt","updatedAt")
SELECT grp.id,v.key,v.name,v.ord,'PHB 2014',1,now(),now()
FROM grp CROSS JOIN (VALUES
 ('bear','Медведь',1),('eagle','Орёл',2),('wolf','Волк',3)
) AS v(key,name,ord)
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
 "name"=EXCLUDED."name","sortOrder"=EXCLUDED."sortOrder","source"=EXCLUDED."source",
 "version"=COALESCE("choice_option_data"."version",0)+1,"updatedAt"=now();

-- Draconic Ancestor.
UPDATE "subclass_feature_data"
SET "grantedLanguages"='["draconic"]'::json,
    "version"=COALESCE("version",0)+1,"updatedAt"=now()
WHERE "referenceKey"='sorcerer_draconic_bloodline_dragon_ancestor'
  AND "grantedLanguages"::jsonb IS DISTINCT FROM '["draconic"]'::jsonb;

WITH feature AS (
 SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='sorcerer_draconic_bloodline_dragon_ancestor'
), grp AS (
 INSERT INTO "choice_group_data" (
   "referenceKey","name","sourceSubclassFeatureId","level","type",
   "selectionCount","minimumSelectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
 )
 SELECT 'sorcerer_draconic_ancestor','Драконий предок',feature.id,1,'featureOption',1,1,false,10,'PHB 2014',1,now(),now()
 FROM feature
 ON CONFLICT ("referenceKey") DO UPDATE SET
   "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=NULL,
   "sourceSubclassFeatureId"=EXCLUDED."sourceSubclassFeatureId",
   "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
   "level"=1,"type"='featureOption',"selectionCount"=1,"minimumSelectionCount"=1,
   "allowDuplicates"=false,"source"='PHB 2014',"version"=COALESCE("choice_group_data"."version",0)+1,"updatedAt"=now()
 RETURNING id
)
INSERT INTO "choice_option_data" (
 "choiceGroupId","optionKey","name","sortOrder","damageType","source","version","createdAt","updatedAt"
)
SELECT grp.id,v.key,v.name,v.ord,v.damage,'PHB 2014',1,now(),now()
FROM grp CROSS JOIN (VALUES
 ('black','Чёрный',1,'acid'),('blue','Синий',2,'lightning'),('brass','Латунный',3,'fire'),
 ('bronze','Бронзовый',4,'lightning'),('copper','Медный',5,'acid'),('gold','Золотой',6,'fire'),
 ('green','Зелёный',7,'poison'),('red','Красный',8,'fire'),('silver','Серебряный',9,'cold'),
 ('white','Белый',10,'cold')
) AS v(key,name,ord,damage)
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
 "name"=EXCLUDED."name","sortOrder"=EXCLUDED."sortOrder","damageType"=EXCLUDED."damageType",
 "source"=EXCLUDED."source","version"=COALESCE("choice_option_data"."version",0)+1,"updatedAt"=now();

-- Draconic Resilience: base AC 13 + Dexterity while not wearing armor.
INSERT INTO "feature_modifier_data" (
 "referenceKey","subclassFeatureId","target","operation","value","conditions","source","version","createdAt","updatedAt"
)
SELECT 'sorcerer_draconic_resilience.armor_class',f.id,2,1,
       '{"kind":0,"staticValue":13,"abilityModifiers":["dexterity"]}'::json,
       '[{"type":0}]'::json,'PHB 2014',1,now(),now()
FROM "subclass_feature_data" f
WHERE f."referenceKey"='sorcerer_draconic_bloodline_draconic_resilience'
ON CONFLICT ("referenceKey") DO UPDATE SET
 "classFeatureId"=NULL,"subclassFeatureId"=EXCLUDED."subclassFeatureId",
 "target"=EXCLUDED."target","operation"=EXCLUDED."operation","value"=EXCLUDED."value",
 "conditions"=EXCLUDED."conditions","source"=EXCLUDED."source",
 "version"=COALESCE("feature_modifier_data"."version",0)+1,"updatedAt"=now();

-- Wild Magic: track the normal once-per-long-rest Tides of Chaos use.
INSERT INTO "feature_resource_definition_data" (
 "subclassFeatureId",key,kind,"maxRule","maxValue","resetOn"
)
SELECT f.id,'tidesOfChaos','uses','fixed',1,'longRest'
FROM "subclass_feature_data" f
WHERE f."referenceKey"='sorcerer_wild_magic_tides_of_chaos'
  AND NOT EXISTS (
    SELECT 1 FROM "feature_resource_definition_data" r
    WHERE r."subclassFeatureId"=f.id AND r.key='tidesOfChaos'
  );

-- Sorcerer Metamagic choices.
WITH feature AS (
 SELECT id FROM "class_feature_data" WHERE "referenceKey"='sorcerer_metamagic'
), grp AS (
 INSERT INTO "choice_group_data" (
   "referenceKey","name","sourceFeatureId","level","type",
   "selectionCount","minimumSelectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
 )
 SELECT 'sorcerer_metamagic_level_3','Метамагия',feature.id,3,'featureOption',2,2,false,10,'PHB 2014',1,now(),now()
 FROM feature
 ON CONFLICT ("referenceKey") DO UPDATE SET
   "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=EXCLUDED."sourceFeatureId","sourceSubclassFeatureId"=NULL,
   "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
   "level"=3,"type"='featureOption',"selectionCount"=2,"minimumSelectionCount"=2,
   "allowDuplicates"=false,"source"='PHB 2014',"version"=COALESCE("choice_group_data"."version",0)+1,"updatedAt"=now()
 RETURNING id
)
INSERT INTO "choice_option_data" ("choiceGroupId","optionKey","name","sortOrder","source","version","createdAt","updatedAt")
SELECT grp.id,v.key,v.name,v.ord,'PHB 2014',1,now(),now()
FROM grp CROSS JOIN (VALUES
 ('careful_spell','Аккуратное заклинание',1),
 ('distant_spell','Далёкое заклинание',2),
 ('empowered_spell','Усиленное заклинание',3),
 ('extended_spell','Продлённое заклинание',4),
 ('heightened_spell','Непреодолимое заклинание',5),
 ('quickened_spell','Ускоренное заклинание',6),
 ('subtle_spell','Неуловимое заклинание',7),
 ('twinned_spell','Удвоенное заклинание',8)
) AS v(key,name,ord)
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
 "name"=EXCLUDED."name","sortOrder"=EXCLUDED."sortOrder","source"=EXCLUDED."source",
 "version"=COALESCE("choice_option_data"."version",0)+1,"updatedAt"=now();

-- Declarative sorcery-point costs for Metamagic.
WITH group_row AS (
 SELECT id FROM "choice_group_data" WHERE "referenceKey"='sorcerer_metamagic_level_3'
), costs("optionKey","amountRule","amountValue") AS (
 VALUES
 ('careful_spell','fixed',1),('distant_spell','fixed',1),('empowered_spell','fixed',1),
 ('extended_spell','fixed',1),('heightened_spell','fixed',3),('quickened_spell','fixed',2),
 ('subtle_spell','fixed',1),('twinned_spell','special',NULL)
)
INSERT INTO "feature_resource_effect_data" (
 "classFeatureId",type,"choiceOptionId","targetType","targetResourceKey","amountRule","amountValue","activationTrigger"
)
SELECT f.id,'spend',o.id,'featureResource','sorceryPoints',c."amountRule",c."amountValue",'manual'
FROM "class_feature_data" f
JOIN group_row g ON true
JOIN "choice_option_data" o ON o."choiceGroupId"=g.id
JOIN costs c ON c."optionKey"=o."optionKey"
WHERE f."referenceKey"='sorcerer_metamagic'
  AND NOT EXISTS (
    SELECT 1 FROM "feature_resource_effect_data" e
    WHERE e."classFeatureId"=f.id AND e."choiceOptionId"=o.id
      AND e.type='spend' AND e."targetResourceKey"='sorceryPoints'
  );

-- Pact of the Chain learns find familiar without counting against spells known.
UPDATE "choice_option_data" o
SET "grantedSpellKeys"='["find_familiar"]'::json,
    "version"=COALESCE(o.version,0)+1,"updatedAt"=now()
FROM "choice_group_data" g
WHERE o."choiceGroupId"=g.id
  AND g."referenceKey"='warlock_pact_boon'
  AND o."optionKey"='pact_chain'
  AND o."grantedSpellKeys"::jsonb IS DISTINCT FROM '["find_familiar"]'::jsonb;

INSERT INTO "serverpod_migrations" ("module","version","timestamp")
VALUES ('characters_mirror','20261006203000000-level3-technical-backfill-3',now())
ON CONFLICT ("module") DO UPDATE SET
 "version"='20261006203000000-level3-technical-backfill-3',"timestamp"=now();

COMMIT;
