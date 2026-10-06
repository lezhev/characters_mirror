BEGIN;

-- Level 1-3 technical reference-data backfill, batch 2.
-- Descriptive fields are intentionally untouched.

-- Bard Expertise at level 3: choose 2 existing skill proficiencies.
WITH feature AS (
  SELECT id FROM "class_feature_data" WHERE "referenceKey"='bard_expertise'
), grp AS (
  INSERT INTO "choice_group_data" (
    "referenceKey","name","sourceFeatureId","level","type",
    "selectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
  )
  SELECT 'bard_expertise_level_3','Компетентность',feature.id,3,'expertise',
         2,false,10,'PHB 2014',1,now(),now()
  FROM feature
  ON CONFLICT ("referenceKey") DO UPDATE SET
    "name"=EXCLUDED."name",
    "sourceClassId"=NULL,"sourceSubclassId"=NULL,
    "sourceFeatureId"=EXCLUDED."sourceFeatureId","sourceSubclassFeatureId"=NULL,
    "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
    "level"=EXCLUDED."level","type"=EXCLUDED."type",
    "selectionCount"=EXCLUDED."selectionCount","allowDuplicates"=EXCLUDED."allowDuplicates",
    "sortOrder"=EXCLUDED."sortOrder","source"=EXCLUDED."source",
    "version"=COALESCE("choice_group_data"."version",0)+1,"updatedAt"=now()
  RETURNING id
)
INSERT INTO "choice_option_data" (
  "choiceGroupId","optionKey","name","sortOrder",
  "grantedExpertiseSkills","requiredExistingSkill","source","version","createdAt","updatedAt"
)
SELECT grp.id,v.key,v.name,v.ord,to_json(ARRAY[v.key]),v.key,'PHB 2014',1,now(),now()
FROM grp
CROSS JOIN (VALUES
 ('acrobatics','Акробатика',1),
 ('animalHandling','Уход за животными',2),
 ('arcana','Магия',3),
 ('athletics','Атлетика',4),
 ('deception','Обман',5),
 ('history','История',6),
 ('insight','Проницательность',7),
 ('intimidation','Запугивание',8),
 ('investigation','Расследование',9),
 ('medicine','Медицина',10),
 ('nature','Природа',11),
 ('perception','Внимательность',12),
 ('performance','Выступление',13),
 ('persuasion','Убеждение',14),
 ('religion','Религия',15),
 ('sleightOfHand','Ловкость рук',16),
 ('stealth','Скрытность',17),
 ('survival','Выживание',18)
) AS v(key,name,ord)
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
  "name"=EXCLUDED."name",
  "sortOrder"=EXCLUDED."sortOrder",
  "grantedExpertiseSkills"=EXCLUDED."grantedExpertiseSkills",
  "requiredExistingSkill"=EXCLUDED."requiredExistingSkill",
  "source"=EXCLUDED."source",
  "version"=COALESCE("choice_option_data"."version",0)+1,
  "updatedAt"=now();

-- College of Lore: gain proficiency with any 3 skills.
WITH feature AS (
  SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='bard_lore_bonus_proficiencies'
), grp AS (
  INSERT INTO "choice_group_data" (
    "referenceKey","name","sourceSubclassFeatureId","level","type",
    "selectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
  )
  SELECT 'bard_lore_bonus_proficiencies','Дополнительные навыки',feature.id,3,'featureOption',
         3,false,10,'PHB 2014',1,now(),now()
  FROM feature
  ON CONFLICT ("referenceKey") DO UPDATE SET
    "name"=EXCLUDED."name",
    "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=NULL,
    "sourceSubclassFeatureId"=EXCLUDED."sourceSubclassFeatureId",
    "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
    "level"=EXCLUDED."level","type"=EXCLUDED."type",
    "selectionCount"=EXCLUDED."selectionCount","allowDuplicates"=EXCLUDED."allowDuplicates",
    "sortOrder"=EXCLUDED."sortOrder","source"=EXCLUDED."source",
    "version"=COALESCE("choice_group_data"."version",0)+1,"updatedAt"=now()
  RETURNING id
)
INSERT INTO "choice_option_data" (
  "choiceGroupId","optionKey","name","sortOrder","grantedSkills",
  "source","version","createdAt","updatedAt"
)
SELECT grp.id,v.key,v.name,v.ord,to_json(ARRAY[v.key]),'PHB 2014',1,now(),now()
FROM grp
CROSS JOIN (VALUES
 ('acrobatics','Акробатика',1),
 ('animalHandling','Уход за животными',2),
 ('arcana','Магия',3),
 ('athletics','Атлетика',4),
 ('deception','Обман',5),
 ('history','История',6),
 ('insight','Проницательность',7),
 ('intimidation','Запугивание',8),
 ('investigation','Расследование',9),
 ('medicine','Медицина',10),
 ('nature','Природа',11),
 ('perception','Внимательность',12),
 ('performance','Выступление',13),
 ('persuasion','Убеждение',14),
 ('religion','Религия',15),
 ('sleightOfHand','Ловкость рук',16),
 ('stealth','Скрытность',17),
 ('survival','Выживание',18)
) AS v(key,name,ord)
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
  "name"=EXCLUDED."name",
  "sortOrder"=EXCLUDED."sortOrder",
  "grantedSkills"=EXCLUDED."grantedSkills",
  "source"=EXCLUDED."source",
  "version"=COALESCE("choice_option_data"."version",0)+1,
  "updatedAt"=now();

-- Cleric 3rd-level domain spells: always prepared.
WITH grants("featureKey","spellKey","grantedAtLevel") AS (
 VALUES
 ('cleric_knowledge_domain_spells','augury',3),
 ('cleric_knowledge_domain_spells','suggestion',3),
 ('cleric_life_domain_spells','lesser_restoration',3),
 ('cleric_life_domain_spells','spiritual_weapon',3),
 ('cleric_light_domain_spells','flaming_sphere',3),
 ('cleric_light_domain_spells','scorching_ray',3),
 ('cleric_nature_domain_spells','barkskin',3),
 ('cleric_nature_domain_spells','spike_growth',3),
 ('cleric_tempest_domain_spells','gust_of_wind',3),
 ('cleric_tempest_domain_spells','shatter',3),
 ('cleric_trickery_domain_spells','mirror_image',3),
 ('cleric_trickery_domain_spells','pass_without_trace',3),
 ('cleric_war_domain_spells','magic_weapon',3),
 ('cleric_war_domain_spells','spiritual_weapon',3)
)
INSERT INTO "class_spell_grant_data" (
  "spellId","sourceSubclassFeatureId","grantedAtLevel","alwaysPrepared",
  source,version,"createdAt","updatedAt"
)
SELECT spell.id,feature.id,grants."grantedAtLevel",true,
       'PHB 2014',1,now(),now()
FROM grants
JOIN "subclass_feature_data" feature ON feature."referenceKey"=grants."featureKey"
JOIN "spell_data" spell ON spell."referenceKey"=grants."spellKey"
WHERE NOT EXISTS (
  SELECT 1 FROM "class_spell_grant_data" existing
  WHERE existing."sourceSubclassFeatureId"=feature.id
    AND existing."spellId"=spell.id
    AND COALESCE(existing."grantedAtLevel",1)=grants."grantedAtLevel"
    AND existing."alwaysPrepared" IS TRUE
);

INSERT INTO "serverpod_migrations" ("module","version","timestamp")
VALUES ('characters_mirror','20261006202000000-level3-technical-backfill-2',now())
ON CONFLICT ("module") DO UPDATE SET
  "version"='20261006202000000-level3-technical-backfill-2',
  "timestamp"=now();

COMMIT;
