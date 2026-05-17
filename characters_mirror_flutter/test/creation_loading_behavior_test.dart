import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/state/background_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/class_step.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/race_step.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('Delayed creation shimmer', () {
    testWidgets('does not appear when loading finishes before delay',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: _LoadingHarness(
            loadDuration: Duration(milliseconds: 100),
          ),
        ),
      );

      expect(find.text('shimmer'), findsNothing);

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump();

      expect(find.text('ready'), findsOneWidget);
      expect(find.text('shimmer'), findsNothing);
    });

    testWidgets('appears when loading exceeds delay', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: _LoadingHarness(
            loadDuration: Duration(milliseconds: 250),
          ),
        ),
      );

      expect(find.text('shimmer'), findsNothing);

      await tester.pump(const Duration(milliseconds: 181));

      expect(find.text('shimmer'), findsOneWidget);
      expect(find.text('ready'), findsNothing);

      await tester.pump(const Duration(milliseconds: 69));
      await tester.pump();

      expect(find.text('ready'), findsOneWidget);
      expect(find.text('shimmer'), findsNothing);
    });
  });

  group('Creation step loading behavior', () {
    testWidgets('keeps warmed race and class state alive between visits',
        (tester) async {
      final raceRepository = _CountingRaceRepository(
        responseDelay: const Duration(milliseconds: 250),
      );
      final classRepository = _CountingClassRepository(
        responseDelay: const Duration(milliseconds: 250),
      );
      final container = ProviderContainer(
        overrides: [
          raceRepositoryProvider.overrideWithValue(raceRepository),
          classRepositoryProvider.overrideWithValue(classRepository),
        ],
      );
      addTearDown(container.dispose);
      _setLargeSurface(tester);

      final router = GoRouter(
        initialLocation: '/create/race',
        routes: [
          GoRoute(
            path: '/create/race',
            builder: (_, __) => const RaceStep(),
          ),
          GoRoute(
            path: '/create/classStep',
            builder: (_, __) => const ClassStep(),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(
            theme: darkTheme,
            routerConfig: router,
          ),
        ),
      );

      expect(find.byType(CreationShimmer), findsNothing);

      await tester.pump(const Duration(milliseconds: 181));

      expect(find.byType(CreationShimmer), findsOneWidget);

      await tester.pumpAndSettle();

      expect(raceRepository.getAllCallCount, 1);

      router.go('/create/classStep');
      await tester.pump();
      expect(find.byType(CreationShimmer), findsNothing);

      await tester.pump(const Duration(milliseconds: 181));
      expect(find.byType(CreationShimmer), findsOneWidget);

      await tester.pumpAndSettle();

      expect(classRepository.getAllCallCount, 1);

      router.go('/create/race');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));

      expect(find.byType(CreationShimmer), findsNothing);
      expect(raceRepository.getAllCallCount, 1);

      router.go('/create/classStep');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));

      expect(find.byType(CreationShimmer), findsNothing);
      expect(classRepository.getAllCallCount, 1);
    });
  });

  test('reset invalidates kept-alive creation step providers', () async {
    final raceRepository = _CountingRaceRepository();
    final classRepository = _CountingClassRepository();
    final backgroundRepository = _CountingBackgroundRepository();
    final container = ProviderContainer(
      overrides: [
        raceRepositoryProvider.overrideWithValue(raceRepository),
        classRepositoryProvider.overrideWithValue(classRepository),
        backgroundRepositoryProvider.overrideWithValue(backgroundRepository),
      ],
    );
    addTearDown(container.dispose);

    final creation = container.read(characterCreationProvider.notifier);
    creation.syncRaceDraft(selectedRace: raceRepository.race);
    creation.syncPrimaryClassDraft(classData: classRepository.classData);
    creation.syncBackgroundDraft(
      selectedBackground: backgroundRepository.background,
    );

    final firstRaceState = await container.read(raceStateProvider.future);
    final firstClassState = await container.read(classStateProvider.future);
    final firstBackgroundState =
        await container.read(backgroundStateProvider.future);

    expect(firstRaceState.selectedRace?.id, raceRepository.race.id);
    expect(firstClassState.selectedClass?.id, classRepository.classData.id);
    expect(
      firstBackgroundState.selectedBackground?.id,
      backgroundRepository.background.id,
    );

    creation.reset();

    final secondRaceState = await container.read(raceStateProvider.future);
    final secondClassState = await container.read(classStateProvider.future);
    final secondBackgroundState =
        await container.read(backgroundStateProvider.future);

    expect(raceRepository.getAllCallCount, 2);
    expect(classRepository.getAllCallCount, 2);
    expect(backgroundRepository.getAllCallCount, 2);
    expect(secondRaceState.selectedRace, isNull);
    expect(secondClassState.selectedClass, isNull);
    expect(secondBackgroundState.selectedBackground, isNull);
  });
}

class _LoadingHarness extends StatefulWidget {
  const _LoadingHarness({
    required this.loadDuration,
  });

  final Duration loadDuration;

  @override
  State<_LoadingHarness> createState() => _LoadingHarnessState();
}

class _LoadingHarnessState extends State<_LoadingHarness> {
  Timer? _timer;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.loadDuration, () {
      if (!mounted) {
        return;
      }
      setState(() {
        _isReady = true;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isReady
          ? const Text('ready')
          : DelayedCreationShimmer(
              shimmerBuilder: (_) => const Text('shimmer'),
            ),
    );
  }
}

class _CountingRaceRepository extends RaceRepository {
  _CountingRaceRepository({
    this.responseDelay = Duration.zero,
  });

  final Duration responseDelay;
  int getAllCallCount = 0;
  final race = RaceData(
    id: 1,
    name: 'Human',
    imageURL: 'human',
    size: CreatureSize.medium,
    speed: 30,
    visionType: SenseType.darkvision,
  );

  @override
  Future<List<RaceData>> getAll() async {
    getAllCallCount += 1;
    if (responseDelay > Duration.zero) {
      await Future<void>.delayed(responseDelay);
    }
    return [race];
  }

  @override
  Future<RaceStepView> getStepView(int raceId) async {
    if (responseDelay > Duration.zero) {
      await Future<void>.delayed(responseDelay);
    }
    return RaceStepView(
      race: race,
      features: const [],
      subraces: const [],
    );
  }
}

class _CountingClassRepository extends ClassRepository {
  _CountingClassRepository({
    this.responseDelay = Duration.zero,
  });

  final Duration responseDelay;
  int getAllCallCount = 0;
  final classData = ClassData(
    id: 2,
    name: 'Fighter',
    imageURL: 'fighter',
  );

  @override
  Future<List<ClassData>> getAll() async {
    getAllCallCount += 1;
    if (responseDelay > Duration.zero) {
      await Future<void>.delayed(responseDelay);
    }
    return [classData];
  }

  @override
  Future<ClassStepView> getStepView(
    int classId, {
    int selectedLevel = 1,
    bool isStartingClass = true,
    int? selectedSubclassId,
    Map<String, int>? abilityScores,
  }) async {
    if (responseDelay > Duration.zero) {
      await Future<void>.delayed(responseDelay);
    }
    return ClassStepView(
      classData: classData,
      selectedLevel: selectedLevel,
      choiceGroups: const [],
    );
  }
}

class _CountingBackgroundRepository extends BackgroundRepository {
  _CountingBackgroundRepository();
  int getAllCallCount = 0;
  final background = BackgroundData(
    id: 3,
    name: 'Acolyte',
    feature: 'Shelter of the Faithful',
  );

  @override
  Future<List<BackgroundData>> getAll() async {
    getAllCallCount += 1;
    return [background];
  }

  @override
  Future<BackgroundStepView> getStepView(int backgroundId) async {
    return BackgroundStepView(
      background: background,
      choiceGroups: const [],
    );
  }
}

void _setLargeSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(1440, 1600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}
