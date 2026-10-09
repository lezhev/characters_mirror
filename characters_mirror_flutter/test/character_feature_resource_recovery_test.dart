import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/helpers/spell_slot_recovery_flow.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/character_feature_card.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/spell_slot_recovery_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('resource recovery availability follows spent slots', () {
    final resource = _resource(1);
    final feature = _recoveryFeature(resource);
    CharacterData character(int available) => CharacterData(
          currentSpellSlots: {1: available},
          spellRecoveryTriggers: {
            'classFeature:42:9': SpellSlotRecoveryTriggerData(
              sourceActionId: 'short-rest',
              trigger: FeatureResourceTrigger.shortRest,
            ),
          },
          derived: CharacterDerivedData(
            spellSlots: {1: 2},
            activeFeatures: [feature],
          ),
        );

    expect(
      canRecoverFeatureResource(character(2).toJson(), feature, resource),
      isFalse,
    );
    expect(
      canRecoverFeatureResource(character(1).toJson(), feature, resource),
      isTrue,
    );
  });

  testWidgets('recovery resource spends only after dialog confirmation',
      (tester) async {
    var current = 1;
    var ordinaryDecrements = 0;
    await tester.pumpWidget(_featureCard(
      resource: _resource(current),
      canSpend: (_) => true,
      onSetResource: (_, __) async => ordinaryDecrements++,
      onSpendResource: (resource) async {
        final selected = await showDialog<Map<int, int>>(
          context: tester.element(find.byType(CharacterFeatureCard)),
          builder: (_) => const SpellSlotRecoveryDialog(
            title: 'Arcane Recovery',
            options: {1: 2},
            budget: 2,
          ),
        );
        if (selected != null) current -= 1;
      },
    ));

    await _expand(tester);
    await tester.tap(find.byTooltip('Потратить ресурс'));
    await tester.pumpAndSettle();
    expect(current, 1);
    expect(ordinaryDecrements, 0);
    await tester.tap(find.text('Отмена'));
    await tester.pumpAndSettle();
    expect(current, 1);
    expect(ordinaryDecrements, 0);

    await tester.tap(find.byTooltip('Потратить ресурс'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('recovery-increase-1')));
    await tester.pump();
    expect(find.text('Выбрано: 1 / 2'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('confirm-spell-slot-recovery')));
    await tester.pumpAndSettle();
    expect(current, 0);
    expect(ordinaryDecrements, 0);
  });

  testWidgets('recovery spend is disabled when no slots are recoverable',
      (tester) async {
    await tester.pumpWidget(_featureCard(
      resource: _resource(1),
      canSpend: (_) => false,
      onSetResource: (_, __) async {},
      onSpendResource: (_) async {},
    ));
    await _expand(tester);
    final spend = tester.widget<IconButton>(
      find.widgetWithIcon(IconButton, Icons.remove_rounded),
    );
    expect(spend.onPressed, isNull);
  });

  testWidgets('ordinary feature resource still uses its decrement callback',
      (tester) async {
    var decrementedTo = -1;
    await tester.pumpWidget(_featureCard(
      resource: _resource(1),
      canSpend: (_) => true,
      onSetResource: (_, current) async => decrementedTo = current,
      onSpendResource: (_) async {},
      recoveryEffects: const [],
    ));
    await _expand(tester);
    await tester.tap(find.byTooltip('Потратить ресурс'));
    await tester.pump();
    expect(decrementedTo, 0);
  });

  testWidgets('short rest recovery effect gets its presentation label',
      (tester) async {
    await tester.pumpWidget(_featureCard(
      resource: _resource(1, resetOn: RestType.dawn),
      canSpend: (_) => true,
      onSetResource: (_, __) async {},
      onSpendResource: (_) async {},
    ));
    await _expand(tester);
    expect(find.text('После короткого отдыха'), findsOneWidget);
    expect(find.text('На рассвете'), findsNothing);
  });
}

Future<void> _expand(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.expand_more));
  await tester.pumpAndSettle();
}

Widget _featureCard({
  required CharacterResourceViewData resource,
  required bool Function(CharacterResourceViewData) canSpend,
  required Future<void> Function(CharacterResourceViewData) onSpendResource,
  required Future<void> Function(String, int) onSetResource,
  List<FeatureResourceEffectData>? recoveryEffects,
}) {
  final feature = _recoveryFeature(resource, recoveryEffects: recoveryEffects);
  return MaterialApp(
    home: Scaffold(
      body: ListView(
        children: [
          CharacterFeatureCard(
            feature: feature,
            onSave: ({name, description, tags}) async {},
            onReset: () async {},
            onSetResource: onSetResource,
            onSpendResource: onSpendResource,
            canSpendResource: canSpend,
          ),
        ],
      ),
    ),
  );
}

CharacterFeatureViewData _recoveryFeature(
  CharacterResourceViewData resource, {
  List<FeatureResourceEffectData>? recoveryEffects,
}) =>
    CharacterFeatureViewData(
      sourceType: CharacterFeatureSourceType.classFeature,
      sourceId: 42,
      sourceClassLevel: 1,
      name: 'Feature',
      defaultName: 'Feature',
      resources: [resource],
      spellSlotRecoveryEffects: recoveryEffects ??
          [
            FeatureResourceEffectData(
              id: 9,
              type: FeatureResourceEffectType.restore,
              targetType: FeatureResourceTargetType.spellSlots,
              activationTrigger: FeatureResourceTrigger.shortRest,
              recoveryPolicy: SpellSlotRecoveryPolicyData(
                mode: SpellSlotRecoveryMode.levelBudget,
                resourceKey: 'recovery',
                levelBudgetBySourceLevel: {1: 2},
              ),
            ),
          ],
    );

CharacterResourceViewData _resource(int current, {RestType? resetOn}) =>
    CharacterResourceViewData(
      key: 'recovery',
      kind: FeatureResourceKind.uses,
      current: current,
      max: 1,
      resetOn: resetOn ?? RestType.longRest,
    );
