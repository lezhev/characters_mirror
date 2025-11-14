BEGIN;

--
-- Class ArmorData as table armor_data
--
CREATE TABLE "armor_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "category" text,
    "baseAC" bigint,
    "dexBonus" boolean,
    "dexBonusMax" bigint,
    "strengthRequirement" bigint,
    "stealthDisadvantage" boolean,
    "weight" double precision,
    "cost" text
);

--
-- Class BackgroundData as table background_data
--
CREATE TABLE "background_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "skillProficiencies" json,
    "suggestedSkillProficiencies" json,
    "skillProficiencieCount" bigint,
    "toolProficiencies" json,
    "suggestedToolProficiencies" json,
    "toolProficiencieCount" bigint,
    "languages" json,
    "suggestedLanguages" json,
    "languageCount" bigint,
    "items" json,
    "coins" double precision,
    "feature" text,
    "suggestedPersonality" json,
    "suggestedIdeal" json,
    "suggestedBond" json,
    "suggestedFlaw" json
);

--
-- Class CharacterData as table characters
--
CREATE TABLE "characters" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "experience" bigint,
    "attributes" json,
    "raceId" bigint NOT NULL,
    "subraceId" bigint NOT NULL,
    "backgroundId" bigint NOT NULL,
    "alignment" text,
    "armorClass" bigint,
    "speed" bigint,
    "coins" bigint,
    "skillProficiencies" json,
    "skillExpertises" json,
    "maxHp" bigint,
    "temporaryHp" bigint,
    "currentHp" bigint,
    "preparedSpellsId" bigint NOT NULL,
    "writtenSpellsId" bigint NOT NULL,
    "itemsId" bigint NOT NULL,
    "magicItemsId" bigint NOT NULL,
    "armorId" bigint NOT NULL,
    "weaponsId" bigint NOT NULL
);

--
-- Class ClassData as table class_data
--
CREATE TABLE "class_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "hitDie" text,
    "savingThrows" json,
    "proficienciesArmor" json,
    "skills" json,
    "skillCount" bigint,
    "spellcasting" boolean,
    "spellcastingAbility" text,
    "_charactersClassesCharactersId" bigint
);

--
-- Class ClassFeatureData as table class_feature_data
--
CREATE TABLE "class_feature_data" (
    "id" bigserial PRIMARY KEY,
    "parentClassId" bigint NOT NULL,
    "name" text,
    "level" bigint NOT NULL,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "abilityBonuses" json,
    "proficiencies" json,
    "specialAbilities" json,
    "variantOptions" json,
    "resourceName" text,
    "resourceAmount" bigint,
    "resourceRegain" text,
    "spellSlots" json,
    "_charactersClassfeaturesCharactersId" bigint
);

--
-- Class ClassOptionData as table class_option_data
--
CREATE TABLE "class_option_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "prerequisites" json,
    "levelRequired" bigint
);

--
-- Class ClassOptionRelation as table class_option_relation
--
CREATE TABLE "class_option_relation" (
    "id" bigserial PRIMARY KEY,
    "optionId" bigint NOT NULL,
    "classDataId" bigint NOT NULL
);

--
-- Class FeatData as table feat_data
--
CREATE TABLE "feat_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "abilityBonuses" json,
    "traits" json,
    "specialAbilities" json,
    "proficiencies" json,
    "prerequisites" json
);

--
-- Class ItemData as table item_data
--
CREATE TABLE "item_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "category" text,
    "weight" double precision,
    "cost" bigint,
    "effects" json,
    "_classDataProficienciestoolsClassDataId" bigint,
    "_classDataStartingequipmentClassDataId" bigint
);

--
-- Class MagicItemData as table magic_item_data
--
CREATE TABLE "magic_item_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "rarity" text,
    "type" text,
    "requiresAttunement" boolean,
    "attunementCondition" text,
    "bonus" json,
    "charges" bigint,
    "rechargeCondition" text,
    "effects" json
);

--
-- Class RaceData as table race_data
--
CREATE TABLE "race_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "speed" bigint,
    "size" text,
    "abilityBonuses" json,
    "traits" json,
    "languages" json,
    "visionType" text,
    "swimSpeed" bigint,
    "climbSpeed" bigint,
    "flySpeed" bigint,
    "resistances" json,
    "skillProficiencies" json,
    "armorProficiencies" json,
    "weaponProficiencies" json,
    "toolProficiencies" json,
    "powerfulBuild" boolean,
    "specialAbilities" json,
    "ageDescription" text,
    "alignmentDescription" text,
    "physicalDescription" text
);

--
-- Class SpellData as table spell_data
--
CREATE TABLE "spell_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "level" bigint,
    "school" text,
    "castingTime" text,
    "range" text,
    "duration" text,
    "components" json,
    "concentration" boolean,
    "ritual" boolean,
    "higherLevel" text,
    "availableForClasses" json
);

--
-- Class SubclassData as table subclass_data
--
CREATE TABLE "subclass_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "parentClassId" bigint NOT NULL,
    "subclassFeatures" json,
    "levelRequired" bigint,
    "_charactersSubclassesCharactersId" bigint
);

--
-- Class SubraceData as table subrace_data
--
CREATE TABLE "subrace_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "parentRaceId" bigint NOT NULL,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "abilityBonuses" json,
    "traits" json,
    "specialAbilities" json,
    "skillProficiencies" json,
    "speedBonus" bigint,
    "swimSpeed" bigint,
    "climbSpeed" bigint,
    "flySpeed" bigint,
    "visionType" text,
    "resistances" json,
    "variantOptions" json,
    "ageDescription" text,
    "alignmentDescription" text,
    "physicalDescription" text
);

--
-- Class WeaponData as table weapon_data
--
CREATE TABLE "weapon_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "isSimple" boolean,
    "isMelee" boolean,
    "damage" text,
    "damageType" text,
    "properties" json,
    "weight" double precision,
    "cost" double precision,
    "rangeNormal" bigint,
    "rangeMax" bigint,
    "_classDataProficienciesweaponsClassDataId" bigint
);

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AuthKey as table serverpod_auth_key
--
CREATE TABLE "serverpod_auth_key" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "hash" text NOT NULL,
    "scopeNames" json NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_auth_key_userId_idx" ON "serverpod_auth_key" USING btree ("userId");

--
-- Class EmailAuth as table serverpod_email_auth
--
CREATE TABLE "serverpod_email_auth" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_email" ON "serverpod_email_auth" USING btree ("email");

--
-- Class EmailCreateAccountRequest as table serverpod_email_create_request
--
CREATE TABLE "serverpod_email_create_request" (
    "id" bigserial PRIMARY KEY,
    "userName" text NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL,
    "verificationCode" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_create_account_request_idx" ON "serverpod_email_create_request" USING btree ("email");

--
-- Class EmailFailedSignIn as table serverpod_email_failed_sign_in
--
CREATE TABLE "serverpod_email_failed_sign_in" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "ipAddress" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_email_failed_sign_in_email_idx" ON "serverpod_email_failed_sign_in" USING btree ("email");
CREATE INDEX "serverpod_email_failed_sign_in_time_idx" ON "serverpod_email_failed_sign_in" USING btree ("time");

--
-- Class EmailReset as table serverpod_email_reset
--
CREATE TABLE "serverpod_email_reset" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "verificationCode" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_reset_verification_idx" ON "serverpod_email_reset" USING btree ("verificationCode");

--
-- Class GoogleRefreshToken as table serverpod_google_refresh_token
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- Class UserImage as table serverpod_user_image
--
CREATE TABLE "serverpod_user_image" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "url" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_user_image_user_id" ON "serverpod_user_image" USING btree ("userId", "version");

--
-- Class UserInfo as table serverpod_user_info
--
CREATE TABLE "serverpod_user_info" (
    "id" bigserial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "created" timestamp without time zone NOT NULL,
    "imageUrl" text,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_user_info_user_identifier" ON "serverpod_user_info" USING btree ("userIdentifier");
CREATE INDEX "serverpod_user_info_email" ON "serverpod_user_info" USING btree ("email");

--
-- Foreign relations for "characters" table
--
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_0"
    FOREIGN KEY("raceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_1"
    FOREIGN KEY("subraceId")
    REFERENCES "subrace_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_2"
    FOREIGN KEY("backgroundId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_3"
    FOREIGN KEY("preparedSpellsId")
    REFERENCES "spell_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_4"
    FOREIGN KEY("writtenSpellsId")
    REFERENCES "spell_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_5"
    FOREIGN KEY("itemsId")
    REFERENCES "item_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_6"
    FOREIGN KEY("magicItemsId")
    REFERENCES "magic_item_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_7"
    FOREIGN KEY("armorId")
    REFERENCES "armor_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_8"
    FOREIGN KEY("weaponsId")
    REFERENCES "weapon_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "class_data" table
--
ALTER TABLE ONLY "class_data"
    ADD CONSTRAINT "class_data_fk_0"
    FOREIGN KEY("_charactersClassesCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "class_feature_data" table
--
ALTER TABLE ONLY "class_feature_data"
    ADD CONSTRAINT "class_feature_data_fk_0"
    FOREIGN KEY("parentClassId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_feature_data"
    ADD CONSTRAINT "class_feature_data_fk_1"
    FOREIGN KEY("_charactersClassfeaturesCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "class_option_relation" table
--
ALTER TABLE ONLY "class_option_relation"
    ADD CONSTRAINT "class_option_relation_fk_0"
    FOREIGN KEY("optionId")
    REFERENCES "class_option_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_option_relation"
    ADD CONSTRAINT "class_option_relation_fk_1"
    FOREIGN KEY("classDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "item_data" table
--
ALTER TABLE ONLY "item_data"
    ADD CONSTRAINT "item_data_fk_0"
    FOREIGN KEY("_classDataProficienciestoolsClassDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "item_data"
    ADD CONSTRAINT "item_data_fk_1"
    FOREIGN KEY("_classDataStartingequipmentClassDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "subclass_data" table
--
ALTER TABLE ONLY "subclass_data"
    ADD CONSTRAINT "subclass_data_fk_0"
    FOREIGN KEY("parentClassId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "subclass_data"
    ADD CONSTRAINT "subclass_data_fk_1"
    FOREIGN KEY("_charactersSubclassesCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "subrace_data" table
--
ALTER TABLE ONLY "subrace_data"
    ADD CONSTRAINT "subrace_data_fk_0"
    FOREIGN KEY("parentRaceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "weapon_data" table
--
ALTER TABLE ONLY "weapon_data"
    ADD CONSTRAINT "weapon_data_fk_0"
    FOREIGN KEY("_classDataProficienciesweaponsClassDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251104153251038', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251104153251038', "timestamp" = now();

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
