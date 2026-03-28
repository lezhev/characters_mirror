BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "dragonborn_ancestry_data" ADD COLUMN "saveAbility" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "race_choice_set_data" (
    "id" bigserial PRIMARY KEY,
    "raceId" bigint,
    "subraceId" bigint,
    "featureId" bigint,
    "kind" bigint,
    "pickCount" bigint,
    "options" json,
    "optionValue" bigint,
    "mustBeDistinct" boolean,
    "description" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_data" ADD COLUMN "visionRange" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "race_feature_spell_grant_data" (
    "id" bigserial PRIMARY KEY,
    "featureId" bigint NOT NULL,
    "spellId" bigint NOT NULL,
    "grantedAtLevel" bigint,
    "castingAbility" bigint,
    "freeCastsPerRest" bigint,
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
-- ACTION ALTER TABLE
--
ALTER TABLE "subrace_data" ADD COLUMN "speedOverride" bigint;
ALTER TABLE "subrace_data" ADD COLUMN "visionRangeOverride" bigint;
ALTER TABLE "subrace_data" ADD COLUMN "armorProficiencies" json;
ALTER TABLE "subrace_data" ADD COLUMN "weaponProficiencies" json;
ALTER TABLE "subrace_data" ADD COLUMN "toolProficiencies" json;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "race_choice_set_data"
    ADD CONSTRAINT "race_choice_set_data_fk_0"
    FOREIGN KEY("raceId")
    REFERENCES "race_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "race_choice_set_data"
    ADD CONSTRAINT "race_choice_set_data_fk_1"
    FOREIGN KEY("subraceId")
    REFERENCES "subrace_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "race_choice_set_data"
    ADD CONSTRAINT "race_choice_set_data_fk_2"
    FOREIGN KEY("featureId")
    REFERENCES "race_feature_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260328124601406', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260328124601406', "timestamp" = now();

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
