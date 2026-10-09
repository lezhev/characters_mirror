BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "choice_option_data" ADD COLUMN "automaticSelection" boolean;

UPDATE choice_option_data SET "automaticSelection" = ("optionKey" = 'minor_illusion')
WHERE "choiceGroupId" IN (SELECT id FROM choice_group_data
  WHERE "referenceKey" = 'wizard_illusion_improved_minor_illusion_cantrip');

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261007182700000-conditional-grant-selection', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007182700000-conditional-grant-selection', "timestamp" = now();

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
