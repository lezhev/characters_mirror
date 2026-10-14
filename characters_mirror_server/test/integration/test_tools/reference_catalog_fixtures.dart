import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

Future<SpellData> ensureSpellFixture(
    Session session, SpellData fallback) async {
  final existing = await SpellData.db.find(session,
      where: (t) => t.referenceKey.equals(fallback.referenceKey), limit: 1);
  return existing.firstOrNull ??
      await SpellData.db.insertRow(session, fallback);
}

Future<WeaponData> ensureWeaponFixture(
    Session session, WeaponData fallback) async {
  final existing = await WeaponData.db.find(session,
      where: (t) => t.referenceKey.equals(fallback.referenceKey), limit: 1);
  return existing.firstOrNull ??
      await WeaponData.db.insertRow(session, fallback);
}

Future<ArmorData> ensureArmorFixture(
    Session session, ArmorData fallback) async {
  final existing = await ArmorData.db.find(session,
      where: (t) => t.referenceKey.equals(fallback.referenceKey), limit: 1);
  return existing.firstOrNull ??
      await ArmorData.db.insertRow(session, fallback);
}
