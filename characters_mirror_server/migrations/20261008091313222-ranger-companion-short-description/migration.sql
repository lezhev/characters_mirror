BEGIN;

-- PHB 2014: descriptive-only ranger companion; mechanics remain manual.
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM subclass_feature_data
    WHERE "referenceKey"='ranger_beast_master_rangers_companion'
      AND level=3
  ) THEN
    RAISE EXCEPTION 'Beast Master companion feature not found at level 3';
  END IF;
  IF EXISTS (
    SELECT 1 FROM subclass_feature_data
    WHERE "referenceKey"='ranger_beast_master_rangers_companion'
      AND NULLIF(btrim("shortDescription"),'') IS NOT NULL
      AND "shortDescription" IS DISTINCT FROM 'Вы получаете зверя-спутника размером не больше Среднего и с ПО не выше 1/4. К его КД, броскам атаки и урона, а также освоенным спасброскам и навыкам добавляется ваш бонус мастерства. Максимум его хитов — не меньше четырёхкратного уровня следопыта. Зверь действует с вашей инициативой; для приказа атаковать, совершить Рывок, Отход или Помощь требуется ваше действие. Без команды он Уклоняется.'
  ) THEN
    RAISE EXCEPTION 'Companion shortDescription was independently modified';
  END IF;
END $$;

UPDATE subclass_feature_data
SET "shortDescription"='Вы получаете зверя-спутника размером не больше Среднего и с ПО не выше 1/4. К его КД, броскам атаки и урона, а также освоенным спасброскам и навыкам добавляется ваш бонус мастерства. Максимум его хитов — не меньше четырёхкратного уровня следопыта. Зверь действует с вашей инициативой; для приказа атаковать, совершить Рывок, Отход или Помощь требуется ваше действие. Без команды он Уклоняется.',
    version=COALESCE(version,0)+1,
    "updatedAt"=now()
WHERE "referenceKey"='ranger_beast_master_rangers_companion'
  AND "shortDescription" IS DISTINCT FROM 'Вы получаете зверя-спутника размером не больше Среднего и с ПО не выше 1/4. К его КД, броскам атаки и урона, а также освоенным спасброскам и навыкам добавляется ваш бонус мастерства. Максимум его хитов — не меньше четырёхкратного уровня следопыта. Зверь действует с вашей инициативой; для приказа атаковать, совершить Рывок, Отход или Помощь требуется ваше действие. Без команды он Уклоняется.';

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261008091313222-ranger-companion-short-description', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008091313222-ranger-companion-short-description', "timestamp" = now();

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
