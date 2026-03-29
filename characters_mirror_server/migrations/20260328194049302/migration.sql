BEGIN;

--
-- ACTION ALTER TABLE
--
CREATE UNIQUE INDEX "spell_class_availability_unique_idx" ON "spell_class_availability_data" USING btree ("spellId", "classDataId");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "spell_data" DROP COLUMN "areaOfEffect";
ALTER TABLE "spell_data" ADD COLUMN "areaOfEffectType" bigint;
ALTER TABLE "spell_data" ADD COLUMN "areaOfEffectSize" bigint;
ALTER TABLE "spell_data" ADD COLUMN "areaOfEffectSecondarySize" bigint;
ALTER TABLE "spell_data" ADD COLUMN "areaOfEffectHeight" bigint;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260328194049302', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260328194049302', "timestamp" = now();

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
