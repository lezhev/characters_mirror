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
import '../../../enums/choice_source_type.dart' as _i2;
import '../../../data/general/character/character_starting_equipment_resolution_data.dart'
    as _i3;

abstract class CharacterStartingEquipmentSelectionData
    implements _i1.SerializableModel {
  CharacterStartingEquipmentSelectionData._({
    this.id,
    this.sourceType,
    this.sourceId,
    this.blockKey,
    this.optionKey,
    this.selectionIndex,
    this.resolutions,
  });

  factory CharacterStartingEquipmentSelectionData({
    int? id,
    _i2.ChoiceSourceType? sourceType,
    int? sourceId,
    String? blockKey,
    String? optionKey,
    int? selectionIndex,
    List<_i3.CharacterStartingEquipmentResolutionData>? resolutions,
  }) = _CharacterStartingEquipmentSelectionDataImpl;

  factory CharacterStartingEquipmentSelectionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterStartingEquipmentSelectionData(
      id: jsonSerialization['id'] as int?,
      sourceType: jsonSerialization['sourceType'] == null
          ? null
          : _i2.ChoiceSourceType.fromJson(
              (jsonSerialization['sourceType'] as String)),
      sourceId: jsonSerialization['sourceId'] as int?,
      blockKey: jsonSerialization['blockKey'] as String?,
      optionKey: jsonSerialization['optionKey'] as String?,
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      resolutions: (jsonSerialization['resolutions'] as List?)
          ?.map((e) => _i3.CharacterStartingEquipmentResolutionData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  int? id;

  _i2.ChoiceSourceType? sourceType;

  int? sourceId;

  String? blockKey;

  String? optionKey;

  int? selectionIndex;

  List<_i3.CharacterStartingEquipmentResolutionData>? resolutions;

  /// Returns a shallow copy of this [CharacterStartingEquipmentSelectionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterStartingEquipmentSelectionData copyWith({
    int? id,
    _i2.ChoiceSourceType? sourceType,
    int? sourceId,
    String? blockKey,
    String? optionKey,
    int? selectionIndex,
    List<_i3.CharacterStartingEquipmentResolutionData>? resolutions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (sourceType != null) 'sourceType': sourceType?.toJson(),
      if (sourceId != null) 'sourceId': sourceId,
      if (blockKey != null) 'blockKey': blockKey,
      if (optionKey != null) 'optionKey': optionKey,
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (resolutions != null)
        'resolutions': resolutions?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterStartingEquipmentSelectionDataImpl
    extends CharacterStartingEquipmentSelectionData {
  _CharacterStartingEquipmentSelectionDataImpl({
    int? id,
    _i2.ChoiceSourceType? sourceType,
    int? sourceId,
    String? blockKey,
    String? optionKey,
    int? selectionIndex,
    List<_i3.CharacterStartingEquipmentResolutionData>? resolutions,
  }) : super._(
          id: id,
          sourceType: sourceType,
          sourceId: sourceId,
          blockKey: blockKey,
          optionKey: optionKey,
          selectionIndex: selectionIndex,
          resolutions: resolutions,
        );

  /// Returns a shallow copy of this [CharacterStartingEquipmentSelectionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterStartingEquipmentSelectionData copyWith({
    Object? id = _Undefined,
    Object? sourceType = _Undefined,
    Object? sourceId = _Undefined,
    Object? blockKey = _Undefined,
    Object? optionKey = _Undefined,
    Object? selectionIndex = _Undefined,
    Object? resolutions = _Undefined,
  }) {
    return CharacterStartingEquipmentSelectionData(
      id: id is int? ? id : this.id,
      sourceType:
          sourceType is _i2.ChoiceSourceType? ? sourceType : this.sourceType,
      sourceId: sourceId is int? ? sourceId : this.sourceId,
      blockKey: blockKey is String? ? blockKey : this.blockKey,
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      selectionIndex:
          selectionIndex is int? ? selectionIndex : this.selectionIndex,
      resolutions:
          resolutions is List<_i3.CharacterStartingEquipmentResolutionData>?
              ? resolutions
              : this.resolutions?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
