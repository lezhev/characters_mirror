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
import '../data/general/class/starting_equipment_block_data.dart' as _i79v36x7;
import '../data/general/class/starting_equipment_line_data.dart' as _iyf3iocy;
import '../views/starting_equipment_option_view.dart' as _iakzuosz;

abstract class StartingEquipmentBlockView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StartingEquipmentBlockView._({this.block, this.fixedLines, this.options});

  factory StartingEquipmentBlockView({
    _i79v36x7.StartingEquipmentBlockData? block,
    List<_iyf3iocy.StartingEquipmentLineData>? fixedLines,
    List<_iakzuosz.StartingEquipmentOptionView>? options,
  }) = _StartingEquipmentBlockViewImpl;

  factory StartingEquipmentBlockView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StartingEquipmentBlockView(
      block: jsonSerialization['block'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<_i79v36x7.StartingEquipmentBlockData>(
                  jsonSerialization['block'],
                ),
      fixedLines: jsonSerialization['fixedLines'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_iyf3iocy.StartingEquipmentLineData>>(
                  jsonSerialization['fixedLines'],
                ),
      options: jsonSerialization['options'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_iakzuosz.StartingEquipmentOptionView>>(
                  jsonSerialization['options'],
                ),
    );
  }

  _i79v36x7.StartingEquipmentBlockData? block;

  List<_iyf3iocy.StartingEquipmentLineData>? fixedLines;

  List<_iakzuosz.StartingEquipmentOptionView>? options;

  /// Returns a shallow copy of this [StartingEquipmentBlockView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StartingEquipmentBlockView copyWith({
    _i79v36x7.StartingEquipmentBlockData? block,
    List<_iyf3iocy.StartingEquipmentLineData>? fixedLines,
    List<_iakzuosz.StartingEquipmentOptionView>? options,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StartingEquipmentBlockView',
      if (block != null) 'block': block?.toJson(),
      if (fixedLines != null)
        'fixedLines': fixedLines?.toJson(valueToJson: (v) => v.toJson()),
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StartingEquipmentBlockView',
      if (block != null) 'block': block?.toJsonForProtocol(),
      if (fixedLines != null)
        'fixedLines': fixedLines?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartingEquipmentBlockViewImpl extends StartingEquipmentBlockView {
  _StartingEquipmentBlockViewImpl({
    _i79v36x7.StartingEquipmentBlockData? block,
    List<_iyf3iocy.StartingEquipmentLineData>? fixedLines,
    List<_iakzuosz.StartingEquipmentOptionView>? options,
  }) : super._(block: block, fixedLines: fixedLines, options: options);

  /// Returns a shallow copy of this [StartingEquipmentBlockView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StartingEquipmentBlockView copyWith({
    Object? block = _Undefined,
    Object? fixedLines = _Undefined,
    Object? options = _Undefined,
  }) {
    return StartingEquipmentBlockView(
      block: block is _i79v36x7.StartingEquipmentBlockData?
          ? block
          : this.block?.copyWith(),
      fixedLines: fixedLines is List<_iyf3iocy.StartingEquipmentLineData>?
          ? fixedLines
          : this.fixedLines?.map((e0) => e0.copyWith()).toList(),
      options: options is List<_iakzuosz.StartingEquipmentOptionView>?
          ? options
          : this.options?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
