BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" ADD COLUMN "resourceStates" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_feature_data" ADD COLUMN "resourceResetOn" text;
ALTER TABLE "class_feature_data" ADD COLUMN "resourceMaxRule" text;
ALTER TABLE "class_feature_data" ADD COLUMN "resourceMaxValue" bigint;
ALTER TABLE "class_feature_data" ADD COLUMN "resourceMaxAbility" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "feature_resource_level_data" (
    "id" bigserial PRIMARY KEY,
    "classFeatureId" bigint,
    "subclassFeatureId" bigint,
    "raceFeatureId" bigint,
    "level" bigint NOT NULL,
    "value" bigint NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_feature_data" ADD COLUMN "resourceResetOn" text;
ALTER TABLE "race_feature_data" ADD COLUMN "resourceMaxRule" text;
ALTER TABLE "race_feature_data" ADD COLUMN "resourceMaxValue" bigint;
ALTER TABLE "race_feature_data" ADD COLUMN "resourceMaxAbility" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_feature_data" ADD COLUMN "resourceResetOn" text;
ALTER TABLE "subclass_feature_data" ADD COLUMN "resourceMaxRule" text;
ALTER TABLE "subclass_feature_data" ADD COLUMN "resourceMaxValue" bigint;
ALTER TABLE "subclass_feature_data" ADD COLUMN "resourceMaxAbility" text;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "feature_resource_level_data"
    ADD CONSTRAINT "feature_resource_level_data_fk_0"
    FOREIGN KEY("classFeatureId")
    REFERENCES "class_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "feature_resource_level_data"
    ADD CONSTRAINT "feature_resource_level_data_fk_1"
    FOREIGN KEY("subclassFeatureId")
    REFERENCES "subclass_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "feature_resource_level_data"
    ADD CONSTRAINT "feature_resource_level_data_fk_2"
    FOREIGN KEY("raceFeatureId")
    REFERENCES "race_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260515152543813', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260515152543813', "timestamp" = now();

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
