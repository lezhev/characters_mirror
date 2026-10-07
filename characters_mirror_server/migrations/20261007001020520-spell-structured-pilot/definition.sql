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
    "bonusAC" bigint,
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
    "availableSkills" json,
    "skillCount" bigint,
    "toolProficiencyKeys" json,
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
-- Class CharacterAppliedChangeRecord as table character_applied_changes
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
-- Class CharacterChoiceRecord as table character_choice_data
--
CREATE TABLE "character_choice_data" (
    "id" bigserial PRIMARY KEY,
    "syncId" text,
    "characterId" bigint NOT NULL,
    "classEntryId" bigint,
    "groupKey" text,
    "optionKey" text,
    "selectionIndex" bigint,
    "updatedAt" timestamp without time zone
);

--
-- Class CharacterClassEntryRecord as table character_class_relation
--
CREATE TABLE "character_class_relation" (
    "id" bigserial PRIMARY KEY,
    "syncId" text,
    "characterId" bigint NOT NULL,
    "classDataId" bigint NOT NULL,
    "subclassId" bigint,
    "level" bigint NOT NULL,
    "isStartingClass" boolean,
    "classOrder" bigint,
    "hpMode" text,
    "hpRolledValues" json,
    "notes" text,
    "updatedAt" timestamp without time zone
);

--
-- Class CharacterSkillSelectionRecord as table character_skill_selection_data
--
CREATE TABLE "character_skill_selection_data" (
    "id" bigserial PRIMARY KEY,
    "syncId" text,
    "characterId" bigint NOT NULL,
    "classEntryId" bigint,
    "classDataId" bigint,
    "backgroundDataId" bigint,
    "skill" text,
    "kind" text,
    "selectionIndex" bigint,
    "updatedAt" timestamp without time zone
);

--
-- Class CharacterSpellSelectionRecord as table character_spell_selection_data
--
CREATE TABLE "character_spell_selection_data" (
    "id" bigserial PRIMARY KEY,
    "syncId" text,
    "characterId" bigint NOT NULL,
    "classEntryId" bigint,
    "classDataId" bigint,
    "spellId" bigint,
    "spellKey" text,
    "kind" text,
    "selectionIndex" bigint,
    "updatedAt" timestamp without time zone
);

--
-- Class CharacterStartingEquipmentResolutionRecord as table character_starting_equipment_resolution_data
--
CREATE TABLE "character_starting_equipment_resolution_data" (
    "id" bigserial PRIMARY KEY,
    "syncId" text,
    "selectionId" bigint NOT NULL,
    "sourceLineEntryId" bigint,
    "catalogType" text,
    "referenceKey" text,
    "quantity" bigint,
    "updatedAt" timestamp without time zone
);

--
-- Class CharacterStartingEquipmentSelectionRecord as table character_starting_equipment_selection_data
--
CREATE TABLE "character_starting_equipment_selection_data" (
    "id" bigserial PRIMARY KEY,
    "syncId" text,
    "characterId" bigint NOT NULL,
    "sourceType" text,
    "sourceId" bigint,
    "sourceEntryId" bigint,
    "choiceOptionEntryId" bigint,
    "isSelected" boolean,
    "selectionIndex" bigint,
    "updatedAt" timestamp without time zone
);

--
-- Class CharacterSyncEventRecord as table character_sync_events
--
CREATE TABLE "character_sync_events" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "characterId" bigint NOT NULL,
    "characterVersion" bigint,
    "eventType" text NOT NULL,
    "changeId" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "character_sync_events_user_id_idx" ON "character_sync_events" USING btree ("userId", "id");
CREATE INDEX "character_sync_events_character_id_idx" ON "character_sync_events" USING btree ("userId", "characterId");

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
    "portraitVersion" bigint,
    "syncTargetRevisions" json,
    "syncBarrierTokens" json,
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
    "deathSaveSuccesses" bigint,
    "deathSaveFailures" bigint,
    "hpPerLevelBonus" bigint,
    "hpFlatBonus" bigint,
    "currentHitDice" json,
    "hitDiceMaxOverrides" json,
    "currentSpellSlots" json,
    "currentPactSlots" json,
    "activeConcentrationSpellName" text,
    "customInitiativeBonus" bigint,
    "customArmorClassBonus" bigint,
    "walkingSpeed" bigint,
    "swimmingSpeed" bigint,
    "climbingSpeed" bigint,
    "flyingSpeed" bigint,
    "displayedSpeedKind" bigint,
    "customSpellSaveDcBonus" bigint,
    "customSpellAttackBonus" bigint,
    "preparedSpellKeys" json,
    "activeConditions" json,
    "exhaustionLevel" bigint,
    "inspiration" boolean,
    "equipment" json,
    "equippedArmor" json,
    "equippedShield" json,
    "manualSkillProficiencies" json,
    "manualSavingThrowProficiencies" json,
    "manualSkillProficiencyOverrides" json,
    "manualSavingThrowProficiencyOverrides" json,
    "manualLanguageOverrides" json,
    "manualToolProficiencyOverrides" json,
    "manualWeaponProficiencyOverrides" json,
    "manualArmorTrainingOverrides" json,
    "notes" json,
    "attacks" json,
    "featureOverrides" json,
    "resourceStates" json
);

--
-- Class ChoiceGroupData as table choice_group_data
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
    "minimumSelectionCount" bigint,
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
-- Class ChoiceOptionData as table choice_option_data
--
CREATE TABLE "choice_option_data" (
    "id" bigserial PRIMARY KEY,
    "choiceGroupId" bigint NOT NULL,
    "optionKey" text NOT NULL,
    "name" text,
    "description" text,
    "shortDescription" text,
    "sortOrder" bigint,
    "grantedAbilityBonuses" json,
    "grantedSkills" json,
    "grantedExpertiseSkills" json,
    "grantedLanguages" json,
    "grantedArmorTraining" json,
    "grantedWeaponTraining" json,
    "grantedToolKeys" json,
    "grantedExpertiseToolKeys" json,
    "requiredExistingSkill" text,
    "requiredExistingToolKey" text,
    "requirements" json,
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
-- Class ClassData as table class_data
--
CREATE TABLE "class_data" (
    "id" bigserial PRIMARY KEY,
    "referenceKey" text,
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
    "toolTrainingKeys" json,
    "availableSkills" json,
    "skillCount" bigint,
    "subclassChoiceLevel" bigint,
    "subclassChoiceFeatureId" bigint,
    "spellcastingProgression" text,
    "spellSelectionMode" text,
    "spellcastingAbilityValue" text,
    "multiclassPrerequisites" json,
    "multiclassArmorTraining" json,
    "multiclassWeaponTraining" json,
    "multiclassToolTrainingKeys" json,
    "imageURL" text
);

-- Indexes
CREATE UNIQUE INDEX "class_reference_key_idx" ON "class_data" USING btree ("referenceKey");

--
-- Class ClassFeatureData as table class_feature_data
--
CREATE TABLE "class_feature_data" (
    "id" bigserial PRIMARY KEY,
    "parentClassId" bigint NOT NULL,
    "name" text,
    "referenceKey" text,
    "description" text,
    "shortDescription" text,
    "level" bigint NOT NULL,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "tags" json,
    "choiceGroupKey" text,
    "grantedLanguages" json,
    "grantedSkills" json,
    "grantedExpertiseSkills" json,
    "grantedArmorTraining" json,
    "grantedWeaponTraining" json,
    "grantedToolKeys" json,
    "grantedExpertiseToolKeys" json,
    "grantedSpellKeys" json,
    "unarmoredDefenseRule" text,
    "relatedTable" text
);

-- Indexes
CREATE UNIQUE INDEX "class_feature_reference_key_idx" ON "class_feature_data" USING btree ("referenceKey");

--
-- Class ClassLevelData as table class_level_data
--
CREATE TABLE "class_level_data" (
    "id" bigserial PRIMARY KEY,
    "classDataId" bigint NOT NULL,
    "subclassDataId" bigint,
    "level" bigint NOT NULL,
    "knownCantrips" bigint,
    "knownSpells" bigint,
    "spellbookSpells" bigint,
    "knownSpellReplacements" bigint,
    "preparedSpellRule" json,
    "preparedSpellFormula" text,
    "resourceSummary" text,
    "notes" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- Class ClassSpellGrantData as table class_spell_grant_data
--
CREATE TABLE "class_spell_grant_data" (
    "id" bigserial PRIMARY KEY,
    "spellId" bigint,
    "sourceClassId" bigint,
    "sourceSubclassId" bigint,
    "sourceFeatureId" bigint,
    "sourceSubclassFeatureId" bigint,
    "grantedAtLevel" bigint,
    "alwaysPrepared" boolean,
    "choiceOptionId" bigint,
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
-- Class FeatureDisplayPropertyData as table feature_display_property_data
--
CREATE TABLE "feature_display_property_data" (
    "id" bigserial PRIMARY KEY,
    "sourceClassFeatureId" bigint,
    "sourceSubclassFeatureId" bigint,
    "key" text NOT NULL,
    "label" text NOT NULL,
    "valueKind" text NOT NULL,
    "staticValue" text,
    "progression" json,
    "formula" text,
    "sortOrder" bigint,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "feature_display_property_class_feature_key_idx" ON "feature_display_property_data" USING btree ("sourceClassFeatureId", "key");
CREATE INDEX "feature_display_property_subclass_feature_key_idx" ON "feature_display_property_data" USING btree ("sourceSubclassFeatureId", "key");

--
-- Class FeatureModifierData as table feature_modifier_data
--
CREATE TABLE "feature_modifier_data" (
    "id" bigserial PRIMARY KEY,
    "referenceKey" text NOT NULL,
    "classFeatureId" bigint,
    "subclassFeatureId" bigint,
    "target" bigint NOT NULL,
    "operation" bigint NOT NULL,
    "value" json NOT NULL,
    "conditions" json,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "feature_modifier_reference_key_idx" ON "feature_modifier_data" USING btree ("referenceKey");
CREATE INDEX "feature_modifier_class_feature_idx" ON "feature_modifier_data" USING btree ("classFeatureId");
CREATE INDEX "feature_modifier_subclass_feature_idx" ON "feature_modifier_data" USING btree ("subclassFeatureId");

--
-- Class FeatureResourceDefinitionData as table feature_resource_definition_data
--
CREATE TABLE "feature_resource_definition_data" (
    "id" bigserial PRIMARY KEY,
    "classFeatureId" bigint,
    "subclassFeatureId" bigint,
    "raceFeatureId" bigint,
    "key" text NOT NULL,
    "choiceOptionId" bigint,
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
-- Class FeatureResourceEffectData as table feature_resource_effect_data
--
CREATE TABLE "feature_resource_effect_data" (
    "id" bigserial PRIMARY KEY,
    "classFeatureId" bigint,
    "subclassFeatureId" bigint,
    "raceFeatureId" bigint,
    "type" text NOT NULL,
    "choiceOptionId" bigint,
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
-- Class FeatureResourceProgressionValueData as table feature_resource_progression_value_data
--
CREATE TABLE "feature_resource_progression_value_data" (
    "id" bigserial PRIMARY KEY,
    "resourceDefinitionId" bigint,
    "level" bigint NOT NULL,
    "value" bigint NOT NULL
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
    "weaponProficiencyKeys" json,
    "toolProficiencyKeys" json,
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
    "shortDescription" text,
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
-- Class SpellData as table spell_data
--
CREATE TABLE "spell_data" (
    "id" bigserial PRIMARY KEY,
    "referenceKey" text NOT NULL,
    "name" text,
    "description" text,
    "shortDescription" text,
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
    "damageParts" json,
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
    "healingScaling" json,
    "healingAddsCastingModifier" boolean,
    "requiresLineOfSight" boolean,
    "requiresVerbal" boolean,
    "requiresSomatic" boolean,
    "requiresMaterial" boolean,
    "availableForClassIds" json,
    "availableForSubclassIds" json
);

-- Indexes
CREATE UNIQUE INDEX "spell_reference_key_idx" ON "spell_data" USING btree ("referenceKey");

--
-- Class SpellSlotProgressionData as table spell_slot_progression_data
--
CREATE TABLE "spell_slot_progression_data" (
    "id" bigserial PRIMARY KEY,
    "tableKey" text,
    "level" bigint NOT NULL,
    "spellSlots" json,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "spell_slot_progression_table_level_idx" ON "spell_slot_progression_data" USING btree ("tableKey", "level");

--
-- Class StartingEquipmentEntryData as table starting_equipment_entry_data
--
CREATE TABLE "starting_equipment_entry_data" (
    "id" bigserial PRIMARY KEY,
    "sourceClassId" bigint,
    "sourceBackgroundId" bigint,
    "parentEntryId" bigint,
    "kind" text,
    "orderIndex" bigint,
    "selectionCount" bigint,
    "lineKind" text,
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

-- Indexes
CREATE INDEX "starting_equipment_entry_class_idx" ON "starting_equipment_entry_data" USING btree ("sourceClassId");
CREATE INDEX "starting_equipment_entry_background_idx" ON "starting_equipment_entry_data" USING btree ("sourceBackgroundId");
CREATE INDEX "starting_equipment_entry_parent_idx" ON "starting_equipment_entry_data" USING btree ("parentEntryId");

--
-- Class SubclassData as table subclass_data
--
CREATE TABLE "subclass_data" (
    "id" bigserial PRIMARY KEY,
    "referenceKey" text,
    "name" text,
    "description" text,
    "shortDescription" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "subclassName" text,
    "parentClassId" bigint NOT NULL,
    "levelRequired" bigint,
    "spellcastingStartLevel" bigint,
    "spellcastingProgression" text,
    "spellSelectionMode" text,
    "spellcastingAbilityValue" text
);

-- Indexes
CREATE UNIQUE INDEX "subclass_reference_key_idx" ON "subclass_data" USING btree ("referenceKey");

--
-- Class SubclassFeatureData as table subclass_feature_data
--
CREATE TABLE "subclass_feature_data" (
    "id" bigserial PRIMARY KEY,
    "parentSubclassId" bigint NOT NULL,
    "name" text,
    "referenceKey" text,
    "description" text,
    "shortDescription" text,
    "level" bigint NOT NULL,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "tags" json,
    "choiceGroupKey" text,
    "grantedSkills" json,
    "grantedExpertiseSkills" json,
    "grantedLanguages" json,
    "grantedArmorTraining" json,
    "grantedWeaponTraining" json,
    "grantedToolKeys" json,
    "grantedExpertiseToolKeys" json,
    "grantedSpellKeys" json,
    "relatedTable" text
);

-- Indexes
CREATE UNIQUE INDEX "subclass_feature_reference_key_idx" ON "subclass_feature_data" USING btree ("referenceKey");

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
    "weaponProficiencyKeys" json,
    "toolProficiencyKeys" json
);

--
-- Class ToolData as table tool_data
--
CREATE TABLE "tool_data" (
    "id" bigserial PRIMARY KEY,
    "referenceKey" text NOT NULL,
    "name" text NOT NULL,
    "category" bigint
);

-- Indexes
CREATE UNIQUE INDEX "tool_data_reference_key_idx" ON "tool_data" USING btree ("referenceKey");

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
-- Foreign relations for "character_skill_selection_data" table
--
ALTER TABLE ONLY "character_skill_selection_data"
    ADD CONSTRAINT "character_skill_selection_data_fk_0"
    FOREIGN KEY("characterId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_skill_selection_data"
    ADD CONSTRAINT "character_skill_selection_data_fk_1"
    FOREIGN KEY("classEntryId")
    REFERENCES "character_class_relation"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_skill_selection_data"
    ADD CONSTRAINT "character_skill_selection_data_fk_2"
    FOREIGN KEY("classDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_skill_selection_data"
    ADD CONSTRAINT "character_skill_selection_data_fk_3"
    FOREIGN KEY("backgroundDataId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "character_spell_selection_data" table
--
ALTER TABLE ONLY "character_spell_selection_data"
    ADD CONSTRAINT "character_spell_selection_data_fk_0"
    FOREIGN KEY("characterId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_spell_selection_data"
    ADD CONSTRAINT "character_spell_selection_data_fk_1"
    FOREIGN KEY("classEntryId")
    REFERENCES "character_class_relation"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_spell_selection_data"
    ADD CONSTRAINT "character_spell_selection_data_fk_2"
    FOREIGN KEY("classDataId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_spell_selection_data"
    ADD CONSTRAINT "character_spell_selection_data_fk_3"
    FOREIGN KEY("spellId")
    REFERENCES "spell_data"("id")
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
ALTER TABLE ONLY "character_starting_equipment_resolution_data"
    ADD CONSTRAINT "character_starting_equipment_resolution_data_fk_1"
    FOREIGN KEY("sourceLineEntryId")
    REFERENCES "starting_equipment_entry_data"("id")
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
ALTER TABLE ONLY "character_starting_equipment_selection_data"
    ADD CONSTRAINT "character_starting_equipment_selection_data_fk_1"
    FOREIGN KEY("sourceEntryId")
    REFERENCES "starting_equipment_entry_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "character_starting_equipment_selection_data"
    ADD CONSTRAINT "character_starting_equipment_selection_data_fk_2"
    FOREIGN KEY("choiceOptionEntryId")
    REFERENCES "starting_equipment_entry_data"("id")
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
-- Foreign relations for "choice_group_data" table
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
-- Foreign relations for "choice_option_data" table
--
ALTER TABLE ONLY "choice_option_data"
    ADD CONSTRAINT "choice_option_data_fk_0"
    FOREIGN KEY("choiceGroupId")
    REFERENCES "choice_group_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "class_data" table
--
ALTER TABLE ONLY "class_data"
    ADD CONSTRAINT "class_data_fk_0"
    FOREIGN KEY("subclassChoiceFeatureId")
    REFERENCES "class_feature_data"("id")
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
ALTER TABLE ONLY "class_level_data"
    ADD CONSTRAINT "class_level_data_fk_1"
    FOREIGN KEY("subclassDataId")
    REFERENCES "subclass_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "class_spell_grant_data" table
--
ALTER TABLE ONLY "class_spell_grant_data"
    ADD CONSTRAINT "class_spell_grant_data_fk_0"
    FOREIGN KEY("spellId")
    REFERENCES "spell_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_spell_grant_data"
    ADD CONSTRAINT "class_spell_grant_data_fk_1"
    FOREIGN KEY("sourceClassId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_spell_grant_data"
    ADD CONSTRAINT "class_spell_grant_data_fk_2"
    FOREIGN KEY("sourceSubclassId")
    REFERENCES "subclass_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_spell_grant_data"
    ADD CONSTRAINT "class_spell_grant_data_fk_3"
    FOREIGN KEY("sourceFeatureId")
    REFERENCES "class_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_spell_grant_data"
    ADD CONSTRAINT "class_spell_grant_data_fk_4"
    FOREIGN KEY("sourceSubclassFeatureId")
    REFERENCES "subclass_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "class_spell_grant_data"
    ADD CONSTRAINT "class_spell_grant_data_fk_5"
    FOREIGN KEY("choiceOptionId")
    REFERENCES "choice_option_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "feature_display_property_data" table
--
ALTER TABLE ONLY "feature_display_property_data"
    ADD CONSTRAINT "feature_display_property_data_fk_0"
    FOREIGN KEY("sourceClassFeatureId")
    REFERENCES "class_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "feature_display_property_data"
    ADD CONSTRAINT "feature_display_property_data_fk_1"
    FOREIGN KEY("sourceSubclassFeatureId")
    REFERENCES "subclass_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "feature_modifier_data" table
--
ALTER TABLE ONLY "feature_modifier_data"
    ADD CONSTRAINT "feature_modifier_data_fk_0"
    FOREIGN KEY("classFeatureId")
    REFERENCES "class_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "feature_modifier_data"
    ADD CONSTRAINT "feature_modifier_data_fk_1"
    FOREIGN KEY("subclassFeatureId")
    REFERENCES "subclass_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "feature_resource_definition_data" table
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
ALTER TABLE ONLY "feature_resource_definition_data"
    ADD CONSTRAINT "feature_resource_definition_data_fk_3"
    FOREIGN KEY("choiceOptionId")
    REFERENCES "choice_option_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "feature_resource_effect_data" table
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
ALTER TABLE ONLY "feature_resource_effect_data"
    ADD CONSTRAINT "feature_resource_effect_data_fk_3"
    FOREIGN KEY("choiceOptionId")
    REFERENCES "choice_option_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "feature_resource_progression_value_data" table
--
ALTER TABLE ONLY "feature_resource_progression_value_data"
    ADD CONSTRAINT "feature_resource_progression_value_data_fk_0"
    FOREIGN KEY("resourceDefinitionId")
    REFERENCES "feature_resource_definition_data"("id")
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
-- Foreign relations for "starting_equipment_entry_data" table
--
ALTER TABLE ONLY "starting_equipment_entry_data"
    ADD CONSTRAINT "starting_equipment_entry_data_fk_0"
    FOREIGN KEY("sourceClassId")
    REFERENCES "class_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "starting_equipment_entry_data"
    ADD CONSTRAINT "starting_equipment_entry_data_fk_1"
    FOREIGN KEY("sourceBackgroundId")
    REFERENCES "background_data"("id")
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
    VALUES ('characters_mirror', '20261007001020520-spell-structured-pilot', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007001020520-spell-structured-pilot', "timestamp" = now();

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
