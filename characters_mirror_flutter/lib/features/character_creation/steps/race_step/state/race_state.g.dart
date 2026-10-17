// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RaceState)
final raceStateProvider = RaceStateProvider._();

final class RaceStateProvider
    extends $AsyncNotifierProvider<RaceState, RaceStateModel> {
  RaceStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'raceStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$raceStateHash();

  @$internal
  @override
  RaceState create() => RaceState();
}

String _$raceStateHash() => r'e0b5f7a1ab4ec0d0f0d0d35719455eb43bed0532';

abstract class _$RaceState extends $AsyncNotifier<RaceStateModel> {
  FutureOr<RaceStateModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<RaceStateModel>, RaceStateModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RaceStateModel>, RaceStateModel>,
              AsyncValue<RaceStateModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
