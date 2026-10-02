import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/widgets/class_profile_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_selector.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/skill_selection_section.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/helpers/attributes_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final classData = ClassData(
    id: 1,
    name: 'Паладин',
    description:
        'Защитник, который сражается за справедливость и помогает союзникам.',
    hitDieValue: 10,
    primaryAbilities: [Ability.strength, Ability.charisma],
    savingThrowProficiencies: [Ability.wisdom, Ability.charisma],
    spellcastingAbilityValue: Ability.charisma,
    skillCount: 2,
    availableSkills: [Skill.athletics, Skill.insight],
  );

  testWidgets('class profile presents localized abilities without raw fields',
      (tester) async {
    await _pumpProfile(tester, classData, const Size(360, 800));

    expect(find.text('Кость хитов'), findsOneWidget);
    expect(find.text('d10'), findsOneWidget);
    expect(find.text('Ключевые характеристики'), findsOneWidget);
    expect(find.text('Сила, Харизма'), findsOneWidget);
    expect(find.text('Спасброски'), findsOneWidget);
    expect(find.text('Мудрость, Харизма'), findsOneWidget);
    expect(find.text('Магия'), findsOneWidget);
    expect(find.text('Харизма'), findsOneWidget);
    expect(
        find.textContaining('Базовая характеристика заклинаний'), findsNothing);
    expect(find.textContaining('Навыки на выбор'), findsNothing);
    for (final english in [
      'Strength',
      'Dexterity',
      'Constitution',
      'Intelligence',
      'Wisdom',
      'Charisma',
      'Athletics',
    ]) {
      expect(find.textContaining(english), findsNothing);
    }
    final description = tester.widget<Text>(find.text(classData.description!));
    expect(description.textAlign, TextAlign.start);
  });

  testWidgets(
      'class profile wraps on narrow and wide viewports without overflow',
      (tester) async {
    for (final size in [
      const Size(320, 720),
      const Size(390, 844),
      const Size(1024, 768),
    ]) {
      await _pumpProfile(tester, classData, size);
      expect(tester.takeException(), isNull);
      expect(find.text('Сила, Харизма'), findsOneWidget);
    }
  });

  test('shared ability labels cover all six class abilities', () {
    expect(
      Ability.values.map(attributesAbilityLabel).toList(),
      [
        'Сила',
        'Ловкость',
        'Телосложение',
        'Интеллект',
        'Мудрость',
        'Харизма',
      ],
    );
  });

  testWidgets('class skill choices use shared Russian labels', (tester) async {
    final group = SkillSelectionGroupView(
      kind: CharacterSkillSelectionKind.classSkill,
      classDataId: 1,
      selectionCount: 2,
      options: [
        Skill.athletics,
        Skill.insight,
        Skill.intimidation,
        Skill.medicine,
        Skill.persuasion,
        Skill.religion,
      ],
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SkillSelectionSection(
              groups: [group],
              selections: const [],
              onToggleSkill: (_, __) {},
              onClearGroup: (_) {},
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final selector = tester.widget<CreationChoiceSelector>(
      find.byType(CreationChoiceSelector),
    );
    expect(selector.items.map((item) => item.title).toSet(), {
      'Атлетика',
      'Проницательность',
      'Запугивание',
      'Медицина',
      'Убеждение',
      'Религия',
    });
    await tester.tap(find.byTooltip('Показать варианты'));
    await tester.pumpAndSettle();
    expect(find.text('Атлетика'), findsOneWidget);
    expect(find.text('Убеждение'), findsOneWidget);
  });
}

Future<void> _pumpProfile(
  WidgetTester tester,
  ClassData classData,
  Size size,
) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ClassProfileCard(classData: classData),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
