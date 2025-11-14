BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "characters" DROP CONSTRAINT "characters_fk_2";
ALTER TABLE "characters" ADD COLUMN "subclassId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_option_data" ADD COLUMN "_charactersVariantoptionsCharactersId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_3"
    FOREIGN KEY("backgroundId")
    REFERENCES "background_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "characters"
    ADD CONSTRAINT "characters_fk_2"
    FOREIGN KEY("subclassId")
    REFERENCES "subclass_data"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "class_option_data"
    ADD CONSTRAINT "class_option_data_fk_0"
    FOREIGN KEY("_charactersVariantoptionsCharactersId")
    REFERENCES "characters"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251114005644127', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251114005644127', "timestamp" = now();

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
