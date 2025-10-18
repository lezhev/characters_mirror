BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "character" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "name" text NOT NULL
);


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251016030016195', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251016030016195', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR _repair
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('_repair', '20251016030606009', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251016030606009', "timestamp" = now();


COMMIT;
