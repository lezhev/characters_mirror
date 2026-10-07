BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "spell_data" ADD COLUMN "areaOfEffectSizeKind" text;


DO $area_measurements$
DECLARE item jsonb; actual jsonb;
BEGIN
  LOCK TABLE spell_data IN SHARE ROW EXCLUSIVE MODE;
  IF NOT EXISTS (SELECT 1 FROM spell_data WHERE "referenceKey" IN ('burning_hands', 'thunderwave', 'fireball', 'lightning_bolt', 'ice_storm', 'flame_strike', 'hunger_of_hadar')) THEN
    RAISE NOTICE 'Area measurement backfill skipped: no canonical pilot area rows in fixture catalog.';
    RETURN;
  END IF;
  FOR item IN SELECT value FROM jsonb_array_elements($area_data$[{"key": "burning_hands", "kind": "length", "shape": "cone", "size": 15, "width": null, "height": null}, {"key": "thunderwave", "kind": "edge", "shape": "cube", "size": 15, "width": null, "height": null}, {"key": "fireball", "kind": "radius", "shape": "sphere", "size": 20, "width": null, "height": null}, {"key": "lightning_bolt", "kind": "length", "shape": "line", "size": 100, "width": 5, "height": null}, {"key": "ice_storm", "kind": "radius", "shape": "cylinder", "size": 20, "width": null, "height": 40}, {"key": "flame_strike", "kind": "radius", "shape": "cylinder", "size": 10, "width": null, "height": 40}, {"key": "hunger_of_hadar", "kind": "radius", "shape": "sphere", "size": 20, "width": null, "height": null}]$area_data$::jsonb)
  LOOP
    SELECT jsonb_build_object('shape', "areaOfEffectType", 'size', "areaOfEffectSize",
        'width', "areaOfEffectSecondarySize", 'height', "areaOfEffectHeight")
      INTO actual FROM spell_data WHERE "referenceKey"=item->>'key';
    IF actual IS DISTINCT FROM (item - 'key' - 'kind') THEN
      RAISE EXCEPTION 'Area measurement preflight mismatch for %', item->>'key';
    END IF;
    IF EXISTS (SELECT 1 FROM spell_data WHERE "referenceKey"=item->>'key'
        AND "areaOfEffectSizeKind" IS NOT NULL) THEN
      RAISE EXCEPTION 'Area measurement would overwrite existing kind for %', item->>'key';
    END IF;
  END LOOP;
  FOR item IN SELECT value FROM jsonb_array_elements($area_data$[{"key": "burning_hands", "kind": "length", "shape": "cone", "size": 15, "width": null, "height": null}, {"key": "thunderwave", "kind": "edge", "shape": "cube", "size": 15, "width": null, "height": null}, {"key": "fireball", "kind": "radius", "shape": "sphere", "size": 20, "width": null, "height": null}, {"key": "lightning_bolt", "kind": "length", "shape": "line", "size": 100, "width": 5, "height": null}, {"key": "ice_storm", "kind": "radius", "shape": "cylinder", "size": 20, "width": null, "height": 40}, {"key": "flame_strike", "kind": "radius", "shape": "cylinder", "size": 10, "width": null, "height": 40}, {"key": "hunger_of_hadar", "kind": "radius", "shape": "sphere", "size": 20, "width": null, "height": null}]$area_data$::jsonb)
  LOOP
    UPDATE spell_data SET "areaOfEffectSizeKind"=item->>'kind' WHERE "referenceKey"=item->>'key';
  END LOOP;
END;
$area_measurements$;

--
-- MIGRATION VERSION FOR characters_mirror
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('characters_mirror', '20261007002111299-spell-area-measurements', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007002111299-spell-area-measurements', "timestamp" = now();

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
