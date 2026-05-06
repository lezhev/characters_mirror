BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "class_level_data" DROP COLUMN "spellSlots";
--
-- ACTION CREATE TABLE
--
CREATE TABLE "spell_slot_progression_data" (
    "id" bigserial PRIMARY KEY,
    "tableKey" text,
    "level" bigint NOT NULL,
    "spellSlots" json,
    "source" text,
    "version" bigint,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "spell_slot_progression_table_level_idx" ON "spell_slot_progression_data" USING btree ("tableKey", "level");

INSERT INTO "spell_slot_progression_data" (
    "tableKey",
    "level",
    "spellSlots",
    "source",
    "version",
    "createdAt",
    "updatedAt"
) VALUES
    ('standard', 1, '[{"k":1,"v":2}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 2, '[{"k":1,"v":3}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 3, '[{"k":1,"v":4},{"k":2,"v":2}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 4, '[{"k":1,"v":4},{"k":2,"v":3}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 5, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":2}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 6, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 7, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":1}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 8, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":2}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 9, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":3},{"k":5,"v":1}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 10, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":3},{"k":5,"v":2}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 11, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":3},{"k":5,"v":2},{"k":6,"v":1}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 12, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":3},{"k":5,"v":2},{"k":6,"v":1}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 13, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":3},{"k":5,"v":2},{"k":6,"v":1},{"k":7,"v":1}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 14, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":3},{"k":5,"v":2},{"k":6,"v":1},{"k":7,"v":1}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 15, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":3},{"k":5,"v":2},{"k":6,"v":1},{"k":7,"v":1},{"k":8,"v":1}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 16, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":3},{"k":5,"v":2},{"k":6,"v":1},{"k":7,"v":1},{"k":8,"v":1}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 17, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":3},{"k":5,"v":2},{"k":6,"v":1},{"k":7,"v":1},{"k":8,"v":1},{"k":9,"v":1}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 18, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":3},{"k":5,"v":3},{"k":6,"v":1},{"k":7,"v":1},{"k":8,"v":1},{"k":9,"v":1}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 19, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":3},{"k":5,"v":3},{"k":6,"v":2},{"k":7,"v":1},{"k":8,"v":1},{"k":9,"v":1}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('standard', 20, '[{"k":1,"v":4},{"k":2,"v":3},{"k":3,"v":3},{"k":4,"v":3},{"k":5,"v":3},{"k":6,"v":2},{"k":7,"v":2},{"k":8,"v":1},{"k":9,"v":1}]'::json, 'D&D 5e standard spell slots', 1, now(), now()),
    ('pact_magic', 1, '[{"k":1,"v":1}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 2, '[{"k":1,"v":2}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 3, '[{"k":2,"v":2}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 4, '[{"k":2,"v":2}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 5, '[{"k":3,"v":2}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 6, '[{"k":3,"v":2}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 7, '[{"k":4,"v":2}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 8, '[{"k":4,"v":2}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 9, '[{"k":5,"v":2}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 10, '[{"k":5,"v":2}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 11, '[{"k":5,"v":3}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 12, '[{"k":5,"v":3}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 13, '[{"k":5,"v":3}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 14, '[{"k":5,"v":3}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 15, '[{"k":5,"v":3}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 16, '[{"k":5,"v":3}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 17, '[{"k":5,"v":4}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 18, '[{"k":5,"v":4}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 19, '[{"k":5,"v":4}]'::json, 'D&D 5e pact magic slots', 1, now(), now()),
    ('pact_magic', 20, '[{"k":5,"v":4}]'::json, 'D&D 5e pact magic slots', 1, now(), now());


--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20260501050439998', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260501050439998', "timestamp" = now();

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
