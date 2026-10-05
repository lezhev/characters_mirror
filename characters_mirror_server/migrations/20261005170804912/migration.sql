BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE FOREIGN KEY
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
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261005170804912', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261005170804912', "timestamp" = now();

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
