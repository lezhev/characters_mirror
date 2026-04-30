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
import '../../../data/general/class/starting_equipment_line_data.dart' as _i2;

abstract class StartingEquipmentOptionData implements _i1.SerializableModel {
  StartingEquipmentOptionData._({
    this.entryId,
    this.parentEntryId,
    this.orderIndex,
    this.lines,
  });

  factory StartingEquipmentOptionData({
    int? entryId,
    int? parentEntryId,
    int? orderIndex,
    List<_i2.StartingEquipmentLineData>? lines,
  }) = _StartingEquipmentOptionDataImpl;

  factory StartingEquipmentOptionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentOptionData(
      entryId: jsonSerialization['entryId'] as int?,
      parentEntryId: jsonSerialization['parentEntryId'] as int?,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      lines: (jsonSerialization['lines'] as List?)
          ?.map((e) => _i2.StartingEquipmentLineData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  int? entryId;

  int? parentEntryId;

  int? orderIndex;

  List<_i2.StartingEquipmentLineData>? lines;

  /// Returns a shallow copy of this [StartingEquipmentOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentOptionData copyWith({
    int? entryId,
    int? parentEntryId,
    int? orderIndex,
    List<_i2.StartingEquipmentLineData>? lines,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (entryId != null) 'entryId': entryId,
      if (parentEntryId != null) 'parentEntryId': parentEntryId,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (lines != null) 'lines': lines?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartingEquipmentOptionDataImpl extends StartingEquipmentOptionData {
  _StartingEquipmentOptionDataImpl({
    int? entryId,
    int? parentEntryId,
    int? orderIndex,
    List<_i2.StartingEquipmentLineData>? lines,
  }) : super._(
          entryId: entryId,
          parentEntryId: parentEntryId,
          orderIndex: orderIndex,
          lines: lines,
        );

  /// Returns a shallow copy of this [StartingEquipmentOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StartingEquipmentOptionData copyWith({
    Object? entryId = _Undefined,
    Object? parentEntryId = _Undefined,
    Object? orderIndex = _Undefined,
    Object? lines = _Undefined,
  }) {
    return StartingEquipmentOptionData(
      entryId: entryId is int? ? entryId : this.entryId,
      parentEntryId: parentEntryId is int? ? parentEntryId : this.parentEntryId,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      lines: lines is List<_i2.StartingEquipmentLineData>?
          ? lines
          : this.lines?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
