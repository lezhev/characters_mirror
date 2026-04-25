BEGIN;

--
-- Class ArmorData as table armor_data
--
CREATE TABLE "armor_data" (
    "id" bigserial PRIMARY KEY,
    "referenceKey" text,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "categoryValue" text,
    "baseAC" bigint,
    "dexBonus" boolean,
    "dexBonusMax" bigint,
    "strengthRequirement" bigint,
    "stealthDisadvantage" boolean,
    "weight" double precision,
    "cost" text
);

-- Indexes
CREATE UNIQUE INDEX "armor_reference_key_idx" ON "armor_data" USING btree ("referenceKey");

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
    "toolProficiencies" json,
    "languages" json,
    "items" json,
    "coins" double precision,
    "feature" text,
    "suggestedPersonality" json,
    "suggestedIdeal" json,
    "suggestedBond" json,
    "suggestedFlaw" json
);

--
-- Class CharacterChoiceRecord as table character_choice_data
--
CREATE TABLE "character_choice_data" (
    "id" bigserial PRIMARY KEY,
    "characterId" bigint NOT NULL,
    "classEntryId" bigint,
    "sourceType" text,
    "sourceId" bigint,
    "groupKey" text,
    "optionKey" text,
    "selectionIndex" bigint,
    "selectedAbility" text,
    "selectedLanguage" text,
    "selectedToolKey" text,
    "selectedSpellKey" text,
    "selectedFeatId" bigint,
    "selectedText" text,
    "selectedCount" bigint
);

--
-- Class CharacterClassEntryRecord as table character_class_relation
--
CREATE TABLE "character_class_relation" (
    "id" bigserial PRIMARY KEY,
    "characterId" bigint NOT NULL,
    "classDataId" bigint NOT NULL,
    "subclassId" bigint,
    "level" bigint NOT NULL,
    "isStartingClass" boolean,
    "classOrder" bigint,
    "hpMode" text,
    "hpRolledValues" json,
    "notes" text
);

--
-- Class CharacterStartingEquipmentResolutionRecord as table character_starting_equipment_resolution_data
--
CREATE TABLE "character_starting_equipment_resolution_data" (
    "id" bigserial PRIMARY KEY,
    "selectionId" bigint NOT NULL,
    "lineKey" text,
    "catalogType" text,
    "referenceKey" text,
    "quantity" bigint
);

--
-- Class CharacterStartingEquipmentSelectionRecord as table character_starting_equipment_selection_data
--
CREATE TABLE "character_starting_equipment_selection_data" (
    "id" bigserial PRIMARY KEY,
    "characterId" bigint NOT NULL,
    "sourceType" text,
    "sourceId" bigint,
    "blockKey" text,
    "optionKey" text,
    "selectionIndex" bigint
);

--
-- Class CharacterRecord as table characters
--
CREATE TABLE "characters" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "age" text,
    "height" text,
    "weight" text,
    "eyes" text,
    "skin" text,
    "hair" text,
    "appearance" text,
    "backstory" text,
    "goals" text,
    "alliesOrganizations" text,
    "personalityTraits" text,
    "ideals" text,
    "bonds" text,
    "flaws" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "userId" bigint,
    "experience" bigint,
    "alignmentValue" text,
    "raceId" bigint,
    "subraceId" bigint,
    "backgroundId" bigint,
    "baseAbilityScores" json,
    "customAbilityBonuses" json,
    "useFlexibleAbilityBonuses" boolean,
    "temporaryHp" bigint,
    "currentHp" bigint,
    "inspiration" boolean,
    "equipment" text,
    "manualSkillProficiencies" json,
    "manualSavingThrowProficiencies" json,
    "notes" json,
    "attacks" json,
    "featureOverrides" json
);

--
-- Class ClassChoiceGroupData as table class_choice_group_data
--
CREATE TABLE "class_choice_group_data" (
    "id" bigserial PRIMARY KEY,
    "name" text,
    "description" text,
    "sourceClassId" bigint,
    "sourceSubclassId" bigint,
    "sourceFeatureId" bigint,
    "sourceSubclassFeatureId" bigint,
    "sourceRaceId" bigint,
    "sourceSubraceId" bigint,
    "sourceBackgroundId" bigint,
    "level" bigint,
    "type" text,
    "selectionCount" bigint,
    "appliesAtCharacterLevel" boolean,
    "exclusiveKey" text,
    "allowDuplicates" boolean,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- Class ClassChoiceOptionData as table class_choice_option_data
--
CREATE TABLE "class_choice_option_data" (
    "id" bigserial PRIMARY KEY,
    "choiceGroupId" bigint NOT NULL,
    "optionKey" text,
    "name" text,
    "description" text,
    "grantedAbilityBonuses" json,
    "grantedSkills" json,
    "grantedLanguages" json,
    "grantedArmorTraining" json,
    "grantedWeaponTraining" json,
    "grantedToolKeys" json,
    "grantedSpellKeys" json,
    "grantedFeatureTags" json,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
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
    "hitDieValue" bigint,
    "primaryAbilities" json,
    "savingThrowProficiencies" json,
    "armorTraining" json,
    "weaponTraining" json,
    "toolTraining" json,
    "availableSkills" json,
    "skillCount" bigint,
    "subclassChoiceLevel" bigint,
    "spellcastingProgression" text,
    "spellcastingAbilityValue" text,
    "multiclassPrerequisites" json,
    "multiclassArmorTraining" json,
    "multiclassWeaponTraining" json,
    "multiclassToolTraining" json,
    "imageURL" text
);

--
-- Class ClassFeatureData as table class_feature_data
--
CREATE TABLE "class_feature_data" (
    "id" bigserial PRIMARY KEY,
    "parentClassId" bigint NOT NULL,
    "name" text,
    "description" text,
    "level" bigint NOT NULL,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "tags" json,
    "choiceGroupKey" text
);

--
-- Class ClassLevelData as table class_level_data
--
CREATE TABLE "class_level_data" (
    "id" bigserial PRIMARY KEY,
    "classDataId" bigint NOT NULL,
    "level" bigint NOT NULL,
    "featureIds" json,
    "subclassFeatureIds" json,
    "knownCantrips" bigint,
    "knownSpells" bigint,
    "preparedSpellFormula" text,
    "resourceSummary" text,
    "spellSlots" json,
    "notes" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
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
    "tags" json,
    "specialAbilities" json,
    "proficiencies" json,
    "prerequisites" json
);

--
-- Class ItemData as table item_data
--
CREATE TABLE "item_data" (
    "id" bigserial PRIMARY KEY,
    "referenceKey" text,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "category" text,
    "weight" double precision,
    "cost" bigint,
    "effects" json
);

-- Indexes
CREATE UNIQUE INDEX "item_reference_key_idx" ON "item_data" USING btree ("referenceKey");

--
-- Class MagicItemData as table magic_item_data
--
CREATE TABLE "magic_item_data" (
    "id" bigserial PRIMARY KEY,
    "referenceKey" text,
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

-- Indexes
CREATE UNIQUE INDEX "magic_item_reference_key_idx" ON "magic_item_data" USING btree ("referenceKey");

--
-- Class RaceChoiceOptionData as table race_choice_option_data
--
CREATE TABLE "race_choice_option_data" (
    "id" bigserial PRIMARY KEY,
    "choiceSetId" bigint NOT NULL,
    "optionKey" text,
    "name" text,
    "description" text,
    "sortOrder" bigint,
    "ability" text,
    "skill" text,
    "language" text,
    "spellId" bigint,
    "featId" bigint,
    "toolKey" text,
    "bonusValue" bigint,
    "damageType" text,
    "areaOfEffectType" text,
    "areaText" text,
    "saveAbility" text,
    "damageByLevel" json,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- Class RaceChoiceSetData as table race_choice_set_data
--
CREATE TABLE "race_choice_set_data" (
    "id" bigserial PRIMARY KEY,
    "featureId" bigint NOT NULL,
    "kind" text,
    "pickCount" bigint,
    "mustBeDistinct" boolean,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
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
    "size" bigint,
    "strengthBonus" bigint,
    "dexterityBonus" bigint,
    "constitutionBonus" bigint,
    "intelligenceBonus" bigint,
    "wisdomBonus" bigint,
    "charismaBonus" bigint,
    "traits" json,
    "languages" json,
    "visionType" text,
    "visionRange" bigint,
    "resistances" json,
    "skillProficiencies" json,
    "armorProficiencies" json,
    "weaponProficiencies" json,
    "toolProficiencies" json,
    "imageURL" text
);

--
-- Class RaceFeatureData as table race_feature_data
--
CREATE TABLE "race_feature_data" (
    "id" bigserial PRIMARY KEY,
    "raceId" bigint,
    "subraceId" bigint,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "level" bigint,
    "usesPerRest" text,
    "usesFormula" text,
    "tags" json
);

--
-- Class RaceFeatureSpellGrantData as table race_feature_spell_grant_data
--
CREATE TABLE "race_feature_spell_grant_data" (
    "id" bigserial PRIMARY KEY,
    "featureId" bigint NOT NULL,
    "spellId" bigint NOT NULL,
    "grantedAtLevel" bigint,
    "castingAbility" text,
    "freeCastsPerRest" text,
    "freeCastsFormula" text,
    "castAtSpellLevel" bigint,
    "canAlsoCastWithSpellSlots" boolean,
    "notes" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- Class SpellClassAvailabilityData as table spell_class_availability_data
--
CREATE TABLE "spell_class_availability_data" (
    "id" bigserial PRIMARY KEY,
    "spellId" bigint NOT NULL,
    "classDataId" bigint NOT NULL,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "spell_class_availability_unique_idx" ON "spell_class_availability_data" USING btree ("spellId", "classDataId");

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
    "schoolValue" text,
    "castingTime" text,
    "range" text,
    "duration" text,
    "concentration" boolean,
    "ritual" boolean,
    "higherLevel" text,
    "savingThrowAbility" text,
    "requiresSavingThrow" boolean,
    "attackType" text,
    "requiresAttackRoll" boolean,
    "damageType" text,
    "damageDice" text,
    "damageScaling" json,
    "conditions" json,
    "targetType" text,
    "areaOfEffectType" text,
    "areaOfEffectSize" bigint,
    "areaOfEffectSecondarySize" bigint,
    "areaOfEffectHeight" bigint,
    "materialDescription" text,
    "materialCost" bigint,
    "materialConsumed" boolean,
    "durationType" text,
    "isHealing" boolean,
    "healingDice" text,
    "requiresLineOfSight" boolean,
    "requiresVerbal" boolean,
    "requiresSomatic" boolean,
    "requiresMaterial" boolean
);

--
-- Class StartingEquipmentBlockData as table starting_equipment_block_data
--
CREATE TABLE "starting_equipment_block_data" (
    "id" bigserial PRIMARY KEY,
    "blockKey" text,
    "orderIndex" bigint,
    "kind" text,
    "selectionCount" bigint,
    "sourceClassId" bigint,
    "sourceBackgroundId" bigint,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- Class StartingEquipmentLineData as table starting_equipment_line_data
--
CREATE TABLE "starting_equipment_line_data" (
    "id" bigserial PRIMARY KEY,
    "blockId" bigint,
    "optionId" bigint,
    "lineKey" text,
    "orderIndex" bigint,
    "kind" text,
    "displayText" text,
    "quantity" bigint,
    "catalogType" text,
    "referenceKey" text,
    "allowedWeaponCategories" json,
    "allowedItemCategories" json,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- Class StartingEquipmentOptionData as table starting_equipment_option_data
--
CREATE TABLE "starting_equipment_option_data" (
    "id" bigserial PRIMARY KEY,
    "blockId" bigint NOT NULL,
    "optionKey" text,
    "orderIndex" bigint,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
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
    "levelRequired" bigint
);

--
-- Class SubclassFeatureData as table subclass_feature_data
--
CREATE TABLE "subclass_feature_data" (
    "id" bigserial PRIMARY KEY,
    "parentSubclassId" bigint NOT NULL,
    "name" text,
    "description" text,
    "level" bigint NOT NULL,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "tags" json,
    "choiceGroupKey" text
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
    "strengthBonus" bigint,
    "dexterityBonus" bigint,
    "constitutionBonus" bigint,
    "intelligenceBonus" bigint,
    "wisdomBonus" bigint,
    "charismaBonus" bigint,
    "traits" json,
    "speedOverride" bigint,
    "visionRangeOverride" bigint,
    "skillProficiencies" json,
    "resistances" json,
    "armorProficiencies" json,
    "weaponProficiencies" json,
    "toolProficiencies" json
);

--
-- Class WeaponData as table weapon_data
--
CREATE TABLE "weapon_data" (
    "id" bigserial PRIMARY KEY,
    "referenceKey" text,
    "name" text,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "category" text,
    "damage" text,
    "damageType" text,
    "properties" json,
    "weight" double precision,
    "cost" double precision,
    "rangeNormal" bigint,
    "rangeMax" bigint
);

-- Indexes
CREATE UNIQUE INDEX "weapon_reference_key_idx" ON "weapon_data" USING btree ("referenceKey");

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
-- Foreign relations for "character_choice_data" table
--
ALTER TABLE ONLY "character_choice_data"
    ADD CONSTRAINT "character_choice_data_fk_0"
    FOREIGN KEY("characterId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_choice_data"
    ADD CONSTRAINT "character_choice_data_fk_1"
    FOREIGN KEY("classEntryId")
    REFERENCES "character_class_relation"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "character_class_relation" table
--
ALTER TABLE ONLY "character_class_relation"
    ADD CONSTRAINT "character_class_relation_fk_0"
    FOREIGN KEY("characterId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_class_relation"
    ADD CONSTRAINT "character_class_relation_fk_1"
    FOREIGN KEY("classDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_class_relation"
    ADD CONSTRAINT "character_class_relation_fk_2"
    FOREIGN KEY("subclassId")
    REFERENCES "subclass_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "character_starting_equipment_resolution_data" table
--
ALTER TABLE ONLY "character_starting_equipment_resolution_data"
    ADD CONSTRAINT "character_starting_equipment_resolution_data_fk_0"
    FOREIGN KEY("selectionId")
    REFERENCES "character_starting_equipment_selection_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "character_starting_equipment_selection_data" table
--
ALTER TABLE ONLY "character_starting_equipment_selection_data"
    ADD CONSTRAINT "character_starting_equipment_selection_data_fk_0"
    FOREIGN KEY("characterId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

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

--
-- Foreign relations for "class_choice_group_data" table
--
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_0"
    FOREIGN KEY("sourceClassId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_1"
    FOREIGN KEY("sourceSubclassId")
    REFERENCES "subclass_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_2"
    FOREIGN KEY("sourceFeatureId")
    REFERENCES "class_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_3"
    FOREIGN KEY("sourceSubclassFeatureId")
    REFERENCES "subclass_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_4"
    FOREIGN KEY("sourceRaceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_5"
    FOREIGN KEY("sourceSubraceId")
    REFERENCES "subrace_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_choice_group_data"
    ADD CONSTRAINT "class_choice_group_data_fk_6"
    FOREIGN KEY("sourceBackgroundId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "class_choice_option_data" table
--
ALTER TABLE ONLY "class_choice_option_data"
    ADD CONSTRAINT "class_choice_option_data_fk_0"
    FOREIGN KEY("choiceGroupId")
    REFERENCES "class_choice_group_data"("id")
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

--
-- Foreign relations for "class_level_data" table
--
ALTER TABLE ONLY "class_level_data"
    ADD CONSTRAINT "class_level_data_fk_0"
    FOREIGN KEY("classDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "race_choice_option_data" table
--
ALTER TABLE ONLY "race_choice_option_data"
    ADD CONSTRAINT "race_choice_option_data_fk_0"
    FOREIGN KEY("choiceSetId")
    REFERENCES "race_choice_set_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "race_choice_option_data"
    ADD CONSTRAINT "race_choice_option_data_fk_1"
    FOREIGN KEY("spellId")
    REFERENCES "spell_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "race_choice_option_data"
    ADD CONSTRAINT "race_choice_option_data_fk_2"
    FOREIGN KEY("featId")
    REFERENCES "feat_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "race_choice_set_data" table
--
ALTER TABLE ONLY "race_choice_set_data"
    ADD CONSTRAINT "race_choice_set_data_fk_0"
    FOREIGN KEY("featureId")
    REFERENCES "race_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "race_feature_data" table
--
ALTER TABLE ONLY "race_feature_data"
    ADD CONSTRAINT "race_feature_data_fk_0"
    FOREIGN KEY("raceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "race_feature_data"
    ADD CONSTRAINT "race_feature_data_fk_1"
    FOREIGN KEY("subraceId")
    REFERENCES "subrace_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "race_feature_spell_grant_data" table
--
ALTER TABLE ONLY "race_feature_spell_grant_data"
    ADD CONSTRAINT "race_feature_spell_grant_data_fk_0"
    FOREIGN KEY("featureId")
    REFERENCES "race_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "race_feature_spell_grant_data"
    ADD CONSTRAINT "race_feature_spell_grant_data_fk_1"
    FOREIGN KEY("spellId")
    REFERENCES "spell_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "spell_class_availability_data" table
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

--
-- Foreign relations for "starting_equipment_block_data" table
--
ALTER TABLE ONLY "starting_equipment_block_data"
    ADD CONSTRAINT "starting_equipment_block_data_fk_0"
    FOREIGN KEY("sourceClassId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "starting_equipment_block_data"
    ADD CONSTRAINT "starting_equipment_block_data_fk_1"
    FOREIGN KEY("sourceBackgroundId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "starting_equipment_line_data" table
--
ALTER TABLE ONLY "starting_equipment_line_data"
    ADD CONSTRAINT "starting_equipment_line_data_fk_0"
    FOREIGN KEY("blockId")
    REFERENCES "starting_equipment_block_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "starting_equipment_line_data"
    ADD CONSTRAINT "starting_equipment_line_data_fk_1"
    FOREIGN KEY("optionId")
    REFERENCES "starting_equipment_option_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "starting_equipment_option_data" table
--
ALTER TABLE ONLY "starting_equipment_option_data"
    ADD CONSTRAINT "starting_equipment_option_data_fk_0"
    FOREIGN KEY("blockId")
    REFERENCES "starting_equipment_block_data"("id")
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

--
-- Foreign relations for "subclass_feature_data" table
--
ALTER TABLE ONLY "subclass_feature_data"
    ADD CONSTRAINT "subclass_feature_data_fk_0"
    FOREIGN KEY("parentSubclassId")
    REFERENCES "subclass_data"("id")
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
    VALUES ('characters_mirror', '20260422221021546', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260422221021546', "timestamp" = now();

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
