BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "character_class_relation" (
    "id" bigserial PRIMARY KEY,
    "characterId" bigint NOT NULL,
    "classDataId" bigint NOT NULL,
    "subclassId" bigint NOT NULL,
    "level" bigint NOT NULL,
    "spellcastingProgression" text
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "subclass_data" DROP CONSTRAINT "subclass_data_fk_1";
ALTER TABLE "subclass_data" DROP COLUMN "_charactersSubclassesCharactersId";
--
-- ACTION CREATE FOREIGN KEY
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
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20251104202303968', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251104202303968', "timestamp" = now();

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
