BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "race_choice_option_data" (
    "id" bigserial PRIMARY KEY,
    "choiceSetId" bigint NOT NULL,
    "optionKey" text,
    "name" text,
    "description" text,
    "sortOrder" bigint,
    "ability" text,
    "skill" text,
    "language" text,
    "spellId" bigint,
    "toolKey" text,
    "bonusValue" bigint,
    "damageType" text,
    "areaOfEffectType" text,
    "areaText" text,
    "saveAbility" text,
    "damageByLevel" json,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- Preserve legacy race/subrace/race-feature data before replacing column types.
--
ALTER TABLE "race_data" RENAME COLUMN "size" TO "_legacy_size";
ALTER TABLE "race_data" RENAME COLUMN "visionType" TO "_legacy_visionType";
ALTER TABLE "race_data" RENAME COLUMN "resistances" TO "_legacy_resistances";

ALTER TABLE "subrace_data" RENAME COLUMN "resistances" TO "_legacy_resistances";
ALTER TABLE "race_feature_data" RENAME COLUMN "usesPerRest" TO "_legacy_usesPerRest";

ALTER TABLE "race_data"
    ADD COLUMN "strengthBonus" bigint,
    ADD COLUMN "dexterityBonus" bigint,
    ADD COLUMN "constitutionBonus" bigint,
    ADD COLUMN "intelligenceBonus" bigint,
    ADD COLUMN "wisdomBonus" bigint,
    ADD COLUMN "charismaBonus" bigint,
    ADD COLUMN "size" bigint,
    ADD COLUMN "visionType" text,
    ADD COLUMN "resistances" json;

ALTER TABLE "subrace_data"
    ADD COLUMN "strengthBonus" bigint,
    ADD COLUMN "dexterityBonus" bigint,
    ADD COLUMN "constitutionBonus" bigint,
    ADD COLUMN "intelligenceBonus" bigint,
    ADD COLUMN "wisdomBonus" bigint,
    ADD COLUMN "charismaBonus" bigint,
    ADD COLUMN "resistances" json;

ALTER TABLE "race_feature_data"
    ADD COLUMN "usesPerRest" text;

UPDATE "race_data"
SET
    "strengthBonus" = COALESCE(("abilityBonuses" ->> 'strength')::bigint, ("abilityBonuses" ->> 'str')::bigint),
    "dexterityBonus" = COALESCE(("abilityBonuses" ->> 'dexterity')::bigint, ("abilityBonuses" ->> 'dex')::bigint),
    "constitutionBonus" = COALESCE(("abilityBonuses" ->> 'constitution')::bigint, ("abilityBonuses" ->> 'con')::bigint),
    "intelligenceBonus" = COALESCE(("abilityBonuses" ->> 'intelligence')::bigint, ("abilityBonuses" ->> 'int')::bigint),
    "wisdomBonus" = COALESCE(("abilityBonuses" ->> 'wisdom')::bigint, ("abilityBonuses" ->> 'wis')::bigint),
    "charismaBonus" = COALESCE(("abilityBonuses" ->> 'charisma')::bigint, ("abilityBonuses" ->> 'cha')::bigint),
    "size" = CASE lower(trim(COALESCE("_legacy_size", '')))
        WHEN 'tiny' THEN 0
        WHEN 'small' THEN 1
        WHEN 'medium' THEN 2
        WHEN 'large' THEN 3
        WHEN 'huge' THEN 4
        WHEN 'gargantuan' THEN 5
        ELSE NULL
    END,
    "visionType" = CASE lower(regexp_replace(COALESCE("_legacy_visionType", ''), '[^a-zA-Z]+', '', 'g'))
        WHEN 'darkvision' THEN 'darkvision'
        WHEN 'blindsight' THEN 'blindsight'
        WHEN 'tremorsense' THEN 'tremorsense'
        WHEN 'truesight' THEN 'truesight'
        ELSE NULL
    END,
    "resistances" = (
        SELECT json_agg(mapped.damage_type)
        FROM (
            SELECT CASE lower(trim(value))
                WHEN 'acid' THEN 'acid'
                WHEN 'bludgeoning' THEN 'bludgeoning'
                WHEN 'cold' THEN 'cold'
                WHEN 'fire' THEN 'fire'
                WHEN 'force' THEN 'force'
                WHEN 'lightning' THEN 'lightning'
                WHEN 'necrotic' THEN 'necrotic'
                WHEN 'piercing' THEN 'piercing'
                WHEN 'poison' THEN 'poison'
                WHEN 'psychic' THEN 'psychic'
                WHEN 'radiant' THEN 'radiant'
                WHEN 'slashing' THEN 'slashing'
                WHEN 'thunder' THEN 'thunder'
                ELSE NULL
            END AS damage_type
            FROM jsonb_array_elements_text(
                COALESCE("_legacy_resistances", '[]'::json)::jsonb
            ) AS values(value)
        ) AS mapped
        WHERE mapped.damage_type IS NOT NULL
    );

UPDATE "subrace_data"
SET
    "strengthBonus" = COALESCE(("abilityBonuses" ->> 'strength')::bigint, ("abilityBonuses" ->> 'str')::bigint),
    "dexterityBonus" = COALESCE(("abilityBonuses" ->> 'dexterity')::bigint, ("abilityBonuses" ->> 'dex')::bigint),
    "constitutionBonus" = COALESCE(("abilityBonuses" ->> 'constitution')::bigint, ("abilityBonuses" ->> 'con')::bigint),
    "intelligenceBonus" = COALESCE(("abilityBonuses" ->> 'intelligence')::bigint, ("abilityBonuses" ->> 'int')::bigint),
    "wisdomBonus" = COALESCE(("abilityBonuses" ->> 'wisdom')::bigint, ("abilityBonuses" ->> 'wis')::bigint),
    "charismaBonus" = COALESCE(("abilityBonuses" ->> 'charisma')::bigint, ("abilityBonuses" ->> 'cha')::bigint),
    "resistances" = (
        SELECT json_agg(mapped.damage_type)
        FROM (
            SELECT CASE lower(trim(value))
                WHEN 'acid' THEN 'acid'
                WHEN 'bludgeoning' THEN 'bludgeoning'
                WHEN 'cold' THEN 'cold'
                WHEN 'fire' THEN 'fire'
                WHEN 'force' THEN 'force'
                WHEN 'lightning' THEN 'lightning'
                WHEN 'necrotic' THEN 'necrotic'
                WHEN 'piercing' THEN 'piercing'
                WHEN 'poison' THEN 'poison'
                WHEN 'psychic' THEN 'psychic'
                WHEN 'radiant' THEN 'radiant'
                WHEN 'slashing' THEN 'slashing'
                WHEN 'thunder' THEN 'thunder'
                ELSE NULL
            END AS damage_type
            FROM jsonb_array_elements_text(
                COALESCE("_legacy_resistances", '[]'::json)::jsonb
            ) AS values(value)
        ) AS mapped
        WHERE mapped.damage_type IS NOT NULL
    );

UPDATE "race_feature_data"
SET "usesPerRest" = CASE lower(regexp_replace(COALESCE("_legacy_usesPerRest", ''), '[^a-zA-Z]+', '', 'g'))
    WHEN 'shortrest' THEN 'shortRest'
    WHEN 'short' THEN 'shortRest'
    WHEN 'longrest' THEN 'longRest'
    WHEN 'long' THEN 'longRest'
    WHEN 'dawn' THEN 'dawn'
    WHEN 'special' THEN 'special'
    ELSE NULL
END;

--
-- Race choice set / spell grant tables are explicitly treated as rebuildable.
--
DELETE FROM "race_feature_spell_grant_data";
DELETE FROM "race_choice_set_data";

--
-- Normalize race_choice_set_data to feature-owned sets only.
--
ALTER TABLE "race_choice_set_data" DROP CONSTRAINT "race_choice_set_data_fk_1";
ALTER TABLE "race_choice_set_data" DROP CONSTRAINT "race_choice_set_data_fk_2";
ALTER TABLE "race_choice_set_data" DROP CONSTRAINT "race_choice_set_data_fk_3";
ALTER TABLE "race_choice_set_data" DROP CONSTRAINT "race_choice_set_data_fk_4";
ALTER TABLE "race_choice_set_data" DROP CONSTRAINT "race_choice_set_data_fk_5";
ALTER TABLE "race_choice_set_data" DROP CONSTRAINT "race_choice_set_data_fk_0";
ALTER TABLE "race_choice_set_data" DROP COLUMN "raceId";
ALTER TABLE "race_choice_set_data" DROP COLUMN "subraceId";
ALTER TABLE "race_choice_set_data" DROP COLUMN "options";
ALTER TABLE "race_choice_set_data" DROP COLUMN "optionValue";
ALTER TABLE "race_choice_set_data" DROP COLUMN "_raceDataChoicesetsRaceDataId";
ALTER TABLE "race_choice_set_data" DROP COLUMN "_raceFeatureDataChoicesetsRaceFeatureDataId";
ALTER TABLE "race_choice_set_data" DROP COLUMN "_subraceDataChoicesetsSubraceDataId";
ALTER TABLE "race_choice_set_data" ALTER COLUMN "featureId" SET NOT NULL;

ALTER TABLE "race_feature_spell_grant_data" DROP CONSTRAINT "race_feature_spell_grant_data_fk_2";
ALTER TABLE "race_feature_spell_grant_data" DROP COLUMN "_raceFeatureDataSpellgrantsRaceFeatureDataId";

--
-- Migrate Dragonborn ancestry into the new feature -> choice set -> choice option model.
--
DO $$
DECLARE
    ancestry_count bigint;
    dragonborn_race_id bigint;
    duplicate_dragonborn_count bigint;
    draconic_feature_id bigint;
    draconic_choice_set_id bigint;
BEGIN
    SELECT COUNT(*) INTO ancestry_count FROM "dragonborn_ancestry_data";
    IF ancestry_count = 0 THEN
        RETURN;
    END IF;

    SELECT id
    INTO dragonborn_race_id
    FROM "race_data"
    WHERE lower(trim(COALESCE("name", ''))) IN (
        'dragonborn',
        'драконорождённый',
        'драконорожденный'
    )
    LIMIT 1;

    IF dragonborn_race_id IS NULL THEN
        RAISE EXCEPTION 'Migration requires exactly one Dragonborn race, but none was found.';
    END IF;

    SELECT COUNT(*)
    INTO duplicate_dragonborn_count
    FROM "race_data"
    WHERE lower(trim(COALESCE("name", ''))) IN (
        'dragonborn',
        'драконорождённый',
        'драконорожденный'
    );

    IF duplicate_dragonborn_count <> 1 THEN
        RAISE EXCEPTION 'Migration requires exactly one Dragonborn race, found %.', duplicate_dragonborn_count;
    END IF;

    SELECT id
    INTO draconic_feature_id
    FROM "race_feature_data"
    WHERE "raceId" = dragonborn_race_id
      AND lower(regexp_replace(COALESCE("name", ''), '[^a-zA-Z0-9]+', '', 'g')) = 'draconicancestry'
    LIMIT 1;

    IF draconic_feature_id IS NULL THEN
        INSERT INTO "race_feature_data" (
            "raceId",
            "subraceId",
            "name",
            "description",
            "source",
            "version",
            "createdAt",
            "updatedAt",
            "level",
            "usesPerRest",
            "usesFormula",
            "tags"
        )
        VALUES (
            dragonborn_race_id,
            NULL,
            'Draconic Ancestry',
            NULL,
            'migration',
            1,
            now(),
            now(),
            1,
            NULL,
            NULL,
            NULL
        )
        RETURNING id INTO draconic_feature_id;
    END IF;

    INSERT INTO "race_choice_set_data" (
        "featureId",
        "kind",
        "pickCount",
        "mustBeDistinct",
        "description",
        "source",
        "version",
        "createdAt",
        "updatedAt"
    )
    VALUES (
        draconic_feature_id,
        'dragonbornAncestryChoice',
        1,
        true,
        'Choose your draconic ancestry.',
        'migration',
        1,
        now(),
        now()
    )
    RETURNING id INTO draconic_choice_set_id;

    INSERT INTO "race_choice_option_data" (
        "choiceSetId",
        "optionKey",
        "name",
        "description",
        "sortOrder",
        "ability",
        "skill",
        "language",
        "spellId",
        "toolKey",
        "bonusValue",
        "damageType",
        "areaOfEffectType",
        "areaText",
        "saveAbility",
        "damageByLevel",
        "source",
        "version",
        "createdAt",
        "updatedAt"
    )
    SELECT
        draconic_choice_set_id,
        trim(both '_' FROM lower(regexp_replace(COALESCE("name", ''), '[^a-zA-Z0-9]+', '_', 'g'))),
        "name",
        NULL,
        row_number() OVER (ORDER BY "id"),
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        "damageType",
        CASE lower(trim(COALESCE("breathShape", '')))
            WHEN 'cone' THEN 'cone'
            WHEN 'cube' THEN 'cube'
            WHEN 'cylinder' THEN 'cylinder'
            WHEN 'line' THEN 'line'
            WHEN 'sphere' THEN 'sphere'
            ELSE NULL
        END,
        "area",
        "saveAbility",
        "damageByLevel",
        COALESCE("source", 'migration'),
        "version",
        COALESCE("createdAt", now()),
        COALESCE("updatedAt", now())
    FROM "dragonborn_ancestry_data"
    ORDER BY "id";
END $$;

--
-- Drop legacy columns once data is backfilled.
--
ALTER TABLE "race_data" DROP COLUMN "abilityBonuses";
ALTER TABLE "race_data" DROP COLUMN "spellcasting";
ALTER TABLE "race_data" DROP COLUMN "_legacy_size";
ALTER TABLE "race_data" DROP COLUMN "_legacy_visionType";
ALTER TABLE "race_data" DROP COLUMN "_legacy_resistances";

ALTER TABLE "subrace_data" DROP COLUMN "abilityBonuses";
ALTER TABLE "subrace_data" DROP COLUMN "_legacy_resistances";

ALTER TABLE "race_feature_data" DROP COLUMN "spells";
ALTER TABLE "race_feature_data" DROP COLUMN "_legacy_usesPerRest";

DROP TABLE "dragonborn_ancestry_data" CASCADE;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "race_choice_option_data"
    ADD CONSTRAINT "race_choice_option_data_fk_0"
    FOREIGN KEY("choiceSetId")
    REFERENCES "race_choice_set_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "race_choice_option_data"
    ADD CONSTRAINT "race_choice_option_data_fk_1"
    FOREIGN KEY("spellId")
    REFERENCES "spell_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "race_choice_set_data"
    ADD CONSTRAINT "race_choice_set_data_fk_0"
    FOREIGN KEY("featureId")
    REFERENCES "race_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260329235835424', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260329235835424', "timestamp" = now();

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
