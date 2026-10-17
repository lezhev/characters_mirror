// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_creation_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CharacterCreation)
final characterCreationProvider = CharacterCreationProvider._();

final class CharacterCreationProvider
    extends $NotifierProvider<CharacterCreation, CharacterCreationState> {
  CharacterCreationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'characterCreationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$characterCreationHash();

  @$internal
  @override
  CharacterCreation create() => CharacterCreation();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CharacterCreationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CharacterCreationState>(value),
    );
  }
}

String _$characterCreationHash() => r'6bc5e78ba7a134d5212dfccea7a3e34ae37376c6';

abstract class _$CharacterCreation extends $Notifier<CharacterCreationState> {
  CharacterCreationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<CharacterCreationState, CharacterCreationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CharacterCreationState, CharacterCreationState>,
              CharacterCreationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
