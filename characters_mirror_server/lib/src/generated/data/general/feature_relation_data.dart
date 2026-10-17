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
import '../../enums/character_feature_source_type.dart' as _ilvqooqk;
import '../../enums/feature_relation_type.dart' as _i1fmwm2o;

abstract class FeatureRelationData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FeatureRelationData._({
    this.id,
    required this.sourceType,
    required this.sourceReferenceKey,
    required this.targetType,
    required this.targetReferenceKey,
    required this.relationType,
    this.propertyMappings,
    required this.priority,
    this.mergeDisplay,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory FeatureRelationData({
    int? id,
    required _ilvqooqk.CharacterFeatureSourceType sourceType,
    required String sourceReferenceKey,
    required _ilvqooqk.CharacterFeatureSourceType targetType,
    required String targetReferenceKey,
    required _i1fmwm2o.FeatureRelationType relationType,
    Map<String, String>? propertyMappings,
    required int priority,
    bool? mergeDisplay,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FeatureRelationDataImpl;

  factory FeatureRelationData.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatureRelationData(
      id: jsonSerialization['id'] as int?,
      sourceType: _ilvqooqk.CharacterFeatureSourceType.fromJson(
        (jsonSerialization['sourceType'] as String),
      ),
      sourceReferenceKey: jsonSerialization['sourceReferenceKey'] as String,
      targetType: _ilvqooqk.CharacterFeatureSourceType.fromJson(
        (jsonSerialization['targetType'] as String),
      ),
      targetReferenceKey: jsonSerialization['targetReferenceKey'] as String,
      relationType: _i1fmwm2o.FeatureRelationType.fromJson(
        (jsonSerialization['relationType'] as String),
      ),
      propertyMappings: jsonSerialization['propertyMappings'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['propertyMappings'],
            ),
      priority: jsonSerialization['priority'] as int,
      mergeDisplay: jsonSerialization['mergeDisplay'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['mergeDisplay']),
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

  static final t = FeatureRelationDataTable();

  static const db = FeatureRelationDataRepository._();

  @override
  int? id;

  _ilvqooqk.CharacterFeatureSourceType sourceType;

  String sourceReferenceKey;

  _ilvqooqk.CharacterFeatureSourceType targetType;

  String targetReferenceKey;

  _i1fmwm2o.FeatureRelationType relationType;

  Map<String, String>? propertyMappings;

  int priority;

  bool? mergeDisplay;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureRelationData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeatureRelationData copyWith({
    int? id,
    _ilvqooqk.CharacterFeatureSourceType? sourceType,
    String? sourceReferenceKey,
    _ilvqooqk.CharacterFeatureSourceType? targetType,
    String? targetReferenceKey,
    _i1fmwm2o.FeatureRelationType? relationType,
    Map<String, String>? propertyMappings,
    int? priority,
    bool? mergeDisplay,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureRelationData',
      if (id != null) 'id': id,
      'sourceType': sourceType.toJson(),
      'sourceReferenceKey': sourceReferenceKey,
      'targetType': targetType.toJson(),
      'targetReferenceKey': targetReferenceKey,
      'relationType': relationType.toJson(),
      if (propertyMappings != null)
        'propertyMappings': propertyMappings?.toJson(),
      'priority': priority,
      if (mergeDisplay != null) 'mergeDisplay': mergeDisplay,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatureRelationData',
      if (id != null) 'id': id,
      'sourceType': sourceType.toJson(),
      'sourceReferenceKey': sourceReferenceKey,
      'targetType': targetType.toJson(),
      'targetReferenceKey': targetReferenceKey,
      'relationType': relationType.toJson(),
      if (propertyMappings != null)
        'propertyMappings': propertyMappings?.toJson(),
      'priority': priority,
      if (mergeDisplay != null) 'mergeDisplay': mergeDisplay,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static FeatureRelationDataInclude include() {
    return FeatureRelationDataInclude._();
  }

  static FeatureRelationDataIncludeList includeList({
    _is.WhereExpressionBuilder<FeatureRelationDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureRelationDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureRelationDataTable>? orderByList,
    FeatureRelationDataInclude? include,
  }) {
    return FeatureRelationDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureRelationData.t),
      orderByList: orderByList?.call(FeatureRelationData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureRelationDataImpl extends FeatureRelationData {
  _FeatureRelationDataImpl({
    int? id,
    required _ilvqooqk.CharacterFeatureSourceType sourceType,
    required String sourceReferenceKey,
    required _ilvqooqk.CharacterFeatureSourceType targetType,
    required String targetReferenceKey,
    required _i1fmwm2o.FeatureRelationType relationType,
    Map<String, String>? propertyMappings,
    required int priority,
    bool? mergeDisplay,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         sourceType: sourceType,
         sourceReferenceKey: sourceReferenceKey,
         targetType: targetType,
         targetReferenceKey: targetReferenceKey,
         relationType: relationType,
         propertyMappings: propertyMappings,
         priority: priority,
         mergeDisplay: mergeDisplay,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FeatureRelationData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeatureRelationData copyWith({
    Object? id = _Undefined,
    _ilvqooqk.CharacterFeatureSourceType? sourceType,
    String? sourceReferenceKey,
    _ilvqooqk.CharacterFeatureSourceType? targetType,
    String? targetReferenceKey,
    _i1fmwm2o.FeatureRelationType? relationType,
    Object? propertyMappings = _Undefined,
    int? priority,
    Object? mergeDisplay = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return FeatureRelationData(
      id: id is int? ? id : this.id,
      sourceType: sourceType ?? this.sourceType,
      sourceReferenceKey: sourceReferenceKey ?? this.sourceReferenceKey,
      targetType: targetType ?? this.targetType,
      targetReferenceKey: targetReferenceKey ?? this.targetReferenceKey,
      relationType: relationType ?? this.relationType,
      propertyMappings: propertyMappings is Map<String, String>?
          ? propertyMappings
          : this.propertyMappings?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      priority: priority ?? this.priority,
      mergeDisplay: mergeDisplay is bool? ? mergeDisplay : this.mergeDisplay,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class FeatureRelationDataUpdateTable
    extends _is.UpdateTable<FeatureRelationDataTable> {
  FeatureRelationDataUpdateTable(super.table);

  _is.ColumnValue<
    _ilvqooqk.CharacterFeatureSourceType,
    _ilvqooqk.CharacterFeatureSourceType
  >
  sourceType(_ilvqooqk.CharacterFeatureSourceType value) =>
      _is.ColumnValue(table.sourceType, value);

  _is.ColumnValue<String, String> sourceReferenceKey(String value) =>
      _is.ColumnValue(table.sourceReferenceKey, value);

  _is.ColumnValue<
    _ilvqooqk.CharacterFeatureSourceType,
    _ilvqooqk.CharacterFeatureSourceType
  >
  targetType(_ilvqooqk.CharacterFeatureSourceType value) =>
      _is.ColumnValue(table.targetType, value);

  _is.ColumnValue<String, String> targetReferenceKey(String value) =>
      _is.ColumnValue(table.targetReferenceKey, value);

  _is.ColumnValue<_i1fmwm2o.FeatureRelationType, _i1fmwm2o.FeatureRelationType>
  relationType(_i1fmwm2o.FeatureRelationType value) =>
      _is.ColumnValue(table.relationType, value);

  _is.ColumnValue<Map<String, String>, Map<String, String>> propertyMappings(
    Map<String, String>? value,
  ) => _is.ColumnValue(table.propertyMappings, value);

  _is.ColumnValue<int, int> priority(int value) =>
      _is.ColumnValue(table.priority, value);

  _is.ColumnValue<bool, bool> mergeDisplay(bool? value) =>
      _is.ColumnValue(table.mergeDisplay, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class FeatureRelationDataTable extends _is.Table<int?> {
  FeatureRelationDataTable({super.tableRelation})
    : super(tableName: 'feature_relation_data') {
    updateTable = FeatureRelationDataUpdateTable(this);
    sourceType = _is.ColumnEnum(
      'sourceType',
      this,
      _is.EnumSerialization.byName,
    );
    sourceReferenceKey = _is.ColumnString('sourceReferenceKey', this);
    targetType = _is.ColumnEnum(
      'targetType',
      this,
      _is.EnumSerialization.byName,
    );
    targetReferenceKey = _is.ColumnString('targetReferenceKey', this);
    relationType = _is.ColumnEnum(
      'relationType',
      this,
      _is.EnumSerialization.byName,
    );
    propertyMappings = _is.ColumnSerializable<Map<String, String>>(
      'propertyMappings',
      this,
    );
    priority = _is.ColumnInt('priority', this);
    mergeDisplay = _is.ColumnBool('mergeDisplay', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final FeatureRelationDataUpdateTable updateTable;

  late final _is.ColumnEnum<_ilvqooqk.CharacterFeatureSourceType> sourceType;

  late final _is.ColumnString sourceReferenceKey;

  late final _is.ColumnEnum<_ilvqooqk.CharacterFeatureSourceType> targetType;

  late final _is.ColumnString targetReferenceKey;

  late final _is.ColumnEnum<_i1fmwm2o.FeatureRelationType> relationType;

  late final _is.ColumnSerializable<Map<String, String>> propertyMappings;

  late final _is.ColumnInt priority;

  late final _is.ColumnBool mergeDisplay;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    sourceType,
    sourceReferenceKey,
    targetType,
    targetReferenceKey,
    relationType,
    propertyMappings,
    priority,
    mergeDisplay,
    source,
    version,
    createdAt,
    updatedAt,
  ];
}

class FeatureRelationDataInclude extends _is.IncludeObject {
  FeatureRelationDataInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FeatureRelationData.t;
}

class FeatureRelationDataIncludeList extends _is.IncludeList {
  FeatureRelationDataIncludeList._({
    _is.WhereExpressionBuilder<FeatureRelationDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureRelationData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FeatureRelationData.t;
}

class FeatureRelationDataRepository {
  const FeatureRelationDataRepository._();

  /// Returns a list of [FeatureRelationData]s matching the given query parameters.
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
  Future<List<FeatureRelationData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureRelationDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureRelationDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureRelationDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeatureRelationData>(
      where: where?.call(FeatureRelationData.t),
      orderBy: orderBy?.call(FeatureRelationData.t),
      orderByList: orderByList?.call(FeatureRelationData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FeatureRelationData] matching the given query parameters.
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
  Future<FeatureRelationData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureRelationDataTable>? where,
    int? offset,
    _is.OrderByBuilder<FeatureRelationDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureRelationDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeatureRelationData>(
      where: where?.call(FeatureRelationData.t),
      orderBy: orderBy?.call(FeatureRelationData.t),
      orderByList: orderByList?.call(FeatureRelationData.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeatureRelationData] by its [id] or null if no such row exists.
  Future<FeatureRelationData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeatureRelationData>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeatureRelationData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureRelationData]s will have their `id` fields set.
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
  Future<List<FeatureRelationData>> insert(
    _is.DatabaseSession session,
    List<FeatureRelationData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FeatureRelationData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FeatureRelationData] and returns the inserted row.
  ///
  /// The returned [FeatureRelationData] will have its `id` field set.
  Future<FeatureRelationData> insertRow(
    _is.DatabaseSession session,
    FeatureRelationData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureRelationData>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FeatureRelationData]s in the list and returns the resulting rows.
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
  /// The returned [FeatureRelationData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureRelationData>> upsert(
    _is.DatabaseSession session,
    List<FeatureRelationData> rows, {
    required _is.ColumnSelections<FeatureRelationDataTable> conflictColumns,
    _is.ColumnSelections<FeatureRelationDataTable>? updateColumns,
    _is.WhereExpressionBuilder<FeatureRelationDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FeatureRelationData>(
      rows,
      conflictColumns: conflictColumns(FeatureRelationData.t),
      updateColumns: updateColumns?.call(FeatureRelationData.t),
      updateWhere: updateWhere?.call(FeatureRelationData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FeatureRelationData] and returns the resulting row.
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
  /// The returned [FeatureRelationData] will have its `id` field set.
  Future<FeatureRelationData?> upsertRow(
    _is.DatabaseSession session,
    FeatureRelationData row, {
    required _is.ColumnSelections<FeatureRelationDataTable> conflictColumns,
    _is.ColumnSelections<FeatureRelationDataTable>? updateColumns,
    _is.WhereExpressionBuilder<FeatureRelationDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FeatureRelationData>(
      row,
      conflictColumns: conflictColumns(FeatureRelationData.t),
      updateColumns: updateColumns?.call(FeatureRelationData.t),
      updateWhere: updateWhere?.call(FeatureRelationData.t),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureRelationData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureRelationData>> update(
    _is.DatabaseSession session,
    List<FeatureRelationData> rows, {
    _is.ColumnSelections<FeatureRelationDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FeatureRelationData>(
      rows,
      columns: columns?.call(FeatureRelationData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FeatureRelationData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureRelationData> updateRow(
    _is.DatabaseSession session,
    FeatureRelationData row, {
    _is.ColumnSelections<FeatureRelationDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureRelationData>(
      row,
      columns: columns?.call(FeatureRelationData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureRelationData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeatureRelationData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FeatureRelationDataUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FeatureRelationData>(
      id,
      columnValues: columnValues(FeatureRelationData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureRelationData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureRelationData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FeatureRelationDataUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<FeatureRelationDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureRelationDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureRelationDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FeatureRelationData>(
      columnValues: columnValues(FeatureRelationData.t.updateTable),
      where: where(FeatureRelationData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureRelationData.t),
      orderByList: orderByList?.call(FeatureRelationData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FeatureRelationData]s in the list and returns the deleted rows.
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
  Future<List<FeatureRelationData>> delete(
    _is.DatabaseSession session,
    List<FeatureRelationData> rows, {
    _is.OrderByBuilder<FeatureRelationDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureRelationDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FeatureRelationData>(
      rows,
      orderBy: orderBy?.call(FeatureRelationData.t),
      orderByList: orderByList?.call(FeatureRelationData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FeatureRelationData].
  Future<FeatureRelationData> deleteRow(
    _is.DatabaseSession session,
    FeatureRelationData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureRelationData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureRelationData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeatureRelationDataTable> where,
    _is.OrderByBuilder<FeatureRelationDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureRelationDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FeatureRelationData>(
      where: where(FeatureRelationData.t),
      orderBy: orderBy?.call(FeatureRelationData.t),
      orderByList: orderByList?.call(FeatureRelationData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureRelationDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FeatureRelationData>(
      where: where?.call(FeatureRelationData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeatureRelationData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeatureRelationDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeatureRelationData>(
      where: where(FeatureRelationData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
