\set ON_ERROR_STOP on
SET client_encoding = 'UTF8';
BEGIN;

DO $$
DECLARE missing_count int;
DECLARE display_count int;
BEGIN
  SELECT count(*) INTO missing_count
  FROM class_feature_data
  WHERE id IN (3,4,17,18,27,33,34,41,48,49,68,70,81,95,121);
  IF missing_count <> 15 THEN
    RAISE EXCEPTION 'Expected 15 target class features, found %', missing_count;
  END IF;

  SELECT count(*) INTO display_count
  FROM feature_display_property_data
  WHERE "sourceClassFeatureId" IN (17,18,27,33,41,48,49,70);
  IF display_count <> 0 THEN
    RAISE EXCEPTION 'Expected no existing level-2 display properties for target features, found %', display_count;
  END IF;
END $$;

UPDATE class_feature_data SET
  "shortDescription" = CASE id
    WHEN 3 THEN 'При первой атаке в свой ход вы можете решить атаковать безрассудно. В этом случае до конца хода все ваши рукопашные атаки оружием с использованием Силы совершаются с преимуществом, но атаки по вам совершаются с преимуществом до начала вашего следующего хода.'
    WHEN 4 THEN 'Вы совершаете с преимуществом спасброски Ловкости от видимых эффектов, пока не ослеплены, не оглушены и не недееспособны.'
    WHEN 17 THEN 'К проверкам характеристик, которыми вы не владеете, добавляется половина бонуса мастерства, округлённая вниз.'
    WHEN 18 THEN 'Во время короткого отдыха ваше исполнение помогает восстановиться вам и союзникам. Если существо слышит вас и тратит одну или несколько Костей Хитов для восстановления хитов, оно дополнительно восстанавливает хиты в размере броска кости Песни отдыха.'
    WHEN 27 THEN 'Вы можете направлять божественную энергию через Изгнание Нежити или эффект своего домена. Все использования Божественного канала восстанавливаются после короткого или продолжительного отдыха.'
    WHEN 33 THEN 'Действием вы можете превратиться в знакомого вам Зверя. На 2-м уровне его ПО не может превышать 1/4 и у него не должно быть скорости плавания или полёта; с 4-го уровня доступно ПО до 1/2 без скорости полёта, а с 8-го — ПО до 1. В облике можно оставаться число часов, равное половине уровня друида, округлённой вниз, и досрочно вернуться в обычный облик бонусным действием.'
    WHEN 34 THEN 'Выберите круг друидов, определяющий вашу специализацию. Он даёт дополнительные умения на 2-м, 6-м, 10-м и 14-м уровнях.'
    WHEN 41 THEN 'В свой ход вы можете совершить одно дополнительное действие помимо обычного и бонусного. Использования восстанавливаются после короткого или продолжительного отдыха.'
    WHEN 48 THEN 'Ваши тренировки позволяют управлять мистической энергией ци. Вы получаете запас очков ци для особых приёмов монаха. Потраченные очки восстанавливаются после короткого или продолжительного отдыха, если вы медитировали не менее 30 минут.'
    WHEN 49 THEN 'Пока вы не носите доспех и не используете щит, ваша скорость увеличивается. С 9-го уровня вы можете во время своего хода перемещаться по вертикальным поверхностям и по воде, не падая во время движения.'
    WHEN 68 THEN 'Выберите один боевой стиль, отражающий вашу боевую специализацию. Один и тот же стиль нельзя выбрать повторно.'
    WHEN 70 THEN 'Попав рукопашной атакой оружием, вы можете потратить ячейку заклинания, чтобы нанести дополнительный урон излучением. Урон растёт с уровнем ячейки и увеличивается против Нежити и Исчадий.'
    WHEN 81 THEN 'Выберите один боевой стиль, отражающий вашу боевую специализацию. Один и тот же стиль нельзя выбрать повторно.'
    WHEN 95 THEN 'В каждом своём ходу вы можете бонусным действием совершить Рывок, Отход или Засаду.'
    WHEN 121 THEN 'Выберите магическую традицию, определяющую вашу магическую специализацию. Она даёт дополнительные умения на 2-м, 6-м, 10-м и 14-м уровнях.'
  END,
  version = COALESCE(version, 0) + 1,
  "updatedAt" = CURRENT_TIMESTAMP
WHERE id IN (3,4,17,18,27,33,34,41,48,49,68,70,81,95,121);

INSERT INTO feature_display_property_data
("sourceClassFeatureId","sourceSubclassFeatureId",key,label,"valueKind","staticValue",progression,formula,"sortOrder",source,version,"createdAt","updatedAt")
VALUES
(17,NULL,'jack_of_all_trades_bonus','Бонус к проверке','staticValue','½ бонуса мастерства',NULL,NULL,0,'PHB 2014',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
(18,NULL,'song_of_rest_die','Кость Песни отдыха','progression',NULL,'[{"k":2,"v":"к6"},{"k":9,"v":"к8"},{"k":13,"v":"к10"},{"k":17,"v":"к12"}]'::json,NULL,0,'PHB 2014',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
(27,NULL,'channel_divinity_uses','Использований','progression',NULL,'[{"k":2,"v":"1"},{"k":6,"v":"2"},{"k":18,"v":"3"}]'::json,NULL,0,'PHB 2014',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
(33,NULL,'wild_shape_uses','Использований','staticValue','2',NULL,NULL,0,'PHB 2014',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
(33,NULL,'wild_shape_max_cr','Макс. ПО','progression',NULL,'[{"k":2,"v":"1/4"},{"k":4,"v":"1/2"},{"k":8,"v":"1"}]'::json,NULL,1,'PHB 2014',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
(33,NULL,'wild_shape_duration_hours','Длительность, ч','formula',NULL,NULL,'floor(classLevel / 2)',2,'PHB 2014',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
(41,NULL,'action_surge_uses','Использований','progression',NULL,'[{"k":2,"v":"1"},{"k":17,"v":"2"}]'::json,NULL,0,'PHB 2014',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
(48,NULL,'ki_points','Очки ци','formula',NULL,NULL,'classLevel',0,'PHB 2014',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
(49,NULL,'unarmored_movement_bonus','Бонус скорости','progression',NULL,'[{"k":2,"v":"+10 фт."},{"k":6,"v":"+15 фт."},{"k":10,"v":"+20 фт."},{"k":14,"v":"+25 фт."},{"k":18,"v":"+30 фт."}]'::json,NULL,0,'PHB 2014',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
(70,NULL,'divine_smite_damage','Урон','staticValue','2к8 + 1к8 за каждый уровень ячейки выше 1',NULL,NULL,0,'PHB 2014',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
(70,NULL,'divine_smite_maximum','Максимум','staticValue','5к8 (6к8 против Нежити и Исчадий)',NULL,NULL,1,'PHB 2014',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);

DO $$
DECLARE short_count int;
DECLARE display_count int;
BEGIN
  SELECT count(*) INTO short_count
  FROM class_feature_data
  WHERE id IN (3,4,17,18,27,33,34,41,48,49,68,70,81,95,121)
    AND NULLIF(BTRIM("shortDescription"),'') IS NOT NULL;
  IF short_count <> 15 THEN
    RAISE EXCEPTION 'Expected 15 short descriptions after update, found %', short_count;
  END IF;

  SELECT count(*) INTO display_count
  FROM feature_display_property_data
  WHERE "sourceClassFeatureId" IN (17,18,27,33,41,48,49,70);
  IF display_count <> 11 THEN
    RAISE EXCEPTION 'Expected 11 display properties after insert, found %', display_count;
  END IF;
END $$;

COMMIT;
