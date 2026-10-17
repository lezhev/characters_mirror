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
import '../../../data/general/character/character_resource_view_data.dart'
    as _iql0t5wa;
import '../../../data/general/feature_resource_effect_data.dart' as _ipujnj10;
import '../../../enums/character_feature_source_type.dart' as _ik7og9il;
import '../../../views/feature_display_property_view.dart' as _i4dynmv7;

abstract class RelatedFeatureViewData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RelatedFeatureViewData._({
    required this.sourceType,
    required this.sourceId,
    this.sourceName,
    this.name,
    this.description,
    this.displayProperties,
    this.resources,
    this.spellSlotRecoveryEffects,
    this.selectedChoices,
  });

  factory RelatedFeatureViewData({
    required _ik7og9il.CharacterFeatureSourceType sourceType,
    required int sourceId,
    String? sourceName,
    String? name,
    String? description,
    List<_i4dynmv7.FeatureDisplayPropertyView>? displayProperties,
    List<_iql0t5wa.CharacterResourceViewData>? resources,
    List<_ipujnj10.FeatureResourceEffectData>? spellSlotRecoveryEffects,
    List<String>? selectedChoices,
  }) = _RelatedFeatureViewDataImpl;

  factory RelatedFeatureViewData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return RelatedFeatureViewData(
      sourceType: _ik7og9il.CharacterFeatureSourceType.fromJson(
        (jsonSerialization['sourceType'] as String),
      ),
      sourceId: jsonSerialization['sourceId'] as int,
      sourceName: jsonSerialization['sourceName'] as String?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      displayProperties: jsonSerialization['displayProperties'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_i4dynmv7.FeatureDisplayPropertyView>>(
                  jsonSerialization['displayProperties'],
                ),
      resources: jsonSerialization['resources'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_iql0t5wa.CharacterResourceViewData>>(
                  jsonSerialization['resources'],
                ),
      spellSlotRecoveryEffects:
          jsonSerialization['spellSlotRecoveryEffects'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_ipujnj10.FeatureResourceEffectData>>(
                  jsonSerialization['spellSlotRecoveryEffects'],
                ),
      selectedChoices: jsonSerialization['selectedChoices'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['selectedChoices'],
            ),
    );
  }

  _ik7og9il.CharacterFeatureSourceType sourceType;

  int sourceId;

  String? sourceName;

  String? name;

  String? description;

  List<_i4dynmv7.FeatureDisplayPropertyView>? displayProperties;

  List<_iql0t5wa.CharacterResourceViewData>? resources;

  List<_ipujnj10.FeatureResourceEffectData>? spellSlotRecoveryEffects;

  List<String>? selectedChoices;

  /// Returns a shallow copy of this [RelatedFeatureViewData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RelatedFeatureViewData copyWith({
    _ik7og9il.CharacterFeatureSourceType? sourceType,
    int? sourceId,
    String? sourceName,
    String? name,
    String? description,
    List<_i4dynmv7.FeatureDisplayPropertyView>? displayProperties,
    List<_iql0t5wa.CharacterResourceViewData>? resources,
    List<_ipujnj10.FeatureResourceEffectData>? spellSlotRecoveryEffects,
    List<String>? selectedChoices,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RelatedFeatureViewData',
      'sourceType': sourceType.toJson(),
      'sourceId': sourceId,
      if (sourceName != null) 'sourceName': sourceName,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (displayProperties != null)
        'displayProperties': displayProperties?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (resources != null)
        'resources': resources?.toJson(valueToJson: (v) => v.toJson()),
      if (spellSlotRecoveryEffects != null)
        'spellSlotRecoveryEffects': spellSlotRecoveryEffects?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (selectedChoices != null) 'selectedChoices': selectedChoices?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RelatedFeatureViewData',
      'sourceType': sourceType.toJson(),
      'sourceId': sourceId,
      if (sourceName != null) 'sourceName': sourceName,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (displayProperties != null)
        'displayProperties': displayProperties?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (resources != null)
        'resources': resources?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (spellSlotRecoveryEffects != null)
        'spellSlotRecoveryEffects': spellSlotRecoveryEffects?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (selectedChoices != null) 'selectedChoices': selectedChoices?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RelatedFeatureViewDataImpl extends RelatedFeatureViewData {
  _RelatedFeatureViewDataImpl({
    required _ik7og9il.CharacterFeatureSourceType sourceType,
    required int sourceId,
    String? sourceName,
    String? name,
    String? description,
    List<_i4dynmv7.FeatureDisplayPropertyView>? displayProperties,
    List<_iql0t5wa.CharacterResourceViewData>? resources,
    List<_ipujnj10.FeatureResourceEffectData>? spellSlotRecoveryEffects,
    List<String>? selectedChoices,
  }) : super._(
         sourceType: sourceType,
         sourceId: sourceId,
         sourceName: sourceName,
         name: name,
         description: description,
         displayProperties: displayProperties,
         resources: resources,
         spellSlotRecoveryEffects: spellSlotRecoveryEffects,
         selectedChoices: selectedChoices,
       );

  /// Returns a shallow copy of this [RelatedFeatureViewData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RelatedFeatureViewData copyWith({
    _ik7og9il.CharacterFeatureSourceType? sourceType,
    int? sourceId,
    Object? sourceName = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? displayProperties = _Undefined,
    Object? resources = _Undefined,
    Object? spellSlotRecoveryEffects = _Undefined,
    Object? selectedChoices = _Undefined,
  }) {
    return RelatedFeatureViewData(
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      sourceName: sourceName is String? ? sourceName : this.sourceName,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      displayProperties:
          displayProperties is List<_i4dynmv7.FeatureDisplayPropertyView>?
          ? displayProperties
          : this.displayProperties?.map((e0) => e0.copyWith()).toList(),
      resources: resources is List<_iql0t5wa.CharacterResourceViewData>?
          ? resources
          : this.resources?.map((e0) => e0.copyWith()).toList(),
      spellSlotRecoveryEffects:
          spellSlotRecoveryEffects is List<_ipujnj10.FeatureResourceEffectData>?
          ? spellSlotRecoveryEffects
          : this.spellSlotRecoveryEffects?.map((e0) => e0.copyWith()).toList(),
      selectedChoices: selectedChoices is List<String>?
          ? selectedChoices
          : this.selectedChoices?.map((e0) => e0).toList(),
    );
  }
}
