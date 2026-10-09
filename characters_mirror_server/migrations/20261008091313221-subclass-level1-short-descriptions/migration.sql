BEGIN;

-- PHB 2014: agreed concise descriptions for early subclass features.
-- Existing resource counters and canonical choices remain unchanged.
CREATE TEMP TABLE _early_subclass_descriptions (
 reference_key text PRIMARY KEY,
 short_description text NOT NULL
) ON COMMIT DROP;
INSERT INTO _early_subclass_descriptions (reference_key,short_description) VALUES
('cleric_light_warding_flare','Когда видимое вами существо в пределах 30 футов атакует вас, вы можете реакцией до определения попадания создать помеху его броску атаки. Умение не действует на существ с иммунитетом к ослеплению.'),
('cleric_trickery_blessing_of_the_trickster','Действием коснитесь другого согласного существа, чтобы дать ему преимущество на проверки Ловкости (Скрытность). Благословение действует 1 час или до повторного использования умения.'),
('cleric_war_war_priest','Когда вы совершаете действие «Атака», вы можете бонусным действием совершить ещё одну атаку оружием.'),
('sorcerer_draconic_bloodline_dragon_ancestor','Выберите вид драконьего предка, определяющий тип урона некоторых ваших способностей. Вы знаете Драконий язык. При проверках Харизмы во взаимодействии с драконами ваш бонус мастерства удваивается, если он применяется.'),
('sorcerer_wild_magic_tides_of_chaos','Вы можете получить преимущество на один бросок атаки, проверку характеристики или спасбросок. До восстановления умения Мастер может вызвать Волну дикой магии после сотворения вами заклинания чародея 1-го уровня или выше, восстановив использование Потока хаоса.'),
('sorcerer_wild_magic_wild_magic_surge','Раз за ход после сотворения заклинания чародея 1-го уровня или выше Мастер может потребовать бросок к20. При результате 1 определите случайный эффект по таблице «Волна дикой магии».'),
('warlock_archfey_fey_presence','Действием заставьте всех существ в 10-футовом кубе, исходящем от вас, совершить спасбросок Мудрости. При провале они становятся очарованными или испуганными вами (на ваш выбор) до конца вашего следующего хода.'),
('warlock_fiend_dark_ones_blessing','Когда вы опускаете хиты враждебного существа до 0, вы получаете временные хиты.');

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM _early_subclass_descriptions d
    LEFT JOIN subclass_feature_data f ON f."referenceKey"=d.reference_key
    WHERE f.id IS NULL OR f.level<>1
  ) THEN
    RAISE EXCEPTION 'Early subclass feature reference missing or wrong level';
  END IF;
  IF EXISTS (
    SELECT 1 FROM _early_subclass_descriptions d
    JOIN subclass_feature_data f ON f."referenceKey"=d.reference_key
    WHERE NULLIF(btrim(f."shortDescription"),'') IS NOT NULL
      AND f."shortDescription" IS DISTINCT FROM d.short_description
  ) THEN
    RAISE EXCEPTION 'Existing nonempty shortDescription conflicts with approved text';
  END IF;
END $$;

UPDATE subclass_feature_data f
SET "shortDescription"=d.short_description,
    version=COALESCE(f.version,0)+1,
    "updatedAt"=now()
FROM _early_subclass_descriptions d
WHERE f."referenceKey"=d.reference_key
  AND f."shortDescription" IS DISTINCT FROM d.short_description;

-- Unlike duration and range, save DC changes with character progression.
DO $$
BEGIN
 IF EXISTS (
 SELECT 1 FROM feature_display_property_data p
 JOIN subclass_feature_data f ON f.id=p."sourceSubclassFeatureId"
 WHERE f."referenceKey"='warlock_archfey_fey_presence'
 AND p.key='fey_presence_save_dc'
 AND (p."valueKind" IS DISTINCT FROM 'formula'
   OR p.formula IS DISTINCT FROM '8 + proficiencyBonus + abilityModifier(charisma)')
 ) THEN
   RAISE EXCEPTION 'Existing fey presence save DC property conflicts';
 END IF;
END $$;

INSERT INTO feature_display_property_data (
 "sourceSubclassFeatureId",key,label,"valueKind",formula,"sortOrder",
 source,version,"createdAt","updatedAt"
)
SELECT f.id,'fey_presence_save_dc','Сл спасброска',
 'formula','8 + proficiencyBonus + abilityModifier(charisma)',0,
 f.source,1,now(),now()
FROM subclass_feature_data f
WHERE f."referenceKey"='warlock_archfey_fey_presence'
AND NOT EXISTS (
 SELECT 1 FROM feature_display_property_data p
 WHERE p."sourceSubclassFeatureId"=f.id
 AND p.key='fey_presence_save_dc'
);


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261008091313221-subclass-level1-short-descriptions', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008091313221-subclass-level1-short-descriptions', "timestamp" = now();

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
