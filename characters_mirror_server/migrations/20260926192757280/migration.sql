BEGIN;

-- Copy legacy class and race choices into the generic catalog before the
-- legacy tables are removed by the follow-up schema migration.
DO $$
DECLARE
    class_group_count integer;
    class_option_count integer;
    race_group_count integer;
    race_option_count integer;
    warlock_id bigint;
    warlock_count integer;
BEGIN
    SELECT count(*) INTO class_group_count FROM class_choice_group_data;
    SELECT count(*) INTO class_option_count FROM class_choice_option_data;

    IF class_group_count NOT IN (0, 8) THEN
        RAISE EXCEPTION 'Expected zero or eight supported legacy class choice groups; found %.', class_group_count;
    END IF;
    IF class_group_count > 0 THEN
        SELECT count(*), min(id) INTO warlock_count, warlock_id
        FROM class_data
        WHERE lower(trim(name)) IN ('warlock', 'колдун');
        IF warlock_count <> 1 THEN
            RAISE EXCEPTION 'Expected exactly one Warlock/Колдун ClassData for the eight legacy choice groups; found %.', warlock_count;
        END IF;
        IF EXISTS (
            SELECT 1 FROM class_choice_group_data g
            WHERE g.level IS NULL
               OR g.level NOT IN (2, 3, 5, 7, 9, 12, 15, 18)
               OR g.type IS NULL
        ) OR (SELECT count(DISTINCT level) FROM class_choice_group_data) <> 8 THEN
            RAISE EXCEPTION 'Legacy Warlock choice groups do not match the approved level mapping.';
        END IF;
        IF EXISTS (
            SELECT 1 FROM class_choice_option_data o
            WHERE nullif(trim(o."optionKey"), '') IS NULL
        ) THEN
            RAISE EXCEPTION 'Legacy class choice options require stable, non-empty optionKey values.';
        END IF;

        -- Resolve every legacy spell display name to one canonical catalog key.
        IF EXISTS (
            SELECT 1
            FROM class_choice_option_data o
            CROSS JOIN LATERAL jsonb_array_elements_text(
                COALESCE(o."grantedSpellKeys"::jsonb, '[]'::jsonb)
            ) legacy_spell(value)
            WHERE (
                SELECT count(*)
                FROM spell_data s
                WHERE trim(s.name) = trim(
                    CASE trim(legacy_spell.value)
                        WHEN 'Ложная жизнь' THEN 'Псевдожизнь'
                        ELSE legacy_spell.value
                    END
                )
            ) <> 1
        ) THEN
            RAISE EXCEPTION 'A legacy class choice spell name has no unique exact SpellData name mapping.';
        END IF;
        IF EXISTS (
            SELECT 1
            FROM class_choice_option_data o
            CROSS JOIN LATERAL jsonb_array_elements_text(
                COALESCE(o."grantedSpellKeys"::jsonb, '[]'::jsonb)
            ) legacy_spell(value)
            JOIN spell_data s ON trim(s.name) = trim(
                CASE trim(legacy_spell.value)
                    WHEN 'Ложная жизнь' THEN 'Псевдожизнь'
                    ELSE legacy_spell.value
                END
            )
            WHERE nullif(trim(s."referenceKey"), '') IS NULL
        ) THEN
            RAISE EXCEPTION 'A mapped SpellData row has an empty referenceKey.';
        END IF;

        INSERT INTO choice_group_data (
            "referenceKey", name, description, "sourceClassId", level, type,
            "selectionCount", "appliesAtCharacterLevel", "exclusiveKey",
            "allowDuplicates", source, version, "createdAt", "updatedAt"
        )
        SELECT
            CASE g.level
                WHEN 2 THEN 'warlock_eldritch_invocations_2'
                WHEN 3 THEN 'warlock_pact_boon'
                WHEN 5 THEN 'warlock_eldritch_invocations_5'
                WHEN 7 THEN 'warlock_eldritch_invocations_7'
                WHEN 9 THEN 'warlock_eldritch_invocations_9'
                WHEN 12 THEN 'warlock_eldritch_invocations_12'
                WHEN 15 THEN 'warlock_eldritch_invocations_15'
                WHEN 18 THEN 'warlock_eldritch_invocations_18'
            END,
            g.name, g.description, warlock_id, g.level, g.type,
            g."selectionCount", g."appliesAtCharacterLevel", g."exclusiveKey",
            g."allowDuplicates", g.source, g.version, g."createdAt", g."updatedAt"
        FROM class_choice_group_data g;

        IF (SELECT count(*) FROM choice_group_data WHERE "referenceKey" LIKE 'warlock_%') <> class_group_count THEN
            RAISE EXCEPTION 'Warlock choice group migration count mismatch.';
        END IF;

        INSERT INTO choice_option_data (
            "choiceGroupId", "optionKey", name, description, "sortOrder",
            "grantedAbilityBonuses", "grantedSkills", "grantedLanguages",
            "grantedArmorTraining", "grantedWeaponTraining", "grantedToolKeys",
            "grantedSpellKeys", "grantedFeatureTags", source, version,
            "createdAt", "updatedAt"
        )
        SELECT
            generic_group.id,
            legacy_option."optionKey",
            legacy_option.name,
            legacy_option.description,
            row_number() OVER (
                PARTITION BY legacy_group.id
                ORDER BY lower(coalesce(legacy_option.name, '')),
                         legacy_option."optionKey"
            ) - 1,
            legacy_option."grantedAbilityBonuses",
            legacy_option."grantedSkills",
            legacy_option."grantedLanguages",
            legacy_option."grantedArmorTraining",
            legacy_option."grantedWeaponTraining",
            legacy_option."grantedToolKeys",
            COALESCE((
                SELECT json_agg(spell.reference_key ORDER BY legacy_spell.ordinality)
                FROM jsonb_array_elements_text(
                    COALESCE(legacy_option."grantedSpellKeys"::jsonb, '[]'::jsonb)
                ) WITH ORDINALITY legacy_spell(value, ordinality)
                JOIN LATERAL (
                    SELECT s."referenceKey" AS reference_key
                    FROM spell_data s
                    WHERE trim(s.name) = trim(
                        CASE trim(legacy_spell.value)
                            WHEN 'Ложная жизнь' THEN 'Псевдожизнь'
                            ELSE legacy_spell.value
                        END
                    )
                ) spell ON true
            ), '[]'::json),
            legacy_option."grantedFeatureTags",
            legacy_option.source, legacy_option.version,
            legacy_option."createdAt", legacy_option."updatedAt"
        FROM class_choice_option_data legacy_option
        JOIN class_choice_group_data legacy_group
          ON legacy_group.id = legacy_option."choiceGroupId"
        JOIN choice_group_data generic_group
          ON generic_group."referenceKey" = CASE legacy_group.level
                WHEN 2 THEN 'warlock_eldritch_invocations_2'
                WHEN 3 THEN 'warlock_pact_boon'
                WHEN 5 THEN 'warlock_eldritch_invocations_5'
                WHEN 7 THEN 'warlock_eldritch_invocations_7'
                WHEN 9 THEN 'warlock_eldritch_invocations_9'
                WHEN 12 THEN 'warlock_eldritch_invocations_12'
                WHEN 15 THEN 'warlock_eldritch_invocations_15'
                WHEN 18 THEN 'warlock_eldritch_invocations_18'
          END;

        IF (SELECT count(*) FROM choice_option_data o JOIN choice_group_data g ON g.id = o."choiceGroupId" WHERE g."referenceKey" LIKE 'warlock_%') <> class_option_count THEN
            RAISE EXCEPTION 'Warlock choice option migration count mismatch.';
        END IF;
    END IF;

    SELECT count(*) INTO race_group_count FROM race_choice_set_data;
    SELECT count(*) INTO race_option_count FROM race_choice_option_data;
    IF EXISTS (
        SELECT 1
        FROM race_choice_set_data legacy_group
        JOIN race_feature_data feature ON feature.id = legacy_group."featureId"
        LEFT JOIN race_data race ON race.id = feature."raceId"
        LEFT JOIN subrace_data subrace ON subrace.id = feature."subraceId"
        WHERE CASE lower(coalesce(race.name, subrace.name, ''))
            WHEN 'драконорожденный' THEN
                CASE legacy_group.kind WHEN 'dragonbornAncestryChoice' THEN 'dragonborn_draconic_ancestry' END
            WHEN 'драконорождённый' THEN
                CASE legacy_group.kind WHEN 'dragonbornAncestryChoice' THEN 'dragonborn_draconic_ancestry' END
            WHEN 'dragonborn' THEN
                CASE legacy_group.kind WHEN 'dragonbornAncestryChoice' THEN 'dragonborn_draconic_ancestry' END
            WHEN 'полуэльф' THEN
                CASE legacy_group.kind WHEN 'abilityBonusChoice' THEN 'half_elf_ability_score_increase' END
            WHEN 'half-elf' THEN
                CASE legacy_group.kind WHEN 'abilityBonusChoice' THEN 'half_elf_ability_score_increase' END
            WHEN 'half elf' THEN
                CASE legacy_group.kind WHEN 'abilityBonusChoice' THEN 'half_elf_ability_score_increase' END
            ELSE NULL
        END IS NULL
    ) THEN
        RAISE EXCEPTION 'A legacy race choice group has no approved stable semantic key mapping.';
    END IF;
    IF EXISTS (
        SELECT 1 FROM race_choice_option_data o
        WHERE nullif(trim(o."optionKey"), '') IS NULL
    ) THEN
        RAISE EXCEPTION 'Legacy race choice options require stable, non-empty optionKey values.';
    END IF;
    IF EXISTS (
        SELECT 1 FROM race_choice_option_data o
        WHERE o."featId" IS NOT NULL OR o."saveAbility" IS NOT NULL
    ) THEN
        RAISE EXCEPTION 'Unsupported legacy race choice effects (feat/saveAbility) must be reviewed before cleanup.';
    END IF;

    INSERT INTO choice_group_data (
        "referenceKey", name, description, "sourceRaceFeatureId", type,
        "selectionCount", "allowDuplicates", "sortOrder", source, version,
        "createdAt", "updatedAt"
    )
    SELECT
        CASE lower(coalesce(race.name, subrace.name, ''))
            WHEN 'драконорожденный' THEN 'dragonborn_draconic_ancestry'
            WHEN 'драконорождённый' THEN 'dragonborn_draconic_ancestry'
            WHEN 'dragonborn' THEN 'dragonborn_draconic_ancestry'
            WHEN 'полуэльф' THEN 'half_elf_ability_score_increase'
            WHEN 'half-elf' THEN 'half_elf_ability_score_increase'
            WHEN 'half elf' THEN 'half_elf_ability_score_increase'
        END,
        coalesce(legacy_group.description, feature.name),
        legacy_group.description,
        legacy_group."featureId",
        CASE legacy_group.kind
            WHEN 'abilityBonusChoice' THEN 'abilityIncrease'
            WHEN 'skillProficiencyChoice' THEN 'custom'
            WHEN 'languageChoice' THEN 'language'
            WHEN 'toolProficiencyChoice' THEN 'tool'
            WHEN 'cantripChoice' THEN 'custom'
            WHEN 'dragonbornAncestryChoice' THEN 'custom'
            WHEN 'featChoice' THEN 'feat'
        END,
        legacy_group."pickCount",
        NOT COALESCE(legacy_group."mustBeDistinct", false),
        CASE legacy_group.kind WHEN 'abilityBonusChoice' THEN 0 ELSE 1 END,
        legacy_group.source, legacy_group.version,
        legacy_group."createdAt", legacy_group."updatedAt"
    FROM race_choice_set_data legacy_group
    JOIN race_feature_data feature ON feature.id = legacy_group."featureId"
    LEFT JOIN race_data race ON race.id = feature."raceId"
    LEFT JOIN subrace_data subrace ON subrace.id = feature."subraceId";

    IF (SELECT count(*) FROM choice_group_data WHERE "referenceKey" IN ('dragonborn_draconic_ancestry', 'half_elf_ability_score_increase')) <> race_group_count THEN
        RAISE EXCEPTION 'Race choice group migration count mismatch.';
    END IF;

    INSERT INTO choice_option_data (
        "choiceGroupId", "optionKey", name, description, "sortOrder",
        "grantedAbilityBonuses", "grantedSkills", "grantedLanguages",
        "grantedToolKeys", "grantedSpellKeys", "grantedFeatureTags",
        "damageType", "areaOfEffectType", "areaText", "damageByLevel",
        source, version, "createdAt", "updatedAt"
    )
    SELECT
        generic_group.id,
        legacy_option."optionKey",
        legacy_option.name,
        legacy_option.description,
        row_number() OVER (
            PARTITION BY legacy_group.id
            ORDER BY legacy_option."sortOrder" NULLS LAST,
                     legacy_option."optionKey"
        ) - 1,
        CASE WHEN legacy_option.ability IS NULL OR legacy_option."bonusValue" IS NULL
             THEN NULL
             ELSE json_build_object(legacy_option.ability, legacy_option."bonusValue") END,
        CASE WHEN legacy_option.skill IS NULL THEN NULL
             ELSE json_build_array(legacy_option.skill) END,
        CASE WHEN legacy_option.language IS NULL THEN NULL
             ELSE json_build_array(legacy_option.language) END,
        CASE WHEN legacy_option."toolKey" IS NULL THEN NULL
             ELSE json_build_array(legacy_option."toolKey") END,
        CASE WHEN spell."referenceKey" IS NULL THEN NULL
             ELSE json_build_array(spell."referenceKey") END,
        legacy_option."grantedFeatureTags",
        legacy_option."damageType",
        legacy_option."areaOfEffectType",
        legacy_option."areaText",
        legacy_option."damageByLevel",
        legacy_option.source, legacy_option.version,
        legacy_option."createdAt", legacy_option."updatedAt"
    FROM race_choice_option_data legacy_option
    JOIN race_choice_set_data legacy_group
      ON legacy_group.id = legacy_option."choiceSetId"
    JOIN race_feature_data feature ON feature.id = legacy_group."featureId"
    LEFT JOIN race_data race ON race.id = feature."raceId"
    LEFT JOIN subrace_data subrace ON subrace.id = feature."subraceId"
    JOIN choice_group_data generic_group
      ON generic_group."referenceKey" = CASE lower(coalesce(race.name, subrace.name, ''))
            WHEN 'драконорожденный' THEN 'dragonborn_draconic_ancestry'
            WHEN 'драконорождённый' THEN 'dragonborn_draconic_ancestry'
            WHEN 'dragonborn' THEN 'dragonborn_draconic_ancestry'
            WHEN 'полуэльф' THEN 'half_elf_ability_score_increase'
            WHEN 'half-elf' THEN 'half_elf_ability_score_increase'
            WHEN 'half elf' THEN 'half_elf_ability_score_increase'
         END
    LEFT JOIN spell_data spell ON spell.id = legacy_option."spellId";

    IF (SELECT count(*) FROM choice_option_data o JOIN choice_group_data g ON g.id = o."choiceGroupId" WHERE g."referenceKey" IN ('dragonborn_draconic_ancestry', 'half_elf_ability_score_increase')) <> race_option_count THEN
        RAISE EXCEPTION 'Race choice option migration count mismatch.';
    END IF;
END $$;

-- Migrate the six temporary background tool-category markers into explicit
-- choices backed by the canonical tool catalog.
DO $$
DECLARE
    marker_count integer;
    group_count integer;
    option_count integer;
BEGIN
    IF EXISTS (
        SELECT 1
        FROM background_data b
        CROSS JOIN LATERAL jsonb_array_elements_text(
            COALESCE(b."toolProficiencies"::jsonb, '[]'::jsonb)
        ) marker(value)
        WHERE CASE lower(trim(marker.value))
            WHEN 'инструменты ремесленника' THEN 0
            WHEN 'tool.artisanstools' THEN 0
            WHEN 'artisan' THEN 0
            WHEN 'музыкальный инструмент' THEN 1
            WHEN 'tool.musicalinstrument' THEN 1
            WHEN 'musicalinstrument' THEN 1
            WHEN 'игровой набор' THEN 2
            WHEN 'tool.gamingset' THEN 2
            WHEN 'gamingset' THEN 2
            ELSE -1
        END < 0
    ) THEN
        RAISE EXCEPTION 'Unrecognized background tool proficiency category marker.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM background_data b
        CROSS JOIN LATERAL jsonb_array_elements_text(
            COALESCE(b."toolProficiencies"::jsonb, '[]'::jsonb)
        ) marker(value)
        WHERE CASE lower(trim(b.name))
            WHEN 'народный герой' THEN 'folk_hero_artisan_tool'
            WHEN 'преступник' THEN 'criminal_gaming_set'
            WHEN 'гильдейский ремесленник' THEN 'guild_artisan_artisan_tool'
            WHEN 'чужеземец' THEN 'outlander_musical_instrument'
            WHEN 'артист' THEN 'entertainer_musical_instrument'
            WHEN 'солдат' THEN 'soldier_gaming_set'
            ELSE NULL
        END IS NULL
    ) THEN
        RAISE EXCEPTION 'Background tool category marker has no approved stable group key.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM background_data b
        CROSS JOIN LATERAL jsonb_array_elements_text(
            COALESCE(b."toolProficiencies"::jsonb, '[]'::jsonb)
        ) marker(value)
        WHERE CASE lower(trim(b.name))
            WHEN 'народный герой' THEN 0
            WHEN 'гильдейский ремесленник' THEN 0
            WHEN 'преступник' THEN 2
            WHEN 'солдат' THEN 2
            WHEN 'чужеземец' THEN 1
            WHEN 'артист' THEN 1
            ELSE -1
        END <> CASE lower(trim(marker.value))
            WHEN 'инструменты ремесленника' THEN 0
            WHEN 'tool.artisanstools' THEN 0
            WHEN 'artisan' THEN 0
            WHEN 'музыкальный инструмент' THEN 1
            WHEN 'tool.musicalinstrument' THEN 1
            WHEN 'musicalinstrument' THEN 1
            WHEN 'игровой набор' THEN 2
            WHEN 'tool.gamingset' THEN 2
            WHEN 'gamingset' THEN 2
            ELSE -2
        END
    ) THEN
        RAISE EXCEPTION 'Background tool marker does not match its approved category.';
    END IF;

    SELECT count(*) INTO marker_count
    FROM (
        SELECT DISTINCT b.id
        FROM background_data b
        CROSS JOIN LATERAL jsonb_array_elements_text(
            COALESCE(b."toolProficiencies"::jsonb, '[]'::jsonb)
        ) marker(value)
    ) marked_backgrounds;

    INSERT INTO choice_group_data (
        "referenceKey", name, "sourceBackgroundId", type,
        "selectionCount", "allowDuplicates", source, version,
        "createdAt", "updatedAt"
    )
    SELECT
        CASE lower(trim(b.name))
            WHEN 'народный герой' THEN 'folk_hero_artisan_tool'
            WHEN 'преступник' THEN 'criminal_gaming_set'
            WHEN 'гильдейский ремесленник' THEN 'guild_artisan_artisan_tool'
            WHEN 'чужеземец' THEN 'outlander_musical_instrument'
            WHEN 'артист' THEN 'entertainer_musical_instrument'
            WHEN 'солдат' THEN 'soldier_gaming_set'
        END,
        b.name,
        b.id,
        'tool',
        1,
        false,
        'Stage 4 explicit background tool choices',
        1,
        now(),
        now()
    FROM background_data b
    WHERE jsonb_array_length(COALESCE(b."toolProficiencies"::jsonb, '[]'::jsonb)) > 0;

    GET DIAGNOSTICS group_count = ROW_COUNT;
    IF group_count <> marker_count THEN
        RAISE EXCEPTION 'Background tool choice group count mismatch: expected %, migrated %.', marker_count, group_count;
    END IF;

    WITH marked AS (
        SELECT DISTINCT
            b.id AS background_id,
            CASE lower(trim(b.name))
                WHEN 'народный герой' THEN 'folk_hero_artisan_tool'
                WHEN 'преступник' THEN 'criminal_gaming_set'
                WHEN 'гильдейский ремесленник' THEN 'guild_artisan_artisan_tool'
                WHEN 'чужеземец' THEN 'outlander_musical_instrument'
                WHEN 'артист' THEN 'entertainer_musical_instrument'
                WHEN 'солдат' THEN 'soldier_gaming_set'
            END AS group_key,
            CASE lower(trim(b.name))
                WHEN 'народный герой' THEN 0
                WHEN 'гильдейский ремесленник' THEN 0
                WHEN 'преступник' THEN 2
                WHEN 'солдат' THEN 2
                WHEN 'чужеземец' THEN 1
                WHEN 'артист' THEN 1
            END AS category
        FROM background_data b
        CROSS JOIN LATERAL jsonb_array_elements_text(
            COALESCE(b."toolProficiencies"::jsonb, '[]'::jsonb)
        ) marker(value)
    ),
    ranked_tools AS (
        SELECT
            marked.group_key,
            t."referenceKey",
            t.name,
            row_number() OVER (
                PARTITION BY marked.group_key
                ORDER BY lower(t.name), t."referenceKey"
            ) - 1 AS sort_order
        FROM marked
        JOIN tool_data t ON t.category = marked.category
    )
    INSERT INTO choice_option_data (
        "choiceGroupId", "optionKey", name, "sortOrder",
        "grantedToolKeys", source, version, "createdAt", "updatedAt"
    )
    SELECT
        g.id,
        ranked_tools."referenceKey",
        ranked_tools.name,
        ranked_tools.sort_order,
        json_build_array(ranked_tools."referenceKey"),
        'Stage 4 explicit background tool choices',
        1,
        now(),
        now()
    FROM ranked_tools
    JOIN choice_group_data g ON g."referenceKey" = ranked_tools.group_key;

    GET DIAGNOSTICS option_count = ROW_COUNT;
    IF marker_count > 0 AND option_count = 0 THEN
        RAISE EXCEPTION 'Background tool choices were created without any catalog options.';
    END IF;

    UPDATE background_data
    SET "toolProficiencies" = '[]'::json
    WHERE jsonb_array_length(COALESCE("toolProficiencies"::jsonb, '[]'::jsonb)) > 0;

    IF EXISTS (
        SELECT 1
        FROM background_data
        WHERE jsonb_array_length(COALESCE("toolProficiencies"::jsonb, '[]'::jsonb)) > 0
    ) THEN
        RAISE EXCEPTION 'Background category markers remain after migration.';
    END IF;
END $$;

-- Model the previously saved default/flexible ability mode as ordinary
-- race-scoped choice identities. Race IDs are only used to resolve the
-- reference relation; the character retains stable semantic keys.
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM character_choice_data c
        LEFT JOIN race_data r ON r.id = c."sourceId"
        WHERE c."groupKey" = 'race_bonus_mode'
          AND (
            c."sourceType" <> 'race'
            OR c."selectedText" NOT IN ('racial', 'flexiblePlusTwoOne', 'flexibleThreePlusOne')
            OR CASE lower(trim(r.name))
                WHEN 'эльф' THEN 'elf_ability_bonus_mode'
                WHEN 'elf' THEN 'elf_ability_bonus_mode'
                WHEN 'полуэльф' THEN 'half_elf_ability_bonus_mode'
                WHEN 'half-elf' THEN 'half_elf_ability_bonus_mode'
                WHEN 'half elf' THEN 'half_elf_ability_bonus_mode'
                WHEN 'полуорк' THEN 'half_orc_ability_bonus_mode'
                WHEN 'half-orc' THEN 'half_orc_ability_bonus_mode'
                WHEN 'half orc' THEN 'half_orc_ability_bonus_mode'
                ELSE NULL
            END IS NULL
          )
    ) THEN
        RAISE EXCEPTION 'Existing race ability-mode choice cannot be mapped unambiguously.';
    END IF;

    INSERT INTO choice_group_data (
        "referenceKey", name, "sourceRaceId", type, "selectionCount",
        "allowDuplicates", source, version, "createdAt", "updatedAt"
    )
    SELECT
        CASE lower(trim(r.name))
            WHEN 'эльф' THEN 'elf_ability_bonus_mode'
            WHEN 'elf' THEN 'elf_ability_bonus_mode'
            WHEN 'полуэльф' THEN 'half_elf_ability_bonus_mode'
            WHEN 'half-elf' THEN 'half_elf_ability_bonus_mode'
            WHEN 'half elf' THEN 'half_elf_ability_bonus_mode'
            WHEN 'полуорк' THEN 'half_orc_ability_bonus_mode'
            WHEN 'half-orc' THEN 'half_orc_ability_bonus_mode'
            WHEN 'half orc' THEN 'half_orc_ability_bonus_mode'
        END,
        r.name || ' ability bonus mode',
        r.id,
        'custom',
        1,
        false,
        'Stage 4 race ability mode choices',
        1,
        now(),
        now()
    FROM race_data r
    WHERE lower(trim(r.name)) IN (
        'эльф', 'elf', 'полуэльф', 'half-elf', 'half elf',
        'полуорк', 'half-orc', 'half orc'
    );

    INSERT INTO choice_option_data (
        "choiceGroupId", "optionKey", name, "sortOrder",
        source, version, "createdAt", "updatedAt"
    )
    SELECT g.id, modes.option_key, modes.display_name, modes.sort_order,
           'Stage 4 race ability mode choices', 1, now(), now()
    FROM choice_group_data g
    CROSS JOIN (VALUES
        ('racial', 'Racial', 0),
        ('flexiblePlusTwoOne', 'Flexible +2/+1', 1),
        ('flexibleThreePlusOne', 'Flexible +1/+1/+1', 2)
    ) modes(option_key, display_name, sort_order)
    WHERE g."referenceKey" IN (
        'elf_ability_bonus_mode',
        'half_elf_ability_bonus_mode',
        'half_orc_ability_bonus_mode'
    );

    UPDATE character_choice_data c
    SET "groupKey" = CASE lower(trim(r.name))
            WHEN 'эльф' THEN 'elf_ability_bonus_mode'
            WHEN 'elf' THEN 'elf_ability_bonus_mode'
            WHEN 'полуэльф' THEN 'half_elf_ability_bonus_mode'
            WHEN 'half-elf' THEN 'half_elf_ability_bonus_mode'
            WHEN 'half elf' THEN 'half_elf_ability_bonus_mode'
            WHEN 'полуорк' THEN 'half_orc_ability_bonus_mode'
            WHEN 'half-orc' THEN 'half_orc_ability_bonus_mode'
            WHEN 'half orc' THEN 'half_orc_ability_bonus_mode'
        END,
        "optionKey" = trim(c."selectedText"),
        "selectionIndex" = COALESCE(c."selectionIndex", 0)
    FROM race_data r
    WHERE c."groupKey" = 'race_bonus_mode'
      AND c."sourceId" = r.id;

    IF EXISTS (
        SELECT 1 FROM character_choice_data c
        WHERE c."groupKey" IS NULL OR c."optionKey" IS NULL
    ) THEN
        RAISE EXCEPTION 'Character choice identity migration left a row without groupKey/optionKey.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM character_choice_data c
        LEFT JOIN choice_group_data g ON g."referenceKey" = c."groupKey"
        LEFT JOIN choice_option_data o
          ON o."choiceGroupId" = g.id AND o."optionKey" = c."optionKey"
        WHERE g.id IS NULL OR o.id IS NULL
    ) THEN
        RAISE EXCEPTION 'Character choice identity migration produced an invalid group/option pair.';
    END IF;
END $$;

ALTER TABLE choice_group_data
    ADD CONSTRAINT choice_group_data_exactly_one_source_chk CHECK (
        num_nonnulls(
            "sourceClassId", "sourceSubclassId", "sourceFeatureId",
            "sourceSubclassFeatureId", "sourceRaceId", "sourceSubraceId",
            "sourceRaceFeatureId", "sourceBackgroundId"
        ) = 1
    );

--
-- ACTION ALTER TABLE
--
ALTER TABLE "background_data" DROP COLUMN "toolProficiencies";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_choice_data" DROP COLUMN "sourceType";
ALTER TABLE "character_choice_data" DROP COLUMN "sourceId";
ALTER TABLE "character_choice_data" DROP COLUMN "selectedAbility";
ALTER TABLE "character_choice_data" DROP COLUMN "selectedLanguage";
ALTER TABLE "character_choice_data" DROP COLUMN "selectedToolKey";
ALTER TABLE "character_choice_data" DROP COLUMN "selectedFeatId";
ALTER TABLE "character_choice_data" DROP COLUMN "selectedText";
ALTER TABLE "character_choice_data" DROP COLUMN "selectedCount";

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260926192757280', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260926192757280', "timestamp" = now();

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
