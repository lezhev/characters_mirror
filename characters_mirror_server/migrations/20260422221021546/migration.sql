BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters"
    ALTER COLUMN "notes" TYPE json
    USING CASE
        WHEN "notes" IS NULL OR btrim("notes") = '' THEN NULL
        ELSE json_build_array("notes")
    END;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260422221021546', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260422221021546', "timestamp" = now();

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
