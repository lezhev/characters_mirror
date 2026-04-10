/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../enums/equipment_catalog_type.dart' as _i2;

abstract class CharacterEquipmentEntryView implements _i1.SerializableModel {
  CharacterEquipmentEntryView._({
    this.catalogType,
    this.referenceKey,
    this.displayText,
    this.quantity,
  });

  factory CharacterEquipmentEntryView({
    _i2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    String? displayText,
    int? quantity,
  }) = _CharacterEquipmentEntryViewImpl;

  factory CharacterEquipmentEntryView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterEquipmentEntryView(
      catalogType: jsonSerialization['catalogType'] == null
          ? null
          : _i2.EquipmentCatalogType.fromJson(
              (jsonSerialization['catalogType'] as String)),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      displayText: jsonSerialization['displayText'] as String?,
      quantity: jsonSerialization['quantity'] as int?,
    );
  }

  _i2.EquipmentCatalogType? catalogType;

  String? referenceKey;

  String? displayText;

  int? quantity;

  /// Returns a shallow copy of this [CharacterEquipmentEntryView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterEquipmentEntryView copyWith({
    _i2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    String? displayText,
    int? quantity,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (displayText != null) 'displayText': displayText,
      if (quantity != null) 'quantity': quantity,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterEquipmentEntryViewImpl extends CharacterEquipmentEntryView {
  _CharacterEquipmentEntryViewImpl({
    _i2.EquipmentCatalogType? catalogType,
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
  @_i1.useResult
  @override
  CharacterEquipmentEntryView copyWith({
    Object? catalogType = _Undefined,
    Object? referenceKey = _Undefined,
    Object? displayText = _Undefined,
    Object? quantity = _Undefined,
  }) {
    return CharacterEquipmentEntryView(
      catalogType: catalogType is _i2.EquipmentCatalogType?
          ? catalogType
          : this.catalogType,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      displayText: displayText is String? ? displayText : this.displayText,
      quantity: quantity is int? ? quantity : this.quantity,
    );
  }
}
