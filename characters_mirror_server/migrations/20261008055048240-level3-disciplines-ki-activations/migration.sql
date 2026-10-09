BEGIN;


-- New PHB 2014 Four Elements discipline selections.
CREATE TEMP TABLE _disciplines(level bigint, option_key text, name text, order_no bigint) ON COMMIT DROP;
INSERT INTO _disciplines VALUES
(6,'clench_of_the_north_wind','Объятья северного ветра',8),
(6,'gong_of_the_summit','Гонг на вершине горы',9),
(11,'clench_of_the_north_wind','Объятья северного ветра',8),
(11,'gong_of_the_summit','Гонг на вершине горы',9),
(11,'flames_of_the_phoenix','Пламя феникса',10),
(11,'mist_stance','Туманная стойка',11),
(11,'ride_the_wind','Осёдланный ветер',12),
(17,'clench_of_the_north_wind','Объятья северного ветра',8),
(17,'gong_of_the_summit','Гонг на вершине горы',9),
(17,'flames_of_the_phoenix','Пламя феникса',10),
(17,'mist_stance','Туманная стойка',11),
(17,'ride_the_wind','Осёдланный ветер',12),
(17,'breath_of_winter','Дыхание зимы',13),
(17,'eternal_mountain_defense','Прочность вечных гор',14),
(17,'river_of_hungry_flame','Река голодного пламени',15),
(17,'wave_of_rolling_earth','Земляной вал',16);

DO $$
BEGIN
 IF EXISTS (SELECT 1 FROM _disciplines d LEFT JOIN choice_group_data g ON g."referenceKey"='monk_four_elements_disciplines_'||d.level::text WHERE g.id IS NULL) THEN
   RAISE EXCEPTION 'Missing Four Elements choice group';
 END IF;
END $$;
INSERT INTO choice_option_data ("choiceGroupId","optionKey",name,"sortOrder",source,version,"createdAt","updatedAt")
SELECT g.id,d.option_key,d.name,d.order_no,'PHB 2014',1,now(),now()
FROM _disciplines d
JOIN choice_group_data g ON g."referenceKey"='monk_four_elements_disciplines_'||d.level::text
WHERE NOT EXISTS (SELECT 1 FROM choice_option_data o WHERE o."choiceGroupId"=g.id AND o."optionKey"=d.option_key);


CREATE TEMP TABLE _discipline_spell_grants(level bigint, option_key text, spell_key text, activation_json json) ON COMMIT DROP;
INSERT INTO _discipline_spell_grants VALUES
(6,'clench_of_the_north_wind','hold_person','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":3,"resourceUpcastPolicy":{"resourcePerAdditionalSpellLevel":1,"maxResourceCostBySourceLevel":[{"k":9,"v":4},{"k":13,"v":5},{"k":17,"v":6}]}}'),
(6,'gong_of_the_summit','shatter','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":3,"resourceUpcastPolicy":{"resourcePerAdditionalSpellLevel":1,"maxResourceCostBySourceLevel":[{"k":9,"v":4},{"k":13,"v":5},{"k":17,"v":6}]}}'),
(11,'clench_of_the_north_wind','hold_person','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":3,"resourceUpcastPolicy":{"resourcePerAdditionalSpellLevel":1,"maxResourceCostBySourceLevel":[{"k":9,"v":4},{"k":13,"v":5},{"k":17,"v":6}]}}'),
(11,'gong_of_the_summit','shatter','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":3,"resourceUpcastPolicy":{"resourcePerAdditionalSpellLevel":1,"maxResourceCostBySourceLevel":[{"k":9,"v":4},{"k":13,"v":5},{"k":17,"v":6}]}}'),
(11,'flames_of_the_phoenix','fireball','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":4,"resourceUpcastPolicy":{"resourcePerAdditionalSpellLevel":1,"maxResourceCostBySourceLevel":[{"k":13,"v":5},{"k":17,"v":6}]}}'),
(11,'mist_stance','gaseous_form','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":4,"castAtSpellLevel":3}'),
(11,'ride_the_wind','fly','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":4,"castAtSpellLevel":3}'),
(17,'clench_of_the_north_wind','hold_person','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":3,"resourceUpcastPolicy":{"resourcePerAdditionalSpellLevel":1,"maxResourceCostBySourceLevel":[{"k":9,"v":4},{"k":13,"v":5},{"k":17,"v":6}]}}'),
(17,'gong_of_the_summit','shatter','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":3,"resourceUpcastPolicy":{"resourcePerAdditionalSpellLevel":1,"maxResourceCostBySourceLevel":[{"k":9,"v":4},{"k":13,"v":5},{"k":17,"v":6}]}}'),
(17,'flames_of_the_phoenix','fireball','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":4,"resourceUpcastPolicy":{"resourcePerAdditionalSpellLevel":1,"maxResourceCostBySourceLevel":[{"k":13,"v":5},{"k":17,"v":6}]}}'),
(17,'mist_stance','gaseous_form','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":4,"castAtSpellLevel":3}'),
(17,'ride_the_wind','fly','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":4,"castAtSpellLevel":3}'),
(17,'breath_of_winter','cone_of_cold','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":6,"castAtSpellLevel":5}'),
(17,'eternal_mountain_defense','stoneskin','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":5,"castAtSpellLevel":4}'),
(17,'river_of_hungry_flame','wall_of_fire','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":5,"resourceUpcastPolicy":{"resourcePerAdditionalSpellLevel":1,"maxResourceCostBySourceLevel":[{"k":17,"v":6}]}}'),
(17,'wave_of_rolling_earth','wall_of_stone','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":6,"castAtSpellLevel":5}');

DO $$
BEGIN
 IF EXISTS(SELECT 1 FROM _discipline_spell_grants d LEFT JOIN spell_data s ON s."referenceKey"=d.spell_key WHERE s.id IS NULL)
 THEN RAISE EXCEPTION 'Missing Four Elements spell';
 END IF;
END $$;
INSERT INTO class_spell_grant_data ("sourceSubclassFeatureId","spellId","grantedAtLevel","alwaysPrepared","choiceOptionId",activation,"castingAbility",source,version,"createdAt","updatedAt")
SELECT f.id,s.id,d.level,true,o.id,d.activation_json,'wisdom',f.source,1,now(),now()
FROM _discipline_spell_grants d
JOIN subclass_feature_data f ON f."referenceKey"='monk_four_elements_disciple_of_the_elements'
JOIN choice_group_data g ON g."referenceKey"='monk_four_elements_disciplines_'||d.level::text
JOIN choice_option_data o ON o."choiceGroupId"=g.id AND o."optionKey"=d.option_key
JOIN spell_data s ON s."referenceKey"=d.spell_key
WHERE NOT EXISTS(SELECT 1 FROM class_spell_grant_data old WHERE old."sourceSubclassFeatureId"=f.id
 AND old."spellId"=s.id AND old."choiceOptionId"=o.id AND old."grantedAtLevel"=d.level);


-- Static PHB elemental attunement is known in addition to selectable disciplines.
INSERT INTO choice_group_data ("referenceKey",name,"sourceSubclassFeatureId",level,type,"selectionCount","minimumSelectionCount","autoSelectSingleEligible","sortOrder",source,version,"createdAt","updatedAt")
SELECT 'monk_four_elements_elemental_attunement','Родство со стихией',f.id,3,'featureOption',1,1,true,0,f.source,1,now(),now()
FROM subclass_feature_data f WHERE f."referenceKey"='monk_four_elements_disciple_of_the_elements'
AND NOT EXISTS(SELECT 1 FROM choice_group_data g WHERE g."referenceKey"='monk_four_elements_elemental_attunement');
INSERT INTO choice_option_data ("choiceGroupId","optionKey",name,"automaticSelection","sortOrder",source,version,"createdAt","updatedAt")
SELECT g.id,'elemental_attunement','Родство со стихией',true,0,g.source,1,now(),now()
FROM choice_group_data g WHERE g."referenceKey"='monk_four_elements_elemental_attunement'
AND NOT EXISTS(SELECT 1 FROM choice_option_data o WHERE o."choiceGroupId"=g.id AND o."optionKey"='elemental_attunement');


-- Spell-only, resource-paid upcast; fixed level is intentionally cleared.
UPDATE class_spell_grant_data g
SET activation=jsonb_set((g.activation::jsonb - 'castAtSpellLevel'),'{resourceUpcastPolicy}','{"resourcePerAdditionalSpellLevel":1,"maxResourceCostBySourceLevel":[{"k":3,"v":2},{"k":5,"v":3},{"k":9,"v":4},{"k":13,"v":5},{"k":17,"v":6}]}'::jsonb)::json,
    version=coalesce(g.version,0)+1,"updatedAt"=now()
FROM subclass_feature_data f,spell_data s
WHERE g."sourceSubclassFeatureId"=f.id AND g."spellId"=s.id
AND f."referenceKey"='monk_four_elements_disciple_of_the_elements'
AND s."referenceKey" IN ('burning_hands','thunderwave')
AND g.activation IS NOT NULL AND (g.activation::jsonb -> 'resourceUpcastPolicy') IS NULL;


-- Shadow Arts spells are paid via ki; suppress legacy class-source fallback.
CREATE TEMP TABLE _shadow_spells(spell_key text,activation_json json) ON COMMIT DROP;
INSERT INTO _shadow_spells VALUES
('pass_without_trace','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":2,"castAtSpellLevel":2}'),
('darkvision','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":2,"castAtSpellLevel":2}'),
('silence','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":2,"castAtSpellLevel":2}'),
('darkness','{"canUseStandardSlots":false,"canUsePactSlots":false,"slotless":true,"atWill":false,"resourceKey":"ki","resourceCost":2,"castAtSpellLevel":2}');

INSERT INTO class_spell_grant_data ("sourceSubclassFeatureId","spellId","grantedAtLevel","alwaysPrepared",activation,"castingAbility",source,version,"createdAt","updatedAt")
SELECT f.id,s.id,3,true,d.activation_json,'wisdom',f.source,1,now(),now()
FROM _shadow_spells d
JOIN subclass_feature_data f ON f."referenceKey"='monk_shadow_shadow_arts'
JOIN spell_data s ON s."referenceKey"=d.spell_key
WHERE NOT EXISTS(SELECT 1 FROM class_spell_grant_data old WHERE old."sourceSubclassFeatureId"=f.id AND old."spellId"=s.id
 AND old."grantedAtLevel"=3 AND old."choiceOptionId" IS NULL);




--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261008055048240-level3-disciplines-ki-activations', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008055048240-level3-disciplines-ki-activations', "timestamp" = now();

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
