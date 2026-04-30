BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "class_spell_grant_data" (
    "id" bigserial PRIMARY KEY,
    "spellId" bigint NOT NULL,
    "sourceClassId" bigint,
    "sourceSubclassId" bigint,
    "sourceFeatureId" bigint,
    "sourceSubclassFeatureId" bigint,
    "grantedAtLevel" bigint,
    "alwaysPrepared" boolean,
    "notes" text,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- ACTION CREATE FOREIGN KEY
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


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260430015959665', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260430015959665', "timestamp" = now();

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
