BEGIN;

-- Legacy background equipment has no structured rows today. The test database
-- intentionally has no reference catalog, so this data migration is a no-op
-- there until those reference rows are present. A partially loaded catalog is
-- rejected instead of silently producing incomplete starting equipment.
DO $$
DECLARE
    target_background_count bigint;
    missing_record record;
    background_id bigint;
    group_id bigint;
    option_id bigint;
    root_row record;
    option_row record;
    line_row record;
BEGIN
    CREATE TEMP TABLE stage6_background_equipment_plan (
        background_name text NOT NULL,
        root_key text NOT NULL,
        root_kind text NOT NULL,
        root_order integer NOT NULL,
        option_key text,
        option_order integer,
        line_kind text NOT NULL,
        catalog_type text NOT NULL,
        reference_key text,
        quantity integer,
        category text
    ) ON COMMIT DROP;

    INSERT INTO stage6_background_equipment_plan VALUES
        ('Послушник', 'fixed:holy_symbol', 'fixedLine', 0, NULL, NULL, 'catalogRef', 'item', 'holy_symbol', 1, NULL),
        ('Послушник', 'acolyte_prayer_book_or_drum', 'choiceGroup', 1, 'prayer_book', 0, 'catalogRef', 'item', 'prayer_book', 1, NULL),
        ('Послушник', 'acolyte_prayer_book_or_drum', 'choiceGroup', 1, 'prayer_drum', 1, 'catalogRef', 'item', 'prayer_drum', 1, NULL),
        ('Послушник', 'fixed:incense_stick', 'fixedLine', 2, NULL, NULL, 'catalogRef', 'item', 'incense_stick', 5, NULL),
        ('Послушник', 'fixed:robe', 'fixedLine', 3, NULL, NULL, 'catalogRef', 'item', 'robe', 1, NULL),
        ('Послушник', 'fixed:common_clothes', 'fixedLine', 4, NULL, NULL, 'catalogRef', 'item', 'common_clothes', 1, NULL),
        ('Послушник', 'fixed:pouch', 'fixedLine', 5, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL),

        ('Благородный', 'fixed:fine_clothes', 'fixedLine', 0, NULL, NULL, 'catalogRef', 'item', 'fine_clothes', 1, NULL),
        ('Благородный', 'fixed:signet_ring', 'fixedLine', 1, NULL, NULL, 'catalogRef', 'item', 'signet_ring', 1, NULL),
        ('Благородный', 'fixed:genealogy_scroll', 'fixedLine', 2, NULL, NULL, 'catalogRef', 'item', 'genealogy_scroll', 1, NULL),
        ('Благородный', 'fixed:pouch', 'fixedLine', 3, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL),

        ('Беспризорник', 'fixed:common_clothes', 'fixedLine', 0, NULL, NULL, 'catalogRef', 'item', 'common_clothes', 1, NULL),
        ('Беспризорник', 'fixed:small_knife', 'fixedLine', 1, NULL, NULL, 'catalogRef', 'item', 'small_knife', 1, NULL),
        ('Беспризорник', 'fixed:home_city_map', 'fixedLine', 2, NULL, NULL, 'catalogRef', 'item', 'home_city_map', 1, NULL),
        ('Беспризорник', 'fixed:pet_mouse', 'fixedLine', 3, NULL, NULL, 'catalogRef', 'item', 'pet_mouse', 1, NULL),
        ('Беспризорник', 'fixed:parents_keepsake', 'fixedLine', 4, NULL, NULL, 'catalogRef', 'item', 'parents_keepsake', 1, NULL),
        ('Беспризорник', 'fixed:pouch', 'fixedLine', 5, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL),

        ('Мудрец', 'fixed:ink_bottle', 'fixedLine', 0, NULL, NULL, 'catalogRef', 'item', 'ink_bottle', 1, NULL),
        ('Мудрец', 'fixed:quill', 'fixedLine', 1, NULL, NULL, 'catalogRef', 'item', 'quill', 1, NULL),
        ('Мудрец', 'fixed:small_knife', 'fixedLine', 2, NULL, NULL, 'catalogRef', 'item', 'small_knife', 1, NULL),
        ('Мудрец', 'fixed:dead_colleague_letter', 'fixedLine', 3, NULL, NULL, 'catalogRef', 'item', 'dead_colleague_letter', 1, NULL),
        ('Мудрец', 'fixed:common_clothes', 'fixedLine', 4, NULL, NULL, 'catalogRef', 'item', 'common_clothes', 1, NULL),
        ('Мудрец', 'fixed:pouch', 'fixedLine', 5, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL),

        ('Народный герой', 'folk_hero_artisan_tool', 'choiceGroup', 0, 'artisan', 0, 'itemCategory', 'tool', NULL, 1, 'artisan'),
        ('Народный герой', 'fixed:shovel', 'fixedLine', 1, NULL, NULL, 'catalogRef', 'item', 'shovel', 1, NULL),
        ('Народный герой', 'fixed:iron_pot', 'fixedLine', 2, NULL, NULL, 'catalogRef', 'item', 'iron_pot', 1, NULL),
        ('Народный герой', 'fixed:common_clothes', 'fixedLine', 3, NULL, NULL, 'catalogRef', 'item', 'common_clothes', 1, NULL),
        ('Народный герой', 'fixed:lucky_charm', 'fixedLine', 4, NULL, NULL, 'catalogRef', 'item', 'lucky_charm', 1, NULL),
        ('Народный герой', 'fixed:pouch', 'fixedLine', 5, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL),

        ('Отшельник', 'fixed:scroll_case', 'fixedLine', 0, NULL, NULL, 'catalogRef', 'item', 'scroll_case', 1, NULL),
        ('Отшельник', 'fixed:blanket', 'fixedLine', 1, NULL, NULL, 'catalogRef', 'item', 'blanket', 1, NULL),
        ('Отшельник', 'fixed:common_clothes', 'fixedLine', 2, NULL, NULL, 'catalogRef', 'item', 'common_clothes', 1, NULL),
        ('Отшельник', 'fixed:herbalism_kit', 'fixedLine', 3, NULL, NULL, 'catalogRef', 'tool', 'herbalism_kit', 1, NULL),
        ('Отшельник', 'fixed:pouch', 'fixedLine', 4, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL),

        ('Пират', 'fixed:silk_rope', 'fixedLine', 0, NULL, NULL, 'catalogRef', 'item', 'silk_rope', 1, NULL),
        ('Пират', 'fixed:lucky_charm', 'fixedLine', 1, NULL, NULL, 'catalogRef', 'item', 'lucky_charm', 1, NULL),
        ('Пират', 'fixed:common_clothes', 'fixedLine', 2, NULL, NULL, 'catalogRef', 'item', 'common_clothes', 1, NULL),
        ('Пират', 'fixed:pouch', 'fixedLine', 3, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL),

        ('Преступник', 'fixed:crowbar', 'fixedLine', 0, NULL, NULL, 'catalogRef', 'item', 'crowbar', 1, NULL),
        ('Преступник', 'fixed:dark_common_clothes', 'fixedLine', 1, NULL, NULL, 'catalogRef', 'item', 'dark_common_clothes', 1, NULL),
        ('Преступник', 'fixed:pouch', 'fixedLine', 2, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL),

        ('Гильдейский ремесленник', 'guild_artisan_artisan_tool', 'choiceGroup', 0, 'artisan', 0, 'itemCategory', 'tool', NULL, 1, 'artisan'),
        ('Гильдейский ремесленник', 'fixed:guild_letter', 'fixedLine', 1, NULL, NULL, 'catalogRef', 'item', 'guild_letter', 1, NULL),
        ('Гильдейский ремесленник', 'fixed:common_clothes', 'fixedLine', 2, NULL, NULL, 'catalogRef', 'item', 'common_clothes', 1, NULL),
        ('Гильдейский ремесленник', 'fixed:pouch', 'fixedLine', 3, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL),

        ('Чужеземец', 'fixed:quarterstaff', 'fixedLine', 0, NULL, NULL, 'catalogRef', 'weapon', 'quarterstaff', 1, NULL),
        ('Чужеземец', 'fixed:hunting_trap', 'fixedLine', 1, NULL, NULL, 'catalogRef', 'item', 'hunting_trap', 1, NULL),
        ('Чужеземец', 'fixed:animal_trophy', 'fixedLine', 2, NULL, NULL, 'catalogRef', 'item', 'animal_trophy', 1, NULL),
        ('Чужеземец', 'fixed:travel_clothes', 'fixedLine', 3, NULL, NULL, 'catalogRef', 'item', 'travel_clothes', 1, NULL),
        ('Чужеземец', 'fixed:pouch', 'fixedLine', 4, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL),

        ('Шарлатан', 'fixed:fine_clothes', 'fixedLine', 0, NULL, NULL, 'catalogRef', 'item', 'fine_clothes', 1, NULL),
        ('Шарлатан', 'fixed:disguise_kit', 'fixedLine', 1, NULL, NULL, 'catalogRef', 'tool', 'disguise_kit', 1, NULL),
        ('Шарлатан', 'charlatan_con_item', 'choiceGroup', 2, 'dyed_liquid_bottle', 0, 'catalogRef', 'item', 'dyed_liquid_bottle', 1, NULL),
        ('Шарлатан', 'charlatan_con_item', 'choiceGroup', 2, 'rigged_dice', 1, 'catalogRef', 'item', 'rigged_dice', 1, NULL),
        ('Шарлатан', 'charlatan_con_item', 'choiceGroup', 2, 'marked_cards', 2, 'catalogRef', 'item', 'marked_cards', 1, NULL),
        ('Шарлатан', 'charlatan_con_item', 'choiceGroup', 2, 'fake_duke_signet_ring', 3, 'catalogRef', 'item', 'fake_duke_signet_ring', 1, NULL),
        ('Шарлатан', 'fixed:pouch', 'fixedLine', 3, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL),

        ('Артист', 'entertainer_musical_instrument', 'choiceGroup', 0, 'musicalInstrument', 0, 'itemCategory', 'tool', NULL, 1, 'musicalInstrument'),
        ('Артист', 'fixed:fan_gift', 'fixedLine', 1, NULL, NULL, 'catalogRef', 'item', 'fan_gift', 1, NULL),
        ('Артист', 'fixed:costume', 'fixedLine', 2, NULL, NULL, 'catalogRef', 'item', 'costume', 1, NULL),
        ('Артист', 'fixed:pouch', 'fixedLine', 3, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL),

        ('Моряк', 'fixed:silk_rope', 'fixedLine', 0, NULL, NULL, 'catalogRef', 'item', 'silk_rope', 1, NULL),
        ('Моряк', 'fixed:lucky_charm', 'fixedLine', 1, NULL, NULL, 'catalogRef', 'item', 'lucky_charm', 1, NULL),
        ('Моряк', 'fixed:common_clothes', 'fixedLine', 2, NULL, NULL, 'catalogRef', 'item', 'common_clothes', 1, NULL),
        ('Моряк', 'fixed:pouch', 'fixedLine', 3, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL),

        ('Солдат', 'fixed:insignia', 'fixedLine', 0, NULL, NULL, 'catalogRef', 'item', 'insignia', 1, NULL),
        ('Солдат', 'fixed:enemy_trophy', 'fixedLine', 1, NULL, NULL, 'catalogRef', 'item', 'enemy_trophy', 1, NULL),
        ('Солдат', 'soldier_gaming_set', 'choiceGroup', 2, 'gamingSet', 0, 'itemCategory', 'tool', NULL, 1, 'gamingSet'),
        ('Солдат', 'fixed:common_clothes', 'fixedLine', 3, NULL, NULL, 'catalogRef', 'item', 'common_clothes', 1, NULL),
        ('Солдат', 'fixed:pouch', 'fixedLine', 4, NULL, NULL, 'catalogRef', 'item', 'pouch', 1, NULL);

    SELECT count(*) INTO target_background_count
    FROM background_data
    WHERE name IN (
        'Послушник', 'Благородный', 'Беспризорник', 'Мудрец',
        'Народный герой', 'Отшельник', 'Пират', 'Преступник',
        'Гильдейский ремесленник', 'Чужеземец', 'Шарлатан', 'Артист',
        'Моряк', 'Солдат'
    );

    IF target_background_count = 0 THEN
        RAISE NOTICE 'No background reference data found; skipping Stage 6 equipment seed.';
    ELSE
        IF target_background_count <> 14 THEN
            RAISE EXCEPTION 'Expected all 14 Stage 6 backgrounds, found %', target_background_count;
        END IF;

        FOR missing_record IN
            SELECT names.name, count(b.id) AS row_count
            FROM (VALUES
                ('Послушник'), ('Благородный'), ('Беспризорник'), ('Мудрец'),
                ('Народный герой'), ('Отшельник'), ('Пират'), ('Преступник'),
                ('Гильдейский ремесленник'), ('Чужеземец'), ('Шарлатан'),
                ('Артист'), ('Моряк'), ('Солдат')
            ) AS names(name)
            LEFT JOIN background_data b ON b.name = names.name
            GROUP BY names.name
            HAVING count(b.id) <> 1
        LOOP
            RAISE EXCEPTION 'Expected exactly one BackgroundData named "%", found %', missing_record.name, missing_record.row_count;
        END LOOP;

        FOR missing_record IN
            SELECT DISTINCT plan.catalog_type, plan.reference_key
            FROM stage6_background_equipment_plan plan
            WHERE plan.line_kind = 'catalogRef'
              AND plan.reference_key IS NOT NULL
              AND CASE plan.catalog_type
                  WHEN 'item' THEN (SELECT count(*) FROM item_data WHERE "referenceKey" = plan.reference_key)
                  WHEN 'tool' THEN (SELECT count(*) FROM tool_data WHERE "referenceKey" = plan.reference_key)
                  WHEN 'weapon' THEN (SELECT count(*) FROM weapon_data WHERE "referenceKey" = plan.reference_key)
                  ELSE 0
              END <> 1
        LOOP
            RAISE EXCEPTION 'Expected exactly one canonical % referenceKey "%" in its catalog', missing_record.catalog_type, missing_record.reference_key;
        END LOOP;

        FOR missing_record IN
            SELECT categories.category_name
            FROM (VALUES ('artisan', 0), ('musicalInstrument', 1), ('gamingSet', 2))
                AS categories(category_name, enum_index)
            WHERE NOT EXISTS (
                SELECT 1 FROM tool_data WHERE category = categories.enum_index
            )
        LOOP
            RAISE EXCEPTION 'No ToolData exist for required ToolCategory "%"', missing_record.category_name;
        END LOOP;

        IF EXISTS (
            SELECT 1
            FROM starting_equipment_entry_data entry
            JOIN background_data background ON background.id = entry."sourceBackgroundId"
            WHERE background.name IN (
                'Послушник', 'Благородный', 'Беспризорник', 'Мудрец',
                'Народный герой', 'Отшельник', 'Пират', 'Преступник',
                'Гильдейский ремесленник', 'Чужеземец', 'Шарлатан', 'Артист',
                'Моряк', 'Солдат'
            )
        ) THEN
            RAISE EXCEPTION 'Stage 6 backgrounds already have starting equipment entries; refusing to duplicate or overwrite them.';
        END IF;

        INSERT INTO starting_equipment_entry_data (
            "sourceBackgroundId", "parentEntryId", "kind", "orderIndex",
            "selectionCount", "lineKind", "quantity", "catalogType",
            "referenceKey", "allowedItemCategories", "source", "version",
            "createdAt", "updatedAt"
        )
        SELECT
            background.id, NULL, 'fixedLine', plan.root_order,
            NULL, plan.line_kind, plan.quantity, plan.catalog_type,
            plan.reference_key,
            CASE WHEN plan.category IS NULL THEN NULL ELSE json_build_array(plan.category) END,
            'stage6-background-starting-equipment', 1, now(), now()
        FROM stage6_background_equipment_plan plan
        JOIN background_data background ON background.name = plan.background_name
        WHERE plan.root_kind = 'fixedLine';

        FOR root_row IN
            SELECT background.id AS background_id, plan.root_key, min(plan.root_order) AS root_order
            FROM stage6_background_equipment_plan plan
            JOIN background_data background ON background.name = plan.background_name
            WHERE plan.root_kind = 'choiceGroup'
            GROUP BY background.id, plan.root_key
        LOOP
            INSERT INTO starting_equipment_entry_data (
                "sourceBackgroundId", "parentEntryId", "kind", "orderIndex",
                "selectionCount", "referenceKey", "source", "version",
                "createdAt", "updatedAt"
            ) VALUES (
                root_row.background_id, NULL, 'choiceGroup', root_row.root_order,
                1, root_row.root_key, 'stage6-background-starting-equipment',
                1, now(), now()
            ) RETURNING id INTO group_id;

            FOR option_row IN
                SELECT DISTINCT plan.option_key, min(plan.option_order) AS option_order
                FROM stage6_background_equipment_plan plan
                JOIN background_data background ON background.name = plan.background_name
                WHERE background.id = root_row.background_id
                  AND plan.root_key = root_row.root_key
                  AND plan.option_key IS NOT NULL
                GROUP BY plan.option_key
                ORDER BY min(plan.option_order)
            LOOP
                INSERT INTO starting_equipment_entry_data (
                    "sourceBackgroundId", "parentEntryId", "kind", "orderIndex",
                    "referenceKey", "source", "version", "createdAt", "updatedAt"
                ) VALUES (
                    root_row.background_id, group_id, 'choiceOption', option_row.option_order,
                    option_row.option_key, 'stage6-background-starting-equipment',
                    1, now(), now()
                ) RETURNING id INTO option_id;

                FOR line_row IN
                    SELECT plan.line_kind, plan.catalog_type, plan.reference_key,
                           plan.quantity, plan.category
                    FROM stage6_background_equipment_plan plan
                    JOIN background_data background ON background.name = plan.background_name
                    WHERE background.id = root_row.background_id
                      AND plan.root_key = root_row.root_key
                      AND plan.option_key = option_row.option_key
                LOOP
                    INSERT INTO starting_equipment_entry_data (
                        "sourceBackgroundId", "parentEntryId", "kind", "orderIndex",
                        "lineKind", "quantity", "catalogType", "referenceKey",
                        "allowedItemCategories", "source", "version", "createdAt", "updatedAt"
                    ) VALUES (
                        root_row.background_id, option_id, 'optionLine', 0,
                        line_row.line_kind, line_row.quantity, line_row.catalog_type,
                        line_row.reference_key,
                        CASE WHEN line_row.category IS NULL THEN NULL ELSE json_build_array(line_row.category) END,
                        'stage6-background-starting-equipment', 1, now(), now()
                    );
                END LOOP;
            END LOOP;
        END LOOP;
    END IF;
END $$;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260927105833200-stage6-background-starting-equipment', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260927105833200-stage6-background-starting-equipment', "timestamp" = now();

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
