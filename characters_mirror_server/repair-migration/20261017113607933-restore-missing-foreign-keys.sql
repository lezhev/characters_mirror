BEGIN;

--
-- ACTION ALTER TABLE
--
--
-- ACTION ALTER TABLE
--
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "character_class_relation"
    ADD CONSTRAINT "character_class_relation_fk_2"
    FOREIGN KEY("subclassId")
    REFERENCES "subclass_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
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
    VALUES ('characters_mirror', '20261017074639038', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261017074639038', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20260824182343939', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182343939', "timestamp" = now();

--
-- MIGRATION VERSION FOR _repair
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('_repair', '20261017113607933-restore-missing-foreign-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261017113607933-restore-missing-foreign-keys', "timestamp" = now();


COMMIT;
