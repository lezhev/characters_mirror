import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Structured spell data roundtrip', (sessionBuilder, endpoints) {
    test('healing scaling survives database and protocol roundtrip', () async {
      final saved = await endpoints.spellData.upsert(
          sessionBuilder,
          SpellData(
              referenceKey: 'structured_healing_roundtrip',
              name: 'Healing fixture',
              description: 'Full rules.',
              level: 1,
              isHealing: true,
              healingDice: '1d8',
              healingAddsCastingModifier: true,
              healingScaling: SpellScalingData(
                  mode: SpellScalingMode.slotLevel,
                  scalingBySlotLevel: {1: '1d8', 3: '3d8'})));
      final loaded = (await endpoints.spellData.getAll(sessionBuilder))
          .singleWhere((s) => s.id == saved.id);
      expect(loaded.healingScaling!.scalingBySlotLevel![3], '3d8');
      expect(loaded.healingAddsCastingModifier, true);
      final p = const SpellPresentationResolver().resolve(loaded.toJson(),
          context: const SpellPresentationContext(
              castLevel: 3, castingAbility: 'wisdom', abilityModifier: 2));
      expect(p.highlights.single.value, '3к8 + 2');
      expect(p.description, 'Full rules.');
    });
    test('part-specific scaling does not grow an independent damage part',
        () async {
      final saved = await endpoints.spellData.upsert(
          sessionBuilder,
          SpellData(
              referenceKey: 'structured_parts_roundtrip',
              name: 'Parts fixture',
              level: 4,
              description: 'Full mixed damage rules.',
              damageParts: [
                DamagePartData(
                    formula: '2d8',
                    damageType: DamageType.bludgeoning,
                    scaling: SpellScalingData(
                        mode: SpellScalingMode.slotLevel,
                        scalingBySlotLevel: {4: '2d8', 5: '3d8'})),
                DamagePartData(formula: '4d6', damageType: DamageType.cold),
              ]));
      final loaded = (await endpoints.spellData.getAll(sessionBuilder))
          .singleWhere((s) => s.id == saved.id);
      final p = const SpellPresentationResolver().resolve(loaded.toJson(),
          context: const SpellPresentationContext(castLevel: 5));
      expect(p.highlights.single.value, '3к8 (дробящий) + 4к6 (холод)');
    });
  });
}
