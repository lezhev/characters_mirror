BEGIN;

-- Level-3 subclass reference data, PHB 2014. No schema changes.
-- All text was approved before this migration.
-- This migration intentionally does not modify ritual-only spell sources,
-- Shadow Arts activation, Four Elements discipline options or runtime combat.

CREATE TEMP TABLE _level3_short (feature_key text PRIMARY KEY, short_text text NOT NULL) ON COMMIT DROP;
INSERT INTO _level3_short (feature_key,short_text) VALUES
('barbarian_berserker_frenzy','Во время ярости вы можете впасть в бешенство и со следующего хода совершать одну рукопашную атаку оружием бонусным действием. После окончания ярости вы получаете одну степень истощения.'),
('barbarian_totem_warrior_spirit_seeker','Вы можете накладывать «Животные чувства» и «Разговор с животными», но только в виде ритуалов.'),
('barbarian_totem_warrior_totem_spirit','Выберите тотемный дух — Волка, Медведя или Орла — и получите связанные с ним способности.'),
('bard_lore_bonus_proficiencies','Вы получаете владение тремя навыками на выбор.'),
('bard_lore_cutting_words','Реакцией потратьте кость Бардовского вдохновения, чтобы уменьшить бросок атаки, урона или проверку характеристики видимого существа в пределах 60 футов.'),
('bard_valor_bonus_proficiencies','Вы получаете владение средними доспехами, щитами и воинским оружием.'),
('bard_valor_combat_inspiration','Существо с вашей костью Бардовского вдохновения может добавить её результат к урону оружием. Если его атакуют, оно может реакцией добавить результат к КД против этой атаки.'),
('druid_land_circle_spells','Выберите тип местности, с которым связан ваш круг: он определяет дополнительные заклинания. Эти заклинания всегда подготовлены и не учитываются в количестве подготовленных заклинаний.'),
('fighter_battle_master_combat_superiority','Вы изучаете три приёма и получаете четыре кости превосходства к8 для их использования. Кости восстанавливаются после короткого или продолжительного отдыха. На более высоких уровнях вы изучаете новые приёмы и можете заменять известные.'),
('fighter_battle_master_student_of_war','Вы получаете владение одним ремесленным инструментом на выбор.'),
('fighter_champion_improved_critical','Ваши атаки оружием совершают критическое попадание при результате 19 или 20 на кости атаки.'),
('fighter_eldritch_knight_spellcasting','Вы изучаете заклинания волшебника и используете Интеллект для их сотворения. На 3-м уровне одно из трёх заклинаний 1-го уровня может быть любой школы, остальные должны принадлежать Ограждению или Воплощению. Ещё по одному заклинанию любой школы можно изучить на 8-м, 14-м и 20-м уровнях.'),
('fighter_eldritch_knight_weapon_bond','После часового ритуала вы можете связать себя с оружием. Пока вы дееспособны, это оружие нельзя выбить у вас из рук; если оно находится на том же плане существования, вы можете бонусным действием телепортировать его себе в руку. Одновременно можно иметь до двух связанных оружий.'),
('monk_four_elements_disciple_of_the_elements','Вы изучаете стихийные практики и тратите ци на их использование. Некоторые практики позволяют накладывать заклинания без материальных компонентов.'),
('monk_open_hand_open_hand_technique','Попав атакой из «Шквала ударов», вы можете выбрать один эффект: цель совершает спасбросок Ловкости, иначе сбивается с ног; совершает спасбросок Силы, иначе отталкивается на расстояние до 15 футов; либо не может совершать реакции до конца вашего следующего хода.'),
('monk_shadow_shadow_arts','За 2 очка ци вы можете накладывать «Бесследное передвижение», «Тёмное зрение», «Тишину» или «Тьму» без материальных компонентов. Также вы получаете «Малую иллюзию», если ещё не знаете её.'),
('paladin_ancients_channel_divinity','Вы получаете два варианта Божественного канала: «Гнев природы» и «Изгнать неверного».'),
('paladin_ancients_oath_spells','Заклинания вашей клятвы всегда подготовлены и не учитываются в количестве подготовленных заклинаний.'),
('paladin_devotion_channel_divinity','Вы получаете два варианта Божественного канала: «Священное оружие» и «Изгнать нечистого».'),
('paladin_devotion_oath_spells','Заклинания вашей клятвы всегда подготовлены и не учитываются в количестве подготовленных заклинаний.'),
('paladin_vengeance_channel_divinity','Вы получаете два варианта Божественного канала: «Порицание врага» и «Обет вражды».'),
('paladin_vengeance_oath_spells','Заклинания вашей клятвы всегда подготовлены и не учитываются в количестве подготовленных заклинаний.'),
('ranger_hunter_hunters_prey','Выберите один стиль охоты: «Сокрушитель орд», «Убийца великанов» или «Убийца колоссов».'),
('rogue_arcane_trickster_mage_hand_legerdemain','При сотворении «Волшебной руки» вы можете сделать её невидимой. Ею можно класть предметы в контейнеры, которые носит или несёт другое существо, доставать предметы из них и использовать воровские инструменты на расстоянии. Чтобы сделать это незаметно, совершите проверку Ловкости рук против Восприятия существа.'),
('rogue_arcane_trickster_spellcasting','Вы изучаете заклинания волшебника и используете Интеллект для их сотворения. На 3-м уровне одно из трёх заклинаний 1-го уровня может быть любой школы, остальные должны принадлежать Иллюзии или Очарованию. Ещё по одному заклинанию любой школы можно изучить на 8-м, 14-м и 20-м уровнях.'),
('rogue_assassin_assassinate','Вы совершаете атаки с преимуществом по существам, которые ещё не ходили в бою, а попадания по застигнутым врасплох существам становятся критическими.'),
('rogue_assassin_bonus_proficiencies','Вы получаете владение набором для грима и инструментами отравителя.'),
('rogue_thief_fast_hands','Бонусным действием вы можете совершить проверку Ловкости рук, использовать воровские инструменты для обезвреживания ловушки или вскрытия замка либо использовать предмет.'),
('rogue_thief_second_story_work','Лазание больше не требует дополнительного движения, а дальность прыжка с разбега увеличивается на число футов, равное модификатору Ловкости.');

DO $$
BEGIN
 IF EXISTS (SELECT 1 FROM _level3_short d LEFT JOIN subclass_feature_data f ON f."referenceKey"=d.feature_key WHERE f.id IS NULL) THEN
   RAISE EXCEPTION 'Level-3 shortDescription references missing subclass feature(s)';
 END IF;
END $$;

UPDATE subclass_feature_data f
SET "shortDescription"=d.short_text,
    version=coalesce(f.version,0)+1,
    "updatedAt"=now()
FROM _level3_short d
WHERE f."referenceKey"=d.feature_key
  AND (f."shortDescription" IS NULL OR btrim(f."shortDescription")='');

CREATE TEMP TABLE _level3_grants (
 feature_key text NOT NULL,
 option_key text NOT NULL,
 granted_level int NOT NULL,
 spell_key text NOT NULL,
 PRIMARY KEY (feature_key,option_key,granted_level,spell_key)
) ON COMMIT DROP;

INSERT INTO _level3_grants (feature_key,option_key,granted_level,spell_key) VALUES
('druid_land_circle_spells','arctic',5,'sleet_storm'),
('druid_land_circle_spells','arctic',5,'slow'),
('druid_land_circle_spells','coast',5,'water_breathing'),
('druid_land_circle_spells','coast',5,'water_walk'),
('druid_land_circle_spells','desert',5,'create_food_and_water'),
('druid_land_circle_spells','desert',5,'protection_from_energy'),
('druid_land_circle_spells','forest',5,'call_lightning'),
('druid_land_circle_spells','forest',5,'plant_growth'),
('druid_land_circle_spells','grassland',5,'daylight'),
('druid_land_circle_spells','grassland',5,'haste'),
('druid_land_circle_spells','mountain',5,'lightning_bolt'),
('druid_land_circle_spells','mountain',5,'meld_into_stone'),
('druid_land_circle_spells','swamp',5,'stinking_cloud'),
('druid_land_circle_spells','swamp',5,'water_walk'),
('druid_land_circle_spells','underdark',5,'gaseous_form'),
('druid_land_circle_spells','underdark',5,'stinking_cloud'),
('druid_land_circle_spells','arctic',7,'freedom_of_movement'),
('druid_land_circle_spells','arctic',7,'ice_storm'),
('druid_land_circle_spells','coast',7,'control_water'),
('druid_land_circle_spells','coast',7,'freedom_of_movement'),
('druid_land_circle_spells','desert',7,'blight'),
('druid_land_circle_spells','desert',7,'hallucinatory_terrain'),
('druid_land_circle_spells','forest',7,'divination'),
('druid_land_circle_spells','forest',7,'freedom_of_movement'),
('druid_land_circle_spells','grassland',7,'divination'),
('druid_land_circle_spells','grassland',7,'freedom_of_movement'),
('druid_land_circle_spells','mountain',7,'stone_shape'),
('druid_land_circle_spells','mountain',7,'stoneskin'),
('druid_land_circle_spells','swamp',7,'freedom_of_movement'),
('druid_land_circle_spells','swamp',7,'locate_creature'),
('druid_land_circle_spells','underdark',7,'greater_invisibility'),
('druid_land_circle_spells','underdark',7,'stone_shape'),
('druid_land_circle_spells','arctic',9,'commune_with_nature'),
('druid_land_circle_spells','arctic',9,'cone_of_cold'),
('druid_land_circle_spells','coast',9,'conjure_elemental'),
('druid_land_circle_spells','coast',9,'scrying'),
('druid_land_circle_spells','desert',9,'insect_plague'),
('druid_land_circle_spells','desert',9,'wall_of_stone'),
('druid_land_circle_spells','forest',9,'commune_with_nature'),
('druid_land_circle_spells','forest',9,'tree_stride'),
('druid_land_circle_spells','grassland',9,'dream'),
('druid_land_circle_spells','grassland',9,'insect_plague'),
('druid_land_circle_spells','mountain',9,'passwall'),
('druid_land_circle_spells','mountain',9,'wall_of_stone'),
('druid_land_circle_spells','swamp',9,'insect_plague'),
('druid_land_circle_spells','swamp',9,'scrying'),
('druid_land_circle_spells','underdark',9,'cloudkill'),
('druid_land_circle_spells','underdark',9,'insect_plague'),
('paladin_ancients_oath_spells','',5,'misty_step'),
('paladin_ancients_oath_spells','',5,'moonbeam'),
('paladin_ancients_oath_spells','',9,'plant_growth'),
('paladin_ancients_oath_spells','',9,'protection_from_energy'),
('paladin_ancients_oath_spells','',13,'ice_storm'),
('paladin_ancients_oath_spells','',13,'stoneskin'),
('paladin_ancients_oath_spells','',17,'commune_with_nature'),
('paladin_ancients_oath_spells','',17,'tree_stride'),
('paladin_devotion_oath_spells','',5,'lesser_restoration'),
('paladin_devotion_oath_spells','',5,'zone_of_truth'),
('paladin_devotion_oath_spells','',9,'beacon_of_hope'),
('paladin_devotion_oath_spells','',9,'dispel_magic'),
('paladin_devotion_oath_spells','',13,'freedom_of_movement'),
('paladin_devotion_oath_spells','',13,'guardian_of_faith'),
('paladin_devotion_oath_spells','',17,'commune'),
('paladin_devotion_oath_spells','',17,'flame_strike'),
('paladin_vengeance_oath_spells','',5,'hold_person'),
('paladin_vengeance_oath_spells','',5,'misty_step'),
('paladin_vengeance_oath_spells','',9,'haste'),
('paladin_vengeance_oath_spells','',9,'protection_from_energy'),
('paladin_vengeance_oath_spells','',13,'banishment'),
('paladin_vengeance_oath_spells','',13,'dimension_door'),
('paladin_vengeance_oath_spells','',17,'hold_monster'),
('paladin_vengeance_oath_spells','',17,'scrying');

DO $$
BEGIN
 IF EXISTS (
   SELECT 1
   FROM _level3_grants v
   LEFT JOIN subclass_feature_data f ON f."referenceKey"=v.feature_key
   LEFT JOIN spell_data s ON s."referenceKey"=v.spell_key
   LEFT JOIN choice_group_data cg ON cg."referenceKey"='druid_land_terrain' AND v.option_key<>''
   LEFT JOIN choice_option_data co ON co."choiceGroupId"=cg.id AND co."optionKey"=v.option_key
   WHERE f.id IS NULL OR s.id IS NULL OR (v.option_key<>'' AND co.id IS NULL)
 ) THEN
   RAISE EXCEPTION 'Level-3 spell grant reference missing';
 END IF;
END $$;

INSERT INTO class_spell_grant_data (
 "sourceSubclassFeatureId", "spellId", "grantedAtLevel",
 "alwaysPrepared", "choiceOptionId",source,version,"createdAt","updatedAt"
)
SELECT f.id,s.id,v.granted_level,true,co.id,f.source,1,now(),now()
FROM _level3_grants v
JOIN subclass_feature_data f ON f."referenceKey"=v.feature_key
JOIN spell_data s ON s."referenceKey"=v.spell_key
LEFT JOIN choice_group_data cg ON cg."referenceKey"='druid_land_terrain' AND v.option_key<>''
LEFT JOIN choice_option_data co ON co."choiceGroupId"=cg.id AND co."optionKey"=v.option_key
WHERE NOT EXISTS (
 SELECT 1 FROM class_spell_grant_data old
 WHERE old."sourceSubclassFeatureId"=f.id AND old."spellId"=s.id
   AND old."grantedAtLevel"=v.granted_level
   AND old."choiceOptionId" IS NOT DISTINCT FROM co.id
);

CREATE TEMP TABLE _level3_properties (
 owner_type text NOT NULL,
 feature_key text NOT NULL,
 property_key text NOT NULL,
 label text NOT NULL,
 value_kind text NOT NULL,
 static_value text,
 formula text,
 sort_order int NOT NULL
) ON COMMIT DROP;
INSERT INTO _level3_properties VALUES
('classFeature','ki','ki_save_dc','Сл приёмов ци','formula',NULL,'8 + proficiencyBonus + abilityModifier(wisdom)',0),
('subclassFeature','fighter_battle_master_combat_superiority','maneuver_save_dc','Сл приёмов','staticValue','8 + БМ + модификатор Силы или Ловкости (на выбор)',NULL,0);

DO $$
BEGIN
 IF EXISTS (
 SELECT 1 FROM _level3_properties p
 LEFT JOIN class_feature_data cf ON p.owner_type='classFeature' AND cf."referenceKey"=p.feature_key
 LEFT JOIN subclass_feature_data sf ON p.owner_type='subclassFeature' AND sf."referenceKey"=p.feature_key
 WHERE (p.owner_type='classFeature' AND cf.id IS NULL)
 OR (p.owner_type='subclassFeature' AND sf.id IS NULL)
 OR p.owner_type NOT IN ('classFeature','subclassFeature')
 ) THEN
 RAISE EXCEPTION 'Level-3 property reference missing';
 END IF;
END $$;

INSERT INTO feature_display_property_data (
 "sourceClassFeatureId","sourceSubclassFeatureId",key,label,"valueKind",
 "staticValue",formula,"sortOrder",source,version,"createdAt","updatedAt"
)
SELECT cf.id,sf.id,p.property_key,p.label,p.value_kind,
       p.static_value,p.formula,p.sort_order,coalesce(cf.source,sf.source),1,now(),now()
FROM _level3_properties p
LEFT JOIN class_feature_data cf ON p.owner_type='classFeature' AND cf."referenceKey"=p.feature_key
LEFT JOIN subclass_feature_data sf ON p.owner_type='subclassFeature' AND sf."referenceKey"=p.feature_key
WHERE NOT EXISTS (
 SELECT 1 FROM feature_display_property_data old
 WHERE old.key=p.property_key
 AND old."sourceClassFeatureId" IS NOT DISTINCT FROM cf.id
 AND old."sourceSubclassFeatureId" IS NOT DISTINCT FROM sf.id
);



--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261008054457035-subclass-level3-presentation', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008054457035-subclass-level3-presentation', "timestamp" = now();

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
