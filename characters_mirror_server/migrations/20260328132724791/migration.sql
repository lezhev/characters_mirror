BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_choice_set_data" ADD COLUMN "_raceDataChoicesetsRaceDataId" bigint;
ALTER TABLE "race_choice_set_data" ADD COLUMN "_raceFeatureDataChoicesetsRaceFeatureDataId" bigint;
ALTER TABLE "race_choice_set_data" ADD COLUMN "_subraceDataChoicesetsSubraceDataId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_feature_spell_grant_data" ADD COLUMN "_raceFeatureDataSpellgrantsRaceFeatureDataId" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "spell_class_availability_data" (
    "id" bigserial PRIMARY KEY,
    "spellId" bigint NOT NULL,
    "classDataId" bigint NOT NULL,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "_spellDataClassavailabilitySpellDataId" bigint
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "spell_data" DROP COLUMN "components";
ALTER TABLE "spell_data" DROP COLUMN "availableForClassIds";
ALTER TABLE "spell_data" ADD COLUMN "savingThrowAbility" bigint;
ALTER TABLE "spell_data" ADD COLUMN "requiresSavingThrow" boolean;
ALTER TABLE "spell_data" ADD COLUMN "attackType" bigint;
ALTER TABLE "spell_data" ADD COLUMN "requiresAttackRoll" boolean;
ALTER TABLE "spell_data" ADD COLUMN "damageType" bigint;
ALTER TABLE "spell_data" ADD COLUMN "damageDice" text;
ALTER TABLE "spell_data" ADD COLUMN "damageScaling" json;
ALTER TABLE "spell_data" ADD COLUMN "conditions" json;
ALTER TABLE "spell_data" ADD COLUMN "targetType" bigint;
ALTER TABLE "spell_data" ADD COLUMN "areaOfEffect" json;
ALTER TABLE "spell_data" ADD COLUMN "materialDescription" text;
ALTER TABLE "spell_data" ADD COLUMN "materialCost" bigint;
ALTER TABLE "spell_data" ADD COLUMN "materialConsumed" boolean;
ALTER TABLE "spell_data" ADD COLUMN "durationType" bigint;
ALTER TABLE "spell_data" ADD COLUMN "isHealing" boolean;
ALTER TABLE "spell_data" ADD COLUMN "healingDice" text;
ALTER TABLE "spell_data" ADD COLUMN "requiresLineOfSight" boolean;
ALTER TABLE "spell_data" ADD COLUMN "requiresVerbal" boolean;
ALTER TABLE "spell_data" ADD COLUMN "requiresSomatic" boolean;
ALTER TABLE "spell_data" ADD COLUMN "requiresMaterial" boolean;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "race_choice_set_data"
    ADD CONSTRAINT "race_choice_set_data_fk_3"
    FOREIGN KEY("_raceDataChoicesetsRaceDataId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "race_choice_set_data"
    ADD CONSTRAINT "race_choice_set_data_fk_4"
    FOREIGN KEY("_raceFeatureDataChoicesetsRaceFeatureDataId")
    REFERENCES "race_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "race_choice_set_data"
    ADD CONSTRAINT "race_choice_set_data_fk_5"
    FOREIGN KEY("_subraceDataChoicesetsSubraceDataId")
    REFERENCES "subrace_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "race_feature_spell_grant_data"
    ADD CONSTRAINT "race_feature_spell_grant_data_fk_2"
    FOREIGN KEY("_raceFeatureDataSpellgrantsRaceFeatureDataId")
    REFERENCES "race_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "spell_class_availability_data"
    ADD CONSTRAINT "spell_class_availability_data_fk_0"
    FOREIGN KEY("spellId")
    REFERENCES "spell_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "spell_class_availability_data"
    ADD CONSTRAINT "spell_class_availability_data_fk_1"
    FOREIGN KEY("classDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "spell_class_availability_data"
    ADD CONSTRAINT "spell_class_availability_data_fk_2"
    FOREIGN KEY("_spellDataClassavailabilitySpellDataId")
    REFERENCES "spell_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260328132724791', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260328132724791', "timestamp" = now();

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
