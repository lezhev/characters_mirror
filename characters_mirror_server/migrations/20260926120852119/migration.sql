BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "background_data" ADD COLUMN "toolProficiencyKeys" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_data" ADD COLUMN "toolTrainingKeys" json;
ALTER TABLE "class_data" ADD COLUMN "multiclassToolTrainingKeys" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_data" ADD COLUMN "toolProficiencyKeys" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subrace_data" ADD COLUMN "toolProficiencyKeys" json;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "tool_data" (
    "id" bigserial PRIMARY KEY,
    "referenceKey" text NOT NULL,
    "name" text NOT NULL,
    "category" bigint
);

-- Indexes
CREATE UNIQUE INDEX "tool_data_reference_key_idx" ON "tool_data" USING btree ("referenceKey");

-- Map only reviewed legacy values. The test database contains older enum-like
-- aliases; category choices remain markers on background_data for Stage 4.
CREATE FUNCTION pg_temp.fixed_tool_key(value text) RETURNS text
    LANGUAGE sql IMMUTABLE AS $$
      SELECT CASE value
        WHEN 'Tool.disguiseKit' THEN 'disguise_kit'
        WHEN 'Набор для маскировки' THEN 'disguise_kit'
        WHEN 'Tool.thievesTools' THEN 'thieves_tools'
        WHEN 'Воровские инструменты' THEN 'thieves_tools'
        WHEN 'Tool.forgeryKit' THEN 'forgery_kit'
        WHEN 'Набор для подделки' THEN 'forgery_kit'
        WHEN 'Tool.herbalismKit' THEN 'herbalism_kit'
        WHEN 'Набор травника' THEN 'herbalism_kit'
        WHEN 'Tool.navigatorsTools' THEN 'navigator_tools'
        WHEN 'Навигационные инструменты' THEN 'navigator_tools'
        WHEN 'Tool.vehiclesWater' THEN 'vehicle_water'
        WHEN 'Водный транспорт' THEN 'vehicle_water'
        WHEN 'Tool.vehiclesLand' THEN 'vehicle_land'
        WHEN 'Tool.land_vehicles' THEN 'vehicle_land'
        WHEN 'Наземные транспортные средства' THEN 'vehicle_land'
        ELSE NULL
      END
    $$;

CREATE FUNCTION pg_temp.background_tool_choice_marker(value text) RETURNS text
    LANGUAGE sql IMMUTABLE AS $$
      SELECT CASE value
        WHEN 'Музыкальный инструмент' THEN 'Музыкальный инструмент'
        WHEN 'Tool.musicalInstrument' THEN 'Музыкальный инструмент'
        WHEN 'Игровой набор' THEN 'Игровой набор'
        WHEN 'Tool.gamingSet' THEN 'Игровой набор'
        WHEN 'Инструменты ремесленника' THEN 'Инструменты ремесленника'
        WHEN 'Tool.artisansTools' THEN 'Инструменты ремесленника'
        ELSE NULL
      END
    $$;

DO $$
DECLARE
  unexpected record;
BEGIN
  SELECT source, value INTO unexpected
  FROM (
    SELECT 'race_data.toolProficiencies' AS source, value
    FROM race_data r
    CROSS JOIN LATERAL jsonb_array_elements_text(
      CASE WHEN jsonb_typeof(r."toolProficiencies"::jsonb) = 'array'
        THEN r."toolProficiencies"::jsonb ELSE '[]'::jsonb END
    ) AS grants(value)
    UNION ALL
    SELECT 'subrace_data.toolProficiencies', value
    FROM subrace_data r
    CROSS JOIN LATERAL jsonb_array_elements_text(
      CASE WHEN jsonb_typeof(r."toolProficiencies"::jsonb) = 'array'
        THEN r."toolProficiencies"::jsonb ELSE '[]'::jsonb END
    ) AS grants(value)
    UNION ALL
    SELECT 'background_data.toolProficiencies', value
    FROM background_data b
    CROSS JOIN LATERAL jsonb_array_elements_text(
      CASE WHEN jsonb_typeof(b."toolProficiencies"::jsonb) = 'array'
        THEN b."toolProficiencies"::jsonb ELSE '[]'::jsonb END
    ) AS grants(value)
    UNION ALL
    SELECT 'class_data.toolTraining', value
    FROM class_data c
    CROSS JOIN LATERAL jsonb_array_elements_text(
      CASE WHEN jsonb_typeof(c."toolTraining"::jsonb) = 'array'
        THEN c."toolTraining"::jsonb ELSE '[]'::jsonb END
    ) AS grants(value)
    UNION ALL
    SELECT 'class_data.multiclassToolTraining', value
    FROM class_data c
    CROSS JOIN LATERAL jsonb_array_elements_text(
      CASE WHEN jsonb_typeof(c."multiclassToolTraining"::jsonb) = 'array'
        THEN c."multiclassToolTraining"::jsonb ELSE '[]'::jsonb END
    ) AS grants(value)
  ) AS legacy_grants
  WHERE pg_temp.fixed_tool_key(value) IS NULL
    AND NOT (
      source = 'background_data.toolProficiencies'
      AND pg_temp.background_tool_choice_marker(value) IS NOT NULL
    )
  LIMIT 1;

  IF FOUND THEN
    RAISE EXCEPTION 'Unmapped legacy tool grant in %: %',
      unexpected.source, unexpected.value;
  END IF;
END $$;

UPDATE race_data r
SET "toolProficiencyKeys" = CASE
  WHEN r."toolProficiencies" IS NULL THEN NULL
  ELSE COALESCE((
    SELECT json_agg(pg_temp.fixed_tool_key(value) ORDER BY ordinal)::json
    FROM jsonb_array_elements_text(r."toolProficiencies"::jsonb)
      WITH ORDINALITY AS grants(value, ordinal)
    WHERE pg_temp.fixed_tool_key(value) IS NOT NULL
  ), '[]'::json)
END;

UPDATE subrace_data r
SET "toolProficiencyKeys" = CASE
  WHEN r."toolProficiencies" IS NULL THEN NULL
  ELSE COALESCE((
    SELECT json_agg(pg_temp.fixed_tool_key(value) ORDER BY ordinal)::json
    FROM jsonb_array_elements_text(r."toolProficiencies"::jsonb)
      WITH ORDINALITY AS grants(value, ordinal)
    WHERE pg_temp.fixed_tool_key(value) IS NOT NULL
  ), '[]'::json)
END;

UPDATE background_data b
SET "toolProficiencyKeys" = CASE
  WHEN b."toolProficiencies" IS NULL THEN NULL
  ELSE COALESCE((
    SELECT json_agg(pg_temp.fixed_tool_key(value) ORDER BY ordinal)::json
    FROM jsonb_array_elements_text(b."toolProficiencies"::jsonb)
      WITH ORDINALITY AS grants(value, ordinal)
    WHERE pg_temp.fixed_tool_key(value) IS NOT NULL
  ), '[]'::json)
END,
    "toolProficiencies" = CASE
      WHEN b."toolProficiencies" IS NULL THEN NULL
      ELSE COALESCE((
        SELECT json_agg(
          pg_temp.background_tool_choice_marker(value) ORDER BY ordinal
        )::json
        FROM jsonb_array_elements_text(b."toolProficiencies"::jsonb)
          WITH ORDINALITY AS grants(value, ordinal)
        WHERE pg_temp.background_tool_choice_marker(value) IS NOT NULL
      ), '[]'::json)
    END;

UPDATE class_data c
SET "toolTrainingKeys" = CASE
  WHEN c."toolTraining" IS NULL THEN NULL
  ELSE COALESCE((
    SELECT json_agg(pg_temp.fixed_tool_key(value) ORDER BY ordinal)::json
    FROM jsonb_array_elements_text(c."toolTraining"::jsonb)
      WITH ORDINALITY AS grants(value, ordinal)
    WHERE pg_temp.fixed_tool_key(value) IS NOT NULL
  ), '[]'::json)
END,
    "multiclassToolTrainingKeys" = CASE
      WHEN c."multiclassToolTraining" IS NULL THEN NULL
      ELSE COALESCE((
        SELECT json_agg(pg_temp.fixed_tool_key(value) ORDER BY ordinal)::json
        FROM jsonb_array_elements_text(c."multiclassToolTraining"::jsonb)
          WITH ORDINALITY AS grants(value, ordinal)
        WHERE pg_temp.fixed_tool_key(value) IS NOT NULL
      ), '[]'::json)
    END;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260926120852119', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260926120852119', "timestamp" = now();

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
