import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/widgets/race_choice_set_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_group_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CreationChoiceGroupCard', () {
    testWidgets('renders vertical cards and toggles single selection',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _ChoiceGroupHarness(
              group: ClassChoiceGroupData(
                id: 1,
                name: 'Навыки',
                selectionCount: 1,
                allowDuplicates: false,
                exclusiveKey: 'skills',
              ),
              options: [
                ClassChoiceOptionData(
                  choiceGroupId: 1,
                  optionKey: 'acrobatics',
                  name: 'Акробатика',
                ),
                ClassChoiceOptionData(
                  choiceGroupId: 1,
                  optionKey: 'athletics',
                  name: 'Атлетика',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(FilterChip), findsNothing);
      expect(find.byType(ChoiceChip), findsNothing);
      expect(
        find.text('Нажмите, чтобы раскрыть список вариантов.'),
        findsOneWidget,
      );

      await tester.tap(find.byTooltip('Показать варианты'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('choice-card-acrobatics')));
      await tester.pumpAndSettle();
      expect(find.text('selected: acrobatics'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('choice-card-acrobatics')));
      await tester.pumpAndSettle();
      expect(find.text('selected: -'), findsOneWidget);
    });

    testWidgets('respects multi-select limit', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _ChoiceGroupHarness(
              group: ClassChoiceGroupData(
                id: 2,
                name: 'Навыки',
                selectionCount: 2,
                allowDuplicates: false,
                exclusiveKey: 'skills_multi',
              ),
              options: [
                ClassChoiceOptionData(
                    choiceGroupId: 2, optionKey: 'a', name: 'A'),
                ClassChoiceOptionData(
                    choiceGroupId: 2, optionKey: 'b', name: 'B'),
                ClassChoiceOptionData(
                    choiceGroupId: 2, optionKey: 'c', name: 'C'),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byTooltip('Показать варианты'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('choice-card-a')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('choice-card-b')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('choice-card-c')));
      await tester.pumpAndSettle();

      expect(find.text('selected: a,b'), findsOneWidget);
    });

    testWidgets('opens info dialog without changing selection', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _ChoiceGroupHarness(
              group: ClassChoiceGroupData(
                id: 3,
                name: 'Навыки',
                selectionCount: 1,
                allowDuplicates: false,
                exclusiveKey: 'skills_info',
              ),
              options: [
                ClassChoiceOptionData(
                  choiceGroupId: 3,
                  optionKey: 'history',
                  name: 'История',
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byTooltip('Показать варианты'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('choice-info-history')));
      await tester.pumpAndSettle();

      expect(find.text('История'), findsNWidgets(2));
      expect(find.text('Описание будет добавлено позже.'), findsOneWidget);
      expect(find.text('selected: -'), findsOneWidget);

      await tester.tap(find.text('Закрыть'));
      await tester.pumpAndSettle();
      expect(find.text('selected: -'), findsOneWidget);
    });

    testWidgets('keeps legacy +/- controls for allowDuplicates',
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

      expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsNothing);

      await tester.tap(find.byIcon(Icons.add_circle_outline));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add_circle_outline));
      await tester.pumpAndSettle();

      expect(find.text('selected: tool_a,tool_a'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.remove_circle_outline));
      await tester.pumpAndSettle();

      expect(find.text('selected: tool_a'), findsOneWidget);
    });
  });

  group('RaceChoiceSetCard', () {
    testWidgets('uses shared card selector and toggles race option',
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
              body: Column(
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
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Показать варианты'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('choice-card-light')));
      await tester.pumpAndSettle();

      expect(find.text('selected: light'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('choice-info-light')));
      await tester.pumpAndSettle();

      expect(find.text('Свет'), findsNWidgets(2));
      expect(find.text('Описание будет добавлено позже.'), findsOneWidget);
    });
  });
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
                if (existingIndex != -1) {
                  _selectedOptions = const [];
                } else {
                  _selectedOptions = [option];
                }
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

class _FakeRaceState extends RaceState {
  @override
  Future<RaceStateModel> build() async => const RaceStateModel();

  @override
  void toggleChoiceOption(
      RaceChoiceSetData choiceSet, RaceChoiceOptionData option) {
    final current = state.value ?? const RaceStateModel();
    final groupKey = choiceSetGroupKey(choiceSet.id);
    if (groupKey == null) {
      return;
    }

    final selectedByGroup = Map<String, List<RaceChoiceOptionData>>.from(
        current.selectedChoiceOptionsByGroup);
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
