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

abstract class CharacterAppliedChangeRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CharacterAppliedChangeRecord._({
    this.id,
    required this.userId,
    required this.changeId,
    this.characterId,
    this.revision,
    required this.createdAt,
  });

  factory CharacterAppliedChangeRecord({
    int? id,
    required int userId,
    required String changeId,
    int? characterId,
    int? revision,
    required DateTime createdAt,
  }) = _CharacterAppliedChangeRecordImpl;

  factory CharacterAppliedChangeRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterAppliedChangeRecord(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      changeId: jsonSerialization['changeId'] as String,
      characterId: jsonSerialization['characterId'] as int?,
      revision: jsonSerialization['revision'] as int?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = CharacterAppliedChangeRecordTable();

  static const db = CharacterAppliedChangeRecordRepository._();

  @override
  int? id;

  int userId;

  String changeId;

  int? characterId;

  int? revision;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterAppliedChangeRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterAppliedChangeRecord copyWith({
    int? id,
    int? userId,
    String? changeId,
    int? characterId,
    int? revision,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterAppliedChangeRecord',
      if (id != null) 'id': id,
      'userId': userId,
      'changeId': changeId,
      if (characterId != null) 'characterId': characterId,
      if (revision != null) 'revision': revision,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CharacterAppliedChangeRecordInclude include() {
    return CharacterAppliedChangeRecordInclude._();
  }

  static CharacterAppliedChangeRecordIncludeList includeList({
    _is.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterAppliedChangeRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterAppliedChangeRecordTable>? orderByList,
    CharacterAppliedChangeRecordInclude? include,
  }) {
    return CharacterAppliedChangeRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterAppliedChangeRecord.t),
      orderByList: orderByList?.call(CharacterAppliedChangeRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterAppliedChangeRecordImpl extends CharacterAppliedChangeRecord {
  _CharacterAppliedChangeRecordImpl({
    int? id,
    required int userId,
    required String changeId,
    int? characterId,
    int? revision,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         changeId: changeId,
         characterId: characterId,
         revision: revision,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CharacterAppliedChangeRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterAppliedChangeRecord copyWith({
    Object? id = _Undefined,
    int? userId,
    String? changeId,
    Object? characterId = _Undefined,
    Object? revision = _Undefined,
    DateTime? createdAt,
  }) {
    return CharacterAppliedChangeRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      changeId: changeId ?? this.changeId,
      characterId: characterId is int? ? characterId : this.characterId,
      revision: revision is int? ? revision : this.revision,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CharacterAppliedChangeRecordUpdateTable
    extends _is.UpdateTable<CharacterAppliedChangeRecordTable> {
  CharacterAppliedChangeRecordUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) =>
      _is.ColumnValue(table.userId, value);

  _is.ColumnValue<String, String> changeId(String value) =>
      _is.ColumnValue(table.changeId, value);

  _is.ColumnValue<int, int> characterId(int? value) =>
      _is.ColumnValue(table.characterId, value);

  _is.ColumnValue<int, int> revision(int? value) =>
      _is.ColumnValue(table.revision, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(table.createdAt, value);
}

class CharacterAppliedChangeRecordTable extends _is.Table<int?> {
  CharacterAppliedChangeRecordTable({super.tableRelation})
    : super(tableName: 'character_applied_changes') {
    updateTable = CharacterAppliedChangeRecordUpdateTable(this);
    userId = _is.ColumnInt('userId', this);
    changeId = _is.ColumnString('changeId', this);
    characterId = _is.ColumnInt('characterId', this);
    revision = _is.ColumnInt('revision', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
  }

  late final CharacterAppliedChangeRecordUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnString changeId;

  late final _is.ColumnInt characterId;

  late final _is.ColumnInt revision;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    changeId,
    characterId,
    revision,
    createdAt,
  ];
}

class CharacterAppliedChangeRecordInclude extends _is.IncludeObject {
  CharacterAppliedChangeRecordInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CharacterAppliedChangeRecord.t;
}

class CharacterAppliedChangeRecordIncludeList extends _is.IncludeList {
  CharacterAppliedChangeRecordIncludeList._({
    _is.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterAppliedChangeRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CharacterAppliedChangeRecord.t;
}

class CharacterAppliedChangeRecordRepository {
  const CharacterAppliedChangeRecordRepository._();

  /// Returns a list of [CharacterAppliedChangeRecord]s matching the given query parameters.
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
  Future<List<CharacterAppliedChangeRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterAppliedChangeRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterAppliedChangeRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CharacterAppliedChangeRecord>(
      where: where?.call(CharacterAppliedChangeRecord.t),
      orderBy: orderBy?.call(CharacterAppliedChangeRecord.t),
      orderByList: orderByList?.call(CharacterAppliedChangeRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CharacterAppliedChangeRecord] matching the given query parameters.
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
  Future<CharacterAppliedChangeRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<CharacterAppliedChangeRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterAppliedChangeRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CharacterAppliedChangeRecord>(
      where: where?.call(CharacterAppliedChangeRecord.t),
      orderBy: orderBy?.call(CharacterAppliedChangeRecord.t),
      orderByList: orderByList?.call(CharacterAppliedChangeRecord.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CharacterAppliedChangeRecord] by its [id] or null if no such row exists.
  Future<CharacterAppliedChangeRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CharacterAppliedChangeRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CharacterAppliedChangeRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterAppliedChangeRecord]s will have their `id` fields set.
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
  Future<List<CharacterAppliedChangeRecord>> insert(
    _is.DatabaseSession session,
    List<CharacterAppliedChangeRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CharacterAppliedChangeRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CharacterAppliedChangeRecord] and returns the inserted row.
  ///
  /// The returned [CharacterAppliedChangeRecord] will have its `id` field set.
  Future<CharacterAppliedChangeRecord> insertRow(
    _is.DatabaseSession session,
    CharacterAppliedChangeRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterAppliedChangeRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CharacterAppliedChangeRecord]s in the list and returns the resulting rows.
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
  /// The returned [CharacterAppliedChangeRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterAppliedChangeRecord>> upsert(
    _is.DatabaseSession session,
    List<CharacterAppliedChangeRecord> rows, {
    required _is.ColumnSelections<CharacterAppliedChangeRecordTable>
    conflictColumns,
    _is.ColumnSelections<CharacterAppliedChangeRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CharacterAppliedChangeRecord>(
      rows,
      conflictColumns: conflictColumns(CharacterAppliedChangeRecord.t),
      updateColumns: updateColumns?.call(CharacterAppliedChangeRecord.t),
      updateWhere: updateWhere?.call(CharacterAppliedChangeRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CharacterAppliedChangeRecord] and returns the resulting row.
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
  /// The returned [CharacterAppliedChangeRecord] will have its `id` field set.
  Future<CharacterAppliedChangeRecord?> upsertRow(
    _is.DatabaseSession session,
    CharacterAppliedChangeRecord row, {
    required _is.ColumnSelections<CharacterAppliedChangeRecordTable>
    conflictColumns,
    _is.ColumnSelections<CharacterAppliedChangeRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CharacterAppliedChangeRecord>(
      row,
      conflictColumns: conflictColumns(CharacterAppliedChangeRecord.t),
      updateColumns: updateColumns?.call(CharacterAppliedChangeRecord.t),
      updateWhere: updateWhere?.call(CharacterAppliedChangeRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterAppliedChangeRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterAppliedChangeRecord>> update(
    _is.DatabaseSession session,
    List<CharacterAppliedChangeRecord> rows, {
    _is.ColumnSelections<CharacterAppliedChangeRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CharacterAppliedChangeRecord>(
      rows,
      columns: columns?.call(CharacterAppliedChangeRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CharacterAppliedChangeRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterAppliedChangeRecord> updateRow(
    _is.DatabaseSession session,
    CharacterAppliedChangeRecord row, {
    _is.ColumnSelections<CharacterAppliedChangeRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterAppliedChangeRecord>(
      row,
      columns: columns?.call(CharacterAppliedChangeRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterAppliedChangeRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CharacterAppliedChangeRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CharacterAppliedChangeRecordUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CharacterAppliedChangeRecord>(
      id,
      columnValues: columnValues(CharacterAppliedChangeRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterAppliedChangeRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterAppliedChangeRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CharacterAppliedChangeRecordUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>
    where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterAppliedChangeRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterAppliedChangeRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CharacterAppliedChangeRecord>(
      columnValues: columnValues(CharacterAppliedChangeRecord.t.updateTable),
      where: where(CharacterAppliedChangeRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterAppliedChangeRecord.t),
      orderByList: orderByList?.call(CharacterAppliedChangeRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CharacterAppliedChangeRecord]s in the list and returns the deleted rows.
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
  Future<List<CharacterAppliedChangeRecord>> delete(
    _is.DatabaseSession session,
    List<CharacterAppliedChangeRecord> rows, {
    _is.OrderByBuilder<CharacterAppliedChangeRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterAppliedChangeRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CharacterAppliedChangeRecord>(
      rows,
      orderBy: orderBy?.call(CharacterAppliedChangeRecord.t),
      orderByList: orderByList?.call(CharacterAppliedChangeRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CharacterAppliedChangeRecord].
  Future<CharacterAppliedChangeRecord> deleteRow(
    _is.DatabaseSession session,
    CharacterAppliedChangeRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterAppliedChangeRecord>(
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
  Future<List<CharacterAppliedChangeRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>
    where,
    _is.OrderByBuilder<CharacterAppliedChangeRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterAppliedChangeRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CharacterAppliedChangeRecord>(
      where: where(CharacterAppliedChangeRecord.t),
      orderBy: orderBy?.call(CharacterAppliedChangeRecord.t),
      orderByList: orderByList?.call(CharacterAppliedChangeRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CharacterAppliedChangeRecord>(
      where: where?.call(CharacterAppliedChangeRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CharacterAppliedChangeRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>
    where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CharacterAppliedChangeRecord>(
      where: where(CharacterAppliedChangeRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
