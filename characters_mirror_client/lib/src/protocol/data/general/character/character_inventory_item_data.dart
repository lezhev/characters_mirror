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
import '../../../enums/character_inventory_item_type.dart' as _ie5gg623;

abstract class CharacterInventoryItemData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CharacterInventoryItemData._({
    this.id,
    this.name,
    this.quantity,
    this.type,
    this.updatedAt,
  });

  factory CharacterInventoryItemData({
    String? id,
    String? name,
    int? quantity,
    _ie5gg623.CharacterInventoryItemType? type,
    DateTime? updatedAt,
  }) = _CharacterInventoryItemDataImpl;

  factory CharacterInventoryItemData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterInventoryItemData(
      id: jsonSerialization['id'] as String?,
      name: jsonSerialization['name'] as String?,
      quantity: jsonSerialization['quantity'] as int?,
      type: jsonSerialization['type'] == null
          ? null
          : _ie5gg623.CharacterInventoryItemType.fromJson(
              (jsonSerialization['type'] as int),
            ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  String? id;

  String? name;

  int? quantity;

  _ie5gg623.CharacterInventoryItemType? type;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterInventoryItemData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CharacterInventoryItemData copyWith({
    String? id,
    String? name,
    int? quantity,
    _ie5gg623.CharacterInventoryItemType? type,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterInventoryItemData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (quantity != null) 'quantity': quantity,
      if (type != null) 'type': type?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterInventoryItemData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (quantity != null) 'quantity': quantity,
      if (type != null) 'type': type?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterInventoryItemDataImpl extends CharacterInventoryItemData {
  _CharacterInventoryItemDataImpl({
    String? id,
    String? name,
    int? quantity,
    _ie5gg623.CharacterInventoryItemType? type,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         quantity: quantity,
         type: type,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CharacterInventoryItemData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CharacterInventoryItemData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? quantity = _Undefined,
    Object? type = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterInventoryItemData(
      id: id is String? ? id : this.id,
      name: name is String? ? name : this.name,
      quantity: quantity is int? ? quantity : this.quantity,
      type: type is _ie5gg623.CharacterInventoryItemType? ? type : this.type,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
