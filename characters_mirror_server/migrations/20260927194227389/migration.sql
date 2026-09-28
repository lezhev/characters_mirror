BEGIN;

--
-- ACTION CREATE TABLE
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
CREATE UNIQUE INDEX "feature_display_property_source_key_idx" ON "feature_display_property_data" USING btree ("sourceClassFeatureId", "sourceSubclassFeatureId", "key");

--
-- ACTION CREATE FOREIGN KEY
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
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260927194227389', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260927194227389', "timestamp" = now();

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
