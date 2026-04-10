/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../data/general/class/starting_equipment_option_data.dart' as _i2;
import '../data/general/class/starting_equipment_line_data.dart' as _i3;

abstract class StartingEquipmentOptionView
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  StartingEquipmentOptionView._({
    this.option,
    this.lines,
  });

  factory StartingEquipmentOptionView({
    _i2.StartingEquipmentOptionData? option,
    List<_i3.StartingEquipmentLineData>? lines,
  }) = _StartingEquipmentOptionViewImpl;

  factory StartingEquipmentOptionView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentOptionView(
      option: jsonSerialization['option'] == null
          ? null
          : _i2.StartingEquipmentOptionData.fromJson(
              (jsonSerialization['option'] as Map<String, dynamic>)),
      lines: (jsonSerialization['lines'] as List?)
          ?.map((e) => _i3.StartingEquipmentLineData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.StartingEquipmentOptionData? option;

  List<_i3.StartingEquipmentLineData>? lines;

  /// Returns a shallow copy of this [StartingEquipmentOptionView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentOptionView copyWith({
    _i2.StartingEquipmentOptionData? option,
    List<_i3.StartingEquipmentLineData>? lines,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (option != null) 'option': option?.toJson(),
      if (lines != null) 'lines': lines?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (option != null) 'option': option?.toJsonForProtocol(),
      if (lines != null)
        'lines': lines?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartingEquipmentOptionViewImpl extends StartingEquipmentOptionView {
  _StartingEquipmentOptionViewImpl({
    _i2.StartingEquipmentOptionData? option,
    List<_i3.StartingEquipmentLineData>? lines,
  }) : super._(
          option: option,
          lines: lines,
        );

  /// Returns a shallow copy of this [StartingEquipmentOptionView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StartingEquipmentOptionView copyWith({
    Object? option = _Undefined,
    Object? lines = _Undefined,
  }) {
    return StartingEquipmentOptionView(
      option: option is _i2.StartingEquipmentOptionData?
          ? option
          : this.option?.copyWith(),
      lines: lines is List<_i3.StartingEquipmentLineData>?
          ? lines
          : this.lines?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
