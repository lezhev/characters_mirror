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
import 'package:characters_mirror_client/src/protocol/protocol.dart'
    as _isnx6jbi;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../data/general/character/character_starting_equipment_resolution_data.dart'
    as _iqru9q08;
import '../../../enums/choice_source_type.dart' as _isgp310x;

abstract class CharacterStartingEquipmentSelectionData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CharacterStartingEquipmentSelectionData._({
    this.id,
    this.sourceType,
    this.sourceId,
    this.sourceEntryId,
    this.choiceOptionEntryId,
    this.isSelected,
    this.selectionIndex,
    this.resolutions,
    this.updatedAt,
  });

  factory CharacterStartingEquipmentSelectionData({
    String? id,
    _isgp310x.ChoiceSourceType? sourceType,
    int? sourceId,
    int? sourceEntryId,
    int? choiceOptionEntryId,
    bool? isSelected,
    int? selectionIndex,
    List<_iqru9q08.CharacterStartingEquipmentResolutionData>? resolutions,
    DateTime? updatedAt,
  }) = _CharacterStartingEquipmentSelectionDataImpl;

  factory CharacterStartingEquipmentSelectionData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterStartingEquipmentSelectionData(
      id: jsonSerialization['id'] as String?,
      sourceType: jsonSerialization['sourceType'] == null
          ? null
          : _isgp310x.ChoiceSourceType.fromJson(
              (jsonSerialization['sourceType'] as String),
            ),
      sourceId: jsonSerialization['sourceId'] as int?,
      sourceEntryId: jsonSerialization['sourceEntryId'] as int?,
      choiceOptionEntryId: jsonSerialization['choiceOptionEntryId'] as int?,
      isSelected: jsonSerialization['isSelected'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isSelected']),
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      resolutions: jsonSerialization['resolutions'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<
              List<_iqru9q08.CharacterStartingEquipmentResolutionData>
            >(jsonSerialization['resolutions']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  String? id;

  _isgp310x.ChoiceSourceType? sourceType;

  int? sourceId;

  int? sourceEntryId;

  int? choiceOptionEntryId;

  bool? isSelected;

  int? selectionIndex;

  List<_iqru9q08.CharacterStartingEquipmentResolutionData>? resolutions;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterStartingEquipmentSelectionData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CharacterStartingEquipmentSelectionData copyWith({
    String? id,
    _isgp310x.ChoiceSourceType? sourceType,
    int? sourceId,
    int? sourceEntryId,
    int? choiceOptionEntryId,
    bool? isSelected,
    int? selectionIndex,
    List<_iqru9q08.CharacterStartingEquipmentResolutionData>? resolutions,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterStartingEquipmentSelectionData',
      if (id != null) 'id': id,
      if (sourceType != null) 'sourceType': sourceType?.toJson(),
      if (sourceId != null) 'sourceId': sourceId,
      if (sourceEntryId != null) 'sourceEntryId': sourceEntryId,
      if (choiceOptionEntryId != null)
        'choiceOptionEntryId': choiceOptionEntryId,
      if (isSelected != null) 'isSelected': isSelected,
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (resolutions != null)
        'resolutions': resolutions?.toJson(valueToJson: (v) => v.toJson()),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterStartingEquipmentSelectionData',
      if (id != null) 'id': id,
      if (sourceType != null) 'sourceType': sourceType?.toJson(),
      if (sourceId != null) 'sourceId': sourceId,
      if (sourceEntryId != null) 'sourceEntryId': sourceEntryId,
      if (choiceOptionEntryId != null)
        'choiceOptionEntryId': choiceOptionEntryId,
      if (isSelected != null) 'isSelected': isSelected,
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (resolutions != null)
        'resolutions': resolutions?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterStartingEquipmentSelectionDataImpl
    extends CharacterStartingEquipmentSelectionData {
  _CharacterStartingEquipmentSelectionDataImpl({
    String? id,
    _isgp310x.ChoiceSourceType? sourceType,
    int? sourceId,
    int? sourceEntryId,
    int? choiceOptionEntryId,
    bool? isSelected,
    int? selectionIndex,
    List<_iqru9q08.CharacterStartingEquipmentResolutionData>? resolutions,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         sourceType: sourceType,
         sourceId: sourceId,
         sourceEntryId: sourceEntryId,
         choiceOptionEntryId: choiceOptionEntryId,
         isSelected: isSelected,
         selectionIndex: selectionIndex,
         resolutions: resolutions,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CharacterStartingEquipmentSelectionData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CharacterStartingEquipmentSelectionData copyWith({
    Object? id = _Undefined,
    Object? sourceType = _Undefined,
    Object? sourceId = _Undefined,
    Object? sourceEntryId = _Undefined,
    Object? choiceOptionEntryId = _Undefined,
    Object? isSelected = _Undefined,
    Object? selectionIndex = _Undefined,
    Object? resolutions = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterStartingEquipmentSelectionData(
      id: id is String? ? id : this.id,
      sourceType: sourceType is _isgp310x.ChoiceSourceType?
          ? sourceType
          : this.sourceType,
      sourceId: sourceId is int? ? sourceId : this.sourceId,
      sourceEntryId: sourceEntryId is int? ? sourceEntryId : this.sourceEntryId,
      choiceOptionEntryId: choiceOptionEntryId is int?
          ? choiceOptionEntryId
          : this.choiceOptionEntryId,
      isSelected: isSelected is bool? ? isSelected : this.isSelected,
      selectionIndex: selectionIndex is int?
          ? selectionIndex
          : this.selectionIndex,
      resolutions:
          resolutions
              is List<_iqru9q08.CharacterStartingEquipmentResolutionData>?
          ? resolutions
          : this.resolutions?.map((e0) => e0.copyWith()).toList(),
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
