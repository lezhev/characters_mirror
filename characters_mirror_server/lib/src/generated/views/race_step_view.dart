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
import '../data/general/race/race_data.dart' as _i2;
import '../data/general/race/subrace_data.dart' as _i3;
import '../data/general/race/race_feature_data.dart' as _i4;

abstract class RaceStepView
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  RaceStepView._({
    this.race,
    this.subraces,
    this.features,
  });

  factory RaceStepView({
    _i2.RaceData? race,
    List<_i3.SubraceData>? subraces,
    List<_i4.RaceFeatureData>? features,
  }) = _RaceStepViewImpl;

  factory RaceStepView.fromJson(Map<String, dynamic> jsonSerialization) {
    return RaceStepView(
      race: jsonSerialization['race'] == null
          ? null
          : _i2.RaceData.fromJson(
              (jsonSerialization['race'] as Map<String, dynamic>)),
      subraces: (jsonSerialization['subraces'] as List?)
          ?.map((e) => _i3.SubraceData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      features: (jsonSerialization['features'] as List?)
          ?.map(
              (e) => _i4.RaceFeatureData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.RaceData? race;

  List<_i3.SubraceData>? subraces;

  List<_i4.RaceFeatureData>? features;

  /// Returns a shallow copy of this [RaceStepView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceStepView copyWith({
    _i2.RaceData? race,
    List<_i3.SubraceData>? subraces,
    List<_i4.RaceFeatureData>? features,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (race != null) 'race': race?.toJson(),
      if (subraces != null)
        'subraces': subraces?.toJson(valueToJson: (v) => v.toJson()),
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (race != null) 'race': race?.toJsonForProtocol(),
      if (subraces != null)
        'subraces': subraces?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceStepViewImpl extends RaceStepView {
  _RaceStepViewImpl({
    _i2.RaceData? race,
    List<_i3.SubraceData>? subraces,
    List<_i4.RaceFeatureData>? features,
  }) : super._(
          race: race,
          subraces: subraces,
          features: features,
        );

  /// Returns a shallow copy of this [RaceStepView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RaceStepView copyWith({
    Object? race = _Undefined,
    Object? subraces = _Undefined,
    Object? features = _Undefined,
  }) {
    return RaceStepView(
      race: race is _i2.RaceData? ? race : this.race?.copyWith(),
      subraces: subraces is List<_i3.SubraceData>?
          ? subraces
          : this.subraces?.map((e0) => e0.copyWith()).toList(),
      features: features is List<_i4.RaceFeatureData>?
          ? features
          : this.features?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
