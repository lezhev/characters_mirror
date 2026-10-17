/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../enums/equipment_catalog_type.dart' as _ia0b4ti5;

abstract class CharacterEquipmentEntryView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CharacterEquipmentEntryView._({
    this.catalogType,
    this.referenceKey,
    this.displayText,
    this.quantity,
  });

  factory CharacterEquipmentEntryView({
    _ia0b4ti5.EquipmentCatalogType? catalogType,
    String? referenceKey,
    String? displayText,
    int? quantity,
  }) = _CharacterEquipmentEntryViewImpl;

  factory CharacterEquipmentEntryView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterEquipmentEntryView(
      catalogType: jsonSerialization['catalogType'] == null
          ? null
          : _ia0b4ti5.EquipmentCatalogType.fromJson(
              (jsonSerialization['catalogType'] as String),
            ),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      displayText: jsonSerialization['displayText'] as String?,
      quantity: jsonSerialization['quantity'] as int?,
    );
  }

  _ia0b4ti5.EquipmentCatalogType? catalogType;

  String? referenceKey;

  String? displayText;

  int? quantity;

  /// Returns a shallow copy of this [CharacterEquipmentEntryView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CharacterEquipmentEntryView copyWith({
    _ia0b4ti5.EquipmentCatalogType? catalogType,
    String? referenceKey,
    String? displayText,
    int? quantity,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterEquipmentEntryView',
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (displayText != null) 'displayText': displayText,
      if (quantity != null) 'quantity': quantity,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterEquipmentEntryView',
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (displayText != null) 'displayText': displayText,
      if (quantity != null) 'quantity': quantity,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterEquipmentEntryViewImpl extends CharacterEquipmentEntryView {
  _CharacterEquipmentEntryViewImpl({
    _ia0b4ti5.EquipmentCatalogType? catalogType,
    String? referenceKey,
    String? displayText,
    int? quantity,
  }) : super._(
         catalogType: catalogType,
         referenceKey: referenceKey,
         displayText: displayText,
         quantity: quantity,
       );

  /// Returns a shallow copy of this [CharacterEquipmentEntryView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CharacterEquipmentEntryView copyWith({
    Object? catalogType = _Undefined,
    Object? referenceKey = _Undefined,
    Object? displayText = _Undefined,
    Object? quantity = _Undefined,
  }) {
    return CharacterEquipmentEntryView(
      catalogType: catalogType is _ia0b4ti5.EquipmentCatalogType?
          ? catalogType
          : this.catalogType,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      displayText: displayText is String? ? displayText : this.displayText,
      quantity: quantity is int? ? quantity : this.quantity,
    );
  }
}
