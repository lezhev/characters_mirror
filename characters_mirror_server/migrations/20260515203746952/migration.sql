BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "feature_resource_level_data" CASCADE;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_feature_data" DROP COLUMN "resourceResetOn";
ALTER TABLE "class_feature_data" DROP COLUMN "resourceMaxRule";
ALTER TABLE "class_feature_data" DROP COLUMN "resourceMaxValue";
ALTER TABLE "class_feature_data" DROP COLUMN "resourceMaxAbility";
--
-- ACTION CREATE TABLE
--
CREATE TABLE "feature_resource_definition_data" (
    "id" bigserial PRIMARY KEY,
    "classFeatureId" bigint,
    "subclassFeatureId" bigint,
    "raceFeatureId" bigint,
    "key" text NOT NULL,
    "name" text,
    "kind" text NOT NULL,
    "maxRule" text NOT NULL,
    "maxValue" bigint,
    "maxAbility" text,
    "resetOn" text,
    "activationTrigger" text,
    "usageResetOn" text,
    "progressionKey" text,
    "becomesUnlimitedAtLevel" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "feature_resource_effect_data" (
    "id" bigserial PRIMARY KEY,
    "classFeatureId" bigint,
    "subclassFeatureId" bigint,
    "raceFeatureId" bigint,
    "type" text NOT NULL,
    "targetType" text,
    "targetResourceKey" text,
    "targetSourceType" text,
    "targetSourceId" bigint,
    "amountRule" text,
    "amountValue" bigint,
    "amountAbility" text,
    "activationTrigger" text,
    "usageResetOn" text,
    "setResetOn" text,
    "setMaxRule" text,
    "setMaxValue" bigint,
    "setMaxAbility" text,
    "addMaxValue" bigint,
    "setUnlimited" boolean,
    "becomesUnlimitedAtLevel" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "feature_resource_progression_value_data" (
    "id" bigserial PRIMARY KEY,
    "resourceDefinitionId" bigint,
    "level" bigint NOT NULL,
    "value" bigint NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_feature_data" DROP COLUMN "resourceResetOn";
ALTER TABLE "race_feature_data" DROP COLUMN "resourceMaxRule";
ALTER TABLE "race_feature_data" DROP COLUMN "resourceMaxValue";
ALTER TABLE "race_feature_data" DROP COLUMN "resourceMaxAbility";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_feature_data" DROP COLUMN "resourceResetOn";
ALTER TABLE "subclass_feature_data" DROP COLUMN "resourceMaxRule";
ALTER TABLE "subclass_feature_data" DROP COLUMN "resourceMaxValue";
ALTER TABLE "subclass_feature_data" DROP COLUMN "resourceMaxAbility";
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "feature_resource_definition_data"
    ADD CONSTRAINT "feature_resource_definition_data_fk_0"
    FOREIGN KEY("classFeatureId")
    REFERENCES "class_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "feature_resource_definition_data"
    ADD CONSTRAINT "feature_resource_definition_data_fk_1"
    FOREIGN KEY("subclassFeatureId")
    REFERENCES "subclass_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "feature_resource_definition_data"
    ADD CONSTRAINT "feature_resource_definition_data_fk_2"
    FOREIGN KEY("raceFeatureId")
    REFERENCES "race_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "feature_resource_effect_data"
    ADD CONSTRAINT "feature_resource_effect_data_fk_0"
    FOREIGN KEY("classFeatureId")
    REFERENCES "class_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "feature_resource_effect_data"
    ADD CONSTRAINT "feature_resource_effect_data_fk_1"
    FOREIGN KEY("subclassFeatureId")
    REFERENCES "subclass_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "feature_resource_effect_data"
    ADD CONSTRAINT "feature_resource_effect_data_fk_2"
    FOREIGN KEY("raceFeatureId")
    REFERENCES "race_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "feature_resource_progression_value_data"
    ADD CONSTRAINT "feature_resource_progression_value_data_fk_0"
    FOREIGN KEY("resourceDefinitionId")
    REFERENCES "feature_resource_definition_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260515203746952', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260515203746952', "timestamp" = now();

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
