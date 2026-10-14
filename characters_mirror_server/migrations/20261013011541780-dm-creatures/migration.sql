BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dm_creatures" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "name" text NOT NULL,
    "sourceType" text NOT NULL,
    "sourceVersion" text,
    "challengeRating" text,
    "rawJson" text NOT NULL,
    "normalizedJson" text NOT NULL,
    "importHash" text NOT NULL,
    "schemaVersion" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "dm_creatures_user_idx" ON "dm_creatures" USING btree ("userId");
CREATE UNIQUE INDEX "dm_creatures_user_hash_idx" ON "dm_creatures" USING btree ("userId", "importHash");


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261013011541780-dm-creatures', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261013011541780-dm-creatures', "timestamp" = now();

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
