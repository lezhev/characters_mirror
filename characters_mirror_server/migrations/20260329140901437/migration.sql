BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "spell_data" DROP COLUMN "schoolValue";
ALTER TABLE "spell_data" DROP COLUMN "savingThrowAbility";
ALTER TABLE "spell_data" DROP COLUMN "attackType";
ALTER TABLE "spell_data" DROP COLUMN "damageType";
ALTER TABLE "spell_data" DROP COLUMN "targetType";
ALTER TABLE "spell_data" DROP COLUMN "areaOfEffectType";
ALTER TABLE "spell_data" DROP COLUMN "durationType";
ALTER TABLE "spell_data" ADD COLUMN "schoolValue" text;
ALTER TABLE "spell_data" ADD COLUMN "savingThrowAbility" text;
ALTER TABLE "spell_data" ADD COLUMN "attackType" text;
ALTER TABLE "spell_data" ADD COLUMN "damageType" text;
ALTER TABLE "spell_data" ADD COLUMN "targetType" text;
ALTER TABLE "spell_data" ADD COLUMN "areaOfEffectType" text;
ALTER TABLE "spell_data" ADD COLUMN "durationType" text;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260329140901437', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260329140901437', "timestamp" = now();

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
