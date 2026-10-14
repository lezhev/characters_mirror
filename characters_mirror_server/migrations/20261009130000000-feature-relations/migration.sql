BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "feature_relation_data" (
    "id" bigserial PRIMARY KEY,
    "sourceType" text NOT NULL,
    "sourceReferenceKey" text NOT NULL,
    "targetType" text NOT NULL,
    "targetReferenceKey" text NOT NULL,
    "relationType" text NOT NULL,
    "propertyMappings" json,
    "priority" bigint NOT NULL,
    "mergeDisplay" boolean,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "feature_relation_source_idx" ON "feature_relation_data" USING btree ("sourceType", "sourceReferenceKey");
CREATE INDEX "feature_relation_target_idx" ON "feature_relation_data" USING btree ("targetType", "targetReferenceKey");
CREATE UNIQUE INDEX "feature_relation_pair_idx" ON "feature_relation_data" USING btree ("sourceType", "sourceReferenceKey", "targetType", "targetReferenceKey", "relationType");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "race_feature_data" ADD COLUMN "referenceKey" text;
CREATE INDEX "race_feature_reference_key_idx" ON "race_feature_data" USING btree ("referenceKey");

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261009130000000-feature-relations', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261009130000000-feature-relations', "timestamp" = now();

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
