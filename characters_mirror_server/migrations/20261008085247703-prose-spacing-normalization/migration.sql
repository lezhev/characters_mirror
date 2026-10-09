BEGIN;

-- Normalize prose punctuation spacing in reference catalog text.
-- Rules mirrored by characters_mirror_shared normalizeProseSpacing():
-- remove whitespace before periods, preserve line breaks after periods,
-- remove trailing whitespace after a terminal period, and repair the one
-- catalog sentence that currently misses a space after a period.
UPDATE "armor_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "background_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "choice_group_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "choice_option_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "shortDescription" = regexp_replace(regexp_replace(regexp_replace("shortDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g')
    OR "shortDescription" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("shortDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "class_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "class_feature_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "shortDescription" = regexp_replace(regexp_replace(regexp_replace("shortDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g')
    OR "shortDescription" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("shortDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "feat_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "item_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "magic_item_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "race_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "race_feature_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "shortDescription" = regexp_replace(regexp_replace(regexp_replace("shortDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g')
    OR "shortDescription" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("shortDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "spell_data"
SET
    "description" = CASE WHEN "referenceKey" = 'infernal_calling' THEN replace(regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'), '.' || U&'\041E\043D', '. ' || U&'\041E\043D') ELSE regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g') END,
    "higherLevel" = regexp_replace(regexp_replace(regexp_replace("higherLevel", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "materialDescription" = regexp_replace(regexp_replace(regexp_replace("materialDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "shortDescription" = regexp_replace(regexp_replace(regexp_replace("shortDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM CASE WHEN "referenceKey" = 'infernal_calling' THEN replace(regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'), '.' || U&'\041E\043D', '. ' || U&'\041E\043D') ELSE regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g') END
    OR "higherLevel" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("higherLevel", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g')
    OR "materialDescription" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("materialDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g')
    OR "shortDescription" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("shortDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "subclass_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "shortDescription" = regexp_replace(regexp_replace(regexp_replace("shortDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g')
    OR "shortDescription" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("shortDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "subclass_feature_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "shortDescription" = regexp_replace(regexp_replace(regexp_replace("shortDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g')
    OR "shortDescription" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("shortDescription", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "subrace_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

UPDATE "weapon_data"
SET
    "description" = regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g'),
    "version" = COALESCE("version", 0) + 1,
    "updatedAt" = now()
WHERE "description" IS DISTINCT FROM regexp_replace(regexp_replace(regexp_replace("description", E'[ \\t\\r\\n]+\\.', '.', 'g'), E'\\.[ \\t]+(\\r?\\n)', E'.\\1', 'g'), E'\\.[ \\t]+$', '.', 'g');

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261008085247703-prose-spacing-normalization', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008085247703-prose-spacing-normalization', "timestamp" = now();

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
