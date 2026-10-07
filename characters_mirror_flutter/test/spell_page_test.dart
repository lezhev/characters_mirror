import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_results_overlay.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/segmented_stat_bar.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/spell_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('spell stat cards keep labels and values without icons',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 280,
            child: SegmentedStatBar(
              segments: [
                SegmentedStatBarItem(
                  label: 'Спасбросок',
                  value: '13',
                ),
                SegmentedStatBarItem(
                  label: 'Атака',
                  value: '+5',
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Спасбросок'), findsOneWidget);
    expect(find.text('13'), findsOneWidget);
    expect(find.text('Атака'), findsOneWidget);
    expect(find.text('+5'), findsOneWidget);
    expect(find.byType(Icon), findsNothing);
  });

  testWidgets('spell page shows spell stats header', (tester) async {
    final castLevels = <int>[];
    final slotUpdates = <int, int>{};

    await tester.pumpWidget(
      MaterialApp(
        home: RollResultsOverlay(
          child: Scaffold(
            body: SpellPageContent(
              onSpellCast: (spell) async => castLevels.add(spell.level ?? 0),
              onSlotCountChanged: (level, available) async {
                slotUpdates[level] = available;
              },
              character: CharacterData(
                classEntries: [
                  CharacterClassEntryData(
                    classOrder: 0,
                    classData: ClassData(
                      spellcastingAbilityValue: Ability.wisdom,
                    ),
                  ),
                ],
                derived: CharacterDerivedData(
                  proficiencyBonus: 2,
                  abilityModifiers: const {Ability.wisdom: 3},
                  spellSlots: const {1: 2, 2: 1},
                ),
                spellSelections: [
                  CharacterSpellSelectionData(
                    selectionIndex: 0,
                    spell: SpellData(
                      referenceKey: 'fire_bolt',
                      name: 'Fire Bolt',
                      level: 0,
                      requiresAttackRoll: true,
                    ),
                  ),
                  CharacterSpellSelectionData(
                    selectionIndex: 1,
                    spell: SpellData(
                      referenceKey: 'burning_hands',
                      name: 'Burning Hands',
                      shortDescription:
                          'Конус огня обжигает существ перед вами.',
                      description:
                          'Каждое существо в 15-футовом конусе делает спасбросок Ловкости.',
                      castingTime: '1 действие',
                      range: 'На себя',
                      duration: 'Мгновенно',
                      level: 1,
                      requiresSavingThrow: true,
                      savingThrowAbility: 'dexterity',
                      requiresVerbal: true,
                      requiresSomatic: true,
                      requiresMaterial: true,
                    ),
                  ),
                  CharacterSpellSelectionData(
                    selectionIndex: 2,
                    spell: SpellData(
                      referenceKey: 'invisibility',
                      name: 'Invisibility',
                      description:
                          'Существо, которого вы касаетесь, становится невидимым до окончания заклинания.',
                      level: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Заклинания'), findsOneWidget);
    expect(find.byIcon(Icons.tune), findsOneWidget);
    expect(find.text('Спасбросок'), findsOneWidget);
    expect(find.text('13'), findsOneWidget);
    expect(find.text('Атака'), findsWidgets);
    expect(find.text('+5'), findsNWidgets(2));
    expect(find.byIcon(Icons.gpp_maybe_outlined), findsNothing);
    expect(find.byIcon(Icons.auto_fix_high), findsNothing);
    expect(find.text('Заговоры'), findsOneWidget);
    expect(find.text('Fire Bolt'), findsOneWidget);
    expect(find.text('Круг 1'), findsOneWidget);
    expect(find.text('Burning Hands'), findsOneWidget);
    expect(find.text('Конус огня обжигает существ перед вами.'), findsNothing);
    expect(find.text('DEX спасбросок'), findsNothing);
    expect(find.text('V'), findsNothing);
    expect(find.text('S'), findsNothing);
    expect(find.text('M'), findsNothing);
    expect(find.text('Круг 2'), findsOneWidget);
    expect(find.text('Invisibility'), findsOneWidget);
    expect(
      find.text('Существо, которого вы касаетесь, становится невидимым до...'),
      findsNothing,
    );
    expect(find.byIcon(Icons.auto_awesome), findsNWidgets(2));
    expect(find.byIcon(Icons.bookmark), findsNothing);
    expect(find.byIcon(Icons.bookmark_border), findsNothing);
    expect(
      find.text(
        'Каждое существо в 15-футовом конусе делает спасбросок Ловкости.',
      ),
      findsNothing,
    );

    await tester.tap(find.widgetWithText(Card, 'Burning Hands'));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Каждое существо в 15-футовом конусе делает спасбросок Ловкости.',
      ),
      findsOneWidget,
    );
    expect(find.text('Burning Hands'), findsWidgets);
    expect(
        find.descendant(
            of: find.byType(AlertDialog), matching: find.text('1 уровень')),
        findsOneWidget);

    await tester.tap(find.text('Закрыть'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('spell-slot-Круг 1-0')));
    await tester.pump();

    expect(slotUpdates[1], 1);

    await tester.tap(find.byKey(const ValueKey('cast-spell-burning_hands')));
    await tester.pump();

    expect(castLevels, contains(1));
    expect(
      find.text(
        'Цель должна пройти спасбросок Ловкости со сложностью 13',
      ),
      findsOneWidget,
    );
    expect(find.text('1 действие'), findsOneWidget);
    expect(find.text('На себя'), findsOneWidget);
    expect(find.text('Мгновенно'), findsOneWidget);
  });

  testWidgets('spell page shows empty stat labels without spellcasting ability',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SpellPageContent(character: CharacterData()),
        ),
      ),
    );

    expect(find.text('—'), findsNWidgets(2));
  });

  testWidgets('spell settings store bonuses relative to base stats',
      (tester) async {
    int? savedDcBonus;
    int? savedAttackBonus;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SpellPageContent(
            onSpellcastingBonusesChanged: (saveDcBonus, attackBonus) async {
              savedDcBonus = saveDcBonus;
              savedAttackBonus = attackBonus;
            },
            character: CharacterData(
              customSpellSaveDcBonus: 1,
              customSpellAttackBonus: 2,
              classEntries: [
                CharacterClassEntryData(
                  classOrder: 0,
                  classData: ClassData(
                    spellcastingAbilityValue: Ability.wisdom,
                  ),
                ),
              ],
              derived: CharacterDerivedData(
                proficiencyBonus: 2,
                abilityModifiers: const {Ability.wisdom: 3},
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('14'), findsOneWidget);
    expect(find.text('+7'), findsOneWidget);

    final settingsButton = find.widgetWithIcon(TextButton, Icons.tune);
    expect(settingsButton, findsOneWidget);
    await tester.tapAt(tester.getCenter(settingsButton));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Настройки заклинаний'), findsOneWidget);
    await tester.enterText(
      find.byKey(const ValueKey('spell-save-dc-field')),
      '15',
    );
    await tester.enterText(
      find.byKey(const ValueKey('spell-attack-bonus-field')),
      '6',
    );
    await tester.pump();

    expect(savedDcBonus, 2);
    expect(savedAttackBonus, 1);
  });

  testWidgets('prepared spell classes show prepared spells on main page',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SpellPageContent(
            onSpellCast: (_) async {},
            character: CharacterData(
              classEntries: [
                CharacterClassEntryData(
                  classOrder: 0,
                  classData: ClassData(
                    spellcastingAbilityValue: Ability.wisdom,
                  ),
                ),
              ],
              derived: CharacterDerivedData(
                proficiencyBonus: 2,
                abilityModifiers: const {Ability.wisdom: 3},
                spellSlots: const {1: 2},
              ),
              spellSelections: [
                CharacterSpellSelectionData(
                  selectionIndex: 0,
                  kind: CharacterSpellSelectionKind.knownSpell,
                  spell: SpellData(
                    referenceKey: 'bless',
                    name: 'Bless',
                    level: 1,
                  ),
                ),
                CharacterSpellSelectionData(
                  selectionIndex: 1,
                  kind: CharacterSpellSelectionKind.preparedSpell,
                  spell: SpellData(
                    referenceKey: 'cure_wounds',
                    name: 'Cure Wounds',
                    level: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Bless'), findsNothing);
    expect(find.text('Cure Wounds'), findsOneWidget);
    expect(find.byIcon(Icons.bookmark_border), findsNothing);
    expect(find.byIcon(Icons.bookmark), findsNothing);
  });

  testWidgets(
      'spell slots change from the filled edge regardless of tap target',
      (tester) async {
    var availableSlots = 4;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return SpellPageContent(
                onSpellCast: (_) async {},
                onSlotCountChanged: (level, available) async {
                  setState(() => availableSlots = available);
                },
                character: CharacterData(
                  currentSpellSlots: {1: availableSlots},
                  derived: CharacterDerivedData(
                    spellSlots: const {1: 5},
                  ),
                  spellSelections: [
                    CharacterSpellSelectionData(
                      selectionIndex: 0,
                      spell: SpellData(
                        referenceKey: 'magic_missile',
                        name: 'Magic Missile',
                        level: 1,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const ValueKey('spell-slot-Круг 1-0')));
    await tester.pump();
    expect(availableSlots, 3);

    await tester.tap(find.byKey(const ValueKey('spell-slot-Круг 1-0')));
    await tester.pump();
    expect(availableSlots, 2);

    await tester.tap(find.byKey(const ValueKey('spell-slot-Круг 1-4')));
    await tester.pump();
    expect(availableSlots, 3);

    await tester.tap(find.byKey(const ValueKey('spell-slot-Круг 1-4')));
    await tester.pump();
    expect(availableSlots, 4);
  });

  testWidgets('spent final spell slot keeps its level row visible',
      (tester) async {
    final title = String.fromCharCodes(const [0x41a, 0x440, 0x443, 0x433]);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SpellPageContent(
            onSpellCast: (_) async {},
            character: CharacterData(
              currentSpellSlots: const {1: 0},
              derived: CharacterDerivedData(
                spellSlots: const {1: 1},
              ),
              spellSelections: [
                CharacterSpellSelectionData(
                  selectionIndex: 0,
                  spell: SpellData(
                    referenceKey: 'magic_missile',
                    name: 'Magic Missile',
                    level: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('$title 1'), findsOneWidget);
    expect(find.byKey(ValueKey('spell-slot-$title 1-0')), findsOneWidget);
  });

  testWidgets('casting concentration spell reports the cast spell',
      (tester) async {
    String? castSpellName;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return SpellPageContent(
                onSpellCast: (spell) async {
                  setState(() => castSpellName = spell.name);
                },
                character: CharacterData(
                  classEntries: [
                    CharacterClassEntryData(
                      classOrder: 0,
                      classData: ClassData(
                        spellcastingAbilityValue: Ability.wisdom,
                      ),
                    ),
                  ],
                  derived: CharacterDerivedData(
                    proficiencyBonus: 2,
                    abilityModifiers: const {Ability.wisdom: 3},
                    spellSlots: const {1: 2},
                  ),
                  spellSelections: [
                    CharacterSpellSelectionData(
                      selectionIndex: 0,
                      spell: SpellData(
                        referenceKey: 'bless',
                        name: 'Bless',
                        level: 1,
                        concentration: true,
                      ),
                    ),
                    CharacterSpellSelectionData(
                      selectionIndex: 1,
                      spell: SpellData(
                        referenceKey: 'fog_cloud',
                        name: 'Fog Cloud',
                        level: 1,
                        concentration: true,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const ValueKey('cast-spell-bless')));
    await tester.pump();

    expect(castSpellName, 'Bless');
    expect(
      find.byKey(const ValueKey('active-concentration-icon')),
      findsNothing,
    );
  });
}
