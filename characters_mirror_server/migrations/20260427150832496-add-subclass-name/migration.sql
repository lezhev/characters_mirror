BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_data" ADD COLUMN IF NOT EXISTS "subclassName" text;

DO $$
DECLARE
    legacy_column text := 'subclass' || 'name';
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = 'public'
            AND table_name = 'subclass_data'
            AND column_name = legacy_column
    ) THEN
        EXECUTE format(
            'UPDATE "subclass_data" SET "subclassName" = %I WHERE "subclassName" IS NULL',
            legacy_column
        );
    END IF;
END $$;

UPDATE "spell_data"
SET "durationType" = NULL
WHERE trim(coalesce("durationType", '')) = '';

-- 
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260427150832496-add-subclass-name', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260427150832496-add-subclass-name', "timestamp" = now();

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
