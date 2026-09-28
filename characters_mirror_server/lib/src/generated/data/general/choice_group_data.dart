/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../data/general/class/class_data.dart' as _i2;
import '../../data/general/class/subclass_data.dart' as _i3;
import '../../data/general/class/class_feature_data.dart' as _i4;
import '../../data/general/class/subclass_feature_data.dart' as _i5;
import '../../data/general/race/race_data.dart' as _i6;
import '../../data/general/race/subrace_data.dart' as _i7;
import '../../data/general/race/race_feature_data.dart' as _i8;
import '../../data/background_data.dart' as _i9;
import '../../enums/choice_type.dart' as _i10;

abstract class ChoiceGroupData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ChoiceGroupData._({
    this.id,
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
    required String referenceKey,
    String? name,
    String? description,
    int? sourceClassId,
    _i2.ClassData? sourceClass,
    int? sourceSubclassId,
    _i3.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _i4.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _i5.SubclassFeatureData? sourceSubclassFeature,
    int? sourceRaceId,
    _i6.RaceData? sourceRace,
    int? sourceSubraceId,
    _i7.SubraceData? sourceSubrace,
    int? sourceRaceFeatureId,
    _i8.RaceFeatureData? sourceRaceFeature,
    int? sourceBackgroundId,
    _i9.BackgroundData? sourceBackground,
    int? level,
    _i10.ChoiceType? type,
    int? selectionCount,
    int? minimumSelectionCount,
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
      referenceKey: jsonSerialization['referenceKey'] as String,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['sourceClass'] as Map<String, dynamic>)),
      sourceSubclassId: jsonSerialization['sourceSubclassId'] as int?,
      sourceSubclass: jsonSerialization['sourceSubclass'] == null
          ? null
          : _i3.SubclassData.fromJson(
              (jsonSerialization['sourceSubclass'] as Map<String, dynamic>)),
      sourceFeatureId: jsonSerialization['sourceFeatureId'] as int?,
      sourceFeature: jsonSerialization['sourceFeature'] == null
          ? null
          : _i4.ClassFeatureData.fromJson(
              (jsonSerialization['sourceFeature'] as Map<String, dynamic>)),
      sourceSubclassFeatureId:
          jsonSerialization['sourceSubclassFeatureId'] as int?,
      sourceSubclassFeature: jsonSerialization['sourceSubclassFeature'] == null
          ? null
          : _i5.SubclassFeatureData.fromJson(
              (jsonSerialization['sourceSubclassFeature']
                  as Map<String, dynamic>)),
      sourceRaceId: jsonSerialization['sourceRaceId'] as int?,
      sourceRace: jsonSerialization['sourceRace'] == null
          ? null
          : _i6.RaceData.fromJson(
              (jsonSerialization['sourceRace'] as Map<String, dynamic>)),
      sourceSubraceId: jsonSerialization['sourceSubraceId'] as int?,
      sourceSubrace: jsonSerialization['sourceSubrace'] == null
          ? null
          : _i7.SubraceData.fromJson(
              (jsonSerialization['sourceSubrace'] as Map<String, dynamic>)),
      sourceRaceFeatureId: jsonSerialization['sourceRaceFeatureId'] as int?,
      sourceRaceFeature: jsonSerialization['sourceRaceFeature'] == null
          ? null
          : _i8.RaceFeatureData.fromJson(
              (jsonSerialization['sourceRaceFeature'] as Map<String, dynamic>)),
      sourceBackgroundId: jsonSerialization['sourceBackgroundId'] as int?,
      sourceBackground: jsonSerialization['sourceBackground'] == null
          ? null
          : _i9.BackgroundData.fromJson(
              (jsonSerialization['sourceBackground'] as Map<String, dynamic>)),
      level: jsonSerialization['level'] as int?,
      type: jsonSerialization['type'] == null
          ? null
          : _i10.ChoiceType.fromJson((jsonSerialization['type'] as String)),
      selectionCount: jsonSerialization['selectionCount'] as int?,
      minimumSelectionCount: jsonSerialization['minimumSelectionCount'] as int?,
      appliesAtCharacterLevel:
          jsonSerialization['appliesAtCharacterLevel'] as bool?,
      exclusiveKey: jsonSerialization['exclusiveKey'] as String?,
      allowDuplicates: jsonSerialization['allowDuplicates'] as bool?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ChoiceGroupDataTable();

  static const db = ChoiceGroupDataRepository._();

  @override
  int? id;

  String referenceKey;

  String? name;

  String? description;

  int? sourceClassId;

  _i2.ClassData? sourceClass;

  int? sourceSubclassId;

  _i3.SubclassData? sourceSubclass;

  int? sourceFeatureId;

  _i4.ClassFeatureData? sourceFeature;

  int? sourceSubclassFeatureId;

  _i5.SubclassFeatureData? sourceSubclassFeature;

  int? sourceRaceId;

  _i6.RaceData? sourceRace;

  int? sourceSubraceId;

  _i7.SubraceData? sourceSubrace;

  int? sourceRaceFeatureId;

  _i8.RaceFeatureData? sourceRaceFeature;

  int? sourceBackgroundId;

  _i9.BackgroundData? sourceBackground;

  int? level;

  _i10.ChoiceType? type;

  int? selectionCount;

  int? minimumSelectionCount;

  bool? appliesAtCharacterLevel;

  String? exclusiveKey;

  bool? allowDuplicates;

  int? sortOrder;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChoiceGroupData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChoiceGroupData copyWith({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    int? sourceClassId,
    _i2.ClassData? sourceClass,
    int? sourceSubclassId,
    _i3.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _i4.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _i5.SubclassFeatureData? sourceSubclassFeature,
    int? sourceRaceId,
    _i6.RaceData? sourceRace,
    int? sourceSubraceId,
    _i7.SubraceData? sourceSubrace,
    int? sourceRaceFeatureId,
    _i8.RaceFeatureData? sourceRaceFeature,
    int? sourceBackgroundId,
    _i9.BackgroundData? sourceBackground,
    int? level,
    _i10.ChoiceType? type,
    int? selectionCount,
    int? minimumSelectionCount,
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
      if (id != null) 'id': id,
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
      if (id != null) 'id': id,
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
    _i2.ClassDataInclude? sourceClass,
    _i3.SubclassDataInclude? sourceSubclass,
    _i4.ClassFeatureDataInclude? sourceFeature,
    _i5.SubclassFeatureDataInclude? sourceSubclassFeature,
    _i6.RaceDataInclude? sourceRace,
    _i7.SubraceDataInclude? sourceSubrace,
    _i8.RaceFeatureDataInclude? sourceRaceFeature,
    _i9.BackgroundDataInclude? sourceBackground,
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
    _i1.WhereExpressionBuilder<ChoiceGroupDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChoiceGroupDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChoiceGroupDataTable>? orderByList,
    ChoiceGroupDataInclude? include,
  }) {
    return ChoiceGroupDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChoiceGroupData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChoiceGroupData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoiceGroupDataImpl extends ChoiceGroupData {
  _ChoiceGroupDataImpl({
    int? id,
    required String referenceKey,
    String? name,
    String? description,
    int? sourceClassId,
    _i2.ClassData? sourceClass,
    int? sourceSubclassId,
    _i3.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _i4.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _i5.SubclassFeatureData? sourceSubclassFeature,
    int? sourceRaceId,
    _i6.RaceData? sourceRace,
    int? sourceSubraceId,
    _i7.SubraceData? sourceSubrace,
    int? sourceRaceFeatureId,
    _i8.RaceFeatureData? sourceRaceFeature,
    int? sourceBackgroundId,
    _i9.BackgroundData? sourceBackground,
    int? level,
    _i10.ChoiceType? type,
    int? selectionCount,
    int? minimumSelectionCount,
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
  @_i1.useResult
  @override
  ChoiceGroupData copyWith({
    Object? id = _Undefined,
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
      referenceKey: referenceKey ?? this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      sourceClassId: sourceClassId is int? ? sourceClassId : this.sourceClassId,
      sourceClass: sourceClass is _i2.ClassData?
          ? sourceClass
          : this.sourceClass?.copyWith(),
      sourceSubclassId:
          sourceSubclassId is int? ? sourceSubclassId : this.sourceSubclassId,
      sourceSubclass: sourceSubclass is _i3.SubclassData?
          ? sourceSubclass
          : this.sourceSubclass?.copyWith(),
      sourceFeatureId:
          sourceFeatureId is int? ? sourceFeatureId : this.sourceFeatureId,
      sourceFeature: sourceFeature is _i4.ClassFeatureData?
          ? sourceFeature
          : this.sourceFeature?.copyWith(),
      sourceSubclassFeatureId: sourceSubclassFeatureId is int?
          ? sourceSubclassFeatureId
          : this.sourceSubclassFeatureId,
      sourceSubclassFeature: sourceSubclassFeature is _i5.SubclassFeatureData?
          ? sourceSubclassFeature
          : this.sourceSubclassFeature?.copyWith(),
      sourceRaceId: sourceRaceId is int? ? sourceRaceId : this.sourceRaceId,
      sourceRace: sourceRace is _i6.RaceData?
          ? sourceRace
          : this.sourceRace?.copyWith(),
      sourceSubraceId:
          sourceSubraceId is int? ? sourceSubraceId : this.sourceSubraceId,
      sourceSubrace: sourceSubrace is _i7.SubraceData?
          ? sourceSubrace
          : this.sourceSubrace?.copyWith(),
      sourceRaceFeatureId: sourceRaceFeatureId is int?
          ? sourceRaceFeatureId
          : this.sourceRaceFeatureId,
      sourceRaceFeature: sourceRaceFeature is _i8.RaceFeatureData?
          ? sourceRaceFeature
          : this.sourceRaceFeature?.copyWith(),
      sourceBackgroundId: sourceBackgroundId is int?
          ? sourceBackgroundId
          : this.sourceBackgroundId,
      sourceBackground: sourceBackground is _i9.BackgroundData?
          ? sourceBackground
          : this.sourceBackground?.copyWith(),
      level: level is int? ? level : this.level,
      type: type is _i10.ChoiceType? ? type : this.type,
      selectionCount:
          selectionCount is int? ? selectionCount : this.selectionCount,
      minimumSelectionCount: minimumSelectionCount is int?
          ? minimumSelectionCount
          : this.minimumSelectionCount,
      appliesAtCharacterLevel: appliesAtCharacterLevel is bool?
          ? appliesAtCharacterLevel
          : this.appliesAtCharacterLevel,
      exclusiveKey: exclusiveKey is String? ? exclusiveKey : this.exclusiveKey,
      allowDuplicates:
          allowDuplicates is bool? ? allowDuplicates : this.allowDuplicates,
      sortOrder: sortOrder is int? ? sortOrder : this.sortOrder,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class ChoiceGroupDataTable extends _i1.Table<int?> {
  ChoiceGroupDataTable({super.tableRelation})
      : super(tableName: 'choice_group_data') {
    referenceKey = _i1.ColumnString(
      'referenceKey',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    sourceClassId = _i1.ColumnInt(
      'sourceClassId',
      this,
    );
    sourceSubclassId = _i1.ColumnInt(
      'sourceSubclassId',
      this,
    );
    sourceFeatureId = _i1.ColumnInt(
      'sourceFeatureId',
      this,
    );
    sourceSubclassFeatureId = _i1.ColumnInt(
      'sourceSubclassFeatureId',
      this,
    );
    sourceRaceId = _i1.ColumnInt(
      'sourceRaceId',
      this,
    );
    sourceSubraceId = _i1.ColumnInt(
      'sourceSubraceId',
      this,
    );
    sourceRaceFeatureId = _i1.ColumnInt(
      'sourceRaceFeatureId',
      this,
    );
    sourceBackgroundId = _i1.ColumnInt(
      'sourceBackgroundId',
      this,
    );
    level = _i1.ColumnInt(
      'level',
      this,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
    );
    selectionCount = _i1.ColumnInt(
      'selectionCount',
      this,
    );
    minimumSelectionCount = _i1.ColumnInt(
      'minimumSelectionCount',
      this,
    );
    appliesAtCharacterLevel = _i1.ColumnBool(
      'appliesAtCharacterLevel',
      this,
    );
    exclusiveKey = _i1.ColumnString(
      'exclusiveKey',
      this,
    );
    allowDuplicates = _i1.ColumnBool(
      'allowDuplicates',
      this,
    );
    sortOrder = _i1.ColumnInt(
      'sortOrder',
      this,
    );
    source = _i1.ColumnString(
      'source',
      this,
    );
    version = _i1.ColumnInt(
      'version',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final _i1.ColumnString referenceKey;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt sourceClassId;

  _i2.ClassDataTable? _sourceClass;

  late final _i1.ColumnInt sourceSubclassId;

  _i3.SubclassDataTable? _sourceSubclass;

  late final _i1.ColumnInt sourceFeatureId;

  _i4.ClassFeatureDataTable? _sourceFeature;

  late final _i1.ColumnInt sourceSubclassFeatureId;

  _i5.SubclassFeatureDataTable? _sourceSubclassFeature;

  late final _i1.ColumnInt sourceRaceId;

  _i6.RaceDataTable? _sourceRace;

  late final _i1.ColumnInt sourceSubraceId;

  _i7.SubraceDataTable? _sourceSubrace;

  late final _i1.ColumnInt sourceRaceFeatureId;

  _i8.RaceFeatureDataTable? _sourceRaceFeature;

  late final _i1.ColumnInt sourceBackgroundId;

  _i9.BackgroundDataTable? _sourceBackground;

  late final _i1.ColumnInt level;

  late final _i1.ColumnEnum<_i10.ChoiceType> type;

  late final _i1.ColumnInt selectionCount;

  late final _i1.ColumnInt minimumSelectionCount;

  late final _i1.ColumnBool appliesAtCharacterLevel;

  late final _i1.ColumnString exclusiveKey;

  late final _i1.ColumnBool allowDuplicates;

  late final _i1.ColumnInt sortOrder;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.ClassDataTable get sourceClass {
    if (_sourceClass != null) return _sourceClass!;
    _sourceClass = _i1.createRelationTable(
      relationFieldName: 'sourceClass',
      field: ChoiceGroupData.t.sourceClassId,
      foreignField: _i2.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceClass!;
  }

  _i3.SubclassDataTable get sourceSubclass {
    if (_sourceSubclass != null) return _sourceSubclass!;
    _sourceSubclass = _i1.createRelationTable(
      relationFieldName: 'sourceSubclass',
      field: ChoiceGroupData.t.sourceSubclassId,
      foreignField: _i3.SubclassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SubclassDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceSubclass!;
  }

  _i4.ClassFeatureDataTable get sourceFeature {
    if (_sourceFeature != null) return _sourceFeature!;
    _sourceFeature = _i1.createRelationTable(
      relationFieldName: 'sourceFeature',
      field: ChoiceGroupData.t.sourceFeatureId,
      foreignField: _i4.ClassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ClassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceFeature!;
  }

  _i5.SubclassFeatureDataTable get sourceSubclassFeature {
    if (_sourceSubclassFeature != null) return _sourceSubclassFeature!;
    _sourceSubclassFeature = _i1.createRelationTable(
      relationFieldName: 'sourceSubclassFeature',
      field: ChoiceGroupData.t.sourceSubclassFeatureId,
      foreignField: _i5.SubclassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.SubclassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceSubclassFeature!;
  }

  _i6.RaceDataTable get sourceRace {
    if (_sourceRace != null) return _sourceRace!;
    _sourceRace = _i1.createRelationTable(
      relationFieldName: 'sourceRace',
      field: ChoiceGroupData.t.sourceRaceId,
      foreignField: _i6.RaceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.RaceDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceRace!;
  }

  _i7.SubraceDataTable get sourceSubrace {
    if (_sourceSubrace != null) return _sourceSubrace!;
    _sourceSubrace = _i1.createRelationTable(
      relationFieldName: 'sourceSubrace',
      field: ChoiceGroupData.t.sourceSubraceId,
      foreignField: _i7.SubraceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7.SubraceDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceSubrace!;
  }

  _i8.RaceFeatureDataTable get sourceRaceFeature {
    if (_sourceRaceFeature != null) return _sourceRaceFeature!;
    _sourceRaceFeature = _i1.createRelationTable(
      relationFieldName: 'sourceRaceFeature',
      field: ChoiceGroupData.t.sourceRaceFeatureId,
      foreignField: _i8.RaceFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceRaceFeature!;
  }

  _i9.BackgroundDataTable get sourceBackground {
    if (_sourceBackground != null) return _sourceBackground!;
    _sourceBackground = _i1.createRelationTable(
      relationFieldName: 'sourceBackground',
      field: ChoiceGroupData.t.sourceBackgroundId,
      foreignField: _i9.BackgroundData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i9.BackgroundDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceBackground!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
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
  _i1.Table? getRelationTable(String relationField) {
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

class ChoiceGroupDataInclude extends _i1.IncludeObject {
  ChoiceGroupDataInclude._({
    _i2.ClassDataInclude? sourceClass,
    _i3.SubclassDataInclude? sourceSubclass,
    _i4.ClassFeatureDataInclude? sourceFeature,
    _i5.SubclassFeatureDataInclude? sourceSubclassFeature,
    _i6.RaceDataInclude? sourceRace,
    _i7.SubraceDataInclude? sourceSubrace,
    _i8.RaceFeatureDataInclude? sourceRaceFeature,
    _i9.BackgroundDataInclude? sourceBackground,
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

  _i2.ClassDataInclude? _sourceClass;

  _i3.SubclassDataInclude? _sourceSubclass;

  _i4.ClassFeatureDataInclude? _sourceFeature;

  _i5.SubclassFeatureDataInclude? _sourceSubclassFeature;

  _i6.RaceDataInclude? _sourceRace;

  _i7.SubraceDataInclude? _sourceSubrace;

  _i8.RaceFeatureDataInclude? _sourceRaceFeature;

  _i9.BackgroundDataInclude? _sourceBackground;

  @override
  Map<String, _i1.Include?> get includes => {
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
  _i1.Table<int?> get table => ChoiceGroupData.t;
}

class ChoiceGroupDataIncludeList extends _i1.IncludeList {
  ChoiceGroupDataIncludeList._({
    _i1.WhereExpressionBuilder<ChoiceGroupDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChoiceGroupData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ChoiceGroupData.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChoiceGroupDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChoiceGroupDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChoiceGroupDataTable>? orderByList,
    _i1.Transaction? transaction,
    ChoiceGroupDataInclude? include,
  }) async {
    return session.db.find<ChoiceGroupData>(
      where: where?.call(ChoiceGroupData.t),
      orderBy: orderBy?.call(ChoiceGroupData.t),
      orderByList: orderByList?.call(ChoiceGroupData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChoiceGroupDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChoiceGroupDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChoiceGroupDataTable>? orderByList,
    _i1.Transaction? transaction,
    ChoiceGroupDataInclude? include,
  }) async {
    return session.db.findFirstRow<ChoiceGroupData>(
      where: where?.call(ChoiceGroupData.t),
      orderBy: orderBy?.call(ChoiceGroupData.t),
      orderByList: orderByList?.call(ChoiceGroupData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ChoiceGroupData] by its [id] or null if no such row exists.
  Future<ChoiceGroupData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ChoiceGroupDataInclude? include,
  }) async {
    return session.db.findById<ChoiceGroupData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ChoiceGroupData]s in the list and returns the inserted rows.
  ///
  /// The returned [ChoiceGroupData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ChoiceGroupData>> insert(
    _i1.Session session,
    List<ChoiceGroupData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ChoiceGroupData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ChoiceGroupData] and returns the inserted row.
  ///
  /// The returned [ChoiceGroupData] will have its `id` field set.
  Future<ChoiceGroupData> insertRow(
    _i1.Session session,
    ChoiceGroupData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChoiceGroupData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChoiceGroupData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChoiceGroupData>> update(
    _i1.Session session,
    List<ChoiceGroupData> rows, {
    _i1.ColumnSelections<ChoiceGroupDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChoiceGroupData>(
      rows,
      columns: columns?.call(ChoiceGroupData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChoiceGroupData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChoiceGroupData> updateRow(
    _i1.Session session,
    ChoiceGroupData row, {
    _i1.ColumnSelections<ChoiceGroupDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChoiceGroupData>(
      row,
      columns: columns?.call(ChoiceGroupData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ChoiceGroupData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChoiceGroupData>> delete(
    _i1.Session session,
    List<ChoiceGroupData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChoiceGroupData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChoiceGroupData].
  Future<ChoiceGroupData> deleteRow(
    _i1.Session session,
    ChoiceGroupData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChoiceGroupData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChoiceGroupData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChoiceGroupDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChoiceGroupData>(
      where: where(ChoiceGroupData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChoiceGroupDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChoiceGroupData>(
      where: where?.call(ChoiceGroupData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ChoiceGroupDataAttachRowRepository {
  const ChoiceGroupDataAttachRowRepository._();

  /// Creates a relation between the given [ChoiceGroupData] and [ClassData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceClassId` to refer to the [ClassData].
  Future<void> sourceClass(
    _i1.Session session,
    ChoiceGroupData choiceGroupData,
    _i2.ClassData sourceClass, {
    _i1.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceClass.id == null) {
      throw ArgumentError.notNull('sourceClass.id');
    }

    var $choiceGroupData =
        choiceGroupData.copyWith(sourceClassId: sourceClass.id);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [SubclassData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceSubclassId` to refer to the [SubclassData].
  Future<void> sourceSubclass(
    _i1.Session session,
    ChoiceGroupData choiceGroupData,
    _i3.SubclassData sourceSubclass, {
    _i1.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceSubclass.id == null) {
      throw ArgumentError.notNull('sourceSubclass.id');
    }

    var $choiceGroupData =
        choiceGroupData.copyWith(sourceSubclassId: sourceSubclass.id);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceSubclassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [ClassFeatureData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceFeatureId` to refer to the [ClassFeatureData].
  Future<void> sourceFeature(
    _i1.Session session,
    ChoiceGroupData choiceGroupData,
    _i4.ClassFeatureData sourceFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceFeature.id == null) {
      throw ArgumentError.notNull('sourceFeature.id');
    }

    var $choiceGroupData =
        choiceGroupData.copyWith(sourceFeatureId: sourceFeature.id);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [SubclassFeatureData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceSubclassFeatureId` to refer to the [SubclassFeatureData].
  Future<void> sourceSubclassFeature(
    _i1.Session session,
    ChoiceGroupData choiceGroupData,
    _i5.SubclassFeatureData sourceSubclassFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceSubclassFeature.id == null) {
      throw ArgumentError.notNull('sourceSubclassFeature.id');
    }

    var $choiceGroupData = choiceGroupData.copyWith(
        sourceSubclassFeatureId: sourceSubclassFeature.id);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [RaceData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceRaceId` to refer to the [RaceData].
  Future<void> sourceRace(
    _i1.Session session,
    ChoiceGroupData choiceGroupData,
    _i6.RaceData sourceRace, {
    _i1.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceRace.id == null) {
      throw ArgumentError.notNull('sourceRace.id');
    }

    var $choiceGroupData =
        choiceGroupData.copyWith(sourceRaceId: sourceRace.id);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceRaceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [SubraceData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceSubraceId` to refer to the [SubraceData].
  Future<void> sourceSubrace(
    _i1.Session session,
    ChoiceGroupData choiceGroupData,
    _i7.SubraceData sourceSubrace, {
    _i1.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceSubrace.id == null) {
      throw ArgumentError.notNull('sourceSubrace.id');
    }

    var $choiceGroupData =
        choiceGroupData.copyWith(sourceSubraceId: sourceSubrace.id);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceSubraceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [RaceFeatureData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceRaceFeatureId` to refer to the [RaceFeatureData].
  Future<void> sourceRaceFeature(
    _i1.Session session,
    ChoiceGroupData choiceGroupData,
    _i8.RaceFeatureData sourceRaceFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceRaceFeature.id == null) {
      throw ArgumentError.notNull('sourceRaceFeature.id');
    }

    var $choiceGroupData =
        choiceGroupData.copyWith(sourceRaceFeatureId: sourceRaceFeature.id);
    await session.db.updateRow<ChoiceGroupData>(
      $choiceGroupData,
      columns: [ChoiceGroupData.t.sourceRaceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChoiceGroupData] and [BackgroundData]
  /// by setting the [ChoiceGroupData]'s foreign key `sourceBackgroundId` to refer to the [BackgroundData].
  Future<void> sourceBackground(
    _i1.Session session,
    ChoiceGroupData choiceGroupData,
    _i9.BackgroundData sourceBackground, {
    _i1.Transaction? transaction,
  }) async {
    if (choiceGroupData.id == null) {
      throw ArgumentError.notNull('choiceGroupData.id');
    }
    if (sourceBackground.id == null) {
      throw ArgumentError.notNull('sourceBackground.id');
    }

    var $choiceGroupData =
        choiceGroupData.copyWith(sourceBackgroundId: sourceBackground.id);
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
    _i1.Session session,
    ChoiceGroupData choicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (choicegroupdata.id == null) {
      throw ArgumentError.notNull('choicegroupdata.id');
    }

    var $choicegroupdata = choicegroupdata.copyWith(sourceClassId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choicegroupdata,
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
    _i1.Session session,
    ChoiceGroupData choicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (choicegroupdata.id == null) {
      throw ArgumentError.notNull('choicegroupdata.id');
    }

    var $choicegroupdata = choicegroupdata.copyWith(sourceSubclassId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choicegroupdata,
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
    _i1.Session session,
    ChoiceGroupData choicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (choicegroupdata.id == null) {
      throw ArgumentError.notNull('choicegroupdata.id');
    }

    var $choicegroupdata = choicegroupdata.copyWith(sourceFeatureId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choicegroupdata,
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
    _i1.Session session,
    ChoiceGroupData choicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (choicegroupdata.id == null) {
      throw ArgumentError.notNull('choicegroupdata.id');
    }

    var $choicegroupdata =
        choicegroupdata.copyWith(sourceSubclassFeatureId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choicegroupdata,
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
    _i1.Session session,
    ChoiceGroupData choicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (choicegroupdata.id == null) {
      throw ArgumentError.notNull('choicegroupdata.id');
    }

    var $choicegroupdata = choicegroupdata.copyWith(sourceRaceId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choicegroupdata,
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
    _i1.Session session,
    ChoiceGroupData choicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (choicegroupdata.id == null) {
      throw ArgumentError.notNull('choicegroupdata.id');
    }

    var $choicegroupdata = choicegroupdata.copyWith(sourceSubraceId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choicegroupdata,
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
    _i1.Session session,
    ChoiceGroupData choicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (choicegroupdata.id == null) {
      throw ArgumentError.notNull('choicegroupdata.id');
    }

    var $choicegroupdata = choicegroupdata.copyWith(sourceRaceFeatureId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choicegroupdata,
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
    _i1.Session session,
    ChoiceGroupData choicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (choicegroupdata.id == null) {
      throw ArgumentError.notNull('choicegroupdata.id');
    }

    var $choicegroupdata = choicegroupdata.copyWith(sourceBackgroundId: null);
    await session.db.updateRow<ChoiceGroupData>(
      $choicegroupdata,
      columns: [ChoiceGroupData.t.sourceBackgroundId],
      transaction: transaction,
    );
  }
}
