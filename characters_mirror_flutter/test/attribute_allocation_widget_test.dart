import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/selection_type.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/state/attribute_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/attribute_selection.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/manual_input_column.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/purchace_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Point Buy score immediately follows plus and minus changes',
      (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container
        .read(attributeStateProvider.notifier)
        .changeType(SelectType.purchace);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(body: PurchaceColumn()),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pump();
    expect(
      tester
          .widget<Text>(
            find.byKey(const ValueKey('attribute-score-strength')),
          )
          .data,
      '9',
    );
    expect(container.read(attributeStateProvider).purchacePoints, 26);

    await tester.tap(find.byIcon(Icons.remove).first);
    await tester.pump();
    expect(
      tester
          .widget<Text>(
            find.byKey(const ValueKey('attribute-score-strength')),
          )
          .data,
      '8',
    );
    expect(container.read(attributeStateProvider).purchacePoints, 27);
  });

  testWidgets('manual input keeps values above twenty', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container
        .read(attributeStateProvider.notifier)
        .changeType(SelectType.manual);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(body: ManualInputColumn()),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('manual-input-strength')),
      '25',
    );
    await tester.pump();

    expect(
      container
          .read(attributeStateProvider)
          .assignedAttributes[Attribute.strength],
      25,
    );
  });

  testWidgets('assigned score can be dragged to move or swap', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final attributes = container.read(attributeStateProvider.notifier);
    attributes.onAcceptWithDetailes(
      DragTargetDetails<int>(data: 15, offset: Offset.zero),
      Attribute.strength,
    );
    attributes.onAcceptWithDetailes(
      DragTargetDetails<int>(data: 14, offset: Offset.zero),
      Attribute.dexterity,
    );
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(body: Column(children: [AttributeSelection()])),
        ),
      ),
    );
    await tester.pumpAndSettle();

    Future<void> drag(Attribute from, Attribute to) async {
      final source = tester.getRect(
        find.byKey(ValueKey('attribute-value-${from.name}')),
      );
      final target = tester.getRect(
        find.byKey(ValueKey('attribute-value-${to.name}')),
      );
      await tester.drag(
        find.byKey(ValueKey('attribute-value-${from.name}')),
        target.center - source.center,
      );
      await tester.pumpAndSettle();
    }

    await drag(Attribute.strength, Attribute.dexterity);
    var state = container.read(attributeStateProvider);
    expect(state.assignedAttributes[Attribute.strength], 14);
    expect(state.assignedAttributes[Attribute.dexterity], 15);

    await drag(Attribute.dexterity, Attribute.wisdom);
    state = container.read(attributeStateProvider);
    expect(state.assignedAttributes[Attribute.dexterity], 0);
    expect(state.assignedAttributes[Attribute.wisdom], 15);
    expect(tester.takeException(), isNull);
  });

  testWidgets('attribute rows stay aligned on a narrow viewport',
      (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: Column(children: [AttributeSelection()]),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    Future<void> expectAlignedRows() async {
      for (final attribute in Attribute.values) {
        final nameRect = tester.getRect(
          find.byKey(ValueKey('attribute-name-${attribute.name}')),
        );
        final valueRect = tester.getRect(
          find.byKey(ValueKey('attribute-value-${attribute.name}')),
        );
        expect(nameRect.top, valueRect.top);
        expect(nameRect.height, valueRect.height);
      }
      expect(tester.takeException(), isNull);
    }

    await expectAlignedRows();
    await tester.binding.setSurfaceSize(const Size(1024, 800));
    await tester.pumpAndSettle();
    await expectAlignedRows();
  });
}
