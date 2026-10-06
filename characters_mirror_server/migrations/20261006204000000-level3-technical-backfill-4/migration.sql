BEGIN;

-- Level 1-3 technical reference-data backfill, batch 4.
-- Descriptive feature text is intentionally untouched.

-- Mandatory PHB choices already present in the catalog.
UPDATE "choice_group_data"
SET "minimumSelectionCount"="selectionCount",
    "version"=COALESCE("version",0)+1,
    "updatedAt"=now()
WHERE "referenceKey" IN (
  'class_feature_39_fighting_style',
  'class_feature_68_fighting_style',
  'class_feature_81_fighting_style',
  'warlock_eldritch_invocations_2',
  'warlock_pact_boon'
)
AND "minimumSelectionCount" IS DISTINCT FROM "selectionCount";

-- Nature Domain: one druid cantrip.
WITH feature AS (
 SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='cleric_nature_acolyte_of_nature'
), grp AS (
 INSERT INTO "choice_group_data" (
  "referenceKey","name","sourceSubclassFeatureId","level","type",
  "selectionCount","minimumSelectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
 )
 SELECT 'cleric_nature_acolyte_cantrip','Заговор друида',feature.id,1,'featureOption',1,1,false,10,'PHB 2014',1,now(),now()
 FROM feature
 ON CONFLICT ("referenceKey") DO UPDATE SET
  "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=NULL,
  "sourceSubclassFeatureId"=EXCLUDED."sourceSubclassFeatureId",
  "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
  "level"=1,"type"='featureOption',"selectionCount"=1,"minimumSelectionCount"=1,
  "allowDuplicates"=false,"source"='PHB 2014',
  "version"=COALESCE("choice_group_data".version,0)+1,"updatedAt"=now()
 RETURNING id
)
INSERT INTO "choice_option_data" (
 "choiceGroupId","optionKey","name","sortOrder","grantedSpellKeys","source","version","createdAt","updatedAt"
)
SELECT grp.id,sp."referenceKey",sp.name,row_number() OVER (ORDER BY sp."referenceKey"),
       to_json(ARRAY[sp."referenceKey"]),'PHB 2014',1,now(),now()
FROM grp CROSS JOIN "spell_data" sp
WHERE sp.level=0 AND sp.source='PHB 2014'
  AND sp."referenceKey" IN ('druidcraft','guidance','mending','poison_spray','produce_flame','resistance','shillelagh','thorn_whip')
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
 "name"=EXCLUDED."name","sortOrder"=EXCLUDED."sortOrder","grantedSpellKeys"=EXCLUDED."grantedSpellKeys",
 "source"=EXCLUDED."source","version"=COALESCE("choice_option_data".version,0)+1,"updatedAt"=now();

-- Nature Domain: one of Animal Handling, Nature, Survival.
WITH feature AS (
 SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='cleric_nature_acolyte_of_nature'
), grp AS (
 INSERT INTO "choice_group_data" (
  "referenceKey","name","sourceSubclassFeatureId","level","type",
  "selectionCount","minimumSelectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
 )
 SELECT 'cleric_nature_acolyte_skill','Навык природы',feature.id,1,'featureOption',1,1,false,20,'PHB 2014',1,now(),now()
 FROM feature
 ON CONFLICT ("referenceKey") DO UPDATE SET
  "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=NULL,
  "sourceSubclassFeatureId"=EXCLUDED."sourceSubclassFeatureId",
  "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
  "level"=1,"type"='featureOption',"selectionCount"=1,"minimumSelectionCount"=1,
  "allowDuplicates"=false,"source"='PHB 2014',
  "version"=COALESCE("choice_group_data".version,0)+1,"updatedAt"=now()
 RETURNING id
)
INSERT INTO "choice_option_data" (
 "choiceGroupId","optionKey","name","sortOrder","grantedSkills","source","version","createdAt","updatedAt"
)
SELECT grp.id,v.key,v.name,v.ord,to_json(ARRAY[v.key]),'PHB 2014',1,now(),now()
FROM grp CROSS JOIN (VALUES
 ('animalHandling','Уход за животными',1),('nature','Природа',2),('survival','Выживание',3)
) AS v(key,name,ord)
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
 "name"=EXCLUDED."name","sortOrder"=EXCLUDED."sortOrder","grantedSkills"=EXCLUDED."grantedSkills",
 "source"=EXCLUDED."source","version"=COALESCE("choice_option_data".version,0)+1,"updatedAt"=now();

-- Circle of the Land: bonus druid cantrip.
WITH feature AS (
 SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='druid_land_bonus_cantrip'
), grp AS (
 INSERT INTO "choice_group_data" (
  "referenceKey","name","sourceSubclassFeatureId","level","type",
  "selectionCount","minimumSelectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
 )
 SELECT 'druid_land_bonus_cantrip','Дополнительный заговор',feature.id,2,'featureOption',1,1,false,10,'PHB 2014',1,now(),now()
 FROM feature
 ON CONFLICT ("referenceKey") DO UPDATE SET
  "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=NULL,
  "sourceSubclassFeatureId"=EXCLUDED."sourceSubclassFeatureId",
  "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
  "level"=2,"type"='featureOption',"selectionCount"=1,"minimumSelectionCount"=1,
  "allowDuplicates"=false,"source"='PHB 2014',
  "version"=COALESCE("choice_group_data".version,0)+1,"updatedAt"=now()
 RETURNING id
)
INSERT INTO "choice_option_data" (
 "choiceGroupId","optionKey","name","sortOrder","grantedSpellKeys","source","version","createdAt","updatedAt"
)
SELECT grp.id,sp."referenceKey",sp.name,row_number() OVER (ORDER BY sp."referenceKey"),
       to_json(ARRAY[sp."referenceKey"]),'PHB 2014',1,now(),now()
FROM grp CROSS JOIN "spell_data" sp
WHERE sp.level=0 AND sp.source='PHB 2014'
  AND sp."referenceKey" IN ('druidcraft','guidance','mending','poison_spray','produce_flame','resistance','shillelagh','thorn_whip')
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
 "name"=EXCLUDED."name","sortOrder"=EXCLUDED."sortOrder","grantedSpellKeys"=EXCLUDED."grantedSpellKeys",
 "source"=EXCLUDED."source","version"=COALESCE("choice_option_data".version,0)+1,"updatedAt"=now();

-- Circle of the Land: one land choice.
WITH feature AS (
 SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='druid_land_circle_spells'
)
INSERT INTO "choice_group_data" (
 "referenceKey","name","sourceSubclassFeatureId","level","type",
 "selectionCount","minimumSelectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
)
SELECT 'druid_land_terrain','Местность круга',feature.id,3,'featureOption',1,1,false,10,'PHB 2014',1,now(),now()
FROM feature
ON CONFLICT ("referenceKey") DO UPDATE SET
 "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=NULL,
 "sourceSubclassFeatureId"=EXCLUDED."sourceSubclassFeatureId",
 "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
 "level"=3,"type"='featureOption',"selectionCount"=1,"minimumSelectionCount"=1,
 "allowDuplicates"=false,"source"='PHB 2014',
 "version"=COALESCE("choice_group_data".version,0)+1,"updatedAt"=now();

WITH grp AS (SELECT id FROM "choice_group_data" WHERE "referenceKey"='druid_land_terrain')
INSERT INTO "choice_option_data" ("choiceGroupId","optionKey","name","sortOrder","source","version","createdAt","updatedAt")
SELECT grp.id,v.key,v.name,v.ord,'PHB 2014',1,now(),now()
FROM grp CROSS JOIN (VALUES
 ('arctic','Арктика',1),('coast','Побережье',2),('desert','Пустыня',3),('forest','Лес',4),
 ('grassland','Луга',5),('mountain','Горы',6),('swamp','Болото',7),('underdark','Подземье',8)
) AS v(key,name,ord)
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
 "name"=EXCLUDED."name","sortOrder"=EXCLUDED."sortOrder","source"=EXCLUDED."source",
 "version"=COALESCE("choice_option_data".version,0)+1,"updatedAt"=now();

-- Selected land -> 3rd-level Circle Spells, always prepared.
WITH grants("optionKey","spellKey") AS (
 VALUES
 ('arctic','hold_person'),('arctic','spike_growth'),
 ('coast','mirror_image'),('coast','misty_step'),
 ('desert','blur'),('desert','silence'),
 ('forest','barkskin'),('forest','spider_climb'),
 ('grassland','invisibility'),('grassland','pass_without_trace'),
 ('mountain','spider_climb'),('mountain','spike_growth'),
 ('swamp','darkness'),('swamp','melfs_acid_arrow'),
 ('underdark','spider_climb'),('underdark','web')
), grp AS (
 SELECT id FROM "choice_group_data" WHERE "referenceKey"='druid_land_terrain'
), feature AS (
 SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='druid_land_circle_spells'
)
INSERT INTO "class_spell_grant_data" (
 "spellId","sourceSubclassFeatureId","grantedAtLevel","alwaysPrepared","choiceOptionId",
 source,version,"createdAt","updatedAt"
)
SELECT sp.id,feature.id,3,true,o.id,'PHB 2014',1,now(),now()
FROM grants g
JOIN grp ON true
JOIN "choice_option_data" o ON o."choiceGroupId"=grp.id AND o."optionKey"=g."optionKey"
JOIN "spell_data" sp ON sp."referenceKey"=g."spellKey"
JOIN feature ON true
WHERE NOT EXISTS (
 SELECT 1 FROM "class_spell_grant_data" e
 WHERE e."sourceSubclassFeatureId"=feature.id AND e."spellId"=sp.id
   AND e."choiceOptionId"=o.id AND COALESCE(e."grantedAtLevel",1)=3
   AND e."alwaysPrepared" IS TRUE
);

-- Remove the old unconditional Circle-of-the-Land subclass availability for
-- the 3rd-level circle-spell set. Druid-list membership remains untouched.
WITH land AS (SELECT id FROM "subclass_data" WHERE "referenceKey"='druid_land')
UPDATE "spell_data" sp
SET "availableForSubclassIds"=COALESCE((
  SELECT json_agg(v.value::bigint)
  FROM json_array_elements_text(COALESCE(sp."availableForSubclassIds",'[]'::json)) v(value)
  CROSS JOIN land
  WHERE v.value::bigint <> land.id
),'[]'::json)
WHERE sp."referenceKey" IN (
 'hold_person','spike_growth','mirror_image','misty_step','blur','silence',
 'barkskin','spider_climb','invisibility','pass_without_trace','darkness','melfs_acid_arrow','web'
)
AND EXISTS (
 SELECT 1 FROM land
 WHERE sp."availableForSubclassIds"::jsonb @> to_jsonb(ARRAY[land.id])
);

-- Natural Recovery: one use per long rest; spell-slot restoration is a
-- declarative special operation requiring slot selection/budget at runtime.
INSERT INTO "feature_resource_definition_data" (
 "subclassFeatureId",key,kind,"maxRule","maxValue","resetOn","activationTrigger"
)
SELECT f.id,'naturalRecovery','uses','fixed',1,'longRest','shortRest'
FROM "subclass_feature_data" f
WHERE f."referenceKey"='druid_land_natural_recovery'
AND NOT EXISTS (
 SELECT 1 FROM "feature_resource_definition_data" r
 WHERE r."subclassFeatureId"=f.id AND r.key='naturalRecovery'
);

INSERT INTO "feature_resource_effect_data" (
 "subclassFeatureId",type,"targetType","amountRule","activationTrigger","usageResetOn"
)
SELECT f.id,'restore','spellSlots','special','shortRest','longRest'
FROM "subclass_feature_data" f
WHERE f."referenceKey"='druid_land_natural_recovery'
AND NOT EXISTS (
 SELECT 1 FROM "feature_resource_effect_data" e
 WHERE e."subclassFeatureId"=f.id AND e.type='restore' AND e."targetType"='spellSlots'
);

-- Battle Master maneuvers: choose three at 3rd level.
WITH feature AS (
 SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='fighter_battle_master_combat_superiority'
), grp AS (
 INSERT INTO "choice_group_data" (
  "referenceKey","name","sourceSubclassFeatureId","level","type",
  "selectionCount","minimumSelectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
 )
 SELECT 'fighter_battle_master_maneuvers_3','Боевые приёмы',feature.id,3,'featureOption',3,3,false,10,'PHB 2014',1,now(),now()
 FROM feature
 ON CONFLICT ("referenceKey") DO UPDATE SET
  "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=NULL,
  "sourceSubclassFeatureId"=EXCLUDED."sourceSubclassFeatureId",
  "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
  "level"=3,"type"='featureOption',"selectionCount"=3,"minimumSelectionCount"=3,
  "allowDuplicates"=false,"source"='PHB 2014',
  "version"=COALESCE("choice_group_data".version,0)+1,"updatedAt"=now()
 RETURNING id
)
INSERT INTO "choice_option_data" ("choiceGroupId","optionKey","name","sortOrder","source","version","createdAt","updatedAt")
SELECT grp.id,v.key,v.name,v.ord,'PHB 2014',1,now(),now()
FROM grp CROSS JOIN (VALUES
 ('commanders_strike','Командирский удар',1),
 ('disarming_attack','Обезоруживающая атака',2),
 ('distracting_strike','Отвлекающий удар',3),
 ('evasive_footwork','Уклонение',4),
 ('feinting_attack','Финт',5),
 ('goading_attack','Провоцирующая атака',6),
 ('lunging_attack','Выпад',7),
 ('maneuvering_attack','Маневрирующая атака',8),
 ('menacing_attack','Устрашающая атака',9),
 ('parry','Парирование',10),
 ('precision_attack','Точная атака',11),
 ('pushing_attack','Толкающая атака',12),
 ('rally','Воодушевление',13),
 ('riposte','Ответный удар',14),
 ('sweeping_attack','Размашистая атака',15),
 ('trip_attack','Сбивающая атака',16)
) AS v(key,name,ord)
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
 "name"=EXCLUDED."name","sortOrder"=EXCLUDED."sortOrder","source"=EXCLUDED."source",
 "version"=COALESCE("choice_option_data".version,0)+1,"updatedAt"=now();

-- Way of Shadow spell access. Minor Illusion is intentionally not auto-granted:
-- RAW has a replacement case when it is already known.
UPDATE "subclass_feature_data"
SET "grantedSpellKeys"='["darkness","darkvision","pass_without_trace","silence"]'::json,
    version=COALESCE(version,0)+1,"updatedAt"=now()
WHERE "referenceKey"='monk_shadow_shadow_arts'
AND "grantedSpellKeys"::jsonb IS DISTINCT FROM '["darkness","darkvision","pass_without_trace","silence"]'::jsonb;

-- Way of the Four Elements: Elemental Attunement is automatic; choose one
-- additional 3rd-level discipline.
WITH feature AS (
 SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='monk_four_elements_disciple_of_the_elements'
), grp AS (
 INSERT INTO "choice_group_data" (
  "referenceKey","name","sourceSubclassFeatureId","level","type",
  "selectionCount","minimumSelectionCount","allowDuplicates","sortOrder","source","version","createdAt","updatedAt"
 )
 SELECT 'monk_four_elements_disciplines_3','Стихийная практика',feature.id,3,'featureOption',1,1,false,10,'PHB 2014',1,now(),now()
 FROM feature
 ON CONFLICT ("referenceKey") DO UPDATE SET
  "sourceClassId"=NULL,"sourceSubclassId"=NULL,"sourceFeatureId"=NULL,
  "sourceSubclassFeatureId"=EXCLUDED."sourceSubclassFeatureId",
  "sourceRaceId"=NULL,"sourceSubraceId"=NULL,"sourceRaceFeatureId"=NULL,"sourceBackgroundId"=NULL,
  "level"=3,"type"='featureOption',"selectionCount"=1,"minimumSelectionCount"=1,
  "allowDuplicates"=false,"source"='PHB 2014',
  "version"=COALESCE("choice_group_data".version,0)+1,"updatedAt"=now()
 RETURNING id
)
INSERT INTO "choice_option_data" (
 "choiceGroupId","optionKey","name","sortOrder","grantedSpellKeys","source","version","createdAt","updatedAt"
)
SELECT grp.id,v.key,v.name,v.ord,
       CASE WHEN v.spell IS NULL THEN NULL ELSE to_json(ARRAY[v.spell]) END,
       'PHB 2014',1,now(),now()
FROM grp CROSS JOIN (VALUES
 ('water_whip','Водяной кнут',1,NULL::text),
 ('fangs_of_fire_snake','Зубы огненной змеи',2,NULL::text),
 ('sweeping_cinder_strike','Испепеляющий удар',3,'burning_hands'),
 ('fist_of_four_thunders','Кулак четырёх громов',4,'thunderwave'),
 ('rush_of_gale_spirits','Натиск штормовых духов',5,'gust_of_wind'),
 ('fist_of_unbroken_air','Несокрушимый воздушный кулак',6,NULL::text),
 ('shape_flowing_river','Формирование текущей реки',7,NULL::text)
) AS v(key,name,ord,spell)
ON CONFLICT ("choiceGroupId","optionKey") DO UPDATE SET
 "name"=EXCLUDED."name","sortOrder"=EXCLUDED."sortOrder","grantedSpellKeys"=EXCLUDED."grantedSpellKeys",
 "source"=EXCLUDED."source","version"=COALESCE("choice_option_data".version,0)+1,"updatedAt"=now();

WITH grp AS (
 SELECT id FROM "choice_group_data" WHERE "referenceKey"='monk_four_elements_disciplines_3'
), costs("optionKey","amount") AS (
 VALUES
 ('water_whip',2),('fangs_of_fire_snake',1),('sweeping_cinder_strike',2),
 ('fist_of_four_thunders',2),('rush_of_gale_spirits',2),
 ('fist_of_unbroken_air',2),('shape_flowing_river',1)
), feature AS (
 SELECT id FROM "subclass_feature_data" WHERE "referenceKey"='monk_four_elements_disciple_of_the_elements'
)
INSERT INTO "feature_resource_effect_data" (
 "subclassFeatureId",type,"choiceOptionId","targetType","targetResourceKey","amountRule","amountValue","activationTrigger"
)
SELECT feature.id,'spend',o.id,'featureResource','ki','fixed',c.amount,'manual'
FROM feature CROSS JOIN grp
JOIN "choice_option_data" o ON o."choiceGroupId"=grp.id
JOIN costs c ON c."optionKey"=o."optionKey"
WHERE NOT EXISTS (
 SELECT 1 FROM "feature_resource_effect_data" e
 WHERE e."subclassFeatureId"=feature.id AND e."choiceOptionId"=o.id
   AND e.type='spend' AND e."targetResourceKey"='ki'
);

-- Arcane Trickster always knows Mage Hand. Full subclass spellcasting remains
-- blocked by school-selection semantics and is intentionally not approximated.
UPDATE "subclass_feature_data"
SET "grantedSpellKeys"='["mage_hand"]'::json,
    version=COALESCE(version,0)+1,"updatedAt"=now()
WHERE "referenceKey"='rogue_arcane_trickster_mage_hand_legerdemain'
AND "grantedSpellKeys"::jsonb IS DISTINCT FROM '["mage_hand"]'::jsonb;

INSERT INTO "serverpod_migrations" ("module","version","timestamp")
VALUES ('characters_mirror','20261006204000000-level3-technical-backfill-4',now())
ON CONFLICT ("module") DO UPDATE SET
 "version"='20261006204000000-level3-technical-backfill-4',"timestamp"=now();

COMMIT;
