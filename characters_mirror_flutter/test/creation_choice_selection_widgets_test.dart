import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/widgets/race_choice_set_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_group_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_selector.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CreationChoiceSelector', () {
    testWidgets('single toggles one option and clears it on repeated tap',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: _SelectorHarness(
                mode: _SelectorHarnessMode.single,
                selectionLimit: 1,
              ),
            ),
          ),
        ),
      );

      await _expandSelector(tester);
      await tester.tap(find.byKey(const ValueKey('choice-card-a')));
      await tester.pump();
      expect(find.text('selected: a'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('choice-card-a')));
      await tester.pump();
      expect(find.text('selected: -'), findsOneWidget);
    });

    testWidgets('fixed shows selected disabled cards', (tester) async {
      var tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CreationChoiceSelector.fixed(
              items: [
                CreationChoiceSelectorItem(
                  id: 'fixed',
                  title: 'Фиксированный предмет',
                  isSelected: true,
                  isEnabled: false,
                  onTap: () => tapCount++,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey('choice-card-fixed')));
      await tester.pump();
      expect(tapCount, 0);
    });

    testWidgets('multi respects selection limit', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: _SelectorHarness(
                mode: _SelectorHarnessMode.multi,
                selectionLimit: 2,
              ),
            ),
          ),
        ),
      );

      await _expandSelector(tester);
      await tester.tap(find.byKey(const ValueKey('choice-card-a')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('choice-card-b')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('choice-card-c')));
      await tester.pump();

      expect(find.text('selected: a,b'), findsOneWidget);
    });

    testWidgets('counter changes counts and stops at limit', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _SelectorHarness(
              mode: _SelectorHarnessMode.counter,
              selectionLimit: 2,
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey('choice-increment-a')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('choice-increment-a')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('choice-increment-a')));
      await tester.pump();
      expect(find.text('selected: a,a'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('choice-decrement-a')));
      await tester.pump();
      expect(find.text('selected: a'), findsOneWidget);
    });

    testWidgets('info button opens dialog without changing selection',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: _SelectorHarness(
                mode: _SelectorHarnessMode.single,
                selectionLimit: 1,
              ),
            ),
          ),
        ),
      );

      await _expandSelector(tester);
      await tester.tap(find.byKey(const ValueKey('choice-info-a')));
      await tester.pumpAndSettle();

      expect(find.text('A'), findsNWidgets(2));
      expect(find.text('Описание A'), findsNWidgets(2));
      expect(find.text('selected: -'), findsOneWidget);
    });
  });

  group('CreationChoiceGroupCard', () {
    testWidgets('adapts class/background multi choice groups', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: _ChoiceGroupHarness(
                group: ClassChoiceGroupData(
                  id: 2,
                  name: 'Инструменты',
                  type: ClassChoiceType.tool,
                  selectionCount: 2,
                  allowDuplicates: false,
                  exclusiveKey: 'skills_multi',
                ),
                options: [
                  ClassChoiceOptionData(
                    choiceGroupId: 2,
                    optionKey: 'a',
                    name: 'A',
                  ),
                  ClassChoiceOptionData(
                    choiceGroupId: 2,
                    optionKey: 'b',
                    name: 'B',
                  ),
                  ClassChoiceOptionData(
                    choiceGroupId: 2,
                    optionKey: 'c',
                    name: 'C',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await _expandSelector(tester);
      await tester.tap(find.byKey(const ValueKey('choice-card-a')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('choice-card-b')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('choice-card-c')));
      await tester.pump();

      expect(find.text('selected: a,b'), findsOneWidget);
    });

    testWidgets('adapts duplicate choice groups to counter mode',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _ChoiceGroupHarness(
              group: ClassChoiceGroupData(
                id: 4,
                name: 'Инструменты',
                selectionCount: 2,
                allowDuplicates: true,
                exclusiveKey: 'dup_group',
              ),
              options: [
                ClassChoiceOptionData(
                  choiceGroupId: 4,
                  optionKey: 'tool_a',
                  name: 'Инструмент A',
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey('choice-increment-tool_a')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('choice-increment-tool_a')));
      await tester.pump();

      expect(find.text('selected: tool_a,tool_a'), findsOneWidget);
    });
  });

  group('RaceChoiceSetCard', () {
    testWidgets('adapts race cantrip choices to shared selector',
        (tester) async {
      final container = ProviderContainer(
        overrides: [
          raceStateProvider.overrideWith(() => _FakeRaceState()),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Consumer(
                      builder: (context, ref, _) {
                        final choiceSet = RaceChoiceSetData(
                          id: 20,
                          featureId: 200,
                          kind: RaceChoiceKind.cantripChoice,
                          pickCount: 1,
                          choiceOptions: [
                            RaceChoiceOptionData(
                              choiceSetId: 20,
                              optionKey: 'light',
                              name: 'Свет',
                            ),
                          ],
                        );
                        final selectedOptions = ref
                                    .watch(raceStateProvider)
                                    .value
                                    ?.selectedChoiceOptionsByGroup[
                                'race_choice_20'] ??
                            const <RaceChoiceOptionData>[];
                        return RaceChoiceSetCard(
                          choiceSet: choiceSet,
                          selectedOptions: selectedOptions,
                        );
                      },
                    ),
                    Consumer(
                      builder: (context, ref, _) {
                        final state = ref.watch(raceStateProvider);
                        final selected =
                            state.value?.selectedChoiceOptionsByGroup[
                                    'race_choice_20'] ??
                                const <RaceChoiceOptionData>[];
                        final label = selected.isEmpty
                            ? '-'
                            : selected
                                .map((option) => option.optionKey ?? '-')
                                .join(',');
                        return Text('selected: $label');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await _expandSelector(tester);
      await tester.tap(find.byKey(const ValueKey('choice-card-light')));
      await tester.pump();

      expect(find.text('selected: light'), findsOneWidget);
    });
  });

  group('StartingEquipmentBlockCards', () {
    testWidgets('adapts equipment option blocks to shared selector',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: _EquipmentChoiceHarness(),
            ),
          ),
        ),
      );

      await _expandSelector(tester);
      await tester.tap(find.byKey(const ValueKey('choice-card-pack_a')));
      await tester.pump();

      expect(find.text('selected: pack_a'), findsOneWidget);
    });

    testWidgets('adapts fixed equipment blocks and keeps resolutions clickable',
        (tester) async {
      var fixedTapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StartingEquipmentBlockCards(
              blockView: StartingEquipmentBlockView(
                block: StartingEquipmentBlockData(
                  id: 2,
                  blockKey: 'fixed_block',
                  kind: StartingEquipmentBlockKind.fixedGrant,
                  name: 'Фиксированное снаряжение',
                ),
                fixedLines: [
                  StartingEquipmentLineData(
                    blockId: 2,
                    lineKey: 'pack',
                    kind: StartingEquipmentLineKind.catalogRef,
                    displayText: 'Набор путешественника',
                    quantity: 1,
                  ),
                  StartingEquipmentLineData(
                    blockId: 2,
                    lineKey: 'weapon',
                    kind: StartingEquipmentLineKind.weaponCategory,
                    displayText: 'Простое оружие',
                    quantity: 1,
                  ),
                ],
              ),
              selections: const [],
              onClearBlock: (_) {},
              onShowChoiceDialog: (_) async {},
              onShowFixedLineDialog: (_) async {
                fixedTapCount++;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey('choice-card-pack')));
      await tester.pump();
      expect(fixedTapCount, 0);

      await tester.tap(find.byKey(const ValueKey('choice-card-weapon')));
      await tester.pump();
      expect(fixedTapCount, 1);
    });
  });
}

Future<void> _expandSelector(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Показать варианты').first);
  await tester.pumpAndSettle();
}

enum _SelectorHarnessMode {
  single,
  multi,
  counter,
}

class _SelectorHarness extends StatefulWidget {
  const _SelectorHarness({
    required this.mode,
    required this.selectionLimit,
  });

  final _SelectorHarnessMode mode;
  final int selectionLimit;

  @override
  State<_SelectorHarness> createState() => _SelectorHarnessState();
}

class _SelectorHarnessState extends State<_SelectorHarness> {
  List<String> _selected = const [];

  @override
  Widget build(BuildContext context) {
    final items = ['a', 'b', 'c'].map((id) {
      final count = _selected.where((item) => item == id).length;
      return CreationChoiceSelectorItem(
        id: id,
        title: id.toUpperCase(),
        subtitle: 'Описание ${id.toUpperCase()}',
        isSelected: _selected.contains(id),
        count: count,
        onTap: () {
          setState(() {
            final selected = [..._selected];
            if (widget.mode == _SelectorHarnessMode.single) {
              _selected = selected.contains(id) ? const [] : [id];
              return;
            }
            if (selected.contains(id)) {
              selected.remove(id);
            } else if (selected.length < widget.selectionLimit) {
              selected.add(id);
            }
            _selected = selected;
          });
        },
        onInfoTap: () => showChoiceOptionPlaceholderDialog(
          context: context,
          title: id.toUpperCase(),
          description: 'Описание ${id.toUpperCase()}',
        ),
        onIncrement: () {
          setState(() {
            if (_selected.length < widget.selectionLimit) {
              _selected = [..._selected, id];
            }
          });
        },
        onDecrement: () {
          setState(() {
            final selected = [..._selected];
            selected.remove(id);
            _selected = selected;
          });
        },
      );
    }).toList();

    final selector = switch (widget.mode) {
      _SelectorHarnessMode.single => CreationChoiceSelector.single(
          title: 'Выбор',
          switchKey: 'selector_single',
          autoScrollOnExpand: false,
          items: items,
        ),
      _SelectorHarnessMode.multi => CreationChoiceSelector.multi(
          title: 'Выбор',
          switchKey: 'selector_multi',
          selectionLimit: widget.selectionLimit,
          autoScrollOnExpand: false,
          items: items,
        ),
      _SelectorHarnessMode.counter => CreationChoiceSelector.counter(
          title: 'Выбор',
          switchKey: 'selector_counter',
          selectionLimit: widget.selectionLimit,
          items: items,
        ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        selector,
        const SizedBox(height: 12),
        Text('selected: ${_selected.isEmpty ? '-' : _selected.join(',')}'),
      ],
    );
  }
}

class _ChoiceGroupHarness extends StatefulWidget {
  const _ChoiceGroupHarness({
    required this.group,
    required this.options,
  });

  final ClassChoiceGroupData group;
  final List<ClassChoiceOptionData> options;

  @override
  State<_ChoiceGroupHarness> createState() => _ChoiceGroupHarnessState();
}

class _ChoiceGroupHarnessState extends State<_ChoiceGroupHarness> {
  List<ClassChoiceOptionData> _selectedOptions = const [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CreationChoiceGroupCard(
          groupView: ClassChoiceGroupView(
            group: widget.group,
            options: widget.options,
          ),
          selectedOptions: _selectedOptions,
          onToggleOption: (group, option) {
            setState(() {
              final selected = [..._selectedOptions];
              final optionKey = option.optionKey?.trim();
              if (optionKey == null || optionKey.isEmpty) {
                return;
              }

              final selectionCount = group.selectionCount ?? 1;
              final existingIndex = selected.indexWhere(
                (item) => item.optionKey?.trim() == optionKey,
              );

              if (selectionCount <= 1) {
                _selectedOptions = existingIndex != -1 ? const [] : [option];
                return;
              }

              if (existingIndex != -1) {
                selected.removeAt(existingIndex);
              } else if (selected.length < selectionCount) {
                selected.add(option);
              }
              _selectedOptions = selected;
            });
          },
          onIncrementOption: (_, option) {
            setState(() {
              final selected = [..._selectedOptions];
              final limit = widget.group.selectionCount ?? 1;
              if (selected.length >= limit) {
                return;
              }
              selected.add(option);
              _selectedOptions = selected;
            });
          },
          onDecrementOption: (_, option) {
            setState(() {
              final selected = [..._selectedOptions];
              final index = selected.indexWhere(
                (item) => item.optionKey == option.optionKey,
              );
              if (index == -1) {
                return;
              }
              selected.removeAt(index);
              _selectedOptions = selected;
            });
          },
          onClearGroup: (_) {
            setState(() {
              _selectedOptions = const [];
            });
          },
        ),
        const SizedBox(height: 12),
        Text(
          'selected: ${_selectedOptions.isEmpty ? '-' : _selectedOptions.map((option) => option.optionKey).join(',')}',
        ),
      ],
    );
  }
}

class _EquipmentChoiceHarness extends StatefulWidget {
  @override
  State<_EquipmentChoiceHarness> createState() =>
      _EquipmentChoiceHarnessState();
}

class _EquipmentChoiceHarnessState extends State<_EquipmentChoiceHarness> {
  List<CharacterStartingEquipmentSelectionData> _selections = const [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StartingEquipmentBlockCards(
          blockView: StartingEquipmentBlockView(
            block: StartingEquipmentBlockData(
              id: 1,
              blockKey: 'choice_block',
              kind: StartingEquipmentBlockKind.choice,
              name: 'Снаряжение',
              selectionCount: 1,
            ),
            options: [
              StartingEquipmentOptionView(
                option: StartingEquipmentOptionData(
                  blockId: 1,
                  optionKey: 'pack_a',
                  name: 'Набор A',
                ),
              ),
              StartingEquipmentOptionView(
                option: StartingEquipmentOptionData(
                  blockId: 1,
                  optionKey: 'pack_b',
                  name: 'Набор B',
                ),
              ),
            ],
          ),
          selections: _selections,
          onClearBlock: (_) {
            setState(() {
              _selections = const [];
            });
          },
          onShowChoiceDialog: (optionView) async {
            setState(() {
              _selections = [
                CharacterStartingEquipmentSelectionData(
                  sourceType: ChoiceSourceType.classData,
                  sourceId: 1,
                  blockKey: 'choice_block',
                  optionKey: optionView.option?.optionKey,
                  selectionIndex: 0,
                ),
              ];
            });
          },
          onShowFixedLineDialog: (_) async {},
        ),
        const SizedBox(height: 12),
        Text(
          'selected: ${_selections.isEmpty ? '-' : _selections.single.optionKey}',
        ),
      ],
    );
  }
}

class _FakeRaceState extends RaceState {
  @override
  Future<RaceStateModel> build() async => const RaceStateModel();

  @override
  void toggleChoiceOption(
    RaceChoiceSetData choiceSet,
    RaceChoiceOptionData option,
  ) {
    final current = state.value ?? const RaceStateModel();
    final groupKey = choiceSetGroupKey(choiceSet.id);
    if (groupKey == null) {
      return;
    }

    final selectedByGroup = Map<String, List<RaceChoiceOptionData>>.from(
      current.selectedChoiceOptionsByGroup,
    );
    final selected = [...?selectedByGroup[groupKey]];
    final optionKey = option.optionKey?.trim();
    if (optionKey == null || optionKey.isEmpty) {
      return;
    }

    final existingIndex = selected.indexWhere(
      (item) => item.optionKey?.trim() == optionKey,
    );

    if (existingIndex != -1) {
      selected.removeAt(existingIndex);
    } else {
      final pickCount = choiceSet.pickCount ?? 1;
      if (pickCount <= 1) {
        selected
          ..clear()
          ..add(option);
      } else if (selected.length < pickCount) {
        selected.add(option);
      }
    }

    if (selected.isEmpty) {
      selectedByGroup.remove(groupKey);
    } else {
      selectedByGroup[groupKey] = selected;
    }

    state = AsyncValue.data(
      current.copyWith(selectedChoiceOptionsByGroup: selectedByGroup),
    );
  }
}
