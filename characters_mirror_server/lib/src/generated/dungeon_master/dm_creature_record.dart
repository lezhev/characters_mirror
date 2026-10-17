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
import 'package:serverpod/serverpod.dart' as _is;

abstract class DmCreatureRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DmCreatureRecord._({
    this.id,
    required this.userId,
    required this.name,
    required this.sourceType,
    this.sourceVersion,
    this.challengeRating,
    required this.rawJson,
    required this.normalizedJson,
    required this.importHash,
    required this.schemaVersion,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DmCreatureRecord({
    int? id,
    required int userId,
    required String name,
    required String sourceType,
    String? sourceVersion,
    String? challengeRating,
    required String rawJson,
    required String normalizedJson,
    required String importHash,
    required int schemaVersion,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DmCreatureRecordImpl;

  factory DmCreatureRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return DmCreatureRecord(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      sourceType: jsonSerialization['sourceType'] as String,
      sourceVersion: jsonSerialization['sourceVersion'] as String?,
      challengeRating: jsonSerialization['challengeRating'] as String?,
      rawJson: jsonSerialization['rawJson'] as String,
      normalizedJson: jsonSerialization['normalizedJson'] as String,
      importHash: jsonSerialization['importHash'] as String,
      schemaVersion: jsonSerialization['schemaVersion'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = DmCreatureRecordTable();

  static const db = DmCreatureRecordRepository._();

  @override
  int? id;

  int userId;

  String name;

  String sourceType;

  String? sourceVersion;

  String? challengeRating;

  String rawJson;

  String normalizedJson;

  String importHash;

  int schemaVersion;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DmCreatureRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DmCreatureRecord copyWith({
    int? id,
    int? userId,
    String? name,
    String? sourceType,
    String? sourceVersion,
    String? challengeRating,
    String? rawJson,
    String? normalizedJson,
    String? importHash,
    int? schemaVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DmCreatureRecord',
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'sourceType': sourceType,
      if (sourceVersion != null) 'sourceVersion': sourceVersion,
      if (challengeRating != null) 'challengeRating': challengeRating,
      'rawJson': rawJson,
      'normalizedJson': normalizedJson,
      'importHash': importHash,
      'schemaVersion': schemaVersion,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DmCreatureRecord',
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'sourceType': sourceType,
      if (sourceVersion != null) 'sourceVersion': sourceVersion,
      if (challengeRating != null) 'challengeRating': challengeRating,
      'rawJson': rawJson,
      'normalizedJson': normalizedJson,
      'importHash': importHash,
      'schemaVersion': schemaVersion,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DmCreatureRecordInclude include() {
    return DmCreatureRecordInclude._();
  }

  static DmCreatureRecordIncludeList includeList({
    _is.WhereExpressionBuilder<DmCreatureRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DmCreatureRecordTable>? orderBy,
    _is.OrderByListBuilder<DmCreatureRecordTable>? orderByList,
    DmCreatureRecordInclude? include,
  }) {
    return DmCreatureRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DmCreatureRecord.t),
      orderByList: orderByList?.call(DmCreatureRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DmCreatureRecordImpl extends DmCreatureRecord {
  _DmCreatureRecordImpl({
    int? id,
    required int userId,
    required String name,
    required String sourceType,
    String? sourceVersion,
    String? challengeRating,
    required String rawJson,
    required String normalizedJson,
    required String importHash,
    required int schemaVersion,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         name: name,
         sourceType: sourceType,
         sourceVersion: sourceVersion,
         challengeRating: challengeRating,
         rawJson: rawJson,
         normalizedJson: normalizedJson,
         importHash: importHash,
         schemaVersion: schemaVersion,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DmCreatureRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DmCreatureRecord copyWith({
    Object? id = _Undefined,
    int? userId,
    String? name,
    String? sourceType,
    Object? sourceVersion = _Undefined,
    Object? challengeRating = _Undefined,
    String? rawJson,
    String? normalizedJson,
    String? importHash,
    int? schemaVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DmCreatureRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      sourceType: sourceType ?? this.sourceType,
      sourceVersion: sourceVersion is String?
          ? sourceVersion
          : this.sourceVersion,
      challengeRating: challengeRating is String?
          ? challengeRating
          : this.challengeRating,
      rawJson: rawJson ?? this.rawJson,
      normalizedJson: normalizedJson ?? this.normalizedJson,
      importHash: importHash ?? this.importHash,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DmCreatureRecordUpdateTable
    extends _is.UpdateTable<DmCreatureRecordTable> {
  DmCreatureRecordUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) =>
      _is.ColumnValue(table.userId, value);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> sourceType(String value) =>
      _is.ColumnValue(table.sourceType, value);

  _is.ColumnValue<String, String> sourceVersion(String? value) =>
      _is.ColumnValue(table.sourceVersion, value);

  _is.ColumnValue<String, String> challengeRating(String? value) =>
      _is.ColumnValue(table.challengeRating, value);

  _is.ColumnValue<String, String> rawJson(String value) =>
      _is.ColumnValue(table.rawJson, value);

  _is.ColumnValue<String, String> normalizedJson(String value) =>
      _is.ColumnValue(table.normalizedJson, value);

  _is.ColumnValue<String, String> importHash(String value) =>
      _is.ColumnValue(table.importHash, value);

  _is.ColumnValue<int, int> schemaVersion(int value) =>
      _is.ColumnValue(table.schemaVersion, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class DmCreatureRecordTable extends _is.Table<int?> {
  DmCreatureRecordTable({super.tableRelation})
    : super(tableName: 'dm_creatures') {
    updateTable = DmCreatureRecordUpdateTable(this);
    userId = _is.ColumnInt('userId', this);
    name = _is.ColumnString('name', this);
    sourceType = _is.ColumnString('sourceType', this);
    sourceVersion = _is.ColumnString('sourceVersion', this);
    challengeRating = _is.ColumnString('challengeRating', this);
    rawJson = _is.ColumnString('rawJson', this);
    normalizedJson = _is.ColumnString('normalizedJson', this);
    importHash = _is.ColumnString('importHash', this);
    schemaVersion = _is.ColumnInt('schemaVersion', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final DmCreatureRecordUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnString name;

  late final _is.ColumnString sourceType;

  late final _is.ColumnString sourceVersion;

  late final _is.ColumnString challengeRating;

  late final _is.ColumnString rawJson;

  late final _is.ColumnString normalizedJson;

  late final _is.ColumnString importHash;

  late final _is.ColumnInt schemaVersion;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    name,
    sourceType,
    sourceVersion,
    challengeRating,
    rawJson,
    normalizedJson,
    importHash,
    schemaVersion,
    createdAt,
    updatedAt,
  ];
}

class DmCreatureRecordInclude extends _is.IncludeObject {
  DmCreatureRecordInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DmCreatureRecord.t;
}

class DmCreatureRecordIncludeList extends _is.IncludeList {
  DmCreatureRecordIncludeList._({
    _is.WhereExpressionBuilder<DmCreatureRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DmCreatureRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DmCreatureRecord.t;
}

class DmCreatureRecordRepository {
  const DmCreatureRecordRepository._();

  /// Returns a list of [DmCreatureRecord]s matching the given query parameters.
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
  Future<List<DmCreatureRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DmCreatureRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DmCreatureRecordTable>? orderBy,
    _is.OrderByListBuilder<DmCreatureRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DmCreatureRecord>(
      where: where?.call(DmCreatureRecord.t),
      orderBy: orderBy?.call(DmCreatureRecord.t),
      orderByList: orderByList?.call(DmCreatureRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DmCreatureRecord] matching the given query parameters.
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
  Future<DmCreatureRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DmCreatureRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<DmCreatureRecordTable>? orderBy,
    _is.OrderByListBuilder<DmCreatureRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DmCreatureRecord>(
      where: where?.call(DmCreatureRecord.t),
      orderBy: orderBy?.call(DmCreatureRecord.t),
      orderByList: orderByList?.call(DmCreatureRecord.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DmCreatureRecord] by its [id] or null if no such row exists.
  Future<DmCreatureRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DmCreatureRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DmCreatureRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [DmCreatureRecord]s will have their `id` fields set.
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
  Future<List<DmCreatureRecord>> insert(
    _is.DatabaseSession session,
    List<DmCreatureRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DmCreatureRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DmCreatureRecord] and returns the inserted row.
  ///
  /// The returned [DmCreatureRecord] will have its `id` field set.
  Future<DmCreatureRecord> insertRow(
    _is.DatabaseSession session,
    DmCreatureRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DmCreatureRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DmCreatureRecord]s in the list and returns the resulting rows.
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
  /// The returned [DmCreatureRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DmCreatureRecord>> upsert(
    _is.DatabaseSession session,
    List<DmCreatureRecord> rows, {
    required _is.ColumnSelections<DmCreatureRecordTable> conflictColumns,
    _is.ColumnSelections<DmCreatureRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<DmCreatureRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DmCreatureRecord>(
      rows,
      conflictColumns: conflictColumns(DmCreatureRecord.t),
      updateColumns: updateColumns?.call(DmCreatureRecord.t),
      updateWhere: updateWhere?.call(DmCreatureRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DmCreatureRecord] and returns the resulting row.
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
  /// The returned [DmCreatureRecord] will have its `id` field set.
  Future<DmCreatureRecord?> upsertRow(
    _is.DatabaseSession session,
    DmCreatureRecord row, {
    required _is.ColumnSelections<DmCreatureRecordTable> conflictColumns,
    _is.ColumnSelections<DmCreatureRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<DmCreatureRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DmCreatureRecord>(
      row,
      conflictColumns: conflictColumns(DmCreatureRecord.t),
      updateColumns: updateColumns?.call(DmCreatureRecord.t),
      updateWhere: updateWhere?.call(DmCreatureRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [DmCreatureRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DmCreatureRecord>> update(
    _is.DatabaseSession session,
    List<DmCreatureRecord> rows, {
    _is.ColumnSelections<DmCreatureRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DmCreatureRecord>(
      rows,
      columns: columns?.call(DmCreatureRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DmCreatureRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DmCreatureRecord> updateRow(
    _is.DatabaseSession session,
    DmCreatureRecord row, {
    _is.ColumnSelections<DmCreatureRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DmCreatureRecord>(
      row,
      columns: columns?.call(DmCreatureRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DmCreatureRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DmCreatureRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DmCreatureRecordUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DmCreatureRecord>(
      id,
      columnValues: columnValues(DmCreatureRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DmCreatureRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DmCreatureRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DmCreatureRecordUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<DmCreatureRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DmCreatureRecordTable>? orderBy,
    _is.OrderByListBuilder<DmCreatureRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DmCreatureRecord>(
      columnValues: columnValues(DmCreatureRecord.t.updateTable),
      where: where(DmCreatureRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DmCreatureRecord.t),
      orderByList: orderByList?.call(DmCreatureRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DmCreatureRecord]s in the list and returns the deleted rows.
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
  Future<List<DmCreatureRecord>> delete(
    _is.DatabaseSession session,
    List<DmCreatureRecord> rows, {
    _is.OrderByBuilder<DmCreatureRecordTable>? orderBy,
    _is.OrderByListBuilder<DmCreatureRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DmCreatureRecord>(
      rows,
      orderBy: orderBy?.call(DmCreatureRecord.t),
      orderByList: orderByList?.call(DmCreatureRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DmCreatureRecord].
  Future<DmCreatureRecord> deleteRow(
    _is.DatabaseSession session,
    DmCreatureRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DmCreatureRecord>(
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
  Future<List<DmCreatureRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DmCreatureRecordTable> where,
    _is.OrderByBuilder<DmCreatureRecordTable>? orderBy,
    _is.OrderByListBuilder<DmCreatureRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DmCreatureRecord>(
      where: where(DmCreatureRecord.t),
      orderBy: orderBy?.call(DmCreatureRecord.t),
      orderByList: orderByList?.call(DmCreatureRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DmCreatureRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DmCreatureRecord>(
      where: where?.call(DmCreatureRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DmCreatureRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DmCreatureRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DmCreatureRecord>(
      where: where(DmCreatureRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
