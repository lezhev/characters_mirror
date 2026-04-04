// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_sheet_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$characterSheetHash() => r'5af52f25547d3825affd52f8905837caaffe5daa';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [characterSheet].
@ProviderFor(characterSheet)
const characterSheetProvider = CharacterSheetFamily();

/// See also [characterSheet].
class CharacterSheetFamily extends Family<AsyncValue<CharacterData>> {
  /// See also [characterSheet].
  const CharacterSheetFamily();

  /// See also [characterSheet].
  CharacterSheetProvider call(
    int characterId,
  ) {
    return CharacterSheetProvider(
      characterId,
    );
  }

  @override
  CharacterSheetProvider getProviderOverride(
    covariant CharacterSheetProvider provider,
  ) {
    return call(
      provider.characterId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'characterSheetProvider';
}

/// See also [characterSheet].
class CharacterSheetProvider extends AutoDisposeFutureProvider<CharacterData> {
  /// See also [characterSheet].
  CharacterSheetProvider(
    int characterId,
  ) : this._internal(
          (ref) => characterSheet(
            ref as CharacterSheetRef,
            characterId,
          ),
          from: characterSheetProvider,
          name: r'characterSheetProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$characterSheetHash,
          dependencies: CharacterSheetFamily._dependencies,
          allTransitiveDependencies:
              CharacterSheetFamily._allTransitiveDependencies,
          characterId: characterId,
        );

  CharacterSheetProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.characterId,
  }) : super.internal();

  final int characterId;

  @override
  Override overrideWith(
    FutureOr<CharacterData> Function(CharacterSheetRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CharacterSheetProvider._internal(
        (ref) => create(ref as CharacterSheetRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        characterId: characterId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CharacterData> createElement() {
    return _CharacterSheetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CharacterSheetProvider && other.characterId == characterId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, characterId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CharacterSheetRef on AutoDisposeFutureProviderRef<CharacterData> {
  /// The parameter `characterId` of this provider.
  int get characterId;
}

class _CharacterSheetProviderElement
    extends AutoDisposeFutureProviderElement<CharacterData>
    with CharacterSheetRef {
  _CharacterSheetProviderElement(super.provider);

  @override
  int get characterId => (origin as CharacterSheetProvider).characterId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
