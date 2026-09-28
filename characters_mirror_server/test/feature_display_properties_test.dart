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
}
