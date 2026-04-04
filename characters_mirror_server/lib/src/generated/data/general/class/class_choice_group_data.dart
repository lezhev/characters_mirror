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
import '../../../data/general/class/class_data.dart' as _i2;
import '../../../data/general/class/subclass_data.dart' as _i3;
import '../../../data/general/class/class_feature_data.dart' as _i4;
import '../../../data/general/class/subclass_feature_data.dart' as _i5;
import '../../../data/general/race/race_data.dart' as _i6;
import '../../../data/general/race/subrace_data.dart' as _i7;
import '../../../data/background_data.dart' as _i8;
import '../../../enums/class_choice_type.dart' as _i9;

abstract class ClassChoiceGroupData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ClassChoiceGroupData._({
    this.id,
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
    this.sourceBackgroundId,
    this.sourceBackground,
    this.level,
    this.type,
    this.selectionCount,
    this.appliesAtCharacterLevel,
    this.exclusiveKey,
    this.allowDuplicates,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassChoiceGroupData({
    int? id,
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
    int? sourceBackgroundId,
    _i8.BackgroundData? sourceBackground,
    int? level,
    _i9.ClassChoiceType? type,
    int? selectionCount,
    bool? appliesAtCharacterLevel,
    String? exclusiveKey,
    bool? allowDuplicates,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ClassChoiceGroupDataImpl;

  factory ClassChoiceGroupData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ClassChoiceGroupData(
      id: jsonSerialization['id'] as int?,
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
      sourceBackgroundId: jsonSerialization['sourceBackgroundId'] as int?,
      sourceBackground: jsonSerialization['sourceBackground'] == null
          ? null
          : _i8.BackgroundData.fromJson(
              (jsonSerialization['sourceBackground'] as Map<String, dynamic>)),
      level: jsonSerialization['level'] as int?,
      type: jsonSerialization['type'] == null
          ? null
          : _i9.ClassChoiceType.fromJson((jsonSerialization['type'] as String)),
      selectionCount: jsonSerialization['selectionCount'] as int?,
      appliesAtCharacterLevel:
          jsonSerialization['appliesAtCharacterLevel'] as bool?,
      exclusiveKey: jsonSerialization['exclusiveKey'] as String?,
      allowDuplicates: jsonSerialization['allowDuplicates'] as bool?,
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

  static final t = ClassChoiceGroupDataTable();

  static const db = ClassChoiceGroupDataRepository._();

  @override
  int? id;

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

  int? sourceBackgroundId;

  _i8.BackgroundData? sourceBackground;

  int? level;

  _i9.ClassChoiceType? type;

  int? selectionCount;

  bool? appliesAtCharacterLevel;

  String? exclusiveKey;

  bool? allowDuplicates;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClassChoiceGroupData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassChoiceGroupData copyWith({
    int? id,
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
    int? sourceBackgroundId,
    _i8.BackgroundData? sourceBackground,
    int? level,
    _i9.ClassChoiceType? type,
    int? selectionCount,
    bool? appliesAtCharacterLevel,
    String? exclusiveKey,
    bool? allowDuplicates,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
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
      if (sourceBackgroundId != null) 'sourceBackgroundId': sourceBackgroundId,
      if (sourceBackground != null)
        'sourceBackground': sourceBackground?.toJson(),
      if (level != null) 'level': level,
      if (type != null) 'type': type?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (appliesAtCharacterLevel != null)
        'appliesAtCharacterLevel': appliesAtCharacterLevel,
      if (exclusiveKey != null) 'exclusiveKey': exclusiveKey,
      if (allowDuplicates != null) 'allowDuplicates': allowDuplicates,
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
      if (sourceBackgroundId != null) 'sourceBackgroundId': sourceBackgroundId,
      if (sourceBackground != null)
        'sourceBackground': sourceBackground?.toJsonForProtocol(),
      if (level != null) 'level': level,
      if (type != null) 'type': type?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (appliesAtCharacterLevel != null)
        'appliesAtCharacterLevel': appliesAtCharacterLevel,
      if (exclusiveKey != null) 'exclusiveKey': exclusiveKey,
      if (allowDuplicates != null) 'allowDuplicates': allowDuplicates,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static ClassChoiceGroupDataInclude include({
    _i2.ClassDataInclude? sourceClass,
    _i3.SubclassDataInclude? sourceSubclass,
    _i4.ClassFeatureDataInclude? sourceFeature,
    _i5.SubclassFeatureDataInclude? sourceSubclassFeature,
    _i6.RaceDataInclude? sourceRace,
    _i7.SubraceDataInclude? sourceSubrace,
    _i8.BackgroundDataInclude? sourceBackground,
  }) {
    return ClassChoiceGroupDataInclude._(
      sourceClass: sourceClass,
      sourceSubclass: sourceSubclass,
      sourceFeature: sourceFeature,
      sourceSubclassFeature: sourceSubclassFeature,
      sourceRace: sourceRace,
      sourceSubrace: sourceSubrace,
      sourceBackground: sourceBackground,
    );
  }

  static ClassChoiceGroupDataIncludeList includeList({
    _i1.WhereExpressionBuilder<ClassChoiceGroupDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassChoiceGroupDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassChoiceGroupDataTable>? orderByList,
    ClassChoiceGroupDataInclude? include,
  }) {
    return ClassChoiceGroupDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassChoiceGroupData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ClassChoiceGroupData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassChoiceGroupDataImpl extends ClassChoiceGroupData {
  _ClassChoiceGroupDataImpl({
    int? id,
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
    int? sourceBackgroundId,
    _i8.BackgroundData? sourceBackground,
    int? level,
    _i9.ClassChoiceType? type,
    int? selectionCount,
    bool? appliesAtCharacterLevel,
    String? exclusiveKey,
    bool? allowDuplicates,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
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
          sourceBackgroundId: sourceBackgroundId,
          sourceBackground: sourceBackground,
          level: level,
          type: type,
          selectionCount: selectionCount,
          appliesAtCharacterLevel: appliesAtCharacterLevel,
          exclusiveKey: exclusiveKey,
          allowDuplicates: allowDuplicates,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ClassChoiceGroupData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassChoiceGroupData copyWith({
    Object? id = _Undefined,
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
    Object? sourceBackgroundId = _Undefined,
    Object? sourceBackground = _Undefined,
    Object? level = _Undefined,
    Object? type = _Undefined,
    Object? selectionCount = _Undefined,
    Object? appliesAtCharacterLevel = _Undefined,
    Object? exclusiveKey = _Undefined,
    Object? allowDuplicates = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return ClassChoiceGroupData(
      id: id is int? ? id : this.id,
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
      sourceBackgroundId: sourceBackgroundId is int?
          ? sourceBackgroundId
          : this.sourceBackgroundId,
      sourceBackground: sourceBackground is _i8.BackgroundData?
          ? sourceBackground
          : this.sourceBackground?.copyWith(),
      level: level is int? ? level : this.level,
      type: type is _i9.ClassChoiceType? ? type : this.type,
      selectionCount:
          selectionCount is int? ? selectionCount : this.selectionCount,
      appliesAtCharacterLevel: appliesAtCharacterLevel is bool?
          ? appliesAtCharacterLevel
          : this.appliesAtCharacterLevel,
      exclusiveKey: exclusiveKey is String? ? exclusiveKey : this.exclusiveKey,
      allowDuplicates:
          allowDuplicates is bool? ? allowDuplicates : this.allowDuplicates,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class ClassChoiceGroupDataTable extends _i1.Table<int?> {
  ClassChoiceGroupDataTable({super.tableRelation})
      : super(tableName: 'class_choice_group_data') {
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

  late final _i1.ColumnInt sourceBackgroundId;

  _i8.BackgroundDataTable? _sourceBackground;

  late final _i1.ColumnInt level;

  late final _i1.ColumnEnum<_i9.ClassChoiceType> type;

  late final _i1.ColumnInt selectionCount;

  late final _i1.ColumnBool appliesAtCharacterLevel;

  late final _i1.ColumnString exclusiveKey;

  late final _i1.ColumnBool allowDuplicates;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.ClassDataTable get sourceClass {
    if (_sourceClass != null) return _sourceClass!;
    _sourceClass = _i1.createRelationTable(
      relationFieldName: 'sourceClass',
      field: ClassChoiceGroupData.t.sourceClassId,
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
      field: ClassChoiceGroupData.t.sourceSubclassId,
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
      field: ClassChoiceGroupData.t.sourceFeatureId,
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
      field: ClassChoiceGroupData.t.sourceSubclassFeatureId,
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
      field: ClassChoiceGroupData.t.sourceRaceId,
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
      field: ClassChoiceGroupData.t.sourceSubraceId,
      foreignField: _i7.SubraceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7.SubraceDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceSubrace!;
  }

  _i8.BackgroundDataTable get sourceBackground {
    if (_sourceBackground != null) return _sourceBackground!;
    _sourceBackground = _i1.createRelationTable(
      relationFieldName: 'sourceBackground',
      field: ClassChoiceGroupData.t.sourceBackgroundId,
      foreignField: _i8.BackgroundData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.BackgroundDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceBackground!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
        sourceClassId,
        sourceSubclassId,
        sourceFeatureId,
        sourceSubclassFeatureId,
        sourceRaceId,
        sourceSubraceId,
        sourceBackgroundId,
        level,
        type,
        selectionCount,
        appliesAtCharacterLevel,
        exclusiveKey,
        allowDuplicates,
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
    if (relationField == 'sourceBackground') {
      return sourceBackground;
    }
    return null;
  }
}

class ClassChoiceGroupDataInclude extends _i1.IncludeObject {
  ClassChoiceGroupDataInclude._({
    _i2.ClassDataInclude? sourceClass,
    _i3.SubclassDataInclude? sourceSubclass,
    _i4.ClassFeatureDataInclude? sourceFeature,
    _i5.SubclassFeatureDataInclude? sourceSubclassFeature,
    _i6.RaceDataInclude? sourceRace,
    _i7.SubraceDataInclude? sourceSubrace,
    _i8.BackgroundDataInclude? sourceBackground,
  }) {
    _sourceClass = sourceClass;
    _sourceSubclass = sourceSubclass;
    _sourceFeature = sourceFeature;
    _sourceSubclassFeature = sourceSubclassFeature;
    _sourceRace = sourceRace;
    _sourceSubrace = sourceSubrace;
    _sourceBackground = sourceBackground;
  }

  _i2.ClassDataInclude? _sourceClass;

  _i3.SubclassDataInclude? _sourceSubclass;

  _i4.ClassFeatureDataInclude? _sourceFeature;

  _i5.SubclassFeatureDataInclude? _sourceSubclassFeature;

  _i6.RaceDataInclude? _sourceRace;

  _i7.SubraceDataInclude? _sourceSubrace;

  _i8.BackgroundDataInclude? _sourceBackground;

  @override
  Map<String, _i1.Include?> get includes => {
        'sourceClass': _sourceClass,
        'sourceSubclass': _sourceSubclass,
        'sourceFeature': _sourceFeature,
        'sourceSubclassFeature': _sourceSubclassFeature,
        'sourceRace': _sourceRace,
        'sourceSubrace': _sourceSubrace,
        'sourceBackground': _sourceBackground,
      };

  @override
  _i1.Table<int?> get table => ClassChoiceGroupData.t;
}

class ClassChoiceGroupDataIncludeList extends _i1.IncludeList {
  ClassChoiceGroupDataIncludeList._({
    _i1.WhereExpressionBuilder<ClassChoiceGroupDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClassChoiceGroupData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ClassChoiceGroupData.t;
}

class ClassChoiceGroupDataRepository {
  const ClassChoiceGroupDataRepository._();

  final attachRow = const ClassChoiceGroupDataAttachRowRepository._();

  final detachRow = const ClassChoiceGroupDataDetachRowRepository._();

  /// Returns a list of [ClassChoiceGroupData]s matching the given query parameters.
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
  Future<List<ClassChoiceGroupData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassChoiceGroupDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassChoiceGroupDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassChoiceGroupDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassChoiceGroupDataInclude? include,
  }) async {
    return session.db.find<ClassChoiceGroupData>(
      where: where?.call(ClassChoiceGroupData.t),
      orderBy: orderBy?.call(ClassChoiceGroupData.t),
      orderByList: orderByList?.call(ClassChoiceGroupData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ClassChoiceGroupData] matching the given query parameters.
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
  Future<ClassChoiceGroupData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassChoiceGroupDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClassChoiceGroupDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassChoiceGroupDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassChoiceGroupDataInclude? include,
  }) async {
    return session.db.findFirstRow<ClassChoiceGroupData>(
      where: where?.call(ClassChoiceGroupData.t),
      orderBy: orderBy?.call(ClassChoiceGroupData.t),
      orderByList: orderByList?.call(ClassChoiceGroupData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ClassChoiceGroupData] by its [id] or null if no such row exists.
  Future<ClassChoiceGroupData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ClassChoiceGroupDataInclude? include,
  }) async {
    return session.db.findById<ClassChoiceGroupData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ClassChoiceGroupData]s in the list and returns the inserted rows.
  ///
  /// The returned [ClassChoiceGroupData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ClassChoiceGroupData>> insert(
    _i1.Session session,
    List<ClassChoiceGroupData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ClassChoiceGroupData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ClassChoiceGroupData] and returns the inserted row.
  ///
  /// The returned [ClassChoiceGroupData] will have its `id` field set.
  Future<ClassChoiceGroupData> insertRow(
    _i1.Session session,
    ClassChoiceGroupData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClassChoiceGroupData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ClassChoiceGroupData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ClassChoiceGroupData>> update(
    _i1.Session session,
    List<ClassChoiceGroupData> rows, {
    _i1.ColumnSelections<ClassChoiceGroupDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ClassChoiceGroupData>(
      rows,
      columns: columns?.call(ClassChoiceGroupData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClassChoiceGroupData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClassChoiceGroupData> updateRow(
    _i1.Session session,
    ClassChoiceGroupData row, {
    _i1.ColumnSelections<ClassChoiceGroupDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClassChoiceGroupData>(
      row,
      columns: columns?.call(ClassChoiceGroupData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ClassChoiceGroupData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ClassChoiceGroupData>> delete(
    _i1.Session session,
    List<ClassChoiceGroupData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ClassChoiceGroupData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ClassChoiceGroupData].
  Future<ClassChoiceGroupData> deleteRow(
    _i1.Session session,
    ClassChoiceGroupData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClassChoiceGroupData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ClassChoiceGroupData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClassChoiceGroupDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ClassChoiceGroupData>(
      where: where(ClassChoiceGroupData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassChoiceGroupDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ClassChoiceGroupData>(
      where: where?.call(ClassChoiceGroupData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ClassChoiceGroupDataAttachRowRepository {
  const ClassChoiceGroupDataAttachRowRepository._();

  /// Creates a relation between the given [ClassChoiceGroupData] and [ClassData]
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceClassId` to refer to the [ClassData].
  Future<void> sourceClass(
    _i1.Session session,
    ClassChoiceGroupData classChoiceGroupData,
    _i2.ClassData sourceClass, {
    _i1.Transaction? transaction,
  }) async {
    if (classChoiceGroupData.id == null) {
      throw ArgumentError.notNull('classChoiceGroupData.id');
    }
    if (sourceClass.id == null) {
      throw ArgumentError.notNull('sourceClass.id');
    }

    var $classChoiceGroupData =
        classChoiceGroupData.copyWith(sourceClassId: sourceClass.id);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classChoiceGroupData,
      columns: [ClassChoiceGroupData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassChoiceGroupData] and [SubclassData]
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceSubclassId` to refer to the [SubclassData].
  Future<void> sourceSubclass(
    _i1.Session session,
    ClassChoiceGroupData classChoiceGroupData,
    _i3.SubclassData sourceSubclass, {
    _i1.Transaction? transaction,
  }) async {
    if (classChoiceGroupData.id == null) {
      throw ArgumentError.notNull('classChoiceGroupData.id');
    }
    if (sourceSubclass.id == null) {
      throw ArgumentError.notNull('sourceSubclass.id');
    }

    var $classChoiceGroupData =
        classChoiceGroupData.copyWith(sourceSubclassId: sourceSubclass.id);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classChoiceGroupData,
      columns: [ClassChoiceGroupData.t.sourceSubclassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassChoiceGroupData] and [ClassFeatureData]
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceFeatureId` to refer to the [ClassFeatureData].
  Future<void> sourceFeature(
    _i1.Session session,
    ClassChoiceGroupData classChoiceGroupData,
    _i4.ClassFeatureData sourceFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (classChoiceGroupData.id == null) {
      throw ArgumentError.notNull('classChoiceGroupData.id');
    }
    if (sourceFeature.id == null) {
      throw ArgumentError.notNull('sourceFeature.id');
    }

    var $classChoiceGroupData =
        classChoiceGroupData.copyWith(sourceFeatureId: sourceFeature.id);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classChoiceGroupData,
      columns: [ClassChoiceGroupData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassChoiceGroupData] and [SubclassFeatureData]
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceSubclassFeatureId` to refer to the [SubclassFeatureData].
  Future<void> sourceSubclassFeature(
    _i1.Session session,
    ClassChoiceGroupData classChoiceGroupData,
    _i5.SubclassFeatureData sourceSubclassFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (classChoiceGroupData.id == null) {
      throw ArgumentError.notNull('classChoiceGroupData.id');
    }
    if (sourceSubclassFeature.id == null) {
      throw ArgumentError.notNull('sourceSubclassFeature.id');
    }

    var $classChoiceGroupData = classChoiceGroupData.copyWith(
        sourceSubclassFeatureId: sourceSubclassFeature.id);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classChoiceGroupData,
      columns: [ClassChoiceGroupData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassChoiceGroupData] and [RaceData]
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceRaceId` to refer to the [RaceData].
  Future<void> sourceRace(
    _i1.Session session,
    ClassChoiceGroupData classChoiceGroupData,
    _i6.RaceData sourceRace, {
    _i1.Transaction? transaction,
  }) async {
    if (classChoiceGroupData.id == null) {
      throw ArgumentError.notNull('classChoiceGroupData.id');
    }
    if (sourceRace.id == null) {
      throw ArgumentError.notNull('sourceRace.id');
    }

    var $classChoiceGroupData =
        classChoiceGroupData.copyWith(sourceRaceId: sourceRace.id);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classChoiceGroupData,
      columns: [ClassChoiceGroupData.t.sourceRaceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassChoiceGroupData] and [SubraceData]
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceSubraceId` to refer to the [SubraceData].
  Future<void> sourceSubrace(
    _i1.Session session,
    ClassChoiceGroupData classChoiceGroupData,
    _i7.SubraceData sourceSubrace, {
    _i1.Transaction? transaction,
  }) async {
    if (classChoiceGroupData.id == null) {
      throw ArgumentError.notNull('classChoiceGroupData.id');
    }
    if (sourceSubrace.id == null) {
      throw ArgumentError.notNull('sourceSubrace.id');
    }

    var $classChoiceGroupData =
        classChoiceGroupData.copyWith(sourceSubraceId: sourceSubrace.id);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classChoiceGroupData,
      columns: [ClassChoiceGroupData.t.sourceSubraceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassChoiceGroupData] and [BackgroundData]
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceBackgroundId` to refer to the [BackgroundData].
  Future<void> sourceBackground(
    _i1.Session session,
    ClassChoiceGroupData classChoiceGroupData,
    _i8.BackgroundData sourceBackground, {
    _i1.Transaction? transaction,
  }) async {
    if (classChoiceGroupData.id == null) {
      throw ArgumentError.notNull('classChoiceGroupData.id');
    }
    if (sourceBackground.id == null) {
      throw ArgumentError.notNull('sourceBackground.id');
    }

    var $classChoiceGroupData =
        classChoiceGroupData.copyWith(sourceBackgroundId: sourceBackground.id);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classChoiceGroupData,
      columns: [ClassChoiceGroupData.t.sourceBackgroundId],
      transaction: transaction,
    );
  }
}

class ClassChoiceGroupDataDetachRowRepository {
  const ClassChoiceGroupDataDetachRowRepository._();

  /// Detaches the relation between this [ClassChoiceGroupData] and the [ClassData] set in `sourceClass`
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceClassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceClass(
    _i1.Session session,
    ClassChoiceGroupData classchoicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (classchoicegroupdata.id == null) {
      throw ArgumentError.notNull('classchoicegroupdata.id');
    }

    var $classchoicegroupdata =
        classchoicegroupdata.copyWith(sourceClassId: null);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classchoicegroupdata,
      columns: [ClassChoiceGroupData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassChoiceGroupData] and the [SubclassData] set in `sourceSubclass`
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceSubclassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceSubclass(
    _i1.Session session,
    ClassChoiceGroupData classchoicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (classchoicegroupdata.id == null) {
      throw ArgumentError.notNull('classchoicegroupdata.id');
    }

    var $classchoicegroupdata =
        classchoicegroupdata.copyWith(sourceSubclassId: null);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classchoicegroupdata,
      columns: [ClassChoiceGroupData.t.sourceSubclassId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassChoiceGroupData] and the [ClassFeatureData] set in `sourceFeature`
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceFeature(
    _i1.Session session,
    ClassChoiceGroupData classchoicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (classchoicegroupdata.id == null) {
      throw ArgumentError.notNull('classchoicegroupdata.id');
    }

    var $classchoicegroupdata =
        classchoicegroupdata.copyWith(sourceFeatureId: null);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classchoicegroupdata,
      columns: [ClassChoiceGroupData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassChoiceGroupData] and the [SubclassFeatureData] set in `sourceSubclassFeature`
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceSubclassFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceSubclassFeature(
    _i1.Session session,
    ClassChoiceGroupData classchoicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (classchoicegroupdata.id == null) {
      throw ArgumentError.notNull('classchoicegroupdata.id');
    }

    var $classchoicegroupdata =
        classchoicegroupdata.copyWith(sourceSubclassFeatureId: null);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classchoicegroupdata,
      columns: [ClassChoiceGroupData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassChoiceGroupData] and the [RaceData] set in `sourceRace`
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceRaceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceRace(
    _i1.Session session,
    ClassChoiceGroupData classchoicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (classchoicegroupdata.id == null) {
      throw ArgumentError.notNull('classchoicegroupdata.id');
    }

    var $classchoicegroupdata =
        classchoicegroupdata.copyWith(sourceRaceId: null);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classchoicegroupdata,
      columns: [ClassChoiceGroupData.t.sourceRaceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassChoiceGroupData] and the [SubraceData] set in `sourceSubrace`
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceSubraceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceSubrace(
    _i1.Session session,
    ClassChoiceGroupData classchoicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (classchoicegroupdata.id == null) {
      throw ArgumentError.notNull('classchoicegroupdata.id');
    }

    var $classchoicegroupdata =
        classchoicegroupdata.copyWith(sourceSubraceId: null);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classchoicegroupdata,
      columns: [ClassChoiceGroupData.t.sourceSubraceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassChoiceGroupData] and the [BackgroundData] set in `sourceBackground`
  /// by setting the [ClassChoiceGroupData]'s foreign key `sourceBackgroundId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceBackground(
    _i1.Session session,
    ClassChoiceGroupData classchoicegroupdata, {
    _i1.Transaction? transaction,
  }) async {
    if (classchoicegroupdata.id == null) {
      throw ArgumentError.notNull('classchoicegroupdata.id');
    }

    var $classchoicegroupdata =
        classchoicegroupdata.copyWith(sourceBackgroundId: null);
    await session.db.updateRow<ClassChoiceGroupData>(
      $classchoicegroupdata,
      columns: [ClassChoiceGroupData.t.sourceBackgroundId],
      transaction: transaction,
    );
  }
}
