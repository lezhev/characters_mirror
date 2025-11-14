BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "background_data" DROP COLUMN "suggestedPersonality";
ALTER TABLE "background_data" DROP COLUMN "suggestedIdeal";
ALTER TABLE "background_data" DROP COLUMN "suggestedBond";
ALTER TABLE "background_data" DROP COLUMN "suggestedFlaw";
ALTER TABLE "background_data" ADD COLUMN "suggestedSkillProficiencies" json;
ALTER TABLE "background_data" ADD COLUMN "skillProficiencieCount" bigint;
ALTER TABLE "background_data" ADD COLUMN "suggestedToolProficiencies" json;
ALTER TABLE "background_data" ADD COLUMN "toolProficiencieCount" bigint;
ALTER TABLE "background_data" ADD COLUMN "languages" json;
ALTER TABLE "background_data" ADD COLUMN "suggestedLanguages" json;
ALTER TABLE "background_data" ADD COLUMN "languageCount" bigint;
ALTER TABLE "background_data" ADD COLUMN "items" json;
ALTER TABLE "background_data" ADD COLUMN "coins" double precision;
ALTER TABLE "background_data" ADD COLUMN "suggestedPersonality" json;
ALTER TABLE "background_data" ADD COLUMN "suggestedIdeal" json;
ALTER TABLE "background_data" ADD COLUMN "suggestedBond" json;
ALTER TABLE "background_data" ADD COLUMN "suggestedFlaw" json;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251102080829221', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251102080829221', "timestamp" = now();

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
