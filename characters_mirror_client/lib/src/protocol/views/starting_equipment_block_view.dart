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
import '../data/general/class/starting_equipment_block_data.dart' as _i2;
import '../data/general/class/starting_equipment_line_data.dart' as _i3;
import '../views/starting_equipment_option_view.dart' as _i4;

abstract class StartingEquipmentBlockView implements _i1.SerializableModel {
  StartingEquipmentBlockView._({
    this.block,
    this.fixedLines,
    this.options,
  });

  factory StartingEquipmentBlockView({
    _i2.StartingEquipmentBlockData? block,
    List<_i3.StartingEquipmentLineData>? fixedLines,
    List<_i4.StartingEquipmentOptionView>? options,
  }) = _StartingEquipmentBlockViewImpl;

  factory StartingEquipmentBlockView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentBlockView(
      block: jsonSerialization['block'] == null
          ? null
          : _i2.StartingEquipmentBlockData.fromJson(
              (jsonSerialization['block'] as Map<String, dynamic>)),
      fixedLines: (jsonSerialization['fixedLines'] as List?)
          ?.map((e) => _i3.StartingEquipmentLineData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      options: (jsonSerialization['options'] as List?)
          ?.map((e) => _i4.StartingEquipmentOptionView.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.StartingEquipmentBlockData? block;

  List<_i3.StartingEquipmentLineData>? fixedLines;

  List<_i4.StartingEquipmentOptionView>? options;

  /// Returns a shallow copy of this [StartingEquipmentBlockView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentBlockView copyWith({
    _i2.StartingEquipmentBlockData? block,
    List<_i3.StartingEquipmentLineData>? fixedLines,
    List<_i4.StartingEquipmentOptionView>? options,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (block != null) 'block': block?.toJson(),
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

class _StartingEquipmentBlockViewImpl extends StartingEquipmentBlockView {
  _StartingEquipmentBlockViewImpl({
    _i2.StartingEquipmentBlockData? block,
    List<_i3.StartingEquipmentLineData>? fixedLines,
    List<_i4.StartingEquipmentOptionView>? options,
  }) : super._(
          block: block,
          fixedLines: fixedLines,
          options: options,
        );

  /// Returns a shallow copy of this [StartingEquipmentBlockView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StartingEquipmentBlockView copyWith({
    Object? block = _Undefined,
    Object? fixedLines = _Undefined,
    Object? options = _Undefined,
  }) {
    return StartingEquipmentBlockView(
      block: block is _i2.StartingEquipmentBlockData?
          ? block
          : this.block?.copyWith(),
      fixedLines: fixedLines is List<_i3.StartingEquipmentLineData>?
          ? fixedLines
          : this.fixedLines?.map((e0) => e0.copyWith()).toList(),
      options: options is List<_i4.StartingEquipmentOptionView>?
          ? options
          : this.options?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
