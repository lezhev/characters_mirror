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
import '../../data/general/feature_resource_definition_data.dart' as _i1wsflhj;

abstract class FeatureResourceProgressionValueData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FeatureResourceProgressionValueData._({
    this.id,
    this.resourceDefinitionId,
    this.resourceDefinition,
    required this.level,
    required this.value,
  });

  factory FeatureResourceProgressionValueData({
    int? id,
    int? resourceDefinitionId,
    _i1wsflhj.FeatureResourceDefinitionData? resourceDefinition,
    required int level,
    required int value,
  }) = _FeatureResourceProgressionValueDataImpl;

  factory FeatureResourceProgressionValueData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FeatureResourceProgressionValueData(
      id: jsonSerialization['id'] as int?,
      resourceDefinitionId: jsonSerialization['resourceDefinitionId'] as int?,
      resourceDefinition: jsonSerialization['resourceDefinition'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_i1wsflhj.FeatureResourceDefinitionData>(
                  jsonSerialization['resourceDefinition'],
                ),
      level: jsonSerialization['level'] as int,
      value: jsonSerialization['value'] as int,
    );
  }

  static final t = FeatureResourceProgressionValueDataTable();

  static const db = FeatureResourceProgressionValueDataRepository._();

  @override
  int? id;

  int? resourceDefinitionId;

  _i1wsflhj.FeatureResourceDefinitionData? resourceDefinition;

  int level;

  int value;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureResourceProgressionValueData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeatureResourceProgressionValueData copyWith({
    int? id,
    int? resourceDefinitionId,
    _i1wsflhj.FeatureResourceDefinitionData? resourceDefinition,
    int? level,
    int? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureResourceProgressionValueData',
      if (id != null) 'id': id,
      if (resourceDefinitionId != null)
        'resourceDefinitionId': resourceDefinitionId,
      if (resourceDefinition != null)
        'resourceDefinition': resourceDefinition?.toJson(),
      'level': level,
      'value': value,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatureResourceProgressionValueData',
      if (id != null) 'id': id,
      if (resourceDefinitionId != null)
        'resourceDefinitionId': resourceDefinitionId,
      if (resourceDefinition != null)
        'resourceDefinition': resourceDefinition?.toJsonForProtocol(),
      'level': level,
      'value': value,
    };
  }

  static FeatureResourceProgressionValueDataInclude include({
    _i1wsflhj.FeatureResourceDefinitionDataInclude? resourceDefinition,
  }) {
    return FeatureResourceProgressionValueDataInclude._(
      resourceDefinition: resourceDefinition,
    );
  }

  static FeatureResourceProgressionValueDataIncludeList includeList({
    _is.WhereExpressionBuilder<FeatureResourceProgressionValueDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureResourceProgressionValueDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceProgressionValueDataTable>?
    orderByList,
    FeatureResourceProgressionValueDataInclude? include,
  }) {
    return FeatureResourceProgressionValueDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureResourceProgressionValueData.t),
      orderByList: orderByList?.call(FeatureResourceProgressionValueData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureResourceProgressionValueDataImpl
    extends FeatureResourceProgressionValueData {
  _FeatureResourceProgressionValueDataImpl({
    int? id,
    int? resourceDefinitionId,
    _i1wsflhj.FeatureResourceDefinitionData? resourceDefinition,
    required int level,
    required int value,
  }) : super._(
         id: id,
         resourceDefinitionId: resourceDefinitionId,
         resourceDefinition: resourceDefinition,
         level: level,
         value: value,
       );

  /// Returns a shallow copy of this [FeatureResourceProgressionValueData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeatureResourceProgressionValueData copyWith({
    Object? id = _Undefined,
    Object? resourceDefinitionId = _Undefined,
    Object? resourceDefinition = _Undefined,
    int? level,
    int? value,
  }) {
    return FeatureResourceProgressionValueData(
      id: id is int? ? id : this.id,
      resourceDefinitionId: resourceDefinitionId is int?
          ? resourceDefinitionId
          : this.resourceDefinitionId,
      resourceDefinition:
          resourceDefinition is _i1wsflhj.FeatureResourceDefinitionData?
          ? resourceDefinition
          : this.resourceDefinition?.copyWith(),
      level: level ?? this.level,
      value: value ?? this.value,
    );
  }
}

class FeatureResourceProgressionValueDataUpdateTable
    extends _is.UpdateTable<FeatureResourceProgressionValueDataTable> {
  FeatureResourceProgressionValueDataUpdateTable(super.table);

  _is.ColumnValue<int, int> resourceDefinitionId(int? value) =>
      _is.ColumnValue(table.resourceDefinitionId, value);

  _is.ColumnValue<int, int> level(int value) =>
      _is.ColumnValue(table.level, value);

  _is.ColumnValue<int, int> value(int value) =>
      _is.ColumnValue(table.value, value);
}

class FeatureResourceProgressionValueDataTable extends _is.Table<int?> {
  FeatureResourceProgressionValueDataTable({super.tableRelation})
    : super(tableName: 'feature_resource_progression_value_data') {
    updateTable = FeatureResourceProgressionValueDataUpdateTable(this);
    resourceDefinitionId = _is.ColumnInt('resourceDefinitionId', this);
    level = _is.ColumnInt('level', this);
    value = _is.ColumnInt('value', this);
  }

  late final FeatureResourceProgressionValueDataUpdateTable updateTable;

  late final _is.ColumnInt resourceDefinitionId;

  _i1wsflhj.FeatureResourceDefinitionDataTable? _resourceDefinition;

  late final _is.ColumnInt level;

  late final _is.ColumnInt value;

  _i1wsflhj.FeatureResourceDefinitionDataTable get resourceDefinition {
    if (_resourceDefinition != null) return _resourceDefinition!;
    _resourceDefinition = _is.createRelationTable(
      relationFieldName: 'resourceDefinition',
      field: FeatureResourceProgressionValueData.t.resourceDefinitionId,
      foreignField: _i1wsflhj.FeatureResourceDefinitionData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i1wsflhj.FeatureResourceDefinitionDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return _resourceDefinition!;
  }

  @override
  List<_is.Column> get columns => [id, resourceDefinitionId, level, value];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'resourceDefinition') {
      return resourceDefinition;
    }
    return null;
  }
}

class FeatureResourceProgressionValueDataInclude extends _is.IncludeObject {
  FeatureResourceProgressionValueDataInclude._({
    _i1wsflhj.FeatureResourceDefinitionDataInclude? resourceDefinition,
  }) {
    _resourceDefinition = resourceDefinition;
  }

  _i1wsflhj.FeatureResourceDefinitionDataInclude? _resourceDefinition;

  @override
  Map<String, _is.Include?> get includes => {
    'resourceDefinition': _resourceDefinition,
  };

  @override
  _is.Table<int?> get table => FeatureResourceProgressionValueData.t;
}

class FeatureResourceProgressionValueDataIncludeList extends _is.IncludeList {
  FeatureResourceProgressionValueDataIncludeList._({
    _is.WhereExpressionBuilder<FeatureResourceProgressionValueDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureResourceProgressionValueData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FeatureResourceProgressionValueData.t;
}

class FeatureResourceProgressionValueDataRepository {
  const FeatureResourceProgressionValueDataRepository._();

  final attachRow =
      const FeatureResourceProgressionValueDataAttachRowRepository._();

  final detachRow =
      const FeatureResourceProgressionValueDataDetachRowRepository._();

  /// Returns a list of [FeatureResourceProgressionValueData]s matching the given query parameters.
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
  Future<List<FeatureResourceProgressionValueData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureResourceProgressionValueDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureResourceProgressionValueDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceProgressionValueDataTable>?
    orderByList,
    _is.Transaction? transaction,
    FeatureResourceProgressionValueDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeatureResourceProgressionValueData>(
      where: where?.call(FeatureResourceProgressionValueData.t),
      orderBy: orderBy?.call(FeatureResourceProgressionValueData.t),
      orderByList: orderByList?.call(FeatureResourceProgressionValueData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FeatureResourceProgressionValueData] matching the given query parameters.
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
  Future<FeatureResourceProgressionValueData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureResourceProgressionValueDataTable>? where,
    int? offset,
    _is.OrderByBuilder<FeatureResourceProgressionValueDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceProgressionValueDataTable>?
    orderByList,
    _is.Transaction? transaction,
    FeatureResourceProgressionValueDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeatureResourceProgressionValueData>(
      where: where?.call(FeatureResourceProgressionValueData.t),
      orderBy: orderBy?.call(FeatureResourceProgressionValueData.t),
      orderByList: orderByList?.call(FeatureResourceProgressionValueData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeatureResourceProgressionValueData] by its [id] or null if no such row exists.
  Future<FeatureResourceProgressionValueData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    FeatureResourceProgressionValueDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeatureResourceProgressionValueData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeatureResourceProgressionValueData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureResourceProgressionValueData]s will have their `id` fields set.
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
  Future<List<FeatureResourceProgressionValueData>> insert(
    _is.DatabaseSession session,
    List<FeatureResourceProgressionValueData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FeatureResourceProgressionValueData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FeatureResourceProgressionValueData] and returns the inserted row.
  ///
  /// The returned [FeatureResourceProgressionValueData] will have its `id` field set.
  Future<FeatureResourceProgressionValueData> insertRow(
    _is.DatabaseSession session,
    FeatureResourceProgressionValueData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureResourceProgressionValueData>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FeatureResourceProgressionValueData]s in the list and returns the resulting rows.
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
  /// The returned [FeatureResourceProgressionValueData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceProgressionValueData>> upsert(
    _is.DatabaseSession session,
    List<FeatureResourceProgressionValueData> rows, {
    required _is.ColumnSelections<FeatureResourceProgressionValueDataTable>
    conflictColumns,
    _is.ColumnSelections<FeatureResourceProgressionValueDataTable>?
    updateColumns,
    _is.WhereExpressionBuilder<FeatureResourceProgressionValueDataTable>?
    updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FeatureResourceProgressionValueData>(
      rows,
      conflictColumns: conflictColumns(FeatureResourceProgressionValueData.t),
      updateColumns: updateColumns?.call(FeatureResourceProgressionValueData.t),
      updateWhere: updateWhere?.call(FeatureResourceProgressionValueData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FeatureResourceProgressionValueData] and returns the resulting row.
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
  /// The returned [FeatureResourceProgressionValueData] will have its `id` field set.
  Future<FeatureResourceProgressionValueData?> upsertRow(
    _is.DatabaseSession session,
    FeatureResourceProgressionValueData row, {
    required _is.ColumnSelections<FeatureResourceProgressionValueDataTable>
    conflictColumns,
    _is.ColumnSelections<FeatureResourceProgressionValueDataTable>?
    updateColumns,
    _is.WhereExpressionBuilder<FeatureResourceProgressionValueDataTable>?
    updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FeatureResourceProgressionValueData>(
      row,
      conflictColumns: conflictColumns(FeatureResourceProgressionValueData.t),
      updateColumns: updateColumns?.call(FeatureResourceProgressionValueData.t),
      updateWhere: updateWhere?.call(FeatureResourceProgressionValueData.t),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureResourceProgressionValueData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceProgressionValueData>> update(
    _is.DatabaseSession session,
    List<FeatureResourceProgressionValueData> rows, {
    _is.ColumnSelections<FeatureResourceProgressionValueDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FeatureResourceProgressionValueData>(
      rows,
      columns: columns?.call(FeatureResourceProgressionValueData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FeatureResourceProgressionValueData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureResourceProgressionValueData> updateRow(
    _is.DatabaseSession session,
    FeatureResourceProgressionValueData row, {
    _is.ColumnSelections<FeatureResourceProgressionValueDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureResourceProgressionValueData>(
      row,
      columns: columns?.call(FeatureResourceProgressionValueData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureResourceProgressionValueData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeatureResourceProgressionValueData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<
      FeatureResourceProgressionValueDataUpdateTable
    >
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FeatureResourceProgressionValueData>(
      id,
      columnValues: columnValues(
        FeatureResourceProgressionValueData.t.updateTable,
      ),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureResourceProgressionValueData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceProgressionValueData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<
      FeatureResourceProgressionValueDataUpdateTable
    >
    columnValues,
    required _is.WhereExpressionBuilder<
      FeatureResourceProgressionValueDataTable
    >
    where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureResourceProgressionValueDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceProgressionValueDataTable>?
    orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FeatureResourceProgressionValueData>(
      columnValues: columnValues(
        FeatureResourceProgressionValueData.t.updateTable,
      ),
      where: where(FeatureResourceProgressionValueData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureResourceProgressionValueData.t),
      orderByList: orderByList?.call(FeatureResourceProgressionValueData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FeatureResourceProgressionValueData]s in the list and returns the deleted rows.
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
  Future<List<FeatureResourceProgressionValueData>> delete(
    _is.DatabaseSession session,
    List<FeatureResourceProgressionValueData> rows, {
    _is.OrderByBuilder<FeatureResourceProgressionValueDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceProgressionValueDataTable>?
    orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FeatureResourceProgressionValueData>(
      rows,
      orderBy: orderBy?.call(FeatureResourceProgressionValueData.t),
      orderByList: orderByList?.call(FeatureResourceProgressionValueData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FeatureResourceProgressionValueData].
  Future<FeatureResourceProgressionValueData> deleteRow(
    _is.DatabaseSession session,
    FeatureResourceProgressionValueData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureResourceProgressionValueData>(
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
  Future<List<FeatureResourceProgressionValueData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<
      FeatureResourceProgressionValueDataTable
    >
    where,
    _is.OrderByBuilder<FeatureResourceProgressionValueDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceProgressionValueDataTable>?
    orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FeatureResourceProgressionValueData>(
      where: where(FeatureResourceProgressionValueData.t),
      orderBy: orderBy?.call(FeatureResourceProgressionValueData.t),
      orderByList: orderByList?.call(FeatureResourceProgressionValueData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureResourceProgressionValueDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FeatureResourceProgressionValueData>(
      where: where?.call(FeatureResourceProgressionValueData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeatureResourceProgressionValueData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<
      FeatureResourceProgressionValueDataTable
    >
    where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeatureResourceProgressionValueData>(
      where: where(FeatureResourceProgressionValueData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class FeatureResourceProgressionValueDataAttachRowRepository {
  const FeatureResourceProgressionValueDataAttachRowRepository._();

  /// Creates a relation between the given [FeatureResourceProgressionValueData] and [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceProgressionValueData]'s foreign key `resourceDefinitionId` to refer to the [FeatureResourceDefinitionData].
  Future<void> resourceDefinition(
    _is.DatabaseSession session,
    FeatureResourceProgressionValueData featureResourceProgressionValueData,
    _i1wsflhj.FeatureResourceDefinitionData resourceDefinition, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceProgressionValueData.id == null) {
      throw ArgumentError.notNull('featureResourceProgressionValueData.id');
    }
    if (resourceDefinition.id == null) {
      throw ArgumentError.notNull('resourceDefinition.id');
    }

    var $featureResourceProgressionValueData =
        featureResourceProgressionValueData.copyWith(
          resourceDefinitionId: resourceDefinition.id,
        );
    await session.db.updateRow<FeatureResourceProgressionValueData>(
      $featureResourceProgressionValueData,
      columns: [FeatureResourceProgressionValueData.t.resourceDefinitionId],
      transaction: transaction,
    );
  }
}

class FeatureResourceProgressionValueDataDetachRowRepository {
  const FeatureResourceProgressionValueDataDetachRowRepository._();

  /// Detaches the relation between this [FeatureResourceProgressionValueData] and the [FeatureResourceDefinitionData] set in `resourceDefinition`
  /// by setting the [FeatureResourceProgressionValueData]'s foreign key `resourceDefinitionId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resourceDefinition(
    _is.DatabaseSession session,
    FeatureResourceProgressionValueData featureResourceProgressionValueData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceProgressionValueData.id == null) {
      throw ArgumentError.notNull('featureResourceProgressionValueData.id');
    }

    var $featureResourceProgressionValueData =
        featureResourceProgressionValueData.copyWith(
          resourceDefinitionId: null,
        );
    await session.db.updateRow<FeatureResourceProgressionValueData>(
      $featureResourceProgressionValueData,
      columns: [FeatureResourceProgressionValueData.t.resourceDefinitionId],
      transaction: transaction,
    );
  }
}
