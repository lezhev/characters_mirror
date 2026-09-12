BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "character_applied_changes" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "changeId" text NOT NULL,
    "characterId" bigint,
    "revision" bigint,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "character_applied_changes_user_change_idx" ON "character_applied_changes" USING btree ("userId", "changeId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" ADD COLUMN "syncTargetRevisions" json;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260911102859360', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260911102859360', "timestamp" = now();

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
