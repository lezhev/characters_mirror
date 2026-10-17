// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ClassState)
final classStateProvider = ClassStateProvider._();

final class ClassStateProvider
    extends $AsyncNotifierProvider<ClassState, ClassStateModel> {
  ClassStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'classStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$classStateHash();

  @$internal
  @override
  ClassState create() => ClassState();
}

String _$classStateHash() => r'e65a01269f8b1d20e6f48d5c568db2f1cbd0a0b6';

abstract class _$ClassState extends $AsyncNotifier<ClassStateModel> {
  FutureOr<ClassStateModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ClassStateModel>, ClassStateModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ClassStateModel>, ClassStateModel>,
              AsyncValue<ClassStateModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
