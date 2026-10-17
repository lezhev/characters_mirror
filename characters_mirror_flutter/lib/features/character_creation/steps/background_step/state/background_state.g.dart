// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BackgroundState)
final backgroundStateProvider = BackgroundStateProvider._();

final class BackgroundStateProvider
    extends $AsyncNotifierProvider<BackgroundState, BackgroundStateModel> {
  BackgroundStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backgroundStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backgroundStateHash();

  @$internal
  @override
  BackgroundState create() => BackgroundState();
}

String _$backgroundStateHash() => r'38e338e026ccb266938ccd6d70ed0d4267d7843f';

abstract class _$BackgroundState extends $AsyncNotifier<BackgroundStateModel> {
  FutureOr<BackgroundStateModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<BackgroundStateModel>, BackgroundStateModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<BackgroundStateModel>,
                BackgroundStateModel
              >,
              AsyncValue<BackgroundStateModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
