BEGIN;

-- Give every catalog race stable identities for the optional ability modes.
-- Existing mode groups from the choice migration are retained.
CREATE TEMP TABLE _stage4_flexible_race_keys ON COMMIT DROP AS
SELECT
    r.id AS race_id,
    r.name AS race_name,
    CASE lower(trim(r.name))
        WHEN 'дварф' THEN 'dwarf'
        WHEN 'dwarf' THEN 'dwarf'
        WHEN 'эльф' THEN 'elf'
        WHEN 'elf' THEN 'elf'
        WHEN 'полурослик' THEN 'halfling'
        WHEN 'halfling' THEN 'halfling'
        WHEN 'человек' THEN 'human'
        WHEN 'human' THEN 'human'
        WHEN 'драконорождённый' THEN 'dragonborn'
        WHEN 'драконорожденный' THEN 'dragonborn'
        WHEN 'dragonborn' THEN 'dragonborn'
        WHEN 'гном' THEN 'gnome'
        WHEN 'gnome' THEN 'gnome'
        WHEN 'полуэльф' THEN 'half_elf'
        WHEN 'half-elf' THEN 'half_elf'
        WHEN 'half elf' THEN 'half_elf'
        WHEN 'полуорк' THEN 'half_orc'
        WHEN 'half-orc' THEN 'half_orc'
        WHEN 'half orc' THEN 'half_orc'
        WHEN 'тифлинг' THEN 'tiefling'
        WHEN 'tiefling' THEN 'tiefling'
    END AS race_key
FROM race_data r;

DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM _stage4_flexible_race_keys WHERE race_key IS NULL)
       OR (SELECT count(DISTINCT race_key) FROM _stage4_flexible_race_keys) <>
          (SELECT count(*) FROM _stage4_flexible_race_keys) THEN
        RAISE EXCEPTION 'Every catalog race requires a unique stable key for flexible ability choices.';
    END IF;
    IF EXISTS (
        SELECT 1 FROM character_choice_data
        WHERE "groupKey" IN (
            'race_flexible_bonus_plus2',
            'race_flexible_bonus_plus1',
            'race_flexible_bonus_three_plus1'
        )
    ) THEN
        RAISE EXCEPTION 'A saved flexible ability choice still uses a synthetic group key.';
    END IF;
END $$;

INSERT INTO choice_group_data (
    "referenceKey", name, "sourceRaceId", type, "selectionCount",
    "allowDuplicates", "sortOrder"
)
SELECT
    r.race_key || '_ability_bonus_mode',
    r.race_name || ' ability bonus mode',
    r.race_id,
    'custom',
    1,
    false,
    90
FROM _stage4_flexible_race_keys r
ON CONFLICT ("referenceKey") DO NOTHING;

INSERT INTO choice_option_data ("choiceGroupId", "optionKey", name, "sortOrder")
SELECT g.id, mode.option_key, mode.display_name, mode.sort_order
FROM _stage4_flexible_race_keys r
JOIN choice_group_data g
  ON g."referenceKey" = r.race_key || '_ability_bonus_mode'
CROSS JOIN (VALUES
    ('racial', 'Racial', 0),
    ('flexiblePlusTwoOne', 'Flexible +2/+1', 1),
    ('flexibleThreePlusOne', 'Flexible +1/+1/+1', 2)
) mode(option_key, display_name, sort_order)
ON CONFLICT ("choiceGroupId", "optionKey") DO NOTHING;

INSERT INTO choice_group_data (
    "referenceKey", name, "sourceRaceId", type, "selectionCount",
    "allowDuplicates", "sortOrder"
)
SELECT
    'race_flexible_bonus_' || variant.key_suffix || '_' || r.race_key,
    r.race_name || ' ' || variant.display_name,
    r.race_id,
    'abilityIncrease',
    variant.selection_count,
    false,
    variant.sort_order
FROM _stage4_flexible_race_keys r
CROSS JOIN (VALUES
    ('plus2', '+2', 1, 91),
    ('plus1', '+1', 1, 92),
    ('three_plus1', '+1/+1/+1', 3, 93)
) variant(key_suffix, display_name, selection_count, sort_order);

INSERT INTO choice_option_data (
    "choiceGroupId", "optionKey", name, "sortOrder",
    "grantedAbilityBonuses"
)
SELECT
    g.id,
    ability.ability_key || CASE WHEN variant.bonus = 2
        THEN '_plus_two' ELSE '_plus_one' END,
    ability.display_name || CASE WHEN variant.bonus = 2
        THEN ' +2' ELSE ' +1' END,
    ability.sort_order,
    json_build_object(ability.ability_key, variant.bonus)
FROM _stage4_flexible_race_keys r
CROSS JOIN (VALUES
    ('plus2', 2),
    ('plus1', 1),
    ('three_plus1', 1)
) variant(key_suffix, bonus)
JOIN choice_group_data g
  ON g."referenceKey" =
     'race_flexible_bonus_' || variant.key_suffix || '_' || r.race_key
CROSS JOIN (VALUES
    ('strength', 'Strength', 0),
    ('dexterity', 'Dexterity', 1),
    ('constitution', 'Constitution', 2),
    ('intelligence', 'Intelligence', 3),
    ('wisdom', 'Wisdom', 4),
    ('charisma', 'Charisma', 5)
) ability(ability_key, display_name, sort_order);

DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM _stage4_flexible_race_keys r
        LEFT JOIN choice_group_data g
          ON g."referenceKey" = r.race_key || '_ability_bonus_mode'
        WHERE g.id IS NULL OR g."sourceRaceId" <> r.race_id
           OR (SELECT count(*) FROM choice_option_data o
               WHERE o."choiceGroupId" = g.id) <> 3
    ) THEN
        RAISE EXCEPTION 'A racial ability mode group has invalid source or options.';
    END IF;
    IF EXISTS (
        SELECT 1
        FROM _stage4_flexible_race_keys r
        CROSS JOIN (VALUES
            ('plus2', 1), ('plus1', 1), ('three_plus1', 3)
        ) variant(key_suffix, selection_count)
        LEFT JOIN choice_group_data g
          ON g."referenceKey" =
             'race_flexible_bonus_' || variant.key_suffix || '_' || r.race_key
        WHERE g.id IS NULL OR g."sourceRaceId" <> r.race_id
           OR g."selectionCount" <> variant.selection_count
           OR g.type <> 'abilityIncrease'
           OR (SELECT count(*) FROM choice_option_data o
               WHERE o."choiceGroupId" = g.id) <> 6
    ) THEN
        RAISE EXCEPTION 'A flexible ability group has invalid source, count, or options.';
    END IF;
END $$;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260926201907379', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260926201907379', "timestamp" = now();

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
