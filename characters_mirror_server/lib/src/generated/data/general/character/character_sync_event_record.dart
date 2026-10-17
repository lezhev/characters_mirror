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

abstract class CharacterSyncEventRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CharacterSyncEventRecord._({
    this.id,
    required this.userId,
    required this.characterId,
    this.characterVersion,
    required this.eventType,
    this.changeId,
    required this.createdAt,
  });

  factory CharacterSyncEventRecord({
    int? id,
    required int userId,
    required int characterId,
    int? characterVersion,
    required String eventType,
    String? changeId,
    required DateTime createdAt,
  }) = _CharacterSyncEventRecordImpl;

  factory CharacterSyncEventRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterSyncEventRecord(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      characterId: jsonSerialization['characterId'] as int,
      characterVersion: jsonSerialization['characterVersion'] as int?,
      eventType: jsonSerialization['eventType'] as String,
      changeId: jsonSerialization['changeId'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = CharacterSyncEventRecordTable();

  static const db = CharacterSyncEventRecordRepository._();

  @override
  int? id;

  int userId;

  int characterId;

  int? characterVersion;

  String eventType;

  String? changeId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterSyncEventRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterSyncEventRecord copyWith({
    int? id,
    int? userId,
    int? characterId,
    int? characterVersion,
    String? eventType,
    String? changeId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterSyncEventRecord',
      if (id != null) 'id': id,
      'userId': userId,
      'characterId': characterId,
      if (characterVersion != null) 'characterVersion': characterVersion,
      'eventType': eventType,
      if (changeId != null) 'changeId': changeId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CharacterSyncEventRecordInclude include() {
    return CharacterSyncEventRecordInclude._();
  }

  static CharacterSyncEventRecordIncludeList includeList({
    _is.WhereExpressionBuilder<CharacterSyncEventRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterSyncEventRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSyncEventRecordTable>? orderByList,
    CharacterSyncEventRecordInclude? include,
  }) {
    return CharacterSyncEventRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterSyncEventRecord.t),
      orderByList: orderByList?.call(CharacterSyncEventRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSyncEventRecordImpl extends CharacterSyncEventRecord {
  _CharacterSyncEventRecordImpl({
    int? id,
    required int userId,
    required int characterId,
    int? characterVersion,
    required String eventType,
    String? changeId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         characterId: characterId,
         characterVersion: characterVersion,
         eventType: eventType,
         changeId: changeId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CharacterSyncEventRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterSyncEventRecord copyWith({
    Object? id = _Undefined,
    int? userId,
    int? characterId,
    Object? characterVersion = _Undefined,
    String? eventType,
    Object? changeId = _Undefined,
    DateTime? createdAt,
  }) {
    return CharacterSyncEventRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      characterId: characterId ?? this.characterId,
      characterVersion: characterVersion is int?
          ? characterVersion
          : this.characterVersion,
      eventType: eventType ?? this.eventType,
      changeId: changeId is String? ? changeId : this.changeId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CharacterSyncEventRecordUpdateTable
    extends _is.UpdateTable<CharacterSyncEventRecordTable> {
  CharacterSyncEventRecordUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) =>
      _is.ColumnValue(table.userId, value);

  _is.ColumnValue<int, int> characterId(int value) =>
      _is.ColumnValue(table.characterId, value);

  _is.ColumnValue<int, int> characterVersion(int? value) =>
      _is.ColumnValue(table.characterVersion, value);

  _is.ColumnValue<String, String> eventType(String value) =>
      _is.ColumnValue(table.eventType, value);

  _is.ColumnValue<String, String> changeId(String? value) =>
      _is.ColumnValue(table.changeId, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(table.createdAt, value);
}

class CharacterSyncEventRecordTable extends _is.Table<int?> {
  CharacterSyncEventRecordTable({super.tableRelation})
    : super(tableName: 'character_sync_events') {
    updateTable = CharacterSyncEventRecordUpdateTable(this);
    userId = _is.ColumnInt('userId', this);
    characterId = _is.ColumnInt('characterId', this);
    characterVersion = _is.ColumnInt('characterVersion', this);
    eventType = _is.ColumnString('eventType', this);
    changeId = _is.ColumnString('changeId', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
  }

  late final CharacterSyncEventRecordUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt characterId;

  late final _is.ColumnInt characterVersion;

  late final _is.ColumnString eventType;

  late final _is.ColumnString changeId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    characterId,
    characterVersion,
    eventType,
    changeId,
    createdAt,
  ];
}

class CharacterSyncEventRecordInclude extends _is.IncludeObject {
  CharacterSyncEventRecordInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CharacterSyncEventRecord.t;
}

class CharacterSyncEventRecordIncludeList extends _is.IncludeList {
  CharacterSyncEventRecordIncludeList._({
    _is.WhereExpressionBuilder<CharacterSyncEventRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterSyncEventRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CharacterSyncEventRecord.t;
}

class CharacterSyncEventRecordRepository {
  const CharacterSyncEventRecordRepository._();

  /// Returns a list of [CharacterSyncEventRecord]s matching the given query parameters.
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
  Future<List<CharacterSyncEventRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterSyncEventRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterSyncEventRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSyncEventRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CharacterSyncEventRecord>(
      where: where?.call(CharacterSyncEventRecord.t),
      orderBy: orderBy?.call(CharacterSyncEventRecord.t),
      orderByList: orderByList?.call(CharacterSyncEventRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CharacterSyncEventRecord] matching the given query parameters.
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
  Future<CharacterSyncEventRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterSyncEventRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<CharacterSyncEventRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSyncEventRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CharacterSyncEventRecord>(
      where: where?.call(CharacterSyncEventRecord.t),
      orderBy: orderBy?.call(CharacterSyncEventRecord.t),
      orderByList: orderByList?.call(CharacterSyncEventRecord.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CharacterSyncEventRecord] by its [id] or null if no such row exists.
  Future<CharacterSyncEventRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CharacterSyncEventRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CharacterSyncEventRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterSyncEventRecord]s will have their `id` fields set.
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
  Future<List<CharacterSyncEventRecord>> insert(
    _is.DatabaseSession session,
    List<CharacterSyncEventRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CharacterSyncEventRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CharacterSyncEventRecord] and returns the inserted row.
  ///
  /// The returned [CharacterSyncEventRecord] will have its `id` field set.
  Future<CharacterSyncEventRecord> insertRow(
    _is.DatabaseSession session,
    CharacterSyncEventRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterSyncEventRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CharacterSyncEventRecord]s in the list and returns the resulting rows.
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
  /// The returned [CharacterSyncEventRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterSyncEventRecord>> upsert(
    _is.DatabaseSession session,
    List<CharacterSyncEventRecord> rows, {
    required _is.ColumnSelections<CharacterSyncEventRecordTable>
    conflictColumns,
    _is.ColumnSelections<CharacterSyncEventRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterSyncEventRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CharacterSyncEventRecord>(
      rows,
      conflictColumns: conflictColumns(CharacterSyncEventRecord.t),
      updateColumns: updateColumns?.call(CharacterSyncEventRecord.t),
      updateWhere: updateWhere?.call(CharacterSyncEventRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CharacterSyncEventRecord] and returns the resulting row.
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
  /// The returned [CharacterSyncEventRecord] will have its `id` field set.
  Future<CharacterSyncEventRecord?> upsertRow(
    _is.DatabaseSession session,
    CharacterSyncEventRecord row, {
    required _is.ColumnSelections<CharacterSyncEventRecordTable>
    conflictColumns,
    _is.ColumnSelections<CharacterSyncEventRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterSyncEventRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CharacterSyncEventRecord>(
      row,
      conflictColumns: conflictColumns(CharacterSyncEventRecord.t),
      updateColumns: updateColumns?.call(CharacterSyncEventRecord.t),
      updateWhere: updateWhere?.call(CharacterSyncEventRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterSyncEventRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterSyncEventRecord>> update(
    _is.DatabaseSession session,
    List<CharacterSyncEventRecord> rows, {
    _is.ColumnSelections<CharacterSyncEventRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CharacterSyncEventRecord>(
      rows,
      columns: columns?.call(CharacterSyncEventRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CharacterSyncEventRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterSyncEventRecord> updateRow(
    _is.DatabaseSession session,
    CharacterSyncEventRecord row, {
    _is.ColumnSelections<CharacterSyncEventRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterSyncEventRecord>(
      row,
      columns: columns?.call(CharacterSyncEventRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterSyncEventRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CharacterSyncEventRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CharacterSyncEventRecordUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CharacterSyncEventRecord>(
      id,
      columnValues: columnValues(CharacterSyncEventRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterSyncEventRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterSyncEventRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CharacterSyncEventRecordUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CharacterSyncEventRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterSyncEventRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSyncEventRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CharacterSyncEventRecord>(
      columnValues: columnValues(CharacterSyncEventRecord.t.updateTable),
      where: where(CharacterSyncEventRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterSyncEventRecord.t),
      orderByList: orderByList?.call(CharacterSyncEventRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CharacterSyncEventRecord]s in the list and returns the deleted rows.
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
  Future<List<CharacterSyncEventRecord>> delete(
    _is.DatabaseSession session,
    List<CharacterSyncEventRecord> rows, {
    _is.OrderByBuilder<CharacterSyncEventRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSyncEventRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CharacterSyncEventRecord>(
      rows,
      orderBy: orderBy?.call(CharacterSyncEventRecord.t),
      orderByList: orderByList?.call(CharacterSyncEventRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CharacterSyncEventRecord].
  Future<CharacterSyncEventRecord> deleteRow(
    _is.DatabaseSession session,
    CharacterSyncEventRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterSyncEventRecord>(
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
  Future<List<CharacterSyncEventRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterSyncEventRecordTable> where,
    _is.OrderByBuilder<CharacterSyncEventRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSyncEventRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CharacterSyncEventRecord>(
      where: where(CharacterSyncEventRecord.t),
      orderBy: orderBy?.call(CharacterSyncEventRecord.t),
      orderByList: orderByList?.call(CharacterSyncEventRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterSyncEventRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CharacterSyncEventRecord>(
      where: where?.call(CharacterSyncEventRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CharacterSyncEventRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterSyncEventRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CharacterSyncEventRecord>(
      where: where(CharacterSyncEventRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
