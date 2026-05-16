import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/character_feature_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CharacterFeatureCard resource', () {
    testWidgets('shows pips and current/max for small resources',
        (tester) async {
      final updates = <int>[];

      await _pumpCard(
        tester,
        resource: CharacterResourceViewData(
          key: 'main',
          name: 'Second Wind',
          kind: FeatureResourceKind.uses,
          current: 2,
          max: 3,
          resetOn: RestType.shortRest,
        ),
        onSetResource: (current) async => updates.add(current),
      );

      expect(find.text('2/3'), findsOneWidget);
      expect(find.byIcon(Icons.circle), findsNWidgets(2));
      expect(find.byIcon(Icons.radio_button_unchecked), findsOneWidget);

      await tester.tap(find.byTooltip('Восстановить ресурс'));
      await tester.pump();

      expect(updates, [3]);
    });

    testWidgets('uses compact count without pips for large resources',
        (tester) async {
      await _pumpCard(
        tester,
        resource: CharacterResourceViewData(
          key: 'main',
          name: 'Lay on Hands',
          kind: FeatureResourceKind.points,
          current: 8,
          max: 10,
          resetOn: RestType.longRest,
        ),
        onSetResource: (_) async {},
      );

      expect(find.text('8/10'), findsOneWidget);
      expect(find.byIcon(Icons.circle), findsNothing);
      expect(find.byIcon(Icons.radio_button_unchecked), findsNothing);
    });
  });
}

Future<void> _pumpCard(
  WidgetTester tester, {
  required CharacterResourceViewData resource,
  required Future<void> Function(int current) onSetResource,
}) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: CharacterFeatureCard(
          feature: CharacterFeatureViewData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: 1,
            defaultName: 'Feature',
            name: 'Feature',
            resources: [resource],
          ),
          onSave: ({name, description, tags}) async {},
          onReset: () async {},
          onSetResource: (_, current) => onSetResource(current),
        ),
      ),
    ),
  );
}
