// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AttributeState)
final attributeStateProvider = AttributeStateProvider._();

final class AttributeStateProvider
    extends $NotifierProvider<AttributeState, AttributeStateModel> {
  AttributeStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'attributeStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$attributeStateHash();

  @$internal
  @override
  AttributeState create() => AttributeState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AttributeStateModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AttributeStateModel>(value),
    );
  }
}

String _$attributeStateHash() => r'6f063abfcc033bacbdd7bda0b6e5314e9c90b8a7';

abstract class _$AttributeState extends $Notifier<AttributeStateModel> {
  AttributeStateModel build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AttributeStateModel, AttributeStateModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AttributeStateModel, AttributeStateModel>,
              AttributeStateModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
