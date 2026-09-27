import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/race_tile_view.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('race selection keeps tile and title geometry stable on mobile',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final races = [
      RaceData(
        id: 1,
        name: 'A very long race name that should be ellipsized',
        imageURL: 'human',
      ),
      RaceData(id: 2, name: 'Elf', imageURL: 'elf'),
    ];
    final container = ProviderContainer(
      overrides: [
        raceStateProvider.overrideWith(() => _FakeRaceState(races)),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: RaceTileView()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final selectedTile = find.byKey(const ValueKey('race-tile-1'));
    final selectedTitle = find.byKey(
      const ValueKey('race-title-1'),
    );
    final neighborTile = find.byKey(const ValueKey('race-tile-2'));
    final tileSizeBefore = tester.getSize(selectedTile);
    final titleRectBefore = tester.getRect(selectedTitle);
    final neighborSizeBefore = tester.getSize(neighborTile);

    await tester.tap(selectedTile);
    await tester.pumpAndSettle();

    expect(tester.getSize(selectedTile), tileSizeBefore);
    expect(tester.getRect(selectedTitle), titleRectBefore);
    expect(tester.getSize(neighborTile), neighborSizeBefore);
    expect(tester.takeException(), isNull);
  });
}

class _FakeRaceState extends RaceState {
  _FakeRaceState(this.races);

  final List<RaceData> races;

  @override
  Future<RaceStateModel> build() async => RaceStateModel(allRaces: races);

  @override
  Future<void> selectRace(RaceData newRace) async {
    state = AsyncValue.data(
      (state.value ?? RaceStateModel(allRaces: races)).copyWith(
        selectedRace: newRace,
      ),
    );
  }

  @override
  void unselectRace() {
    state = AsyncValue.data(
      (state.value ?? RaceStateModel(allRaces: races)).copyWith(
        selectedRace: null,
      ),
    );
  }
}
