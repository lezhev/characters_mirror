import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/background_step.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/state/background_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/widgets/background_features.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('background tile shows selected border by id', (tester) async {
    final tileBackground = BackgroundData(id: 7, name: 'Артист');
    final selectedBackground = BackgroundData(id: 7, name: 'Артист');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          backgroundStateProvider.overrideWith(
            () => _FakeBackgroundState(
              BackgroundStateModel(
                allBackgrounds: [tileBackground],
                selectedBackground: selectedBackground,
              ),
            ),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: BackgroundTile(background: tileBackground),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final ink = tester.widget<Ink>(find.byType(Ink).first);
    final decoration = ink.decoration! as BoxDecoration;
    final border = decoration.border! as Border;
    expect(border.top.width, 2);
  });

  testWidgets('background features use class-style choices and item cards',
      (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final background = BackgroundData(
      id: 3,
      name: 'Народный герой',
      skillProficiencies: ['Уход за животными'],
      toolProficiencies: ['Инструменты ремесленника'],
      languageCount: 1,
      items: ['Комплект путешественника'],
      suggestedPersonality: const [
        'Я всегда сначала смеюсь. Потом задаю вопросы.',
      ],
    );
    final skillGroup = ClassChoiceGroupData(
      id: 41,
      sourceBackgroundId: background.id,
      type: ClassChoiceType.skill,
      name: 'Навыки',
      selectionCount: 1,
      exclusiveKey: 'background_skill_pick',
      allowDuplicates: false,
    );
    final languageGroup = ClassChoiceGroupData(
      id: 42,
      sourceBackgroundId: background.id,
      type: ClassChoiceType.language,
      name: 'Языки',
      selectionCount: 1,
      exclusiveKey: 'background_language_pick',
      allowDuplicates: false,
    );
    final stepView = BackgroundStepView(
      background: background,
      choiceGroups: [
        ClassChoiceGroupView(
          group: skillGroup,
          options: [
            ClassChoiceOptionData(
              choiceGroupId: 41,
              optionKey: 'survival',
              name: 'Выживание',
            ),
          ],
        ),
        ClassChoiceGroupView(
          group: languageGroup,
          options: [
            ClassChoiceOptionData(
              choiceGroupId: 42,
              optionKey: 'celestial',
              name: 'celestial',
              grantedLanguages: const [Language.celestial],
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: ProviderScope(
          overrides: [
            backgroundStateProvider.overrideWith(
              () => _FakeBackgroundState(
                BackgroundStateModel(
                  selectedBackground: background,
                  stepView: stepView,
                ),
              ),
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: BackgroundFeatures(
                  selectedBackground: background,
                  stepView: stepView,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Владения предыстории'), findsOneWidget);
    expect(find.text('Владения и языки'), findsOneWidget);
    expect(find.text('Навыки'), findsOneWidget);
    expect(find.text('Языки'), findsOneWidget);
    expect(find.byType(CreationChoiceSelector), findsWidgets);
    expect(find.text('Уход за животными'), findsOneWidget);
    expect(find.text('Инструменты ремесленника'), findsOneWidget);
    expect(find.text('Языков на выбор: 1'), findsNothing);
    expect(find.text('Небесный'), findsOneWidget);
    expect(find.text('Комплект путешественника'), findsOneWidget);
    expect(find.text('Я всегда сначала смеюсь'), findsOneWidget);

    final skillTop = tester.getTopLeft(find.text('Владение навыками')).dy;
    final languageTop = tester.getTopLeft(find.text('Языки')).dy;
    final toolTop = tester.getTopLeft(find.text('Владение инструментами')).dy;
    expect(skillTop, lessThan(languageTop));
    expect(languageTop, lessThan(toolTop));

    final promptCard = find.byKey(
      const ValueKey('choice-card-Черты характера_Я всегда сначала смеюсь'),
    );
    await tester.ensureVisible(promptCard);
    await tester.pumpAndSettle();
    await tester.tap(promptCard);
    await tester.pumpAndSettle();

    expect(
      container.read(characterCreationProvider).character.personalityTraits,
      'Я всегда сначала смеюсь. Потом задаю вопросы.',
    );

    final promptInfo = find.byKey(
      const ValueKey('choice-info-Черты характера_Я всегда сначала смеюсь'),
    );
    await tester.ensureVisible(promptInfo);
    await tester.pumpAndSettle();
    await tester.tap(promptInfo);
    await tester.pumpAndSettle();

    expect(find.text('Я всегда сначала смеюсь'), findsWidgets);
    expect(find.text('Потом задаю вопросы.'), findsOneWidget);
  });
}

class _FakeBackgroundState extends BackgroundState {
  _FakeBackgroundState(this.initialState);

  final BackgroundStateModel initialState;

  @override
  Future<BackgroundStateModel> build() async => initialState;
}
