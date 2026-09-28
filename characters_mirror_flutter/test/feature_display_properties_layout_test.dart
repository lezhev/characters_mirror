import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/feature_display_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('labels and values remain compact and wrap at narrow width',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 170,
          child: FeatureDisplayProperties(properties: [
            FeatureDisplayPropertyView(
              key: 'short',
              label: 'Урон ярости',
              value: '+2',
            ),
            FeatureDisplayPropertyView(
              key: 'long',
              label: 'Суммарный уровень ячеек',
              value: '1к10 + 5',
            ),
          ]),
        ),
      ),
    ));

    expect(find.text('Урон ярости: +2'), findsOneWidget);
    expect(find.text('Суммарный уровень ячеек: 1к10 + 5'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
