// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_sheet_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(characterSheet)
final characterSheetProvider = CharacterSheetFamily._();

final class CharacterSheetProvider
    extends
        $FunctionalProvider<
          AsyncValue<CharacterData>,
          CharacterData,
          FutureOr<CharacterData>
        >
    with $FutureModifier<CharacterData>, $FutureProvider<CharacterData> {
  CharacterSheetProvider._({
    required CharacterSheetFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'characterSheetProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$characterSheetHash();

  @override
  String toString() {
    return r'characterSheetProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CharacterData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CharacterData> create(Ref ref) {
    final argument = this.argument as int;
    return characterSheet(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CharacterSheetProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$characterSheetHash() => r'5af52f25547d3825affd52f8905837caaffe5daa';

final class CharacterSheetFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CharacterData>, int> {
  CharacterSheetFamily._()
    : super(
        retry: null,
        name: r'characterSheetProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CharacterSheetProvider call(int characterId) =>
      CharacterSheetProvider._(argument: characterId, from: this);

  @override
  String toString() => r'characterSheetProvider';
}
