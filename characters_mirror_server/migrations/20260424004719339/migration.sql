BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_choice_data" ADD COLUMN "syncId" text;
ALTER TABLE "character_choice_data" ADD COLUMN "updatedAt" timestamp without time zone;
UPDATE "character_choice_data"
SET
    "syncId" = COALESCE(
        "syncId",
        substr(md5(random()::text || clock_timestamp()::text), 1, 8) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 12)
    ),
    "updatedAt" = COALESCE(
        "updatedAt",
        (SELECT c."updatedAt" FROM "characters" c WHERE c."id" = "character_choice_data"."characterId"),
        now()
    );
--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_class_relation" ADD COLUMN "syncId" text;
ALTER TABLE "character_class_relation" ADD COLUMN "updatedAt" timestamp without time zone;
UPDATE "character_class_relation"
SET
    "syncId" = COALESCE(
        "syncId",
        substr(md5(random()::text || clock_timestamp()::text), 1, 8) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 12)
    ),
    "updatedAt" = COALESCE(
        "updatedAt",
        (SELECT c."updatedAt" FROM "characters" c WHERE c."id" = "character_class_relation"."characterId"),
        now()
    );
--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_starting_equipment_resolution_data" ADD COLUMN "syncId" text;
ALTER TABLE "character_starting_equipment_resolution_data" ADD COLUMN "updatedAt" timestamp without time zone;
UPDATE "character_starting_equipment_resolution_data"
SET
    "syncId" = COALESCE(
        "syncId",
        substr(md5(random()::text || clock_timestamp()::text), 1, 8) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 12)
    ),
    "updatedAt" = COALESCE(
        "updatedAt",
        (
            SELECT c."updatedAt"
            FROM "character_starting_equipment_selection_data" s
            JOIN "characters" c ON c."id" = s."characterId"
            WHERE s."id" = "character_starting_equipment_resolution_data"."selectionId"
        ),
        now()
    );
--
-- ACTION ALTER TABLE
--
ALTER TABLE "character_starting_equipment_selection_data" ADD COLUMN "syncId" text;
ALTER TABLE "character_starting_equipment_selection_data" ADD COLUMN "updatedAt" timestamp without time zone;
UPDATE "character_starting_equipment_selection_data"
SET
    "syncId" = COALESCE(
        "syncId",
        substr(md5(random()::text || clock_timestamp()::text), 1, 8) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
        substr(md5(random()::text || clock_timestamp()::text), 1, 12)
    ),
    "updatedAt" = COALESCE(
        "updatedAt",
        (SELECT c."updatedAt" FROM "characters" c WHERE c."id" = "character_starting_equipment_selection_data"."characterId"),
        now()
    );
--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" RENAME COLUMN "equipment" TO "equipment_legacy_text";
ALTER TABLE "characters" RENAME COLUMN "notes" TO "notes_legacy_json";
ALTER TABLE "characters" ADD COLUMN "equipment" json;
ALTER TABLE "characters" ADD COLUMN "notes" json;

UPDATE "characters"
SET "equipment" = CASE
    WHEN "equipment_legacy_text" IS NULL OR btrim("equipment_legacy_text") = '' THEN NULL
    ELSE json_build_array(
        json_build_object(
            'id',
            substr(md5(random()::text || clock_timestamp()::text), 1, 8) || '-' ||
            substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
            substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
            substr(md5(random()::text || clock_timestamp()::text), 1, 4) || '-' ||
            substr(md5(random()::text || clock_timestamp()::text), 1, 12),
            'name', "equipment_legacy_text",
            'quantity', 1,
            'type', 4,
            'updatedAt', "updatedAt"
        )
    )
END;

UPDATE "characters"
SET "notes" = CASE
    WHEN "notes_legacy_json" IS NULL THEN NULL
    ELSE (
        SELECT CASE
            WHEN COUNT(*) = 0 THEN NULL
            ELSE json_agg(
                json_build_object(
                    'id',
                    substr(md5(random()::text || clock_timestamp()::text || value), 1, 8) || '-' ||
                    substr(md5(random()::text || clock_timestamp()::text || value), 1, 4) || '-' ||
                    substr(md5(random()::text || clock_timestamp()::text || value), 1, 4) || '-' ||
                    substr(md5(random()::text || clock_timestamp()::text || value), 1, 4) || '-' ||
                    substr(md5(random()::text || clock_timestamp()::text || value), 1, 12),
                    'text', value,
                    'updatedAt', "characters"."updatedAt"
                )
            )
        END
        FROM json_array_elements_text("notes_legacy_json") AS note(value)
    )
END;

UPDATE "characters"
SET "attacks" = (
    SELECT CASE
        WHEN COUNT(*) = 0 THEN NULL
        ELSE json_agg(
            jsonb_build_object(
                'id',
                COALESCE(value::jsonb->>'id',
                    substr(md5(random()::text || clock_timestamp()::text || value::text), 1, 8) || '-' ||
                    substr(md5(random()::text || clock_timestamp()::text || value::text), 1, 4) || '-' ||
                    substr(md5(random()::text || clock_timestamp()::text || value::text), 1, 4) || '-' ||
                    substr(md5(random()::text || clock_timestamp()::text || value::text), 1, 4) || '-' ||
                    substr(md5(random()::text || clock_timestamp()::text || value::text), 1, 12)
                ),
                'updatedAt',
                COALESCE(value::jsonb->>'updatedAt', "characters"."updatedAt"::text)
            ) || (value::jsonb - 'id' - 'updatedAt')
        )
    END
    FROM json_array_elements(COALESCE("attacks", '[]'::json)) AS attack(value)
)
WHERE "attacks" IS NOT NULL;

UPDATE "characters"
SET "featureOverrides" = (
    SELECT CASE
        WHEN COUNT(*) = 0 THEN NULL
        ELSE json_agg(
            jsonb_build_object(
                'id',
                COALESCE(value::jsonb->>'id',
                    substr(md5(random()::text || clock_timestamp()::text || value::text), 1, 8) || '-' ||
                    substr(md5(random()::text || clock_timestamp()::text || value::text), 1, 4) || '-' ||
                    substr(md5(random()::text || clock_timestamp()::text || value::text), 1, 4) || '-' ||
                    substr(md5(random()::text || clock_timestamp()::text || value::text), 1, 4) || '-' ||
                    substr(md5(random()::text || clock_timestamp()::text || value::text), 1, 12)
                ),
                'updatedAt',
                COALESCE(value::jsonb->>'updatedAt', "characters"."updatedAt"::text)
            ) || (value::jsonb - 'id' - 'updatedAt')
        )
    END
    FROM json_array_elements(COALESCE("featureOverrides", '[]'::json)) AS feature(value)
)
WHERE "featureOverrides" IS NOT NULL;

ALTER TABLE "characters" DROP COLUMN "equipment_legacy_text";
ALTER TABLE "characters" DROP COLUMN "notes_legacy_json";

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260424004719339', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260424004719339', "timestamp" = now();

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
