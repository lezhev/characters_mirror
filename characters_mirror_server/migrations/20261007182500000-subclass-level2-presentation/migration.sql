BEGIN;

-- All level-2 subclass features remain readable even when their mechanics are
-- intentionally runtime-only. Improved Minor Illusion is explicitly deferred.
WITH texts("referenceKey","shortDescription") AS (
  VALUES
    ('cleric_knowledge_knowledge_of_the_ages',
     'Потратьте Божественный канал и на 10 минут получите владение одним выбранным навыком или инструментом.'),
    ('cleric_life_preserve_life',
     'Потратьте Божественный канал и распределите 5 × уровень жреца хитов лечения между существами в пределах 30 футов. Нельзя поднять хиты цели выше половины максимума; не действует на нежить и конструктов.'),
    ('cleric_light_radiance_of_the_dawn',
     'Потратьте Божественный канал: рассеется магическая тьма в пределах 30 футов, а враждебные существа совершают спасбросок Телосложения. При провале они получают 2к10 + уровень жреца урона излучением, при успехе — половину.'),
    ('cleric_nature_charm_animals_and_plants',
     'Потратьте Божественный канал: звери и растения в пределах 30 футов совершают спасбросок Мудрости, а при провале очарованы вами на 1 минуту или пока не получат урон.'),
    ('cleric_tempest_destructive_wrath',
     'Когда вы наносите урон электричеством или звуком, можете потратить Божественный канал, чтобы вместо броска нанести максимальный возможный урон.'),
    ('cleric_trickery_invoke_duplicity',
     'Потратьте Божественный канал и действием создайте иллюзорную копию себя на 1 минуту с концентрацией. Бонусным действием перемещайте её; можете накладывать заклинания как из её пространства, а рядом с целью копия даёт преимущество вашим атакам.'),
    ('cleric_war_guided_strike',
     'Совершив бросок атаки, потратьте Божественный канал, чтобы получить +10 к результату. Решение принимается после броска, но до определения попадания.'),
    ('druid_land_bonus_cantrip',
     'Вы изучаете один дополнительный заговор друида. Он не учитывается в количестве известных вам заговоров.'),
    ('druid_land_natural_recovery',
     'Один раз между продолжительными отдыхами во время короткого отдыха восстановите потраченные ячейки суммарным уровнем не больше половины уровня друида, округлённой вверх. Ячейки 6-го уровня и выше восстановить нельзя.'),
    ('druid_moon_combat_wild_shape',
     'Вы можете принимать Дикий облик бонусным действием. Находясь в облике, бонусным действием потратьте ячейку заклинания и восстановите 1к8 хитов за каждый уровень ячейки.'),
    ('druid_moon_circle_forms',
     'С 2 уровня вы можете принимать облик зверя с ПО до 1. С 6 уровня максимальный ПО равен уровню друида, делённому на 3 с округлением вниз.'),
    ('wizard_abjuration_abjuration_savant',
     'Золото и время, которые вы тратите на копирование заклинаний школы Ограждения в книгу заклинаний, уменьшаются вдвое.'),
    ('wizard_abjuration_arcane_ward',
     'Наложив заклинание Ограждения 1-го уровня или выше, создайте защиту с запасом хитов 2 × уровень волшебника + модификатор Интеллекта. Пока защита существует, такие заклинания восстанавливают ей хиты в размере 2 × уровень заклинания.'),
    ('wizard_conjuration_conjuration_savant',
     'Золото и время, которые вы тратите на копирование заклинаний школы Созидания в книгу заклинаний, уменьшаются вдвое.'),
    ('wizard_conjuration_minor_conjuration',
     'Действием создайте увиденный ранее немагический предмет размером до 3 футов и весом до 10 фунтов. Он исчезает через 1 час, при повторном использовании умения или если нанесёт либо получит урон.'),
    ('wizard_divination_divination_savant',
     'Золото и время, которые вы тратите на копирование заклинаний школы Прорицания в книгу заклинаний, уменьшаются вдвое.'),
    ('wizard_divination_portent',
     'После продолжительного отдыха бросьте два к20 и сохраните результаты. До следующего отдыха можете заменить бросок атаки, спасбросок или проверку характеристики видимого существа одним из них, выбрав замену до броска.'),
    ('wizard_enchantment_enchantment_savant',
     'Золото и время, которые вы тратите на копирование заклинаний школы Очарования в книгу заклинаний, уменьшаются вдвое.'),
    ('wizard_enchantment_hypnotic_gaze',
     'Действием выберите видимое существо в пределах 5 футов. Оно совершает спасбросок Мудрости против Сл ваших заклинаний; при провале становится очарованным, недееспособным и получает скорость 0, пока вы поддерживаете эффект.'),
    ('wizard_evocation_evocation_savant',
     'Золото и время, которые вы тратите на копирование заклинаний школы Воплощения в книгу заклинаний, уменьшаются вдвое.'),
    ('wizard_evocation_sculpt_spells',
     'Накладывая заклинание Воплощения, затрагивающее других существ, выберите до 1 + уровень заклинания видимых существ. Они автоматически преуспевают в спасбросках от него и не получают урон, если при успехе должны получить половину.'),
    ('wizard_illusion_illusion_savant',
     'Золото и время, которые вы тратите на копирование заклинаний школы Иллюзии в книгу заклинаний, уменьшаются вдвое.'),
    ('wizard_necromancy_necromancy_savant',
     'Золото и время, которые вы тратите на копирование заклинаний школы Некромантии в книгу заклинаний, уменьшаются вдвое.'),
    ('wizard_necromancy_grim_harvest',
     'Раз в ход, убив одно или несколько существ заклинанием 1-го уровня или выше, восстановите хиты в размере 2 × уровень заклинания, или 3 × уровень для Некромантии. Не действует при убийстве нежити и конструктов.'),
    ('wizard_transmutation_transmutation_savant',
     'Золото и время, которые вы тратите на копирование заклинаний школы Преобразования в книгу заклинаний, уменьшаются вдвое.'),
    ('wizard_transmutation_minor_alchemy',
     'За каждые 10 минут временно преобразуйте до 1 кубического фута немагического дерева, камня, железа, меди или серебра в другой материал из этого списка. Эффект длится 1 час или до потери концентрации.')
)
UPDATE subclass_feature_data f
SET "shortDescription" = t."shortDescription",
    version = coalesce(f.version, 0) + 1,
    "updatedAt" = now()
FROM texts t
WHERE f."referenceKey" = t."referenceKey"
  AND f."shortDescription" IS DISTINCT FROM t."shortDescription";

CREATE TEMP TABLE _level2_display_values (
  feature_key text NOT NULL,
  property_key text NOT NULL,
  label text NOT NULL,
  value_kind text NOT NULL,
  static_value text,
  formula text,
  sort_order integer NOT NULL
) ON COMMIT DROP;

INSERT INTO _level2_display_values VALUES
  ('cleric_knowledge_knowledge_of_the_ages',
   'check_bonus',
   'Бонус к проверке навыка или инструмента',
   'staticValue',
   'Бонус мастерства',
   NULL,
   0),
  ('cleric_life_preserve_life',
   'healing_pool',
   'Запас лечения',
   'formula',
   NULL,
   '5 * classLevel',
   0),
  ('cleric_light_radiance_of_the_dawn',
   'damage',
   'Урон',
   'formula',
   NULL,
   '2d10 + classLevel',
   0),
  ('cleric_war_guided_strike',
   'attack_roll_bonus',
   'Бонус к броску атаки',
   'staticValue',
   '+10',
   NULL,
   0),
  ('druid_land_natural_recovery',
   'recoverable_slot_levels',
   'Суммарный уровень ячеек',
   'formula',
   NULL,
   'ceil(classLevel / 2)',
   0),
  ('druid_moon_circle_forms',
   'max_beast_cr',
   'Макс. ПО',
   'formula',
   NULL,
   'max(1, floor(classLevel / 3))',
   0),
  ('wizard_abjuration_arcane_ward',
   'ward_hit_points',
   'Хиты защиты',
   'formula',
   NULL,
   '2 * classLevel + abilityModifier(intelligence)',
   0);

UPDATE feature_display_property_data p
SET label = v.label,
    "valueKind" = v.value_kind,
    "staticValue" = v.static_value,
    progression = NULL,
    formula = v.formula,
    "sortOrder" = v.sort_order,
    source = f.source,
    version = coalesce(p.version, 0) + 1,
    "updatedAt" = now()
FROM _level2_display_values v
JOIN subclass_feature_data f ON f."referenceKey" = v.feature_key
WHERE p."sourceSubclassFeatureId" = f.id
  AND p.key = v.property_key;

INSERT INTO feature_display_property_data (
  "sourceSubclassFeatureId",
  key,
  label,
  "valueKind",
  "staticValue",
  formula,
  "sortOrder",
  source,
  version,
  "createdAt",
  "updatedAt"
)
SELECT
  f.id,
  v.property_key,
  v.label,
  v.value_kind,
  v.static_value,
  v.formula,
  v.sort_order,
  f.source,
  1,
  now(),
  now()
FROM _level2_display_values v
JOIN subclass_feature_data f ON f."referenceKey" = v.feature_key
WHERE NOT EXISTS (
  SELECT 1
  FROM feature_display_property_data p
  WHERE p."sourceSubclassFeatureId" = f.id
    AND p.key = v.property_key
);

-- Preserve recovery intent for a future slot-recovery dialog. The current
-- runtime does not execute restore/spend effects yet.
UPDATE feature_resource_effect_data e
SET "activationTrigger" = 'shortRest'
FROM class_feature_data f
WHERE e."classFeatureId" = f.id
  AND f."referenceKey" = 'wizard_arcane_recovery'
  AND e.type = 'restore'
  AND e."targetType" = 'spellSlots'
  AND e."activationTrigger" IS NULL;

INSERT INTO feature_resource_effect_data (
  "classFeatureId",
  type,
  "targetType",
  "targetResourceKey",
  "amountRule",
  "amountValue"
)
SELECT
  f.id,
  'spend',
  'featureResource',
  'arcaneRecovery',
  'fixed',
  1
FROM class_feature_data f
WHERE f."referenceKey" = 'wizard_arcane_recovery'
  AND NOT EXISTS (
    SELECT 1
    FROM feature_resource_effect_data e
    WHERE e."classFeatureId" = f.id
      AND e.type = 'spend'
      AND e."targetType" = 'featureResource'
      AND e."targetResourceKey" = 'arcaneRecovery'
  );

INSERT INTO feature_resource_effect_data (
  "subclassFeatureId",
  type,
  "targetType",
  "targetResourceKey",
  "amountRule",
  "amountValue"
)
SELECT
  f.id,
  'spend',
  'featureResource',
  'naturalRecovery',
  'fixed',
  1
FROM subclass_feature_data f
WHERE f."referenceKey" = 'druid_land_natural_recovery'
  AND NOT EXISTS (
    SELECT 1
    FROM feature_resource_effect_data e
    WHERE e."subclassFeatureId" = f.id
      AND e.type = 'spend'
      AND e."targetType" = 'featureResource'
      AND e."targetResourceKey" = 'naturalRecovery'
  );

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
VALUES (
  'characters_mirror',
  '20261007182500000-subclass-level2-presentation',
  now()
)
ON CONFLICT ("module") DO UPDATE SET
  "version" = '20261007182500000-subclass-level2-presentation',
  "timestamp" = now();

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
VALUES ('serverpod', '20240516151843329', now())
ON CONFLICT ("module") DO UPDATE SET
  "version" = '20240516151843329',
  "timestamp" = now();

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
VALUES ('serverpod_auth', '20240520102713718', now())
ON CONFLICT ("module") DO UPDATE SET
  "version" = '20240520102713718',
  "timestamp" = now();

COMMIT;
