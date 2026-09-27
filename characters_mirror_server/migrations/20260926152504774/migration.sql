BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "choice_group_data" (
    "id" bigserial PRIMARY KEY,
    "referenceKey" text NOT NULL,
    "name" text,
    "description" text,
    "sourceClassId" bigint,
    "sourceSubclassId" bigint,
    "sourceFeatureId" bigint,
    "sourceSubclassFeatureId" bigint,
    "sourceRaceId" bigint,
    "sourceSubraceId" bigint,
    "sourceRaceFeatureId" bigint,
    "sourceBackgroundId" bigint,
    "level" bigint,
    "type" text,
    "selectionCount" bigint,
    "appliesAtCharacterLevel" boolean,
    "exclusiveKey" text,
    "allowDuplicates" boolean,
    "sortOrder" bigint,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "choice_group_reference_key_idx" ON "choice_group_data" USING btree ("referenceKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "choice_option_data" (
    "id" bigserial PRIMARY KEY,
    "choiceGroupId" bigint NOT NULL,
    "optionKey" text NOT NULL,
    "name" text,
    "description" text,
    "sortOrder" bigint,
    "grantedAbilityBonuses" json,
    "grantedSkills" json,
    "grantedLanguages" json,
    "grantedArmorTraining" json,
    "grantedWeaponTraining" json,
    "grantedToolKeys" json,
    "grantedSpellKeys" json,
    "grantedFeatureTags" json,
    "damageType" text,
    "areaOfEffectType" text,
    "areaText" text,
    "damageByLevel" json,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "choice_option_group_key_idx" ON "choice_option_data" USING btree ("choiceGroupId", "optionKey");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "choice_group_data"
    ADD CONSTRAINT "choice_group_data_fk_0"
    FOREIGN KEY("sourceClassId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "choice_group_data"
    ADD CONSTRAINT "choice_group_data_fk_1"
    FOREIGN KEY("sourceSubclassId")
    REFERENCES "subclass_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "choice_group_data"
    ADD CONSTRAINT "choice_group_data_fk_2"
    FOREIGN KEY("sourceFeatureId")
    REFERENCES "class_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "choice_group_data"
    ADD CONSTRAINT "choice_group_data_fk_3"
    FOREIGN KEY("sourceSubclassFeatureId")
    REFERENCES "subclass_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "choice_group_data"
    ADD CONSTRAINT "choice_group_data_fk_4"
    FOREIGN KEY("sourceRaceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "choice_group_data"
    ADD CONSTRAINT "choice_group_data_fk_5"
    FOREIGN KEY("sourceSubraceId")
    REFERENCES "subrace_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "choice_group_data"
    ADD CONSTRAINT "choice_group_data_fk_6"
    FOREIGN KEY("sourceRaceFeatureId")
    REFERENCES "race_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "choice_group_data"
    ADD CONSTRAINT "choice_group_data_fk_7"
    FOREIGN KEY("sourceBackgroundId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "choice_option_data"
    ADD CONSTRAINT "choice_option_data_fk_0"
    FOREIGN KEY("choiceGroupId")
    REFERENCES "choice_group_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260926152504774', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260926152504774', "timestamp" = now();

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
