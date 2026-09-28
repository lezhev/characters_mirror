BEGIN;

--
-- ACTION ALTER TABLE
--
DROP INDEX "feature_display_property_source_key_idx";
CREATE INDEX "feature_display_property_class_feature_key_idx" ON "feature_display_property_data" USING btree ("sourceClassFeatureId", "key");
CREATE INDEX "feature_display_property_subclass_feature_key_idx" ON "feature_display_property_data" USING btree ("sourceSubclassFeatureId", "key");

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260927195616272', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260927195616272', "timestamp" = now();

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
