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
import '../../../data/general/character/related_feature_view_data.dart'
    as _ipb1wupa;
import '../../../data/general/feature_resource_effect_data.dart' as _ipujnj10;
import '../../../enums/character_feature_source_type.dart' as _ik7og9il;
import '../../../enums/feature_tag.dart' as _ixkx8coo;
import '../../../views/feature_display_property_view.dart' as _i4dynmv7;
import '../../../views/selected_feature_choice_view.dart' as _irdrn251;

abstract class CharacterFeatureViewData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CharacterFeatureViewData._({
    required this.sourceType,
    required this.sourceId,
    this.sourceName,
    this.level,
    this.defaultName,
    this.defaultDescription,
    this.defaultTags,
    this.name,
    this.description,
    this.shortDescription,
    this.tags,
    this.isCustomized,
    this.resources,
    this.displayProperties,
    this.relatedFeatures,
    this.mergedIntoFeatureSourceType,
    this.mergedIntoFeatureSourceId,
    this.selectedChoices,
    this.selectedChoiceDetails,
    this.sourceClassLevel,
    this.spellSlotRecoveryEffects,
  });

  factory CharacterFeatureViewData({
    required _ik7og9il.CharacterFeatureSourceType sourceType,
    required int sourceId,
    String? sourceName,
    int? level,
    String? defaultName,
    String? defaultDescription,
    List<_ixkx8coo.FeatureTag>? defaultTags,
    String? name,
    String? description,
    String? shortDescription,
    List<_ixkx8coo.FeatureTag>? tags,
    bool? isCustomized,
    List<_iql0t5wa.CharacterResourceViewData>? resources,
    List<_i4dynmv7.FeatureDisplayPropertyView>? displayProperties,
    List<_ipb1wupa.RelatedFeatureViewData>? relatedFeatures,
    _ik7og9il.CharacterFeatureSourceType? mergedIntoFeatureSourceType,
    int? mergedIntoFeatureSourceId,
    List<String>? selectedChoices,
    List<_irdrn251.SelectedFeatureChoiceView>? selectedChoiceDetails,
    int? sourceClassLevel,
    List<_ipujnj10.FeatureResourceEffectData>? spellSlotRecoveryEffects,
  }) = _CharacterFeatureViewDataImpl;

  factory CharacterFeatureViewData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterFeatureViewData(
      sourceType: _ik7og9il.CharacterFeatureSourceType.fromJson(
        (jsonSerialization['sourceType'] as String),
      ),
      sourceId: jsonSerialization['sourceId'] as int,
      sourceName: jsonSerialization['sourceName'] as String?,
      level: jsonSerialization['level'] as int?,
      defaultName: jsonSerialization['defaultName'] as String?,
      defaultDescription: jsonSerialization['defaultDescription'] as String?,
      defaultTags: jsonSerialization['defaultTags'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ixkx8coo.FeatureTag>>(
              jsonSerialization['defaultTags'],
            ),
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      shortDescription: jsonSerialization['shortDescription'] as String?,
      tags: jsonSerialization['tags'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ixkx8coo.FeatureTag>>(
              jsonSerialization['tags'],
            ),
      isCustomized: jsonSerialization['isCustomized'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isCustomized']),
      resources: jsonSerialization['resources'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_iql0t5wa.CharacterResourceViewData>>(
                  jsonSerialization['resources'],
                ),
      displayProperties: jsonSerialization['displayProperties'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_i4dynmv7.FeatureDisplayPropertyView>>(
                  jsonSerialization['displayProperties'],
                ),
      relatedFeatures: jsonSerialization['relatedFeatures'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_ipb1wupa.RelatedFeatureViewData>>(
                  jsonSerialization['relatedFeatures'],
                ),
      mergedIntoFeatureSourceType:
          jsonSerialization['mergedIntoFeatureSourceType'] == null
          ? null
          : _ik7og9il.CharacterFeatureSourceType.fromJson(
              (jsonSerialization['mergedIntoFeatureSourceType'] as String),
            ),
      mergedIntoFeatureSourceId:
          jsonSerialization['mergedIntoFeatureSourceId'] as int?,
      selectedChoices: jsonSerialization['selectedChoices'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['selectedChoices'],
            ),
      selectedChoiceDetails: jsonSerialization['selectedChoiceDetails'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_irdrn251.SelectedFeatureChoiceView>>(
                  jsonSerialization['selectedChoiceDetails'],
                ),
      sourceClassLevel: jsonSerialization['sourceClassLevel'] as int?,
      spellSlotRecoveryEffects:
          jsonSerialization['spellSlotRecoveryEffects'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_ipujnj10.FeatureResourceEffectData>>(
                  jsonSerialization['spellSlotRecoveryEffects'],
                ),
    );
  }

  _ik7og9il.CharacterFeatureSourceType sourceType;

  int sourceId;

  String? sourceName;

  int? level;

  String? defaultName;

  String? defaultDescription;

  List<_ixkx8coo.FeatureTag>? defaultTags;

  String? name;

  String? description;

  String? shortDescription;

  List<_ixkx8coo.FeatureTag>? tags;

  bool? isCustomized;

  List<_iql0t5wa.CharacterResourceViewData>? resources;

  List<_i4dynmv7.FeatureDisplayPropertyView>? displayProperties;

  List<_ipb1wupa.RelatedFeatureViewData>? relatedFeatures;

  _ik7og9il.CharacterFeatureSourceType? mergedIntoFeatureSourceType;

  int? mergedIntoFeatureSourceId;

  List<String>? selectedChoices;

  List<_irdrn251.SelectedFeatureChoiceView>? selectedChoiceDetails;

  int? sourceClassLevel;

  List<_ipujnj10.FeatureResourceEffectData>? spellSlotRecoveryEffects;

  /// Returns a shallow copy of this [CharacterFeatureViewData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CharacterFeatureViewData copyWith({
    _ik7og9il.CharacterFeatureSourceType? sourceType,
    int? sourceId,
    String? sourceName,
    int? level,
    String? defaultName,
    String? defaultDescription,
    List<_ixkx8coo.FeatureTag>? defaultTags,
    String? name,
    String? description,
    String? shortDescription,
    List<_ixkx8coo.FeatureTag>? tags,
    bool? isCustomized,
    List<_iql0t5wa.CharacterResourceViewData>? resources,
    List<_i4dynmv7.FeatureDisplayPropertyView>? displayProperties,
    List<_ipb1wupa.RelatedFeatureViewData>? relatedFeatures,
    _ik7og9il.CharacterFeatureSourceType? mergedIntoFeatureSourceType,
    int? mergedIntoFeatureSourceId,
    List<String>? selectedChoices,
    List<_irdrn251.SelectedFeatureChoiceView>? selectedChoiceDetails,
    int? sourceClassLevel,
    List<_ipujnj10.FeatureResourceEffectData>? spellSlotRecoveryEffects,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterFeatureViewData',
      'sourceType': sourceType.toJson(),
      'sourceId': sourceId,
      if (sourceName != null) 'sourceName': sourceName,
      if (level != null) 'level': level,
      if (defaultName != null) 'defaultName': defaultName,
      if (defaultDescription != null) 'defaultDescription': defaultDescription,
      if (defaultTags != null)
        'defaultTags': defaultTags?.toJson(valueToJson: (v) => v.toJson()),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (shortDescription != null) 'shortDescription': shortDescription,
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (isCustomized != null) 'isCustomized': isCustomized,
      if (resources != null)
        'resources': resources?.toJson(valueToJson: (v) => v.toJson()),
      if (displayProperties != null)
        'displayProperties': displayProperties?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (relatedFeatures != null)
        'relatedFeatures': relatedFeatures?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (mergedIntoFeatureSourceType != null)
        'mergedIntoFeatureSourceType': mergedIntoFeatureSourceType?.toJson(),
      if (mergedIntoFeatureSourceId != null)
        'mergedIntoFeatureSourceId': mergedIntoFeatureSourceId,
      if (selectedChoices != null) 'selectedChoices': selectedChoices?.toJson(),
      if (selectedChoiceDetails != null)
        'selectedChoiceDetails': selectedChoiceDetails?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (sourceClassLevel != null) 'sourceClassLevel': sourceClassLevel,
      if (spellSlotRecoveryEffects != null)
        'spellSlotRecoveryEffects': spellSlotRecoveryEffects?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterFeatureViewData',
      'sourceType': sourceType.toJson(),
      'sourceId': sourceId,
      if (sourceName != null) 'sourceName': sourceName,
      if (level != null) 'level': level,
      if (defaultName != null) 'defaultName': defaultName,
      if (defaultDescription != null) 'defaultDescription': defaultDescription,
      if (defaultTags != null)
        'defaultTags': defaultTags?.toJson(valueToJson: (v) => v.toJson()),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (shortDescription != null) 'shortDescription': shortDescription,
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (isCustomized != null) 'isCustomized': isCustomized,
      if (resources != null)
        'resources': resources?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (displayProperties != null)
        'displayProperties': displayProperties?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (relatedFeatures != null)
        'relatedFeatures': relatedFeatures?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (mergedIntoFeatureSourceType != null)
        'mergedIntoFeatureSourceType': mergedIntoFeatureSourceType?.toJson(),
      if (mergedIntoFeatureSourceId != null)
        'mergedIntoFeatureSourceId': mergedIntoFeatureSourceId,
      if (selectedChoices != null) 'selectedChoices': selectedChoices?.toJson(),
      if (selectedChoiceDetails != null)
        'selectedChoiceDetails': selectedChoiceDetails?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (sourceClassLevel != null) 'sourceClassLevel': sourceClassLevel,
      if (spellSlotRecoveryEffects != null)
        'spellSlotRecoveryEffects': spellSlotRecoveryEffects?.toJson(
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

class _CharacterFeatureViewDataImpl extends CharacterFeatureViewData {
  _CharacterFeatureViewDataImpl({
    required _ik7og9il.CharacterFeatureSourceType sourceType,
    required int sourceId,
    String? sourceName,
    int? level,
    String? defaultName,
    String? defaultDescription,
    List<_ixkx8coo.FeatureTag>? defaultTags,
    String? name,
    String? description,
    String? shortDescription,
    List<_ixkx8coo.FeatureTag>? tags,
    bool? isCustomized,
    List<_iql0t5wa.CharacterResourceViewData>? resources,
    List<_i4dynmv7.FeatureDisplayPropertyView>? displayProperties,
    List<_ipb1wupa.RelatedFeatureViewData>? relatedFeatures,
    _ik7og9il.CharacterFeatureSourceType? mergedIntoFeatureSourceType,
    int? mergedIntoFeatureSourceId,
    List<String>? selectedChoices,
    List<_irdrn251.SelectedFeatureChoiceView>? selectedChoiceDetails,
    int? sourceClassLevel,
    List<_ipujnj10.FeatureResourceEffectData>? spellSlotRecoveryEffects,
  }) : super._(
         sourceType: sourceType,
         sourceId: sourceId,
         sourceName: sourceName,
         level: level,
         defaultName: defaultName,
         defaultDescription: defaultDescription,
         defaultTags: defaultTags,
         name: name,
         description: description,
         shortDescription: shortDescription,
         tags: tags,
         isCustomized: isCustomized,
         resources: resources,
         displayProperties: displayProperties,
         relatedFeatures: relatedFeatures,
         mergedIntoFeatureSourceType: mergedIntoFeatureSourceType,
         mergedIntoFeatureSourceId: mergedIntoFeatureSourceId,
         selectedChoices: selectedChoices,
         selectedChoiceDetails: selectedChoiceDetails,
         sourceClassLevel: sourceClassLevel,
         spellSlotRecoveryEffects: spellSlotRecoveryEffects,
       );

  /// Returns a shallow copy of this [CharacterFeatureViewData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CharacterFeatureViewData copyWith({
    _ik7og9il.CharacterFeatureSourceType? sourceType,
    int? sourceId,
    Object? sourceName = _Undefined,
    Object? level = _Undefined,
    Object? defaultName = _Undefined,
    Object? defaultDescription = _Undefined,
    Object? defaultTags = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? shortDescription = _Undefined,
    Object? tags = _Undefined,
    Object? isCustomized = _Undefined,
    Object? resources = _Undefined,
    Object? displayProperties = _Undefined,
    Object? relatedFeatures = _Undefined,
    Object? mergedIntoFeatureSourceType = _Undefined,
    Object? mergedIntoFeatureSourceId = _Undefined,
    Object? selectedChoices = _Undefined,
    Object? selectedChoiceDetails = _Undefined,
    Object? sourceClassLevel = _Undefined,
    Object? spellSlotRecoveryEffects = _Undefined,
  }) {
    return CharacterFeatureViewData(
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      sourceName: sourceName is String? ? sourceName : this.sourceName,
      level: level is int? ? level : this.level,
      defaultName: defaultName is String? ? defaultName : this.defaultName,
      defaultDescription: defaultDescription is String?
          ? defaultDescription
          : this.defaultDescription,
      defaultTags: defaultTags is List<_ixkx8coo.FeatureTag>?
          ? defaultTags
          : this.defaultTags?.map((e0) => e0).toList(),
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      shortDescription: shortDescription is String?
          ? shortDescription
          : this.shortDescription,
      tags: tags is List<_ixkx8coo.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
      isCustomized: isCustomized is bool? ? isCustomized : this.isCustomized,
      resources: resources is List<_iql0t5wa.CharacterResourceViewData>?
          ? resources
          : this.resources?.map((e0) => e0.copyWith()).toList(),
      displayProperties:
          displayProperties is List<_i4dynmv7.FeatureDisplayPropertyView>?
          ? displayProperties
          : this.displayProperties?.map((e0) => e0.copyWith()).toList(),
      relatedFeatures:
          relatedFeatures is List<_ipb1wupa.RelatedFeatureViewData>?
          ? relatedFeatures
          : this.relatedFeatures?.map((e0) => e0.copyWith()).toList(),
      mergedIntoFeatureSourceType:
          mergedIntoFeatureSourceType is _ik7og9il.CharacterFeatureSourceType?
          ? mergedIntoFeatureSourceType
          : this.mergedIntoFeatureSourceType,
      mergedIntoFeatureSourceId: mergedIntoFeatureSourceId is int?
          ? mergedIntoFeatureSourceId
          : this.mergedIntoFeatureSourceId,
      selectedChoices: selectedChoices is List<String>?
          ? selectedChoices
          : this.selectedChoices?.map((e0) => e0).toList(),
      selectedChoiceDetails:
          selectedChoiceDetails is List<_irdrn251.SelectedFeatureChoiceView>?
          ? selectedChoiceDetails
          : this.selectedChoiceDetails?.map((e0) => e0.copyWith()).toList(),
      sourceClassLevel: sourceClassLevel is int?
          ? sourceClassLevel
          : this.sourceClassLevel,
      spellSlotRecoveryEffects:
          spellSlotRecoveryEffects is List<_ipujnj10.FeatureResourceEffectData>?
          ? spellSlotRecoveryEffects
          : this.spellSlotRecoveryEffects?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
