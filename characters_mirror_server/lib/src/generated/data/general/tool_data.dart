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
import '../../enums/tool_category.dart' as _i7uzvg6w;

abstract class ToolData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ToolData._({
    this.id,
    required this.referenceKey,
    required this.name,
    this.category,
  });

  factory ToolData({
    int? id,
    required String referenceKey,
    required String name,
    _i7uzvg6w.ToolCategory? category,
  }) = _ToolDataImpl;

  factory ToolData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ToolData(
      id: jsonSerialization['id'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String,
      name: jsonSerialization['name'] as String,
      category: jsonSerialization['category'] == null
          ? null
          : _i7uzvg6w.ToolCategory.fromJson(
              (jsonSerialization['category'] as int),
            ),
    );
  }

  static final t = ToolDataTable();

  static const db = ToolDataRepository._();

  @override
  int? id;

  String referenceKey;

  String name;

  _i7uzvg6w.ToolCategory? category;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ToolData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ToolData copyWith({
    int? id,
    String? referenceKey,
    String? name,
    _i7uzvg6w.ToolCategory? category,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ToolData',
      if (id != null) 'id': id,
      'referenceKey': referenceKey,
      'name': name,
      if (category != null) 'category': category?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ToolData',
      if (id != null) 'id': id,
      'referenceKey': referenceKey,
      'name': name,
      if (category != null) 'category': category?.toJson(),
    };
  }

  static ToolDataInclude include() {
    return ToolDataInclude._();
  }

  static ToolDataIncludeList includeList({
    _is.WhereExpressionBuilder<ToolDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ToolDataTable>? orderBy,
    _is.OrderByListBuilder<ToolDataTable>? orderByList,
    ToolDataInclude? include,
  }) {
    return ToolDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ToolData.t),
      orderByList: orderByList?.call(ToolData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ToolDataImpl extends ToolData {
  _ToolDataImpl({
    int? id,
    required String referenceKey,
    required String name,
    _i7uzvg6w.ToolCategory? category,
  }) : super._(
         id: id,
         referenceKey: referenceKey,
         name: name,
         category: category,
       );

  /// Returns a shallow copy of this [ToolData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ToolData copyWith({
    Object? id = _Undefined,
    String? referenceKey,
    String? name,
    Object? category = _Undefined,
  }) {
    return ToolData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey ?? this.referenceKey,
      name: name ?? this.name,
      category: category is _i7uzvg6w.ToolCategory? ? category : this.category,
    );
  }
}

class ToolDataUpdateTable extends _is.UpdateTable<ToolDataTable> {
  ToolDataUpdateTable(super.table);

  _is.ColumnValue<String, String> referenceKey(String value) =>
      _is.ColumnValue(table.referenceKey, value);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<_i7uzvg6w.ToolCategory, _i7uzvg6w.ToolCategory> category(
    _i7uzvg6w.ToolCategory? value,
  ) => _is.ColumnValue(table.category, value);
}

class ToolDataTable extends _is.Table<int?> {
  ToolDataTable({super.tableRelation}) : super(tableName: 'tool_data') {
    updateTable = ToolDataUpdateTable(this);
    referenceKey = _is.ColumnString('referenceKey', this);
    name = _is.ColumnString('name', this);
    category = _is.ColumnEnum('category', this, _is.EnumSerialization.byIndex);
  }

  late final ToolDataUpdateTable updateTable;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnString name;

  late final _is.ColumnEnum<_i7uzvg6w.ToolCategory> category;

  @override
  List<_is.Column> get columns => [id, referenceKey, name, category];
}

class ToolDataInclude extends _is.IncludeObject {
  ToolDataInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ToolData.t;
}

class ToolDataIncludeList extends _is.IncludeList {
  ToolDataIncludeList._({
    _is.WhereExpressionBuilder<ToolDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ToolData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ToolData.t;
}

class ToolDataRepository {
  const ToolDataRepository._();

  /// Returns a list of [ToolData]s matching the given query parameters.
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
  Future<List<ToolData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ToolDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ToolDataTable>? orderBy,
    _is.OrderByListBuilder<ToolDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ToolData>(
      where: where?.call(ToolData.t),
      orderBy: orderBy?.call(ToolData.t),
      orderByList: orderByList?.call(ToolData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ToolData] matching the given query parameters.
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
  Future<ToolData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ToolDataTable>? where,
    int? offset,
    _is.OrderByBuilder<ToolDataTable>? orderBy,
    _is.OrderByListBuilder<ToolDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ToolData>(
      where: where?.call(ToolData.t),
      orderBy: orderBy?.call(ToolData.t),
      orderByList: orderByList?.call(ToolData.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ToolData] by its [id] or null if no such row exists.
  Future<ToolData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ToolData>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ToolData]s in the list and returns the inserted rows.
  ///
  /// The returned [ToolData]s will have their `id` fields set.
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
  Future<List<ToolData>> insert(
    _is.DatabaseSession session,
    List<ToolData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ToolData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ToolData] and returns the inserted row.
  ///
  /// The returned [ToolData] will have its `id` field set.
  Future<ToolData> insertRow(
    _is.DatabaseSession session,
    ToolData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ToolData>(row, transaction: transaction);
  }

  /// Upserts all [ToolData]s in the list and returns the resulting rows.
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
  /// The returned [ToolData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ToolData>> upsert(
    _is.DatabaseSession session,
    List<ToolData> rows, {
    required _is.ColumnSelections<ToolDataTable> conflictColumns,
    _is.ColumnSelections<ToolDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ToolDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ToolData>(
      rows,
      conflictColumns: conflictColumns(ToolData.t),
      updateColumns: updateColumns?.call(ToolData.t),
      updateWhere: updateWhere?.call(ToolData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ToolData] and returns the resulting row.
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
  /// The returned [ToolData] will have its `id` field set.
  Future<ToolData?> upsertRow(
    _is.DatabaseSession session,
    ToolData row, {
    required _is.ColumnSelections<ToolDataTable> conflictColumns,
    _is.ColumnSelections<ToolDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ToolDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ToolData>(
      row,
      conflictColumns: conflictColumns(ToolData.t),
      updateColumns: updateColumns?.call(ToolData.t),
      updateWhere: updateWhere?.call(ToolData.t),
      transaction: transaction,
    );
  }

  /// Updates all [ToolData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ToolData>> update(
    _is.DatabaseSession session,
    List<ToolData> rows, {
    _is.ColumnSelections<ToolDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ToolData>(
      rows,
      columns: columns?.call(ToolData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ToolData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ToolData> updateRow(
    _is.DatabaseSession session,
    ToolData row, {
    _is.ColumnSelections<ToolDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ToolData>(
      row,
      columns: columns?.call(ToolData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ToolData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ToolData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ToolDataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ToolData>(
      id,
      columnValues: columnValues(ToolData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ToolData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ToolData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ToolDataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ToolDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ToolDataTable>? orderBy,
    _is.OrderByListBuilder<ToolDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ToolData>(
      columnValues: columnValues(ToolData.t.updateTable),
      where: where(ToolData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ToolData.t),
      orderByList: orderByList?.call(ToolData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ToolData]s in the list and returns the deleted rows.
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
  Future<List<ToolData>> delete(
    _is.DatabaseSession session,
    List<ToolData> rows, {
    _is.OrderByBuilder<ToolDataTable>? orderBy,
    _is.OrderByListBuilder<ToolDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ToolData>(
      rows,
      orderBy: orderBy?.call(ToolData.t),
      orderByList: orderByList?.call(ToolData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ToolData].
  Future<ToolData> deleteRow(
    _is.DatabaseSession session,
    ToolData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ToolData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ToolData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ToolDataTable> where,
    _is.OrderByBuilder<ToolDataTable>? orderBy,
    _is.OrderByListBuilder<ToolDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ToolData>(
      where: where(ToolData.t),
      orderBy: orderBy?.call(ToolData.t),
      orderByList: orderByList?.call(ToolData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ToolDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ToolData>(
      where: where?.call(ToolData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ToolData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ToolDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ToolData>(
      where: where(ToolData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
