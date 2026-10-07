import 'package:characters_mirror_server/src/feature_display_properties.dart';
import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  test('server adapter exposes the shared resolved formula value', () {
    final values = resolveDisplayPropertyViews(
      definitions: [
        FeatureDisplayPropertyData(
          key: 'healing',
          label: 'Лечение',
          valueKind: FeatureDisplayPropertyValueKind.formula,
          formula: '1d10 + classLevel',
        ),
      ],
      sourceLevel: 5,
      characterLevel: 12,
    );

    expect(values.single.value, '1к10 + 5');
  });

  test('display formula supports min and max', () {
    final values = resolveDisplayPropertyViews(
      definitions: [
        FeatureDisplayPropertyData(
          key: 'temporary_hp',
          label: 'Временные хиты',
          valueKind: FeatureDisplayPropertyValueKind.formula,
          formula: 'max(1, classLevel + abilityModifier(charisma))',
        ),
      ],
      sourceLevel: 3,
      abilityModifiers: const {'charisma': -4},
    );

    expect(values.single.value, '1');

    final higher = resolveDisplayPropertyViews(
      definitions: [
        FeatureDisplayPropertyData(
          key: 'temporary_hp',
          label: 'Временные хиты',
          valueKind: FeatureDisplayPropertyValueKind.formula,
          formula: 'min(20, classLevel + abilityModifier(charisma))',
        ),
      ],
      sourceLevel: 18,
      abilityModifiers: const {'charisma': 5},
    );

    expect(higher.single.value, '20');
  });
}
