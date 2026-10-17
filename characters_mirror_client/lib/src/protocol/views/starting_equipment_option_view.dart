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
import '../data/general/class/starting_equipment_line_data.dart' as _iyf3iocy;
import '../data/general/class/starting_equipment_option_data.dart' as _iyweqvnk;

abstract class StartingEquipmentOptionView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StartingEquipmentOptionView._({this.option, this.lines});

  factory StartingEquipmentOptionView({
    _iyweqvnk.StartingEquipmentOptionData? option,
    List<_iyf3iocy.StartingEquipmentLineData>? lines,
  }) = _StartingEquipmentOptionViewImpl;

  factory StartingEquipmentOptionView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StartingEquipmentOptionView(
      option: jsonSerialization['option'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<_iyweqvnk.StartingEquipmentOptionData>(
                  jsonSerialization['option'],
                ),
      lines: jsonSerialization['lines'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_iyf3iocy.StartingEquipmentLineData>>(
                  jsonSerialization['lines'],
                ),
    );
  }

  _iyweqvnk.StartingEquipmentOptionData? option;

  List<_iyf3iocy.StartingEquipmentLineData>? lines;

  /// Returns a shallow copy of this [StartingEquipmentOptionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StartingEquipmentOptionView copyWith({
    _iyweqvnk.StartingEquipmentOptionData? option,
    List<_iyf3iocy.StartingEquipmentLineData>? lines,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StartingEquipmentOptionView',
      if (option != null) 'option': option?.toJson(),
      if (lines != null) 'lines': lines?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StartingEquipmentOptionView',
      if (option != null) 'option': option?.toJsonForProtocol(),
      if (lines != null)
        'lines': lines?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartingEquipmentOptionViewImpl extends StartingEquipmentOptionView {
  _StartingEquipmentOptionViewImpl({
    _iyweqvnk.StartingEquipmentOptionData? option,
    List<_iyf3iocy.StartingEquipmentLineData>? lines,
  }) : super._(option: option, lines: lines);

  /// Returns a shallow copy of this [StartingEquipmentOptionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StartingEquipmentOptionView copyWith({
    Object? option = _Undefined,
    Object? lines = _Undefined,
  }) {
    return StartingEquipmentOptionView(
      option: option is _iyweqvnk.StartingEquipmentOptionData?
          ? option
          : this.option?.copyWith(),
      lines: lines is List<_iyf3iocy.StartingEquipmentLineData>?
          ? lines
          : this.lines?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
