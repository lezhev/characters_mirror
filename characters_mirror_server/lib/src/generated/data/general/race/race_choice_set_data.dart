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
import '../../../data/general/race/race_feature_data.dart' as _i2;
import '../../../enums/race_choice_kind.dart' as _i3;
import '../../../data/general/race/race_choice_option_data.dart' as _i4;

abstract class RaceChoiceSetData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RaceChoiceSetData._({
    this.id,
    required this.featureId,
    this.feature,
    this.kind,
    this.pickCount,
    this.mustBeDistinct,
    this.description,
    this.choiceOptions,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory RaceChoiceSetData({
    int? id,
    required int featureId,
    _i2.RaceFeatureData? feature,
    _i3.RaceChoiceKind? kind,
    int? pickCount,
    bool? mustBeDistinct,
    String? description,
    List<_i4.RaceChoiceOptionData>? choiceOptions,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RaceChoiceSetDataImpl;

  factory RaceChoiceSetData.fromJson(Map<String, dynamic> jsonSerialization) {
    return RaceChoiceSetData(
      id: jsonSerialization['id'] as int?,
      featureId: jsonSerialization['featureId'] as int,
      feature: jsonSerialization['feature'] == null
          ? null
          : _i2.RaceFeatureData.fromJson(
              (jsonSerialization['feature'] as Map<String, dynamic>)),
      kind: jsonSerialization['kind'] == null
          ? null
          : _i3.RaceChoiceKind.fromJson((jsonSerialization['kind'] as String)),
      pickCount: jsonSerialization['pickCount'] as int?,
      mustBeDistinct: jsonSerialization['mustBeDistinct'] as bool?,
      description: jsonSerialization['description'] as String?,
      choiceOptions: (jsonSerialization['choiceOptions'] as List?)
          ?.map((e) =>
              _i4.RaceChoiceOptionData.fromJson((e as Map<String, dynamic>)))
          .toList(),
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

  static final t = RaceChoiceSetDataTable();

  static const db = RaceChoiceSetDataRepository._();

  @override
  int? id;

  int featureId;

  _i2.RaceFeatureData? feature;

  _i3.RaceChoiceKind? kind;

  int? pickCount;

  bool? mustBeDistinct;

  String? description;

  List<_i4.RaceChoiceOptionData>? choiceOptions;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RaceChoiceSetData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceChoiceSetData copyWith({
    int? id,
    int? featureId,
    _i2.RaceFeatureData? feature,
    _i3.RaceChoiceKind? kind,
    int? pickCount,
    bool? mustBeDistinct,
    String? description,
    List<_i4.RaceChoiceOptionData>? choiceOptions,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'featureId': featureId,
      if (feature != null) 'feature': feature?.toJson(),
      if (kind != null) 'kind': kind?.toJson(),
      if (pickCount != null) 'pickCount': pickCount,
      if (mustBeDistinct != null) 'mustBeDistinct': mustBeDistinct,
      if (description != null) 'description': description,
      if (choiceOptions != null)
        'choiceOptions': choiceOptions?.toJson(valueToJson: (v) => v.toJson()),
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
      'featureId': featureId,
      if (feature != null) 'feature': feature?.toJsonForProtocol(),
      if (kind != null) 'kind': kind?.toJson(),
      if (pickCount != null) 'pickCount': pickCount,
      if (mustBeDistinct != null) 'mustBeDistinct': mustBeDistinct,
      if (description != null) 'description': description,
      if (choiceOptions != null)
        'choiceOptions':
            choiceOptions?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static RaceChoiceSetDataInclude include({
    _i2.RaceFeatureDataInclude? feature,
    _i4.RaceChoiceOptionDataIncludeList? choiceOptions,
  }) {
    return RaceChoiceSetDataInclude._(
      feature: feature,
      choiceOptions: choiceOptions,
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
    required int featureId,
    _i2.RaceFeatureData? feature,
    _i3.RaceChoiceKind? kind,
    int? pickCount,
    bool? mustBeDistinct,
    String? description,
    List<_i4.RaceChoiceOptionData>? choiceOptions,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          featureId: featureId,
          feature: feature,
          kind: kind,
          pickCount: pickCount,
          mustBeDistinct: mustBeDistinct,
          description: description,
          choiceOptions: choiceOptions,
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
    int? featureId,
    Object? feature = _Undefined,
    Object? kind = _Undefined,
    Object? pickCount = _Undefined,
    Object? mustBeDistinct = _Undefined,
    Object? description = _Undefined,
    Object? choiceOptions = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return RaceChoiceSetData(
      id: id is int? ? id : this.id,
      featureId: featureId ?? this.featureId,
      feature:
          feature is _i2.RaceFeatureData? ? feature : this.feature?.copyWith(),
      kind: kind is _i3.RaceChoiceKind? ? kind : this.kind,
      pickCount: pickCount is int? ? pickCount : this.pickCount,
      mustBeDistinct:
          mustBeDistinct is bool? ? mustBeDistinct : this.mustBeDistinct,
      description: description is String? ? description : this.description,
      choiceOptions: choiceOptions is List<_i4.RaceChoiceOptionData>?
          ? choiceOptions
          : this.choiceOptions?.map((e0) => e0.copyWith()).toList(),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class RaceChoiceSetDataTable extends _i1.Table<int?> {
  RaceChoiceSetDataTable({super.tableRelation})
      : super(tableName: 'race_choice_set_data') {
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
  }

  late final _i1.ColumnInt featureId;

  _i2.RaceFeatureDataTable? _feature;

  late final _i1.ColumnEnum<_i3.RaceChoiceKind> kind;

  late final _i1.ColumnInt pickCount;

  late final _i1.ColumnBool mustBeDistinct;

  late final _i1.ColumnString description;

  _i4.RaceChoiceOptionDataTable? ___choiceOptions;

  _i1.ManyRelation<_i4.RaceChoiceOptionDataTable>? _choiceOptions;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.RaceFeatureDataTable get feature {
    if (_feature != null) return _feature!;
    _feature = _i1.createRelationTable(
      relationFieldName: 'feature',
      field: RaceChoiceSetData.t.featureId,
      foreignField: _i2.RaceFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _feature!;
  }

  _i4.RaceChoiceOptionDataTable get __choiceOptions {
    if (___choiceOptions != null) return ___choiceOptions!;
    ___choiceOptions = _i1.createRelationTable(
      relationFieldName: '__choiceOptions',
      field: RaceChoiceSetData.t.id,
      foreignField: _i4.RaceChoiceOptionData.t.choiceSetId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RaceChoiceOptionDataTable(tableRelation: foreignTableRelation),
    );
    return ___choiceOptions!;
  }

  _i1.ManyRelation<_i4.RaceChoiceOptionDataTable> get choiceOptions {
    if (_choiceOptions != null) return _choiceOptions!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'choiceOptions',
      field: RaceChoiceSetData.t.id,
      foreignField: _i4.RaceChoiceOptionData.t.choiceSetId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RaceChoiceOptionDataTable(tableRelation: foreignTableRelation),
    );
    _choiceOptions = _i1.ManyRelation<_i4.RaceChoiceOptionDataTable>(
      tableWithRelations: relationTable,
      table: _i4.RaceChoiceOptionDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _choiceOptions!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        featureId,
        kind,
        pickCount,
        mustBeDistinct,
        description,
        source,
        version,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'feature') {
      return feature;
    }
    if (relationField == 'choiceOptions') {
      return __choiceOptions;
    }
    return null;
  }
}

class RaceChoiceSetDataInclude extends _i1.IncludeObject {
  RaceChoiceSetDataInclude._({
    _i2.RaceFeatureDataInclude? feature,
    _i4.RaceChoiceOptionDataIncludeList? choiceOptions,
  }) {
    _feature = feature;
    _choiceOptions = choiceOptions;
  }

  _i2.RaceFeatureDataInclude? _feature;

  _i4.RaceChoiceOptionDataIncludeList? _choiceOptions;

  @override
  Map<String, _i1.Include?> get includes => {
        'feature': _feature,
        'choiceOptions': _choiceOptions,
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

  final attach = const RaceChoiceSetDataAttachRepository._();

  final attachRow = const RaceChoiceSetDataAttachRowRepository._();

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

class RaceChoiceSetDataAttachRepository {
  const RaceChoiceSetDataAttachRepository._();

  /// Creates a relation between this [RaceChoiceSetData] and the given [RaceChoiceOptionData]s
  /// by setting each [RaceChoiceOptionData]'s foreign key `choiceSetId` to refer to this [RaceChoiceSetData].
  Future<void> choiceOptions(
    _i1.Session session,
    RaceChoiceSetData raceChoiceSetData,
    List<_i4.RaceChoiceOptionData> raceChoiceOptionData, {
    _i1.Transaction? transaction,
  }) async {
    if (raceChoiceOptionData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('raceChoiceOptionData.id');
    }
    if (raceChoiceSetData.id == null) {
      throw ArgumentError.notNull('raceChoiceSetData.id');
    }

    var $raceChoiceOptionData = raceChoiceOptionData
        .map((e) => e.copyWith(choiceSetId: raceChoiceSetData.id))
        .toList();
    await session.db.update<_i4.RaceChoiceOptionData>(
      $raceChoiceOptionData,
      columns: [_i4.RaceChoiceOptionData.t.choiceSetId],
      transaction: transaction,
    );
  }
}

class RaceChoiceSetDataAttachRowRepository {
  const RaceChoiceSetDataAttachRowRepository._();

  /// Creates a relation between the given [RaceChoiceSetData] and [RaceFeatureData]
  /// by setting the [RaceChoiceSetData]'s foreign key `featureId` to refer to the [RaceFeatureData].
  Future<void> feature(
    _i1.Session session,
    RaceChoiceSetData raceChoiceSetData,
    _i2.RaceFeatureData feature, {
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

  /// Creates a relation between this [RaceChoiceSetData] and the given [RaceChoiceOptionData]
  /// by setting the [RaceChoiceOptionData]'s foreign key `choiceSetId` to refer to this [RaceChoiceSetData].
  Future<void> choiceOptions(
    _i1.Session session,
    RaceChoiceSetData raceChoiceSetData,
    _i4.RaceChoiceOptionData raceChoiceOptionData, {
    _i1.Transaction? transaction,
  }) async {
    if (raceChoiceOptionData.id == null) {
      throw ArgumentError.notNull('raceChoiceOptionData.id');
    }
    if (raceChoiceSetData.id == null) {
      throw ArgumentError.notNull('raceChoiceSetData.id');
    }

    var $raceChoiceOptionData =
        raceChoiceOptionData.copyWith(choiceSetId: raceChoiceSetData.id);
    await session.db.updateRow<_i4.RaceChoiceOptionData>(
      $raceChoiceOptionData,
      columns: [_i4.RaceChoiceOptionData.t.choiceSetId],
      transaction: transaction,
    );
  }
}
