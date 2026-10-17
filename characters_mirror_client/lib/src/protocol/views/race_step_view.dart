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
import '../data/general/race/race_data.dart' as _ihlw44xu;
import '../data/general/race/race_feature_data.dart' as _iqq0a9cu;
import '../data/general/race/subrace_data.dart' as _is1vx1i0;
import '../views/choice_group_view.dart' as _i8vdv0v3;

abstract class RaceStepView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RaceStepView._({this.race, this.subraces, this.features, this.choiceGroups});

  factory RaceStepView({
    _ihlw44xu.RaceData? race,
    List<_is1vx1i0.SubraceData>? subraces,
    List<_iqq0a9cu.RaceFeatureData>? features,
    List<_i8vdv0v3.ChoiceGroupView>? choiceGroups,
  }) = _RaceStepViewImpl;

  factory RaceStepView.fromJson(Map<String, dynamic> jsonSerialization) {
    return RaceStepView(
      race: jsonSerialization['race'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_ihlw44xu.RaceData>(
              jsonSerialization['race'],
            ),
      subraces: jsonSerialization['subraces'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_is1vx1i0.SubraceData>>(
              jsonSerialization['subraces'],
            ),
      features: jsonSerialization['features'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iqq0a9cu.RaceFeatureData>>(
              jsonSerialization['features'],
            ),
      choiceGroups: jsonSerialization['choiceGroups'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_i8vdv0v3.ChoiceGroupView>>(
              jsonSerialization['choiceGroups'],
            ),
    );
  }

  _ihlw44xu.RaceData? race;

  List<_is1vx1i0.SubraceData>? subraces;

  List<_iqq0a9cu.RaceFeatureData>? features;

  List<_i8vdv0v3.ChoiceGroupView>? choiceGroups;

  /// Returns a shallow copy of this [RaceStepView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RaceStepView copyWith({
    _ihlw44xu.RaceData? race,
    List<_is1vx1i0.SubraceData>? subraces,
    List<_iqq0a9cu.RaceFeatureData>? features,
    List<_i8vdv0v3.ChoiceGroupView>? choiceGroups,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RaceStepView',
      if (race != null) 'race': race?.toJson(),
      if (subraces != null)
        'subraces': subraces?.toJson(valueToJson: (v) => v.toJson()),
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJson()),
      if (choiceGroups != null)
        'choiceGroups': choiceGroups?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RaceStepView',
      if (race != null) 'race': race?.toJsonForProtocol(),
      if (subraces != null)
        'subraces': subraces?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (choiceGroups != null)
        'choiceGroups': choiceGroups?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceStepViewImpl extends RaceStepView {
  _RaceStepViewImpl({
    _ihlw44xu.RaceData? race,
    List<_is1vx1i0.SubraceData>? subraces,
    List<_iqq0a9cu.RaceFeatureData>? features,
    List<_i8vdv0v3.ChoiceGroupView>? choiceGroups,
  }) : super._(
         race: race,
         subraces: subraces,
         features: features,
         choiceGroups: choiceGroups,
       );

  /// Returns a shallow copy of this [RaceStepView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RaceStepView copyWith({
    Object? race = _Undefined,
    Object? subraces = _Undefined,
    Object? features = _Undefined,
    Object? choiceGroups = _Undefined,
  }) {
    return RaceStepView(
      race: race is _ihlw44xu.RaceData? ? race : this.race?.copyWith(),
      subraces: subraces is List<_is1vx1i0.SubraceData>?
          ? subraces
          : this.subraces?.map((e0) => e0.copyWith()).toList(),
      features: features is List<_iqq0a9cu.RaceFeatureData>?
          ? features
          : this.features?.map((e0) => e0.copyWith()).toList(),
      choiceGroups: choiceGroups is List<_i8vdv0v3.ChoiceGroupView>?
          ? choiceGroups
          : this.choiceGroups?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
