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
import '../../data/background_data.dart' as _i1wu8zwo;
import '../../data/general/choice_requirement_data.dart' as _igf6e3qg;
import '../../data/general/class/class_data.dart' as _ia3fljii;
import '../../data/general/class/class_feature_data.dart' as _inxbtq9c;
import '../../data/general/class/subclass_data.dart' as _icujtw1s;
import '../../data/general/class/subclass_feature_data.dart' as _i6bcyp7i;
import '../../data/general/race/race_data.dart' as _iaoquhhq;
import '../../data/general/race/race_feature_data.dart' as _iga2jap7;
import '../../data/general/race/subrace_data.dart' as _ixj8g60z;
import '../../enums/choice_type.dart' as _iypqkewo;

abstract class ChoiceGroupData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChoiceGroupData._({
    this.id,
    this.progressionKey,
    this.replacementsAllowed,
    this.replacementProgressionKeys,
    required this.referenceKey,
    this.name,
    this.description,
    this.sourceClassId,
    this.sourceClass,
    this.sourceSubclassId,
    this.sourceSubclass,
    this.sourceFeatureId,
    this.sourceFeature,
    this.sourceSubclassFeatureId,
    this.sourceSubclassFeature,
    this.sourceRaceId,
    this.sourceRace,
    this.sourceSubraceId,
    this.sourceSubrace,
    this.sourceRaceFeatureId,
    this.sourceRaceFeature,
    this.sourceBackgroundId,
    this.sourceBackground,
    this.level,
    this.type,
    this.selectionCount,
    this.minimumSelectionCount,
    this.requirements,
    this.autoSelectSingleEligible,
    this.appliesAtCharacterLevel,
    this.exclusiveKey,
    this.allowDuplicates,
    this.sortOrder,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory ChoiceGroupData({
    int? id,
    String? progressionKey,
    int? replacementsAllowed,
    List<String>? replacementProgressionKeys,
    required String referenceKey,
    String? name,
    String? description,
    int? sourceClassId,
    _ia3fljii.ClassData? sourceClass,
    int? sourceSubclassId,
    _icujtw1s.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _inxbtq9c.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? sourceSubclassFeature,
    int? sourceRaceId,
    _iaoquhhq.RaceData? sourceRace,
    int? sourceSubraceId,
    _ixj8g60z.SubraceData? sourceSubrace,
    int? sourceRaceFeatureId,
    _iga2jap7.RaceFeatureData? sourceRaceFeature,
    int? sourceBackgroundId,
    _i1wu8zwo.BackgroundData? sourceBackground,
    int? level,
    _iypqkewo.ChoiceType? type,
    int? selectionCount,
    int? minimumSelectionCount,
    List<_igf6e3qg.ChoiceRequirementData>? requirements,
    bool? autoSelectSingleEligible,
    bool? appliesAtCharacterLevel,
    String? exclusiveKey,
    bool? allowDuplicates,
    int? sortOrder,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ChoiceGroupDataImpl;

  factory ChoiceGroupData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChoiceGroupData(
      id: jsonSerialization['id'] as int?,
      progressionKey: jsonSerialization['progressionKey'] as String?,
      replacementsAllowed: jsonSerialization['replacementsAllowed'] as int?,
      replacementProgressionKeys:
          jsonSerialization['replacementProgressionKeys'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['replacementProgressionKeys'],
            ),
      referenceKey: jsonSerialization['referenceKey'] as String,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_ia3fljii.ClassData>(
              jsonSerialization['sourceClass'],
            ),
      sourceSubclassId: jsonSerialization['sourceSubclassId'] as int?,
      sourceSubclass: jsonSerialization['sourceSubclass'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_icujtw1s.SubclassData>(
              jsonSerialization['sourceSubclass'],
            ),
      sourceFeatureId: jsonSerialization['sourceFeatureId'] as int?,
      sourceFeature: jsonSerialization['sourceFeature'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_inxbtq9c.ClassFeatureData>(
              jsonSerialization['sourceFeature'],
            ),
      sourceSubclassFeatureId:
          jsonSerialization['sourceSubclassFeatureId'] as int?,
      sourceSubclassFeature: jsonSerialization['sourceSubclassFeature'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_i6bcyp7i.SubclassFeatureData>(
              jsonSerialization['sourceSubclassFeature'],
            ),
      sourceRaceId: jsonSerialization['sourceRaceId'] as int?,
      sourceRace: jsonSerialization['sourceRace'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_iaoquhhq.RaceData>(
              jsonSerialization['sourceRace'],
            ),
      sourceSubraceId: jsonSerialization['sourceSubraceId'] as int?,
      sourceSubrace: jsonSerialization['sourceSubrace'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_ixj8g60z.SubraceData>(
              jsonSerialization['sourceSubrace'],
            ),
      sourceRaceFeatureId: jsonSerialization['sourceRaceFeatureId'] as int?,
      sourceRaceFeature: jsonSerialization['sourceRaceFeature'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_iga2jap7.RaceFeatureData>(
              jsonSerialization['sourceRaceFeature'],
            ),
      sourceBackgroundId: jsonSerialization['sourceBackgroundId'] as int?,
      sourceBackground: jsonSerialization['sourceBackground'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_i1wu8zwo.BackgroundData>(
              jsonSerialization['sourceBackground'],
            ),
      level: jsonSerialization['level'] as int?,
      type: jsonSerialization['type'] == null
          ? null
          : _iypqkewo.ChoiceType.fromJson(
              (jsonSerialization['type'] as String),
            ),
      selectionCount: jsonSerialization['selectionCount'] as int?,
      minimumSelectionCount: jsonSerialization['minimumSelectionCount'] as int?,
      requirements: jsonSerialization['requirements'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_igf6e3qg.ChoiceRequirementData>>(
                  jsonSerialization['requirements'],
                ),
      autoSelectSingleEligible:
          jsonSerialization['autoSelectSingleEligible'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['autoSelectSingleEligible'],
            ),
      appliesAtCharacterLevel:
          jsonSerialization['appliesAtCharacterLevel'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['appliesAtCharacterLevel'],
            ),
      exclusiveKey: jsonSerialization['exclusiveKey'] as String?,
      allowDuplicates: jsonSerialization['allowDuplicates'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['allowDuplicates'],
            ),
      sortOrder: jsonSerialization['sortOrder'] as int?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? progressionKey;

  int? replacementsAllowed;

  List<String>? replacementProgressionKeys;

  String referenceKey;

  String? name;

  String? description;

  int? sourceClassId;

  _ia3fljii.ClassData? sourceClass;

  int? sourceSubclassId;

  _icujtw1s.SubclassData? sourceSubclass;

  int? sourceFeatureId;

  _inxbtq9c.ClassFeatureData? sourceFeature;

  int? sourceSubclassFeatureId;

  _i6bcyp7i.SubclassFeatureData? sourceSubclassFeature;

  int? sourceRaceId;

  _iaoquhhq.RaceData? sourceRace;

  int? sourceSubraceId;

  _ixj8g60z.SubraceData? sourceSubrace;

  int? sourceRaceFeatureId;

  _iga2jap7.RaceFeatureData? sourceRaceFeature;

  int? sourceBackgroundId;

  _i1wu8zwo.BackgroundData? sourceBackground;

  int? level;

  _iypqkewo.ChoiceType? type;

  int? selectionCount;

  int? minimumSelectionCount;

  List<_igf6e3qg.ChoiceRequirementData>? requirements;

  bool? autoSelectSingleEligible;

  bool? appliesAtCharacterLevel;

  String? exclusiveKey;

  bool? allowDuplicates;

  int? sortOrder;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [ChoiceGroupData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChoiceGroupData copyWith({
    int? id,
    String? progressionKey,
    int? replacementsAllowed,
    List<String>? replacementProgressionKeys,
    String? referenceKey,
    String? name,
    String? description,
    int? sourceClassId,
    _ia3fljii.ClassData? sourceClass,
    int? sourceSubclassId,
    _icujtw1s.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _inxbtq9c.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? sourceSubclassFeature,
    int? sourceRaceId,
    _iaoquhhq.RaceData? sourceRace,
    int? sourceSubraceId,
    _ixj8g60z.SubraceData? sourceSubrace,
    int? sourceRaceFeatureId,
    _iga2jap7.RaceFeatureData? sourceRaceFeature,
    int? sourceBackgroundId,
    _i1wu8zwo.BackgroundData? sourceBackground,
    int? level,
    _iypqkewo.ChoiceType? type,
    int? selectionCount,
    int? minimumSelectionCount,
    List<_igf6e3qg.ChoiceRequirementData>? requirements,
    bool? autoSelectSingleEligible,
    bool? appliesAtCharacterLevel,
    String? exclusiveKey,
    bool? allowDuplicates,
    int? sortOrder,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChoiceGroupData',
      if (id != null) 'id': id,
      if (progressionKey != null) 'progressionKey': progressionKey,
      if (replacementsAllowed != null)
        'replacementsAllowed': replacementsAllowed,
      if (replacementProgressionKeys != null)
        'replacementProgressionKeys': replacementProgressionKeys?.toJson(),
      'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJson(),
      if (sourceSubclassId != null) 'sourceSubclassId': sourceSubclassId,
      if (sourceSubclass != null) 'sourceSubclass': sourceSubclass?.toJson(),
      if (sourceFeatureId != null) 'sourceFeatureId': sourceFeatureId,
      if (sourceFeature != null) 'sourceFeature': sourceFeature?.toJson(),
      if (sourceSubclassFeatureId != null)
        'sourceSubclassFeatureId': sourceSubclassFeatureId,
      if (sourceSubclassFeature != null)
        'sourceSubclassFeature': sourceSubclassFeature?.toJson(),
      if (sourceRaceId != null) 'sourceRaceId': sourceRaceId,
      if (sourceRace != null) 'sourceRace': sourceRace?.toJson(),
      if (sourceSubraceId != null) 'sourceSubraceId': sourceSubraceId,
      if (sourceSubrace != null) 'sourceSubrace': sourceSubrace?.toJson(),
      if (sourceRaceFeatureId != null)
        'sourceRaceFeatureId': sourceRaceFeatureId,
      if (sourceRaceFeature != null)
        'sourceRaceFeature': sourceRaceFeature?.toJson(),
      if (sourceBackgroundId != null) 'sourceBackgroundId': sourceBackgroundId,
      if (sourceBackground != null)
        'sourceBackground': sourceBackground?.toJson(),
      if (level != null) 'level': level,
      if (type != null) 'type': type?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (minimumSelectionCount != null)
        'minimumSelectionCount': minimumSelectionCount,
      if (requirements != null)
        'requirements': requirements?.toJson(valueToJson: (v) => v.toJson()),
      if (autoSelectSingleEligible != null)
        'autoSelectSingleEligible': autoSelectSingleEligible,
      if (appliesAtCharacterLevel != null)
        'appliesAtCharacterLevel': appliesAtCharacterLevel,
      if (exclusiveKey != null) 'exclusiveKey': exclusiveKey,
      if (allowDuplicates != null) 'allowDuplicates': allowDuplicates,
      if (sortOrder != null) 'sortOrder': sortOrder,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChoiceGroupData',
      if (id != null) 'id': id,
      if (progressionKey != null) 'progressionKey': progressionKey,
      if (replacementsAllowed != null)
        'replacementsAllowed': replacementsAllowed,
      if (replacementProgressionKeys != null)
        'replacementProgressionKeys': replacementProgressionKeys?.toJson(),
      'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJsonForProtocol(),
      if (sourceSubclassId != null) 'sourceSubclassId': sourceSubclassId,
      if (sourceSubclass != null)
        'sourceSubclass': sourceSubclass?.toJsonForProtocol(),
      if (sourceFeatureId != null) 'sourceFeatureId': sourceFeatureId,
      if (sourceFeature != null)
        'sourceFeature': sourceFeature?.toJsonForProtocol(),
      if (sourceSubclassFeatureId != null)
        'sourceSubclassFeatureId': sourceSubclassFeatureId,
      if (sourceSubclassFeature != null)
        'sourceSubclassFeature': sourceSubclassFeature?.toJsonForProtocol(),
      if (sourceRaceId != null) 'sourceRaceId': sourceRaceId,
      if (sourceRace != null) 'sourceRace': sourceRace?.toJsonForProtocol(),
      if (sourceSubraceId != null) 'sourceSubraceId': sourceSubraceId,
      if (sourceSubrace != null)
        'sourceSubrace': sourceSubrace?.toJsonForProtocol(),
      if (sourceRaceFeatureId != null)
        'sourceRaceFeatureId': sourceRaceFeatureId,
      if (sourceRaceFeature != null)
        'sourceRaceFeature': sourceRaceFeature?.toJsonForProtocol(),
      if (sourceBackgroundId != null) 'sourceBackgroundId': sourceBackgroundId,
      if (sourceBackground != null)
        'sourceBackground': sourceBackground?.toJsonForProtocol(),
      if (level != null) 'level': level,
      if (type != null) 'type': type?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (minimumSelectionCount != null)
        'minimumSelectionCount': minimumSelectionCount,
      if (requirements != null)
        'requirements': requirements?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (autoSelectSingleEligible != null)
        'autoSelectSingleEligible': autoSelectSingleEligible,
      if (appliesAtCharacterLevel != null)
        'appliesAtCharacterLevel': appliesAtCharacterLevel,
      if (exclusiveKey != null) 'exclusiveKey': exclusiveKey,
      if (allowDuplicates != null) 'allowDuplicates': allowDuplicates,
      if (sortOrder != null) 'sortOrder': sortOrder,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoiceGroupDataImpl extends ChoiceGroupData {
  _ChoiceGroupDataImpl({
    int? id,
    String? progressionKey,
    int? replacementsAllowed,
    List<String>? replacementProgressionKeys,
    required String referenceKey,
    String? name,
    String? description,
    int? sourceClassId,
    _ia3fljii.ClassData? sourceClass,
    int? sourceSubclassId,
    _icujtw1s.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _inxbtq9c.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? sourceSubclassFeature,
    int? sourceRaceId,
    _iaoquhhq.RaceData? sourceRace,
    int? sourceSubraceId,
    _ixj8g60z.SubraceData? sourceSubrace,
    int? sourceRaceFeatureId,
    _iga2jap7.RaceFeatureData? sourceRaceFeature,
    int? sourceBackgroundId,
    _i1wu8zwo.BackgroundData? sourceBackground,
    int? level,
    _iypqkewo.ChoiceType? type,
    int? selectionCount,
    int? minimumSelectionCount,
    List<_igf6e3qg.ChoiceRequirementData>? requirements,
    bool? autoSelectSingleEligible,
    bool? appliesAtCharacterLevel,
    String? exclusiveKey,
    bool? allowDuplicates,
    int? sortOrder,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         progressionKey: progressionKey,
         replacementsAllowed: replacementsAllowed,
         replacementProgressionKeys: replacementProgressionKeys,
         referenceKey: referenceKey,
         name: name,
         description: description,
         sourceClassId: sourceClassId,
         sourceClass: sourceClass,
         sourceSubclassId: sourceSubclassId,
         sourceSubclass: sourceSubclass,
         sourceFeatureId: sourceFeatureId,
         sourceFeature: sourceFeature,
         sourceSubclassFeatureId: sourceSubclassFeatureId,
         sourceSubclassFeature: sourceSubclassFeature,
         sourceRaceId: sourceRaceId,
         sourceRace: sourceRace,
         sourceSubraceId: sourceSubraceId,
         sourceSubrace: sourceSubrace,
         sourceRaceFeatureId: sourceRaceFeatureId,
         sourceRaceFeature: sourceRaceFeature,
         sourceBackgroundId: sourceBackgroundId,
         sourceBackground: sourceBackground,
         level: level,
         type: type,
         selectionCount: selectionCount,
         minimumSelectionCount: minimumSelectionCount,
         requirements: requirements,
         autoSelectSingleEligible: autoSelectSingleEligible,
         appliesAtCharacterLevel: appliesAtCharacterLevel,
         exclusiveKey: exclusiveKey,
         allowDuplicates: allowDuplicates,
         sortOrder: sortOrder,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ChoiceGroupData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChoiceGroupData copyWith({
    Object? id = _Undefined,
    Object? progressionKey = _Undefined,
    Object? replacementsAllowed = _Undefined,
    Object? replacementProgressionKeys = _Undefined,
    String? referenceKey,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? sourceClassId = _Undefined,
    Object? sourceClass = _Undefined,
    Object? sourceSubclassId = _Undefined,
    Object? sourceSubclass = _Undefined,
    Object? sourceFeatureId = _Undefined,
    Object? sourceFeature = _Undefined,
    Object? sourceSubclassFeatureId = _Undefined,
    Object? sourceSubclassFeature = _Undefined,
    Object? sourceRaceId = _Undefined,
    Object? sourceRace = _Undefined,
    Object? sourceSubraceId = _Undefined,
    Object? sourceSubrace = _Undefined,
    Object? sourceRaceFeatureId = _Undefined,
    Object? sourceRaceFeature = _Undefined,
    Object? sourceBackgroundId = _Undefined,
    Object? sourceBackground = _Undefined,
    Object? level = _Undefined,
    Object? type = _Undefined,
    Object? selectionCount = _Undefined,
    Object? minimumSelectionCount = _Undefined,
    Object? requirements = _Undefined,
    Object? autoSelectSingleEligible = _Undefined,
    Object? appliesAtCharacterLevel = _Undefined,
    Object? exclusiveKey = _Undefined,
    Object? allowDuplicates = _Undefined,
    Object? sortOrder = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return ChoiceGroupData(
      id: id is int? ? id : this.id,
      progressionKey: progressionKey is String?
          ? progressionKey
          : this.progressionKey,
      replacementsAllowed: replacementsAllowed is int?
          ? replacementsAllowed
          : this.replacementsAllowed,
      replacementProgressionKeys: replacementProgressionKeys is List<String>?
          ? replacementProgressionKeys
          : this.replacementProgressionKeys?.map((e0) => e0).toList(),
      referenceKey: referenceKey ?? this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      sourceClassId: sourceClassId is int? ? sourceClassId : this.sourceClassId,
      sourceClass: sourceClass is _ia3fljii.ClassData?
          ? sourceClass
          : this.sourceClass?.copyWith(),
      sourceSubclassId: sourceSubclassId is int?
          ? sourceSubclassId
          : this.sourceSubclassId,
      sourceSubclass: sourceSubclass is _icujtw1s.SubclassData?
          ? sourceSubclass
          : this.sourceSubclass?.copyWith(),
      sourceFeatureId: sourceFeatureId is int?
          ? sourceFeatureId
          : this.sourceFeatureId,
      sourceFeature: sourceFeature is _inxbtq9c.ClassFeatureData?
          ? sourceFeature
          : this.sourceFeature?.copyWith(),
      sourceSubclassFeatureId: sourceSubclassFeatureId is int?
          ? sourceSubclassFeatureId
          : this.sourceSubclassFeatureId,
      sourceSubclassFeature:
          sourceSubclassFeature is _i6bcyp7i.SubclassFeatureData?
          ? sourceSubclassFeature
          : this.sourceSubclassFeature?.copyWith(),
      sourceRaceId: sourceRaceId is int? ? sourceRaceId : this.sourceRaceId,
      sourceRace: sourceRace is _iaoquhhq.RaceData?
          ? sourceRace
          : this.sourceRace?.copyWith(),
      sourceSubraceId: sourceSubraceId is int?
          ? sourceSubraceId
          : this.sourceSubraceId,
      sourceSubrace: sourceSubrace is _ixj8g60z.SubraceData?
          ? sourceSubrace
          : this.sourceSubrace?.copyWith(),
      sourceRaceFeatureId: sourceRaceFeatureId is int?
          ? sourceRaceFeatureId
          : this.sourceRaceFeatureId,
      sourceRaceFeature: sourceRaceFeature is _iga2jap7.RaceFeatureData?
          ? sourceRaceFeature
          : this.sourceRaceFeature?.copyWith(),
      sourceBackgroundId: sourceBackgroundId is int?
          ? sourceBackgroundId
          : this.sourceBackgroundId,
      sourceBackground: sourceBackground is _i1wu8zwo.BackgroundData?
          ? sourceBackground
          : this.sourceBackground?.copyWith(),
      level: level is int? ? level : this.level,
      type: type is _iypqkewo.ChoiceType? ? type : this.type,
      selectionCount: selectionCount is int?
          ? selectionCount
          : this.selectionCount,
      minimumSelectionCount: minimumSelectionCount is int?
          ? minimumSelectionCount
          : this.minimumSelectionCount,
      requirements: requirements is List<_igf6e3qg.ChoiceRequirementData>?
          ? requirements
          : this.requirements?.map((e0) => e0.copyWith()).toList(),
      autoSelectSingleEligible: autoSelectSingleEligible is bool?
          ? autoSelectSingleEligible
          : this.autoSelectSingleEligible,
      appliesAtCharacterLevel: appliesAtCharacterLevel is bool?
          ? appliesAtCharacterLevel
          : this.appliesAtCharacterLevel,
      exclusiveKey: exclusiveKey is String? ? exclusiveKey : this.exclusiveKey,
      allowDuplicates: allowDuplicates is bool?
          ? allowDuplicates
          : this.allowDuplicates,
      sortOrder: sortOrder is int? ? sortOrder : this.sortOrder,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
