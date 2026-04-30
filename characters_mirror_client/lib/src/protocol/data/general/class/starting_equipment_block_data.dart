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
import '../../../enums/starting_equipment_block_kind.dart' as _i2;
import '../../../data/general/class/starting_equipment_line_data.dart' as _i3;
import '../../../data/general/class/starting_equipment_option_data.dart' as _i4;

abstract class StartingEquipmentBlockData implements _i1.SerializableModel {
  StartingEquipmentBlockData._({
    this.entryId,
    this.orderIndex,
    this.kind,
    this.selectionCount,
    this.fixedLines,
    this.options,
  });

  factory StartingEquipmentBlockData({
    int? entryId,
    int? orderIndex,
    _i2.StartingEquipmentBlockKind? kind,
    int? selectionCount,
    List<_i3.StartingEquipmentLineData>? fixedLines,
    List<_i4.StartingEquipmentOptionData>? options,
  }) = _StartingEquipmentBlockDataImpl;

  factory StartingEquipmentBlockData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentBlockData(
      entryId: jsonSerialization['entryId'] as int?,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _i2.StartingEquipmentBlockKind.fromJson(
              (jsonSerialization['kind'] as String)),
      selectionCount: jsonSerialization['selectionCount'] as int?,
      fixedLines: (jsonSerialization['fixedLines'] as List?)
          ?.map((e) => _i3.StartingEquipmentLineData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      options: (jsonSerialization['options'] as List?)
          ?.map((e) => _i4.StartingEquipmentOptionData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  int? entryId;

  int? orderIndex;

  _i2.StartingEquipmentBlockKind? kind;

  int? selectionCount;

  List<_i3.StartingEquipmentLineData>? fixedLines;

  List<_i4.StartingEquipmentOptionData>? options;

  /// Returns a shallow copy of this [StartingEquipmentBlockData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentBlockData copyWith({
    int? entryId,
    int? orderIndex,
    _i2.StartingEquipmentBlockKind? kind,
    int? selectionCount,
    List<_i3.StartingEquipmentLineData>? fixedLines,
    List<_i4.StartingEquipmentOptionData>? options,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (entryId != null) 'entryId': entryId,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (fixedLines != null)
        'fixedLines': fixedLines?.toJson(valueToJson: (v) => v.toJson()),
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartingEquipmentBlockDataImpl extends StartingEquipmentBlockData {
  _StartingEquipmentBlockDataImpl({
    int? entryId,
    int? orderIndex,
    _i2.StartingEquipmentBlockKind? kind,
    int? selectionCount,
    List<_i3.StartingEquipmentLineData>? fixedLines,
    List<_i4.StartingEquipmentOptionData>? options,
  }) : super._(
          entryId: entryId,
          orderIndex: orderIndex,
          kind: kind,
          selectionCount: selectionCount,
          fixedLines: fixedLines,
          options: options,
        );

  /// Returns a shallow copy of this [StartingEquipmentBlockData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StartingEquipmentBlockData copyWith({
    Object? entryId = _Undefined,
    Object? orderIndex = _Undefined,
    Object? kind = _Undefined,
    Object? selectionCount = _Undefined,
    Object? fixedLines = _Undefined,
    Object? options = _Undefined,
  }) {
    return StartingEquipmentBlockData(
      entryId: entryId is int? ? entryId : this.entryId,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      kind: kind is _i2.StartingEquipmentBlockKind? ? kind : this.kind,
      selectionCount:
          selectionCount is int? ? selectionCount : this.selectionCount,
      fixedLines: fixedLines is List<_i3.StartingEquipmentLineData>?
          ? fixedLines
          : this.fixedLines?.map((e0) => e0.copyWith()).toList(),
      options: options is List<_i4.StartingEquipmentOptionData>?
          ? options
          : this.options?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
