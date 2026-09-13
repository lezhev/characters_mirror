BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "character_sync_events" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "characterId" bigint NOT NULL,
    "characterVersion" bigint,
    "eventType" text NOT NULL,
    "changeId" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "character_sync_events_user_id_idx" ON "character_sync_events" USING btree ("userId", "id");
CREATE INDEX "character_sync_events_character_id_idx" ON "character_sync_events" USING btree ("userId", "characterId");


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260912222027108', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260912222027108', "timestamp" = now();

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
