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
import '../../../data/general/race/race_data.dart' as _i2;
import '../../../data/general/race/subrace_data.dart' as _i3;
import '../../../data/general/race/race_feature_data.dart' as _i4;
import '../../../enums/race_choice_kind.dart' as _i5;

abstract class RaceChoiceSetData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RaceChoiceSetData._({
    this.id,
    this.raceId,
    this.race,
    this.subraceId,
    this.subrace,
    this.featureId,
    this.feature,
    this.kind,
    this.pickCount,
    this.options,
    this.optionValue,
    this.mustBeDistinct,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  })  : _raceDataChoicesetsRaceDataId = null,
        _raceFeatureDataChoicesetsRaceFeatureDataId = null,
        _subraceDataChoicesetsSubraceDataId = null;

  factory RaceChoiceSetData({
    int? id,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    int? featureId,
    _i4.RaceFeatureData? feature,
    _i5.RaceChoiceKind? kind,
    int? pickCount,
    List<String>? options,
    int? optionValue,
    bool? mustBeDistinct,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RaceChoiceSetDataImpl;

  factory RaceChoiceSetData.fromJson(Map<String, dynamic> jsonSerialization) {
    return RaceChoiceSetDataImplicit._(
      id: jsonSerialization['id'] as int?,
      raceId: jsonSerialization['raceId'] as int?,
      race: jsonSerialization['race'] == null
          ? null
          : _i2.RaceData.fromJson(
              (jsonSerialization['race'] as Map<String, dynamic>)),
      subraceId: jsonSerialization['subraceId'] as int?,
      subrace: jsonSerialization['subrace'] == null
          ? null
          : _i3.SubraceData.fromJson(
              (jsonSerialization['subrace'] as Map<String, dynamic>)),
      featureId: jsonSerialization['featureId'] as int?,
      feature: jsonSerialization['feature'] == null
          ? null
          : _i4.RaceFeatureData.fromJson(
              (jsonSerialization['feature'] as Map<String, dynamic>)),
      kind: jsonSerialization['kind'] == null
          ? null
          : _i5.RaceChoiceKind.fromJson((jsonSerialization['kind'] as String)),
      pickCount: jsonSerialization['pickCount'] as int?,
      options: (jsonSerialization['options'] as List?)
          ?.map((e) => e as String)
          .toList(),
      optionValue: jsonSerialization['optionValue'] as int?,
      mustBeDistinct: jsonSerialization['mustBeDistinct'] as bool?,
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      $_raceDataChoicesetsRaceDataId:
          jsonSerialization['_raceDataChoicesetsRaceDataId'] as int?,
      $_raceFeatureDataChoicesetsRaceFeatureDataId:
          jsonSerialization['_raceFeatureDataChoicesetsRaceFeatureDataId']
              as int?,
      $_subraceDataChoicesetsSubraceDataId:
          jsonSerialization['_subraceDataChoicesetsSubraceDataId'] as int?,
    );
  }

  static final t = RaceChoiceSetDataTable();

  static const db = RaceChoiceSetDataRepository._();

  @override
  int? id;

  int? raceId;

  _i2.RaceData? race;

  int? subraceId;

  _i3.SubraceData? subrace;

  int? featureId;

  _i4.RaceFeatureData? feature;

  _i5.RaceChoiceKind? kind;

  int? pickCount;

  List<String>? options;

  int? optionValue;

  bool? mustBeDistinct;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  final int? _raceDataChoicesetsRaceDataId;

  final int? _raceFeatureDataChoicesetsRaceFeatureDataId;

  final int? _subraceDataChoicesetsSubraceDataId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RaceChoiceSetData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceChoiceSetData copyWith({
    int? id,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    int? featureId,
    _i4.RaceFeatureData? feature,
    _i5.RaceChoiceKind? kind,
    int? pickCount,
    List<String>? options,
    int? optionValue,
    bool? mustBeDistinct,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (raceId != null) 'raceId': raceId,
      if (race != null) 'race': race?.toJson(),
      if (subraceId != null) 'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJson(),
      if (featureId != null) 'featureId': featureId,
      if (feature != null) 'feature': feature?.toJson(),
      if (kind != null) 'kind': kind?.toJson(),
      if (pickCount != null) 'pickCount': pickCount,
      if (options != null) 'options': options?.toJson(),
      if (optionValue != null) 'optionValue': optionValue,
      if (mustBeDistinct != null) 'mustBeDistinct': mustBeDistinct,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (_raceDataChoicesetsRaceDataId != null)
        '_raceDataChoicesetsRaceDataId': _raceDataChoicesetsRaceDataId,
      if (_raceFeatureDataChoicesetsRaceFeatureDataId != null)
        '_raceFeatureDataChoicesetsRaceFeatureDataId':
            _raceFeatureDataChoicesetsRaceFeatureDataId,
      if (_subraceDataChoicesetsSubraceDataId != null)
        '_subraceDataChoicesetsSubraceDataId':
            _subraceDataChoicesetsSubraceDataId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (raceId != null) 'raceId': raceId,
      if (race != null) 'race': race?.toJsonForProtocol(),
      if (subraceId != null) 'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJsonForProtocol(),
      if (featureId != null) 'featureId': featureId,
      if (feature != null) 'feature': feature?.toJsonForProtocol(),
      if (kind != null) 'kind': kind?.toJson(),
      if (pickCount != null) 'pickCount': pickCount,
      if (options != null) 'options': options?.toJson(),
      if (optionValue != null) 'optionValue': optionValue,
      if (mustBeDistinct != null) 'mustBeDistinct': mustBeDistinct,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static RaceChoiceSetDataInclude include({
    _i2.RaceDataInclude? race,
    _i3.SubraceDataInclude? subrace,
    _i4.RaceFeatureDataInclude? feature,
  }) {
    return RaceChoiceSetDataInclude._(
      race: race,
      subrace: subrace,
      feature: feature,
    );
  }

  static RaceChoiceSetDataIncludeList includeList({
    _i1.WhereExpressionBuilder<RaceChoiceSetDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RaceChoiceSetDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceChoiceSetDataTable>? orderByList,
    RaceChoiceSetDataInclude? include,
  }) {
    return RaceChoiceSetDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RaceChoiceSetData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RaceChoiceSetData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceChoiceSetDataImpl extends RaceChoiceSetData {
  _RaceChoiceSetDataImpl({
    int? id,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    int? featureId,
    _i4.RaceFeatureData? feature,
    _i5.RaceChoiceKind? kind,
    int? pickCount,
    List<String>? options,
    int? optionValue,
    bool? mustBeDistinct,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          raceId: raceId,
          race: race,
          subraceId: subraceId,
          subrace: subrace,
          featureId: featureId,
          feature: feature,
          kind: kind,
          pickCount: pickCount,
          options: options,
          optionValue: optionValue,
          mustBeDistinct: mustBeDistinct,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [RaceChoiceSetData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RaceChoiceSetData copyWith({
    Object? id = _Undefined,
    Object? raceId = _Undefined,
    Object? race = _Undefined,
    Object? subraceId = _Undefined,
    Object? subrace = _Undefined,
    Object? featureId = _Undefined,
    Object? feature = _Undefined,
    Object? kind = _Undefined,
    Object? pickCount = _Undefined,
    Object? options = _Undefined,
    Object? optionValue = _Undefined,
    Object? mustBeDistinct = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return RaceChoiceSetDataImplicit._(
      id: id is int? ? id : this.id,
      raceId: raceId is int? ? raceId : this.raceId,
      race: race is _i2.RaceData? ? race : this.race?.copyWith(),
      subraceId: subraceId is int? ? subraceId : this.subraceId,
      subrace: subrace is _i3.SubraceData? ? subrace : this.subrace?.copyWith(),
      featureId: featureId is int? ? featureId : this.featureId,
      feature:
          feature is _i4.RaceFeatureData? ? feature : this.feature?.copyWith(),
      kind: kind is _i5.RaceChoiceKind? ? kind : this.kind,
      pickCount: pickCount is int? ? pickCount : this.pickCount,
      options: options is List<String>?
          ? options
          : this.options?.map((e0) => e0).toList(),
      optionValue: optionValue is int? ? optionValue : this.optionValue,
      mustBeDistinct:
          mustBeDistinct is bool? ? mustBeDistinct : this.mustBeDistinct,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      $_raceDataChoicesetsRaceDataId: this._raceDataChoicesetsRaceDataId,
      $_raceFeatureDataChoicesetsRaceFeatureDataId:
          this._raceFeatureDataChoicesetsRaceFeatureDataId,
      $_subraceDataChoicesetsSubraceDataId:
          this._subraceDataChoicesetsSubraceDataId,
    );
  }
}

class RaceChoiceSetDataImplicit extends _RaceChoiceSetDataImpl {
  RaceChoiceSetDataImplicit._({
    int? id,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    int? featureId,
    _i4.RaceFeatureData? feature,
    _i5.RaceChoiceKind? kind,
    int? pickCount,
    List<String>? options,
    int? optionValue,
    bool? mustBeDistinct,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? $_raceDataChoicesetsRaceDataId,
    int? $_raceFeatureDataChoicesetsRaceFeatureDataId,
    int? $_subraceDataChoicesetsSubraceDataId,
  })  : _raceDataChoicesetsRaceDataId = $_raceDataChoicesetsRaceDataId,
        _raceFeatureDataChoicesetsRaceFeatureDataId =
            $_raceFeatureDataChoicesetsRaceFeatureDataId,
        _subraceDataChoicesetsSubraceDataId =
            $_subraceDataChoicesetsSubraceDataId,
        super(
          id: id,
          raceId: raceId,
          race: race,
          subraceId: subraceId,
          subrace: subrace,
          featureId: featureId,
          feature: feature,
          kind: kind,
          pickCount: pickCount,
          options: options,
          optionValue: optionValue,
          mustBeDistinct: mustBeDistinct,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory RaceChoiceSetDataImplicit(
    RaceChoiceSetData raceChoiceSetData, {
    int? $_raceDataChoicesetsRaceDataId,
    int? $_raceFeatureDataChoicesetsRaceFeatureDataId,
    int? $_subraceDataChoicesetsSubraceDataId,
  }) {
    return RaceChoiceSetDataImplicit._(
      id: raceChoiceSetData.id,
      raceId: raceChoiceSetData.raceId,
      race: raceChoiceSetData.race,
      subraceId: raceChoiceSetData.subraceId,
      subrace: raceChoiceSetData.subrace,
      featureId: raceChoiceSetData.featureId,
      feature: raceChoiceSetData.feature,
      kind: raceChoiceSetData.kind,
      pickCount: raceChoiceSetData.pickCount,
      options: raceChoiceSetData.options,
      optionValue: raceChoiceSetData.optionValue,
      mustBeDistinct: raceChoiceSetData.mustBeDistinct,
      description: raceChoiceSetData.description,
      source: raceChoiceSetData.source,
      version: raceChoiceSetData.version,
      createdAt: raceChoiceSetData.createdAt,
      updatedAt: raceChoiceSetData.updatedAt,
      $_raceDataChoicesetsRaceDataId: $_raceDataChoicesetsRaceDataId,
      $_raceFeatureDataChoicesetsRaceFeatureDataId:
          $_raceFeatureDataChoicesetsRaceFeatureDataId,
      $_subraceDataChoicesetsSubraceDataId:
          $_subraceDataChoicesetsSubraceDataId,
    );
  }

  @override
  final int? _raceDataChoicesetsRaceDataId;

  @override
  final int? _raceFeatureDataChoicesetsRaceFeatureDataId;

  @override
  final int? _subraceDataChoicesetsSubraceDataId;
}

class RaceChoiceSetDataTable extends _i1.Table<int?> {
  RaceChoiceSetDataTable({super.tableRelation})
      : super(tableName: 'race_choice_set_data') {
    raceId = _i1.ColumnInt(
      'raceId',
      this,
    );
    subraceId = _i1.ColumnInt(
      'subraceId',
      this,
    );
    featureId = _i1.ColumnInt(
      'featureId',
      this,
    );
    kind = _i1.ColumnEnum(
      'kind',
      this,
      _i1.EnumSerialization.byName,
    );
    pickCount = _i1.ColumnInt(
      'pickCount',
      this,
    );
    options = _i1.ColumnSerializable(
      'options',
      this,
    );
    optionValue = _i1.ColumnInt(
      'optionValue',
      this,
    );
    mustBeDistinct = _i1.ColumnBool(
      'mustBeDistinct',
      this,
    );
    description = _i1.ColumnString(
      'description',
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
    $_raceDataChoicesetsRaceDataId = _i1.ColumnInt(
      '_raceDataChoicesetsRaceDataId',
      this,
    );
    $_raceFeatureDataChoicesetsRaceFeatureDataId = _i1.ColumnInt(
      '_raceFeatureDataChoicesetsRaceFeatureDataId',
      this,
    );
    $_subraceDataChoicesetsSubraceDataId = _i1.ColumnInt(
      '_subraceDataChoicesetsSubraceDataId',
      this,
    );
  }

  late final _i1.ColumnInt raceId;

  _i2.RaceDataTable? _race;

  late final _i1.ColumnInt subraceId;

  _i3.SubraceDataTable? _subrace;

  late final _i1.ColumnInt featureId;

  _i4.RaceFeatureDataTable? _feature;

  late final _i1.ColumnEnum<_i5.RaceChoiceKind> kind;

  late final _i1.ColumnInt pickCount;

  late final _i1.ColumnSerializable options;

  late final _i1.ColumnInt optionValue;

  late final _i1.ColumnBool mustBeDistinct;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt $_raceDataChoicesetsRaceDataId;

  late final _i1.ColumnInt $_raceFeatureDataChoicesetsRaceFeatureDataId;

  late final _i1.ColumnInt $_subraceDataChoicesetsSubraceDataId;

  _i2.RaceDataTable get race {
    if (_race != null) return _race!;
    _race = _i1.createRelationTable(
      relationFieldName: 'race',
      field: RaceChoiceSetData.t.raceId,
      foreignField: _i2.RaceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RaceDataTable(tableRelation: foreignTableRelation),
    );
    return _race!;
  }

  _i3.SubraceDataTable get subrace {
    if (_subrace != null) return _subrace!;
    _subrace = _i1.createRelationTable(
      relationFieldName: 'subrace',
      field: RaceChoiceSetData.t.subraceId,
      foreignField: _i3.SubraceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SubraceDataTable(tableRelation: foreignTableRelation),
    );
    return _subrace!;
  }

  _i4.RaceFeatureDataTable get feature {
    if (_feature != null) return _feature!;
    _feature = _i1.createRelationTable(
      relationFieldName: 'feature',
      field: RaceChoiceSetData.t.featureId,
      foreignField: _i4.RaceFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _feature!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        raceId,
        subraceId,
        featureId,
        kind,
        pickCount,
        options,
        optionValue,
        mustBeDistinct,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        $_raceDataChoicesetsRaceDataId,
        $_raceFeatureDataChoicesetsRaceFeatureDataId,
        $_subraceDataChoicesetsSubraceDataId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        raceId,
        subraceId,
        featureId,
        kind,
        pickCount,
        options,
        optionValue,
        mustBeDistinct,
        description,
        source,
        version,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'race') {
      return race;
    }
    if (relationField == 'subrace') {
      return subrace;
    }
    if (relationField == 'feature') {
      return feature;
    }
    return null;
  }
}

class RaceChoiceSetDataInclude extends _i1.IncludeObject {
  RaceChoiceSetDataInclude._({
    _i2.RaceDataInclude? race,
    _i3.SubraceDataInclude? subrace,
    _i4.RaceFeatureDataInclude? feature,
  }) {
    _race = race;
    _subrace = subrace;
    _feature = feature;
  }

  _i2.RaceDataInclude? _race;

  _i3.SubraceDataInclude? _subrace;

  _i4.RaceFeatureDataInclude? _feature;

  @override
  Map<String, _i1.Include?> get includes => {
        'race': _race,
        'subrace': _subrace,
        'feature': _feature,
      };

  @override
  _i1.Table<int?> get table => RaceChoiceSetData.t;
}

class RaceChoiceSetDataIncludeList extends _i1.IncludeList {
  RaceChoiceSetDataIncludeList._({
    _i1.WhereExpressionBuilder<RaceChoiceSetDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RaceChoiceSetData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RaceChoiceSetData.t;
}

class RaceChoiceSetDataRepository {
  const RaceChoiceSetDataRepository._();

  final attachRow = const RaceChoiceSetDataAttachRowRepository._();

  final detachRow = const RaceChoiceSetDataDetachRowRepository._();

  /// Returns a list of [RaceChoiceSetData]s matching the given query parameters.
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
  Future<List<RaceChoiceSetData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceChoiceSetDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RaceChoiceSetDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceChoiceSetDataTable>? orderByList,
    _i1.Transaction? transaction,
    RaceChoiceSetDataInclude? include,
  }) async {
    return session.db.find<RaceChoiceSetData>(
      where: where?.call(RaceChoiceSetData.t),
      orderBy: orderBy?.call(RaceChoiceSetData.t),
      orderByList: orderByList?.call(RaceChoiceSetData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [RaceChoiceSetData] matching the given query parameters.
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
  Future<RaceChoiceSetData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceChoiceSetDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<RaceChoiceSetDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceChoiceSetDataTable>? orderByList,
    _i1.Transaction? transaction,
    RaceChoiceSetDataInclude? include,
  }) async {
    return session.db.findFirstRow<RaceChoiceSetData>(
      where: where?.call(RaceChoiceSetData.t),
      orderBy: orderBy?.call(RaceChoiceSetData.t),
      orderByList: orderByList?.call(RaceChoiceSetData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [RaceChoiceSetData] by its [id] or null if no such row exists.
  Future<RaceChoiceSetData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    RaceChoiceSetDataInclude? include,
  }) async {
    return session.db.findById<RaceChoiceSetData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [RaceChoiceSetData]s in the list and returns the inserted rows.
  ///
  /// The returned [RaceChoiceSetData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<RaceChoiceSetData>> insert(
    _i1.Session session,
    List<RaceChoiceSetData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<RaceChoiceSetData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [RaceChoiceSetData] and returns the inserted row.
  ///
  /// The returned [RaceChoiceSetData] will have its `id` field set.
  Future<RaceChoiceSetData> insertRow(
    _i1.Session session,
    RaceChoiceSetData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RaceChoiceSetData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RaceChoiceSetData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RaceChoiceSetData>> update(
    _i1.Session session,
    List<RaceChoiceSetData> rows, {
    _i1.ColumnSelections<RaceChoiceSetDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RaceChoiceSetData>(
      rows,
      columns: columns?.call(RaceChoiceSetData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RaceChoiceSetData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RaceChoiceSetData> updateRow(
    _i1.Session session,
    RaceChoiceSetData row, {
    _i1.ColumnSelections<RaceChoiceSetDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RaceChoiceSetData>(
      row,
      columns: columns?.call(RaceChoiceSetData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [RaceChoiceSetData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RaceChoiceSetData>> delete(
    _i1.Session session,
    List<RaceChoiceSetData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RaceChoiceSetData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RaceChoiceSetData].
  Future<RaceChoiceSetData> deleteRow(
    _i1.Session session,
    RaceChoiceSetData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RaceChoiceSetData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RaceChoiceSetData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RaceChoiceSetDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RaceChoiceSetData>(
      where: where(RaceChoiceSetData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceChoiceSetDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RaceChoiceSetData>(
      where: where?.call(RaceChoiceSetData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RaceChoiceSetDataAttachRowRepository {
  const RaceChoiceSetDataAttachRowRepository._();

  /// Creates a relation between the given [RaceChoiceSetData] and [RaceData]
  /// by setting the [RaceChoiceSetData]'s foreign key `raceId` to refer to the [RaceData].
  Future<void> race(
    _i1.Session session,
    RaceChoiceSetData raceChoiceSetData,
    _i2.RaceData race, {
    _i1.Transaction? transaction,
  }) async {
    if (raceChoiceSetData.id == null) {
      throw ArgumentError.notNull('raceChoiceSetData.id');
    }
    if (race.id == null) {
      throw ArgumentError.notNull('race.id');
    }

    var $raceChoiceSetData = raceChoiceSetData.copyWith(raceId: race.id);
    await session.db.updateRow<RaceChoiceSetData>(
      $raceChoiceSetData,
      columns: [RaceChoiceSetData.t.raceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [RaceChoiceSetData] and [SubraceData]
  /// by setting the [RaceChoiceSetData]'s foreign key `subraceId` to refer to the [SubraceData].
  Future<void> subrace(
    _i1.Session session,
    RaceChoiceSetData raceChoiceSetData,
    _i3.SubraceData subrace, {
    _i1.Transaction? transaction,
  }) async {
    if (raceChoiceSetData.id == null) {
      throw ArgumentError.notNull('raceChoiceSetData.id');
    }
    if (subrace.id == null) {
      throw ArgumentError.notNull('subrace.id');
    }

    var $raceChoiceSetData = raceChoiceSetData.copyWith(subraceId: subrace.id);
    await session.db.updateRow<RaceChoiceSetData>(
      $raceChoiceSetData,
      columns: [RaceChoiceSetData.t.subraceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [RaceChoiceSetData] and [RaceFeatureData]
  /// by setting the [RaceChoiceSetData]'s foreign key `featureId` to refer to the [RaceFeatureData].
  Future<void> feature(
    _i1.Session session,
    RaceChoiceSetData raceChoiceSetData,
    _i4.RaceFeatureData feature, {
    _i1.Transaction? transaction,
  }) async {
    if (raceChoiceSetData.id == null) {
      throw ArgumentError.notNull('raceChoiceSetData.id');
    }
    if (feature.id == null) {
      throw ArgumentError.notNull('feature.id');
    }

    var $raceChoiceSetData = raceChoiceSetData.copyWith(featureId: feature.id);
    await session.db.updateRow<RaceChoiceSetData>(
      $raceChoiceSetData,
      columns: [RaceChoiceSetData.t.featureId],
      transaction: transaction,
    );
  }
}

class RaceChoiceSetDataDetachRowRepository {
  const RaceChoiceSetDataDetachRowRepository._();

  /// Detaches the relation between this [RaceChoiceSetData] and the [RaceData] set in `race`
  /// by setting the [RaceChoiceSetData]'s foreign key `raceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> race(
    _i1.Session session,
    RaceChoiceSetData racechoicesetdata, {
    _i1.Transaction? transaction,
  }) async {
    if (racechoicesetdata.id == null) {
      throw ArgumentError.notNull('racechoicesetdata.id');
    }

    var $racechoicesetdata = racechoicesetdata.copyWith(raceId: null);
    await session.db.updateRow<RaceChoiceSetData>(
      $racechoicesetdata,
      columns: [RaceChoiceSetData.t.raceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [RaceChoiceSetData] and the [SubraceData] set in `subrace`
  /// by setting the [RaceChoiceSetData]'s foreign key `subraceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subrace(
    _i1.Session session,
    RaceChoiceSetData racechoicesetdata, {
    _i1.Transaction? transaction,
  }) async {
    if (racechoicesetdata.id == null) {
      throw ArgumentError.notNull('racechoicesetdata.id');
    }

    var $racechoicesetdata = racechoicesetdata.copyWith(subraceId: null);
    await session.db.updateRow<RaceChoiceSetData>(
      $racechoicesetdata,
      columns: [RaceChoiceSetData.t.subraceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [RaceChoiceSetData] and the [RaceFeatureData] set in `feature`
  /// by setting the [RaceChoiceSetData]'s foreign key `featureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> feature(
    _i1.Session session,
    RaceChoiceSetData racechoicesetdata, {
    _i1.Transaction? transaction,
  }) async {
    if (racechoicesetdata.id == null) {
      throw ArgumentError.notNull('racechoicesetdata.id');
    }

    var $racechoicesetdata = racechoicesetdata.copyWith(featureId: null);
    await session.db.updateRow<RaceChoiceSetData>(
      $racechoicesetdata,
      columns: [RaceChoiceSetData.t.featureId],
      transaction: transaction,
    );
  }
}
