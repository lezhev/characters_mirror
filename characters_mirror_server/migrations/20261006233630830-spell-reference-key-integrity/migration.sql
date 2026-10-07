BEGIN;

-- Do not infer canonical keys or partially migrate a legacy/import catalog.
LOCK TABLE "spell_data" IN ACCESS EXCLUSIVE MODE;
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM "spell_data"
        WHERE "referenceKey" IS NULL OR btrim("referenceKey") = ''
    ) THEN
        RAISE EXCEPTION 'SpellData.referenceKey hardening requires non-null, non-empty canonical keys';
    END IF;
    IF EXISTS (
        SELECT 1 FROM "spell_data"
        GROUP BY "referenceKey" HAVING count(*) > 1
    ) THEN
        RAISE EXCEPTION 'SpellData.referenceKey hardening requires unique canonical keys';
    END IF;
END $$;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "spell_data" ALTER COLUMN "referenceKey" SET NOT NULL;
CREATE UNIQUE INDEX "spell_reference_key_idx" ON "spell_data" USING btree ("referenceKey");

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261006233630830-spell-reference-key-integrity', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006233630830-spell-reference-key-integrity', "timestamp" = now();

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
