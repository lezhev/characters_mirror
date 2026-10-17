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
import '../data/background_data.dart' as _i19ulkwb;
import '../views/choice_group_view.dart' as _i8vdv0v3;
import '../views/skill_selection_group_view.dart' as _ihq8n2m8;
import '../views/starting_equipment_block_view.dart' as _ixcahpkd;

abstract class BackgroundStepView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BackgroundStepView._({
    this.background,
    this.choiceGroups,
    this.skillSelectionGroups,
    this.startingEquipmentBlocks,
  });

  factory BackgroundStepView({
    _i19ulkwb.BackgroundData? background,
    List<_i8vdv0v3.ChoiceGroupView>? choiceGroups,
    List<_ihq8n2m8.SkillSelectionGroupView>? skillSelectionGroups,
    List<_ixcahpkd.StartingEquipmentBlockView>? startingEquipmentBlocks,
  }) = _BackgroundStepViewImpl;

  factory BackgroundStepView.fromJson(Map<String, dynamic> jsonSerialization) {
    return BackgroundStepView(
      background: jsonSerialization['background'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_i19ulkwb.BackgroundData>(
              jsonSerialization['background'],
            ),
      choiceGroups: jsonSerialization['choiceGroups'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_i8vdv0v3.ChoiceGroupView>>(
              jsonSerialization['choiceGroups'],
            ),
      skillSelectionGroups: jsonSerialization['skillSelectionGroups'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_ihq8n2m8.SkillSelectionGroupView>>(
                  jsonSerialization['skillSelectionGroups'],
                ),
      startingEquipmentBlocks:
          jsonSerialization['startingEquipmentBlocks'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_ixcahpkd.StartingEquipmentBlockView>>(
                  jsonSerialization['startingEquipmentBlocks'],
                ),
    );
  }

  _i19ulkwb.BackgroundData? background;

  List<_i8vdv0v3.ChoiceGroupView>? choiceGroups;

  List<_ihq8n2m8.SkillSelectionGroupView>? skillSelectionGroups;

  List<_ixcahpkd.StartingEquipmentBlockView>? startingEquipmentBlocks;

  /// Returns a shallow copy of this [BackgroundStepView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BackgroundStepView copyWith({
    _i19ulkwb.BackgroundData? background,
    List<_i8vdv0v3.ChoiceGroupView>? choiceGroups,
    List<_ihq8n2m8.SkillSelectionGroupView>? skillSelectionGroups,
    List<_ixcahpkd.StartingEquipmentBlockView>? startingEquipmentBlocks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BackgroundStepView',
      if (background != null) 'background': background?.toJson(),
      if (choiceGroups != null)
        'choiceGroups': choiceGroups?.toJson(valueToJson: (v) => v.toJson()),
      if (skillSelectionGroups != null)
        'skillSelectionGroups': skillSelectionGroups?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (startingEquipmentBlocks != null)
        'startingEquipmentBlocks': startingEquipmentBlocks?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BackgroundStepView',
      if (background != null) 'background': background?.toJsonForProtocol(),
      if (choiceGroups != null)
        'choiceGroups': choiceGroups?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (skillSelectionGroups != null)
        'skillSelectionGroups': skillSelectionGroups?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (startingEquipmentBlocks != null)
        'startingEquipmentBlocks': startingEquipmentBlocks?.toJson(
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

class _BackgroundStepViewImpl extends BackgroundStepView {
  _BackgroundStepViewImpl({
    _i19ulkwb.BackgroundData? background,
    List<_i8vdv0v3.ChoiceGroupView>? choiceGroups,
    List<_ihq8n2m8.SkillSelectionGroupView>? skillSelectionGroups,
    List<_ixcahpkd.StartingEquipmentBlockView>? startingEquipmentBlocks,
  }) : super._(
         background: background,
         choiceGroups: choiceGroups,
         skillSelectionGroups: skillSelectionGroups,
         startingEquipmentBlocks: startingEquipmentBlocks,
       );

  /// Returns a shallow copy of this [BackgroundStepView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BackgroundStepView copyWith({
    Object? background = _Undefined,
    Object? choiceGroups = _Undefined,
    Object? skillSelectionGroups = _Undefined,
    Object? startingEquipmentBlocks = _Undefined,
  }) {
    return BackgroundStepView(
      background: background is _i19ulkwb.BackgroundData?
          ? background
          : this.background?.copyWith(),
      choiceGroups: choiceGroups is List<_i8vdv0v3.ChoiceGroupView>?
          ? choiceGroups
          : this.choiceGroups?.map((e0) => e0.copyWith()).toList(),
      skillSelectionGroups:
          skillSelectionGroups is List<_ihq8n2m8.SkillSelectionGroupView>?
          ? skillSelectionGroups
          : this.skillSelectionGroups?.map((e0) => e0.copyWith()).toList(),
      startingEquipmentBlocks:
          startingEquipmentBlocks is List<_ixcahpkd.StartingEquipmentBlockView>?
          ? startingEquipmentBlocks
          : this.startingEquipmentBlocks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
