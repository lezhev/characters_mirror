import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/class_features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClassFeatures current level', () {
    testWidgets('renders subclass features inside current level block',
        (tester) async {
      final stepView = _buildStepView(
        currentFeatures: [
          ClassFeatureData(
            id: 90,
            parentClassId: 1,
            name: 'Базовая подготовка',
            level: 1,
          ),
        ],
        currentSubclassFeatures: [
          SubclassFeatureData(
            id: 91,
            parentSubclassId: 10,
            name: 'Пробуждённый разум',
            level: 1,
            description: 'Подклассное умение текущего уровня.',
          ),
        ],
        futureFeatures: const [],
        futureSubclassFeatures: const [],
        progression: const [],
      );

      await _pumpClassFeatures(tester, stepView);

      expect(find.text('Умения текущего уровня'), findsOneWidget);
      expect(find.text('Умения подкласса'), findsNothing);
      expect(find.text('Базовая подготовка'), findsOneWidget);
      expect(find.text('Пробуждённый разум'), findsOneWidget);
      expect(find.text('Подклассное умение текущего уровня.'), findsOneWidget);
    });
  });

  group('ClassFeatures future progression', () {
    testWidgets(
        'renders a single future progression block for class and subclass features',
        (tester) async {
      final stepView = _buildStepView(
        currentFeatures: const [],
        currentSubclassFeatures: const [],
        futureFeatures: [
          ClassFeatureData(
            id: 100,
            parentClassId: 1,
            name: 'Выбор архетипа',
            level: 2,
          ),
        ],
        futureSubclassFeatures: [
          SubclassFeatureData(
            id: 200,
            parentSubclassId: 10,
            name: 'Иллюзорная магия',
            level: 2,
          ),
        ],
        progression: [
          ClassLevelData(
            classDataId: 1,
            level: 2,
            subclassFeatureIds: const [200],
            resourceSummary: 'Открывается специализация подкласса.',
          ),
        ],
      );

      await _pumpClassFeatures(tester, stepView);

      expect(find.text('Будущая прогрессия'), findsOneWidget);
      expect(find.text('Будущие умения подкласса'), findsNothing);

      await tester.tap(find.text('Будущая прогрессия'));
      await tester.pumpAndSettle();

      expect(find.text('Выбор архетипа'), findsOneWidget);
      expect(find.text('Иллюзорная магия'), findsOneWidget);
    });

    testWidgets('shows subclass features in the same future progression block',
        (tester) async {
      final stepView = _buildStepView(
        currentFeatures: const [],
        currentSubclassFeatures: const [],
        futureFeatures: [
          ClassFeatureData(
            id: 101,
            parentClassId: 1,
            name: 'Потусторонний покровитель',
            level: 2,
          ),
        ],
        futureSubclassFeatures: [
          SubclassFeatureData(
            id: 201,
            parentSubclassId: 10,
            name: 'Боевое вдохновение',
            level: 2,
            description: 'Даёт реальное умение подкласса на этом уровне.',
          ),
        ],
        progression: const [],
      );

      await _pumpClassFeatures(tester, stepView);
      await tester.tap(find.text('Будущая прогрессия'));
      await tester.pumpAndSettle();

      expect(find.text('Уровень 2: Потусторонний покровитель'), findsOneWidget);
      expect(find.text('Боевое вдохновение'), findsOneWidget);
      expect(find.text('Даёт реальное умение подкласса на этом уровне.'),
          findsOneWidget);
      expect(find.text('Будущие умения подкласса'), findsNothing);
    });
  });
}

Future<void> _pumpClassFeatures(
  WidgetTester tester,
  ClassStepView stepView,
) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        classRepositoryProvider.overrideWithValue(
          _FakeClassRepository(classes: [stepView.classData!]),
        ),
      ],
      child: MaterialApp(
        theme: darkTheme,
        home: Scaffold(
          body: ClassFeatures(
            stepView: stepView,
            selectedLevel: 1,
          ),
        ),
      ),
    ),
  );

  await tester.pumpAndSettle();
}

ClassStepView _buildStepView({
  required List<ClassFeatureData> currentFeatures,
  required List<SubclassFeatureData> currentSubclassFeatures,
  required List<ClassFeatureData> futureFeatures,
  required List<SubclassFeatureData> futureSubclassFeatures,
  required List<ClassLevelData> progression,
}) {
  return ClassStepView(
    classData: ClassData(
      id: 1,
      name: 'Wizard',
      imageURL: 'wizard',
      subclassChoiceLevel: 2,
    ),
    selectedLevel: 1,
    currentLevelFeatures: currentFeatures,
    currentSubclassFeatures: currentSubclassFeatures,
    futureLevelFeatures: futureFeatures,
    futureSubclassFeatures: futureSubclassFeatures,
    progression: progression,
  );
}

class _FakeClassRepository extends ClassRepository {
  _FakeClassRepository({
    required this.classes,
  });

  final List<ClassData> classes;

  @override
  Future<List<ClassData>> getAll() async => classes;
}
