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
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../data/general/choice_group_data.dart' as _igmk6n2e;
import '../data/general/choice_option_data.dart' as _ivap0b5b;
import '../views/choice_option_eligibility_view.dart' as _iandvenz;

abstract class ChoiceGroupView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ChoiceGroupView._({this.group, this.options, this.optionEligibility});

  factory ChoiceGroupView({
    _igmk6n2e.ChoiceGroupData? group,
    List<_ivap0b5b.ChoiceOptionData>? options,
    List<_iandvenz.ChoiceOptionEligibilityView>? optionEligibility,
  }) = _ChoiceGroupViewImpl;

  factory ChoiceGroupView.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChoiceGroupView(
      group: jsonSerialization['group'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_igmk6n2e.ChoiceGroupData>(
              jsonSerialization['group'],
            ),
      options: jsonSerialization['options'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ivap0b5b.ChoiceOptionData>>(
              jsonSerialization['options'],
            ),
      optionEligibility: jsonSerialization['optionEligibility'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_iandvenz.ChoiceOptionEligibilityView>>(
                  jsonSerialization['optionEligibility'],
                ),
    );
  }

  _igmk6n2e.ChoiceGroupData? group;

  List<_ivap0b5b.ChoiceOptionData>? options;

  List<_iandvenz.ChoiceOptionEligibilityView>? optionEligibility;

  /// Returns a shallow copy of this [ChoiceGroupView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChoiceGroupView copyWith({
    _igmk6n2e.ChoiceGroupData? group,
    List<_ivap0b5b.ChoiceOptionData>? options,
    List<_iandvenz.ChoiceOptionEligibilityView>? optionEligibility,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChoiceGroupView',
      if (group != null) 'group': group?.toJson(),
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJson()),
      if (optionEligibility != null)
        'optionEligibility': optionEligibility?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChoiceGroupView',
      if (group != null) 'group': group?.toJsonForProtocol(),
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (optionEligibility != null)
        'optionEligibility': optionEligibility?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoiceGroupViewImpl extends ChoiceGroupView {
  _ChoiceGroupViewImpl({
    _igmk6n2e.ChoiceGroupData? group,
    List<_ivap0b5b.ChoiceOptionData>? options,
    List<_iandvenz.ChoiceOptionEligibilityView>? optionEligibility,
  }) : super._(
         group: group,
         options: options,
         optionEligibility: optionEligibility,
       );

  /// Returns a shallow copy of this [ChoiceGroupView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ChoiceGroupView copyWith({
    Object? group = _Undefined,
    Object? options = _Undefined,
    Object? optionEligibility = _Undefined,
  }) {
    return ChoiceGroupView(
      group: group is _igmk6n2e.ChoiceGroupData?
          ? group
          : this.group?.copyWith(),
      options: options is List<_ivap0b5b.ChoiceOptionData>?
          ? options
          : this.options?.map((e0) => e0.copyWith()).toList(),
      optionEligibility:
          optionEligibility is List<_iandvenz.ChoiceOptionEligibilityView>?
          ? optionEligibility
          : this.optionEligibility?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
