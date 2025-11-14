BEGIN;

--
-- ACTION CREATE TABLE
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
    "abilityBonuses" json,
    "proficiencies" json,
    "specialAbilities" json,
    "variantOptions" text,
    "resourceName" text,
    "resourceAmount" bigint,
    "resourceRegain" text,
    "spellSlots" json,
    "knownSpells" bigint NOT NULL,
    "knownCantips" bigint NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subclass_feature_data"
    ADD CONSTRAINT "subclass_feature_data_fk_0"
    FOREIGN KEY("parentSubclassId")
    REFERENCES "subclass_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251114020655143', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251114020655143', "timestamp" = now();

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
