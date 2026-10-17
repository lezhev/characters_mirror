/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
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
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['replacementProgressionKeys'],
            ),
      referenceKey: jsonSerialization['referenceKey'] as String,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_ia3fljii.ClassData>(
              jsonSerialization['sourceClass'],
            ),
      sourceSubclassId: jsonSerialization['sourceSubclassId'] as int?,
      sourceSubclass: jsonSerialization['sourceSubclass'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_icujtw1s.SubclassData>(
              jsonSerialization['sourceSubclass'],
            ),
      sourceFeatureId: jsonSerialization['sourceFeatureId'] as int?,
      sourceFeature: jsonSerialization['sourceFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_inxbtq9c.ClassFeatureData>(
              jsonSerialization['sourceFeature'],
            ),
      sourceSubclassFeatureId:
          jsonSerialization['sourceSubclassFeatureId'] as int?,
      sourceSubclassFeature: jsonSerialization['sourceSubclassFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i6bcyp7i.SubclassFeatureData>(
              jsonSerialization['sourceSubclassFeature'],
            ),
      sourceRaceId: jsonSerialization['sourceRaceId'] as int?,
      sourceRace: jsonSerialization['sourceRace'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_iaoquhhq.RaceData>(
              jsonSerialization['sourceRace'],
            ),
      sourceSubraceId: jsonSerialization['sourceSubraceId'] as int?,
      sourceSubrace: jsonSerialization['sourceSubrace'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_ixj8g60z.SubraceData>(
              jsonSerialization['sourceSubrace'],
            ),
      sourceRaceFeatureId: jsonSerialization['sourceRaceFeatureId'] as int?,
      sourceRaceFeature: jsonSerialization['sourceRaceFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_iga2jap7.RaceFeatureData>(
              jsonSerialization['sourceRaceFeature'],
            ),
      sourceBackgroundId: jsonSerialization['sourceBackgroundId'] as int?,
      sourceBackground: jsonSerialization['sourceBackground'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i1wu8zwo.BackgroundData>(
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
          : _ikmnmw29.Protocol()
                .deserialize<List<_igf6e3qg.ChoiceRequirementData>>(
                  jsonSerialization['requirements'],
                ),
      autoSelectSingleEligible:
          jsonSerialization['autoSelectSingleEligible'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['autoSelectSingleEligible'],
            ),
      appliesAtCharacterLevel:
          jsonSerialization['appliesAtCharacterLevel'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['appliesAtCharacterLevel'],
            ),
      exclusiveKey: jsonSerialization['exclusiveKey'] as String?,
      allowDuplicates: jsonSerialization['allowDuplicates'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['allowDuplicates'],
            ),
      sortOrder: jsonSerialization['sortOrder'] as int?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ChoiceGroupDataTable();

  static const db = ChoiceGroupDataRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChoiceGroupData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static ChoiceGroupDataInclude include({
    _ia3fljii.ClassDataInclude? sourceClass,
    _icujtw1s.SubclassDataInclude? sourceSubclass,
    _inxbtq9c.ClassFeatureDataInclude? sourceFeature,
    _i6bcyp7i.SubclassFeatureDataInclude? sourceSubclassFeature,
    _iaoquhhq.RaceDataInclude? sourceRace,
    _ixj8g60z.SubraceDataInclude? sourceSubrace,
    _iga2jap7.RaceFeatureDataInclude? sourceRaceFeature,
    _i1wu8zwo.BackgroundDataInclude? sourceBackground,
  }) {
    return ChoiceGroupDataInclude._(
      sourceClass: sourceClass,
      sourceSubclass: sourceSubclass,
      sourceFeature: sourceFeature,
      sourceSubclassFeature: sourceSubclassFeature,
      sourceRace: sourceRace,
      sourceSubrace: sourceSubrace,
      sourceRaceFeature: sourceRaceFeature,
      sourceBackground: sourceBackground,
    );
  }

  static ChoiceGroupDataIncludeList includeList({
    _is.WhereExpressionBuilder<ChoiceGroupDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChoiceGroupDataTable>? orderBy,
    _is.OrderByListBuilder<ChoiceGroupDataTable>? orderByList,
    ChoiceGroupDataInclude? include,
  }) {
    return ChoiceGroupDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChoiceGroupData.t),
      orderByList: orderByList?.call(ChoiceGroupData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class ChoiceGroupDataUpdateTable extends _is.UpdateTable<ChoiceGroupDataTable> {
  ChoiceGroupDataUpdateTable(super.table);

  _is.ColumnValue<String, String> progressionKey(String? value) =>
      _is.ColumnValue(table.progressionKey, value);

  _is.ColumnValue<int, int> replacementsAllowed(int? value) =>
      _is.ColumnValue(table.replacementsAllowed, value);

  _is.ColumnValue<List<String>, List<String>> replacementProgressionKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.replacementProgressionKeys, value);

  _is.ColumnValue<String, String> referenceKey(String value) =>
      _is.ColumnValue(table.referenceKey, value);

  _is.ColumnValue<String, String> name(String? value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<int, int> sourceClassId(int? value) =>
      _is.ColumnValue(table.sourceClassId, value);

  _is.ColumnValue<int, int> sourceSubclassId(int? value) =>
      _is.ColumnValue(table.sourceSubclassId, value);

  _is.ColumnValue<int, int> sourceFeatureId(int? value) =>
      _is.ColumnValue(table.sourceFeatureId, value);

  _is.ColumnValue<int, int> sourceSubclassFeatureId(int? value) =>
      _is.ColumnValue(table.sourceSubclassFeatureId, value);

  _is.ColumnValue<int, int> sourceRaceId(int? value) =>
      _is.ColumnValue(table.sourceRaceId, value);

  _is.ColumnValue<int, int> sourceSubraceId(int? value) =>
      _is.ColumnValue(table.sourceSubraceId, value);

  _is.ColumnValue<int, int> sourceRaceFeatureId(int? value) =>
      _is.ColumnValue(table.sourceRaceFeatureId, value);

  _is.ColumnValue<int, int> sourceBackgroundId(int? value) =>
      _is.ColumnValue(table.sourceBackgroundId, value);

  _is.ColumnValue<int, int> level(int? value) =>
      _is.ColumnValue(table.level, value);

  _is.ColumnValue<_iypqkewo.ChoiceType, _iypqkewo.ChoiceType> type(
    _iypqkewo.ChoiceType? value,
  ) => _is.ColumnValue(table.type, value);

  _is.ColumnValue<int, int> selectionCount(int? value) =>
      _is.ColumnValue(table.selectionCount, value);

  _is.ColumnValue<int, int> minimumSelectionCount(int? value) =>
      _is.ColumnValue(table.minimumSelectionCount, value);

  _is.ColumnValue<
    List<_igf6e3qg.ChoiceRequirementData>,
    List<_igf6e3qg.ChoiceRequirementData>
  >
  requirements(List<_igf6e3qg.ChoiceRequirementData>? value) =>
      _is.ColumnValue(table.requirements, value);

  _is.ColumnValue<bool, bool> autoSelectSingleEligible(bool? value) =>
      _is.ColumnValue(table.autoSelectSingleEligible, value);

  _is.ColumnValue<bool, bool> appliesAtCharacterLevel(bool? value) =>
      _is.ColumnValue(table.appliesAtCharacterLevel, value);

  _is.ColumnValue<String, String> exclusiveKey(String? value) =>
      _is.ColumnValue(table.exclusiveKey, value);

  _is.ColumnValue<bool, bool> allowDuplicates(bool? value) =>
      _is.ColumnValue(table.allowDuplicates, value);

  _is.ColumnValue<int, int> sortOrder(int? value) =>
      _is.ColumnValue(table.sortOrder, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class ChoiceGroupDataTable extends _is.Table<int?> {
  ChoiceGroupDataTable({super.tableRelation})
    : super(tableName: 'choice_group_data') {
    updateTable = ChoiceGroupDataUpdateTable(this);
    progressionKey = _is.ColumnString('progressionKey', this);
    replacementsAllowed = _is.ColumnInt('replacementsAllowed', this);
    replacementProgressionKeys = _is.ColumnSerializable<List<String>>(
      'replacementProgressionKeys',
      this,
    );
    referenceKey = _is.ColumnString('referenceKey', this);
    name = _is.ColumnString('name', this);
    description = _is.ColumnString('description', this);
    sourceClassId = _is.ColumnInt('sourceClassId', this);
    sourceSubclassId = _is.ColumnInt('sourceSubclassId', this);
    sourceFeatureId = _is.ColumnInt('sourceFeatureId', this);
    sourceSubclassFeatureId = _is.ColumnInt('sourceSubclassFeatureId', this);
    sourceRaceId = _is.ColumnInt('sourceRaceId', this);
    sourceSubraceId = _is.ColumnInt('sourceSubraceId', this);
    sourceRaceFeatureId = _is.ColumnInt('sourceRaceFeatureId', this);
    sourceBackgroundId = _is.ColumnInt('sourceBackgroundId', this);
    level = _is.ColumnInt('level', this);
    type = _is.ColumnEnum('type', this, _is.EnumSerialization.byName);
    selectionCount = _is.ColumnInt('selectionCount', this);
    minimumSelectionCount = _is.ColumnInt('minimumSelectionCount', this);
    requirements =
        _is.ColumnSerializable<List<_igf6e3qg.ChoiceRequirementData>>(
          'requirements',
          this,
        );
    autoSelectSingleEligible = _is.ColumnBool('autoSelectSingleEligible', this);
    appliesAtCharacterLevel = _is.ColumnBool('appliesAtCharacterLevel', this);
    exclusiveKey = _is.ColumnString('exclusiveKey', this);
    allowDuplicates = _is.ColumnBool('allowDuplicates', this);
    sortOrder = _is.ColumnInt('sortOrder', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final ChoiceGroupDataUpdateTable updateTable;

  late final _is.ColumnString progressionKey;

  late final _is.ColumnInt replacementsAllowed;

  late final _is.ColumnSerializable<List<String>> replacementProgressionKeys;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnInt sourceClassId;

  _ia3fljii.ClassDataTable? _sourceClass;

  late final _is.ColumnInt sourceSubclassId;

  _icujtw1s.SubclassDataTable? _sourceSubclass;

  late final _is.ColumnInt sourceFeatureId;

  _inxbtq9c.ClassFeatureDataTable? _sourceFeature;

  late final _is.ColumnInt sourceSubclassFeatureId;

  _i6bcyp7i.SubclassFeatureDataTable? _sourceSubclassFeature;

  late final _is.ColumnInt sourceRaceId;

  _iaoquhhq.RaceDataTable? _sourceRace;

  late final _is.ColumnInt sourceSubraceId;

  _ixj8g60z.SubraceDataTable? _sourceSubrace;

  late final _is.ColumnInt sourceRaceFeatureId;

  _iga2jap7.RaceFeatureDataTable? _sourceRaceFeature;

  late final _is.ColumnInt sourceBackgroundId;

  _i1wu8zwo.BackgroundDataTable? _sourceBackground;

  late final _is.ColumnInt level;

  late final _is.ColumnEnum<_iypqkewo.ChoiceType> type;

  late final _is.ColumnInt selectionCount;

  late final _is.ColumnInt minimumSelectionCount;

  late final _is.ColumnSerializable<List<_igf6e3qg.ChoiceRequirementData>>
  requirements;

  late final _is.ColumnBool autoSelectSingleEligible;

  late final _is.ColumnBool appliesAtCharacterLevel;

  late final _is.ColumnString exclusiveKey;

  late final _is.ColumnBool allowDuplicates;

  late final _is.ColumnInt sortOrder;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _ia3fljii.ClassDataTable get sourceClass {
    if (_sourceClass != null) return _sourceClass!;
    _sourceClass = _is.createRelationTable(
      relationFieldName: 'sourceClass',
      field: ChoiceGroupData.t.sourceClassId,
      foreignField: _ia3fljii.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ia3fljii.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceClass!;
  }

  _icujtw1s.SubclassDataTable get sourceSubclass {
    if (_sourceSubclass != null) return _sourceSubclass!;
    _sourceSubclass = _is.createRelationTable(
      relationFieldName: 'sourceSubclass',
      field: ChoiceGroupData.t.sourceSubclassId,
      foreignField: _icujtw1s.SubclassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _icujtw1s.SubclassDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceSubclass!;
  }

  _inxbtq9c.ClassFeatureDataTable get sourceFeature {
    if (_sourceFeature != null) return _sourceFeature!;
    _sourceFeature = _is.createRelationTable(
      relationFieldName: 'sourceFeature',
      field: ChoiceGroupData.t.sourceFeatureId,
      foreignField: _inxbtq9c.ClassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _inxbtq9c.ClassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceFeature!;
  }

  _i6bcyp7i.SubclassFeatureDataTable get sourceSubclassFeature {
    if (_sourceSubclassFeature != null) return _sourceSubclassFeature!;
    _sourceSubclassFeature = _is.createRelationTable(
      relationFieldName: 'sourceSubclassFeature',
      field: ChoiceGroupData.t.sourceSubclassFeatureId,
      foreignField: _i6bcyp7i.SubclassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i6bcyp7i.SubclassFeatureDataTable(
        tableRelation: foreignTableRelation,
      ),
    );
    return _sourceSubclassFeature!;
  }

  _iaoquhhq.RaceDataTable get sourceRace {
    if (_sourceRace != null) return _sourceRace!;
    _sourceRace = _is.createRelationTable(
      relationFieldName: 'sourceRace',
      field: ChoiceGroupData.t.sourceRaceId,
      foreignField: _iaoquhhq.RaceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iaoquhhq.RaceDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceRace!;
  }

  _ixj8g60z.SubraceDataTable get sourceSubrace {
    if (_sourceSubrace != null) return _sourceSubrace!;
    _sourceSubrace = _is.createRelationTable(
      relationFieldName: 'sourceSubrace',
      field: ChoiceGroupData.t.sourceSubraceId,
      foreignField: _ixj8g60z.SubraceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ixj8g60z.SubraceDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceSubrace!;
  }

  _iga2jap7.RaceFeatureDataTable get sourceRaceFeature {
    if (_sourceRaceFeature != null) return _sourceRaceFeature!;
    _sourceRaceFeature = _is.createRelationTable(
      relationFieldName: 'sourceRaceFeature',
      field: ChoiceGroupData.t.sourceRaceFeatureId,
      foreignField: _iga2jap7.RaceFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iga2jap7.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceRaceFeature!;
  }

  _i1wu8zwo.BackgroundDataTable get sourceBackground {
    if (_sourceBackground != null) return _sourceBackground!;
    _sourceBackground = _is.createRelationTable(
      relationFieldName: 'sourceBackground',
      field: ChoiceGroupData.t.sourceBackgroundId,
      foreignField: _i1wu8zwo.BackgroundData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i1wu8zwo.BackgroundDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceBackground!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    progressionKey,
    replacementsAllowed,
    replacementProgressionKeys,
    referenceKey,
    name,
    description,
    sourceClassId,
    sourceSubclassId,
    sourceFeatureId,
    sourceSubclassFeatureId,
    sourceRaceId,
    sourceSubraceId,
    sourceRaceFeatureId,
    sourceBackgroundId,
    level,
    type,
    selectionCount,
    minimumSelectionCount,
    requirements,
    autoSelectSingleEligible,
    appliesAtCharacterLevel,
    exclusiveKey,
    allowDuplicates,
    sortOrder,
    source,
    version,
    createdAt,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'sourceClass') {
      return sourceClass;
    }
    if (relationField == 'sourceSubclass') {
      return sourceSubclass;
    }
    if (relationField == 'sourceFeature') {
      return sourceFeature;
    }
    if (relationField == 'sourceSubclassFeature') {
      return sourceSubclassFeature;
    }
    if (relationField == 'sourceRace') {
      return sourceRace;
    }
    if (relationField == 'sourceSubrace') {
      return sourceSubrace;
    }
    if (relationField == 'sourceRaceFeature') {
      return sourceRaceFeature;
    }
    if (relationField == 'sourceBackground') {
      return sourceBackground;
    }
    return null;
  }
}

class ChoiceGroupDataInclude extends _is.IncludeObject {
  ChoiceGroupDataInclude._({
    _ia3fljii.ClassDataInclude? sourceClass,
    _icujtw1s.SubclassDataInclude? sourceSubclass,
    _inxbtq9c.ClassFeatureDataInclude? sourceFeature,
    _i6bcyp7i.SubclassFeatureDataInclude? sourceSubclassFeature,
    _iaoquhhq.RaceDataInclude? sourceRace,
    _ixj8g60z.SubraceDataInclude? sourceSubrace,
    _iga2jap7.RaceFeatureDataInclude? sourceRaceFeature,
    _i1wu8zwo.BackgroundDataInclude? sourceBackground,
  }) {
    _sourceClass = sourceClass;
    _sourceSubclass = sourceSubclass;
    _sourceFeature = sourceFeature;
    _sourceSubclassFeature = sourceSubclassFeature;
    _sourceRace = sourceRace;
    _sourceSubrace = sourceSubrace;
    _sourceRaceFeature = sourceRaceFeature;
    _sourceBackground = sourceBackground;
  }

  _ia3fljii.ClassDataInclude? _sourceClass;

  _icujtw1s.SubclassDataInclude? _sourceSubclass;

  _inxbtq9c.ClassFeatureDataInclude? _sourceFeature;

  _i6bcyp7i.SubclassFeatureDataInclude? _sourceSubclassFeature;

  _iaoquhhq.RaceDataInclude? _sourceRace;

  _ixj8g60z.SubraceDataInclude? _sourceSubrace;

  _iga2jap7.RaceFeatureDataInclude? _sourceRaceFeature;

  _i1wu8zwo.BackgroundDataInclude? _sourceBackground;

  @override
  Map<String, _is.Include?> get includes => {
    'sourceClass': _sourceClass,
    'sourceSubclass': _sourceSubclass,
    'sourceFeature': _sourceFeature,
    'sourceSubclassFeature': _sourceSubclassFeature,
    'sourceRace': _sourceRace,
    'sourceSubrace': _sourceSubrace,
    'sourceRaceFeature': _sourceRaceFeature,
    'sourceBackground': _sourceBackground,
  };

  @override
  _is.Table<int?> get table => ChoiceGroupData.t;
}

class ChoiceGroupDataIncludeList extends _is.IncludeList {
  ChoiceGroupDataIncludeList._({
    _is.WhereExpressionBuilder<ChoiceGroupDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChoiceGroupData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ChoiceGroupData.t;
}

class ChoiceGroupDataRepository {
  const ChoiceGroupDataRepository._();

  final attachRow = const ChoiceGroupDataAttachRowRepository._();

  final detachRow = const ChoiceGroupDataDetachRowRepository._();

  /// Returns a list of [ChoiceGroupData]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<ChoiceGroupData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChoiceGroupDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChoiceGroupDataTable>? orderBy,
    _is.OrderByListBuilder<ChoiceGroupDataTable>? orderByList,
    _is.Transaction? transaction,
    ChoiceGroupDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChoiceGroupData>(
      where: where?.call(ChoiceGroupData.t),
      orderBy: orderBy?.call(ChoiceGroupData.t),
      orderByList: orderByList?.call(ChoiceGroupData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChoiceGroupData] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<ChoiceGroupData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChoiceGroupDataTable>? where,
    int? offset,
    _is.OrderByBuilder<ChoiceGroupDataTable>? orderBy,
    _is.OrderByListBuilder<ChoiceGroupDataTable>? orderByList,
    _is.Transaction? transaction,
    ChoiceGroupDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChoiceGroupData>(
      where: where?.call(ChoiceGroupData.t),
      orderBy: orderBy?.call(ChoiceGroupData.t),
      orderByList: orderByList?.call(ChoiceGroupData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChoiceGroupData] by its [id] or null if no such row exists.
  Future<ChoiceGroupData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ChoiceGroupDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChoiceGroupData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChoiceGroupData]s in the list and returns the inserted rows.
  ///
  /// The returned [ChoiceGroupData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChoiceGroupData>> insert(
    _is.DatabaseSession session,
    List<ChoiceGroupData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ChoiceGroupData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ChoiceGroupData] and returns the inserted row.
  ///
  /// The returned [ChoiceGroupData] will have its `id` field set.
  Future<ChoiceGroupData> insertRow(
    _is.DatabaseSession session,
    ChoiceGroupData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChoiceGroupData>(row, transaction: transaction);
  }

  /// Upserts all [ChoiceGroupData]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [ChoiceGroupData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChoiceGroupData>> upsert(
    _is.DatabaseSession session,
    List<ChoiceGroupData> rows, {
    required _is.ColumnSelections<ChoiceGroupDataTable> conflictColumns,
    _is.ColumnSelections<ChoiceGroupDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ChoiceGroupDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ChoiceGroupData>(
      rows,
      conflictColumns: conflictColumns(ChoiceGroupData.t),
      updateColumns: updateColumns?.call(ChoiceGroupData.t),
      updateWhere: updateWhere?.call(ChoiceGroupData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ChoiceGroupData] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [ChoiceGroupData] will have its `id` field set.
  Future<ChoiceGroupData?> upsertRow(
    _is.DatabaseSession session,
    ChoiceGroupData row, {
    required _is.ColumnSelections<ChoiceGroupDataTable> conflictColumns,
    _is.ColumnSelections<ChoiceGroupDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ChoiceGroupDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ChoiceGroupData>(
      row,
      conflictColumns: conflictColumns(ChoiceGroupData.t),
      updateColumns: updateColumns?.call(ChoiceGroupData.t),
      updateWhere: updateWhere?.call(ChoiceGroupData.t),
      transaction: transaction,
    );
  }

  /// Updates all [ChoiceGroupData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChoiceGroupData>> update(
    _is.DatabaseSession session,
    List<ChoiceGroupData> rows, {
    _is.ColumnSelections<ChoiceGroupDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ChoiceGroupData>(
      rows,
      columns: columns?.call(ChoiceGroupData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ChoiceGroupData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChoiceGroupData> updateRow(
    _is.DatabaseSession session,
    ChoiceGroupData row, {
    _is.ColumnSelections<ChoiceGroupDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChoiceGroupData>(
      row,
      columns: columns?.call(ChoiceGroupData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChoiceGroupData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChoiceGroupData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ChoiceGroupDataUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ChoiceGroupData>(
      id,
      columnValues: columnValues(ChoiceGroupData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChoiceGroupData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChoiceGroupData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ChoiceGroupDataUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ChoiceGroupDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChoiceGroupDataTable>? orderBy,
    _is.OrderByListBuilder<ChoiceGroupDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ChoiceGroupData>(
      columnValues: columnValues(ChoiceGroupData.t.updateTable),
      where: where(ChoiceGroupData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChoiceGroupData.t),
      orderByList: orderByList?.call(ChoiceGroupData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ChoiceGroupData]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChoiceGroupData>> delete(
    _is.DatabaseSession session,
    List<ChoiceGroupData> rows, {
    _is.OrderByBuilder<ChoiceGroupDataTable>? orderBy,
    _is.OrderByListBuilder<ChoiceGroupDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ChoiceGroupData>(
      rows,
      orderBy: orderBy?.call(ChoiceGroupData.t),
      orderByList: orderByList?.call(ChoiceGroupData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ChoiceGroupData].
  Future<ChoiceGroupData> deleteRow(
    _is.DatabaseSession session,
    ChoiceGroupData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChoiceGroupData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChoiceGroupData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChoiceGroupDataTable> where,
    _is.OrderByBuilder<ChoiceGroupDataTable>? orderBy,
    _is.OrderByListBuilder<ChoiceGroupDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ChoiceGroupData>(
      where: where(ChoiceGroupData.t),
      orderBy: orderBy?.call(ChoiceGroupData.t),
      orderByList: orderByList?.call(ChoiceGroupData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChoiceGroupDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ChoiceGroupData>(
      where: where?.call(ChoiceGroupData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChoiceGroupData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChoiceGroupDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChoiceGroupData>(
      where: where(ChoiceGroupData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ChoiceGroupDataAttachRowRepository {
  const ChoiceGroupDataAttachRowRepository._();

  /// Creates a relation between the given [ChoiceGroupData] and [ClassData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceClassId` to refer to the [ClassData].
  Future<void> sourceClass(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData,
    _ia3fljii.ClassData sourceClass, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceClass.id == null) {
      throw ArgumentError.notNull('sourceClass.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(
      sourceClassId: sourceClass.id,
    );
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [SubclassData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceSubclassId` to refer to the [SubclassData].
  Future<void> sourceSubclass(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData,
    _icujtw1s.SubclassData sourceSubclass, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceSubclass.id == null) {
      throw ArgumentError.notNull('sourceSubclass.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(
      sourceSubclassId: sourceSubclass.id,
    );
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceSubclassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [ClassFeatureData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceFeatureId` to refer to the [ClassFeatureData].
  Future<void> sourceFeature(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData,
    _inxbtq9c.ClassFeatureData sourceFeature, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceFeature.id == null) {
      throw ArgumentError.notNull('sourceFeature.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(
      sourceFeatureId: sourceFeature.id,
    );
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [SubclassFeatureData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceSubclassFeatureId` to refer to the [SubclassFeatureData].
  Future<void> sourceSubclassFeature(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData,
    _i6bcyp7i.SubclassFeatureData sourceSubclassFeature, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceSubclassFeature.id == null) {
      throw ArgumentError.notNull('sourceSubclassFeature.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(
      sourceSubclassFeatureId: sourceSubclassFeature.id,
    );
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [RaceData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceRaceId` to refer to the [RaceData].
  Future<void> sourceRace(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData,
    _iaoquhhq.RaceData sourceRace, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceRace.id == null) {
      throw ArgumentError.notNull('sourceRace.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(
      sourceRaceId: sourceRace.id,
    );
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceRaceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [SubraceData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceSubraceId` to refer to the [SubraceData].
  Future<void> sourceSubrace(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData,
    _ixj8g60z.SubraceData sourceSubrace, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceSubrace.id == null) {
      throw ArgumentError.notNull('sourceSubrace.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(
      sourceSubraceId: sourceSubrace.id,
    );
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceSubraceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [RaceFeatureData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceRaceFeatureId` to refer to the [RaceFeatureData].
  Future<void> sourceRaceFeature(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData,
    _iga2jap7.RaceFeatureData sourceRaceFeature, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceRaceFeature.id == null) {
      throw ArgumentError.notNull('sourceRaceFeature.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(
      sourceRaceFeatureId: sourceRaceFeature.id,
    );
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceRaceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [BackgroundData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceBackgroundId` to refer to the [BackgroundData].
  Future<void> sourceBackground(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData,
    _i1wu8zwo.BackgroundData sourceBackground, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceBackground.id == null) {
      throw ArgumentError.notNull('sourceBackground.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(
      sourceBackgroundId: sourceBackground.id,
    );
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceBackgroundId],
      transaction: transaction,
    );
  }
}

class ChoiceGroupDataDetachRowRepository {
  const ChoiceGroupDataDetachRowRepository._();

  /// Detaches the relation between this [ChoiceGroupData] and the [ClassData] set in `sourceClass`
  /// by setting the [ChoiceGroupData]'s foreign key `sourceClassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceClass(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(sourceClassId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ChoiceGroupData] and the [SubclassData] set in `sourceSubclass`
  /// by setting the [ChoiceGroupData]'s foreign key `sourceSubclassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceSubclass(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(sourceSubclassId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceSubclassId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ChoiceGroupData] and the [ClassFeatureData] set in `sourceFeature`
  /// by setting the [ChoiceGroupData]'s foreign key `sourceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceFeature(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(sourceFeatureId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ChoiceGroupData] and the [SubclassFeatureData] set in `sourceSubclassFeature`
  /// by setting the [ChoiceGroupData]'s foreign key `sourceSubclassFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceSubclassFeature(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(
      sourceSubclassFeatureId: null,
    );
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ChoiceGroupData] and the [RaceData] set in `sourceRace`
  /// by setting the [ChoiceGroupData]'s foreign key `sourceRaceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceRace(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(sourceRaceId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceRaceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ChoiceGroupData] and the [SubraceData] set in `sourceSubrace`
  /// by setting the [ChoiceGroupData]'s foreign key `sourceSubraceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceSubrace(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(sourceSubraceId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceSubraceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ChoiceGroupData] and the [RaceFeatureData] set in `sourceRaceFeature`
  /// by setting the [ChoiceGroupData]'s foreign key `sourceRaceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceRaceFeature(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(sourceRaceFeatureId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceRaceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ChoiceGroupData] and the [BackgroundData] set in `sourceBackground`
  /// by setting the [ChoiceGroupData]'s foreign key `sourceBackgroundId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceBackground(
    _is.DatabaseSession session,
    ChoiceGroupData choiceGroupData, {
    _is.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(sourceBackgroundId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceBackgroundId],
      transaction: transaction,
    );
  }
}
