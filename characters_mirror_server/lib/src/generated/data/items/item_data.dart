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

abstract class ItemData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ItemData._({
    this.id,
    this.referenceKey,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.weight,
    this.cost,
    this.effects,
  });

  factory ItemData({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    double? weight,
    int? cost,
    List<String>? effects,
  }) = _ItemDataImpl;

  factory ItemData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ItemData(
      id: jsonSerialization['id'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      category: jsonSerialization['category'] as String?,
      weight: (jsonSerialization['weight'] as num?)?.toDouble(),
      cost: jsonSerialization['cost'] as int?,
      effects: jsonSerialization['effects'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['effects'],
            ),
    );
  }

  static final t = ItemDataTable();

  static const db = ItemDataRepository._();

  @override
  int? id;

  String? referenceKey;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  String? category;

  double? weight;

  int? cost;

  List<String>? effects;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ItemData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ItemData copyWith({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    double? weight,
    int? cost,
    List<String>? effects,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ItemData',
      if (id != null) 'id': id,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (category != null) 'category': category,
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
      if (effects != null) 'effects': effects?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ItemData',
      if (id != null) 'id': id,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (category != null) 'category': category,
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
      if (effects != null) 'effects': effects?.toJson(),
    };
  }

  static ItemDataInclude include() {
    return ItemDataInclude._();
  }

  static ItemDataIncludeList includeList({
    _is.WhereExpressionBuilder<ItemDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ItemDataTable>? orderBy,
    _is.OrderByListBuilder<ItemDataTable>? orderByList,
    ItemDataInclude? include,
  }) {
    return ItemDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ItemData.t),
      orderByList: orderByList?.call(ItemData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ItemDataImpl extends ItemData {
  _ItemDataImpl({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    double? weight,
    int? cost,
    List<String>? effects,
  }) : super._(
         id: id,
         referenceKey: referenceKey,
         name: name,
         description: description,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
         category: category,
         weight: weight,
         cost: cost,
         effects: effects,
       );

  /// Returns a shallow copy of this [ItemData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ItemData copyWith({
    Object? id = _Undefined,
    Object? referenceKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? category = _Undefined,
    Object? weight = _Undefined,
    Object? cost = _Undefined,
    Object? effects = _Undefined,
  }) {
    return ItemData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      category: category is String? ? category : this.category,
      weight: weight is double? ? weight : this.weight,
      cost: cost is int? ? cost : this.cost,
      effects: effects is List<String>?
          ? effects
          : this.effects?.map((e0) => e0).toList(),
    );
  }
}

class ItemDataUpdateTable extends _is.UpdateTable<ItemDataTable> {
  ItemDataUpdateTable(super.table);

  _is.ColumnValue<String, String> referenceKey(String? value) =>
      _is.ColumnValue(table.referenceKey, value);

  _is.ColumnValue<String, String> name(String? value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);

  _is.ColumnValue<String, String> category(String? value) =>
      _is.ColumnValue(table.category, value);

  _is.ColumnValue<double, double> weight(double? value) =>
      _is.ColumnValue(table.weight, value);

  _is.ColumnValue<int, int> cost(int? value) =>
      _is.ColumnValue(table.cost, value);

  _is.ColumnValue<List<String>, List<String>> effects(List<String>? value) =>
      _is.ColumnValue(table.effects, value);
}

class ItemDataTable extends _is.Table<int?> {
  ItemDataTable({super.tableRelation}) : super(tableName: 'item_data') {
    updateTable = ItemDataUpdateTable(this);
    referenceKey = _is.ColumnString('referenceKey', this);
    name = _is.ColumnString('name', this);
    description = _is.ColumnString('description', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    category = _is.ColumnString('category', this);
    weight = _is.ColumnDouble('weight', this);
    cost = _is.ColumnInt('cost', this);
    effects = _is.ColumnSerializable<List<String>>('effects', this);
  }

  late final ItemDataUpdateTable updateTable;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnString category;

  late final _is.ColumnDouble weight;

  late final _is.ColumnInt cost;

  late final _is.ColumnSerializable<List<String>> effects;

  @override
  List<_is.Column> get columns => [
    id,
    referenceKey,
    name,
    description,
    source,
    version,
    createdAt,
    updatedAt,
    category,
    weight,
    cost,
    effects,
  ];
}

class ItemDataInclude extends _is.IncludeObject {
  ItemDataInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ItemData.t;
}

class ItemDataIncludeList extends _is.IncludeList {
  ItemDataIncludeList._({
    _is.WhereExpressionBuilder<ItemDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ItemData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ItemData.t;
}

class ItemDataRepository {
  const ItemDataRepository._();

  /// Returns a list of [ItemData]s matching the given query parameters.
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
  Future<List<ItemData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ItemDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ItemDataTable>? orderBy,
    _is.OrderByListBuilder<ItemDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ItemData>(
      where: where?.call(ItemData.t),
      orderBy: orderBy?.call(ItemData.t),
      orderByList: orderByList?.call(ItemData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ItemData] matching the given query parameters.
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
  Future<ItemData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ItemDataTable>? where,
    int? offset,
    _is.OrderByBuilder<ItemDataTable>? orderBy,
    _is.OrderByListBuilder<ItemDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ItemData>(
      where: where?.call(ItemData.t),
      orderBy: orderBy?.call(ItemData.t),
      orderByList: orderByList?.call(ItemData.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ItemData] by its [id] or null if no such row exists.
  Future<ItemData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ItemData>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ItemData]s in the list and returns the inserted rows.
  ///
  /// The returned [ItemData]s will have their `id` fields set.
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
  Future<List<ItemData>> insert(
    _is.DatabaseSession session,
    List<ItemData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ItemData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ItemData] and returns the inserted row.
  ///
  /// The returned [ItemData] will have its `id` field set.
  Future<ItemData> insertRow(
    _is.DatabaseSession session,
    ItemData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ItemData>(row, transaction: transaction);
  }

  /// Upserts all [ItemData]s in the list and returns the resulting rows.
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
  /// The returned [ItemData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ItemData>> upsert(
    _is.DatabaseSession session,
    List<ItemData> rows, {
    required _is.ColumnSelections<ItemDataTable> conflictColumns,
    _is.ColumnSelections<ItemDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ItemDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ItemData>(
      rows,
      conflictColumns: conflictColumns(ItemData.t),
      updateColumns: updateColumns?.call(ItemData.t),
      updateWhere: updateWhere?.call(ItemData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ItemData] and returns the resulting row.
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
  /// The returned [ItemData] will have its `id` field set.
  Future<ItemData?> upsertRow(
    _is.DatabaseSession session,
    ItemData row, {
    required _is.ColumnSelections<ItemDataTable> conflictColumns,
    _is.ColumnSelections<ItemDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ItemDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ItemData>(
      row,
      conflictColumns: conflictColumns(ItemData.t),
      updateColumns: updateColumns?.call(ItemData.t),
      updateWhere: updateWhere?.call(ItemData.t),
      transaction: transaction,
    );
  }

  /// Updates all [ItemData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ItemData>> update(
    _is.DatabaseSession session,
    List<ItemData> rows, {
    _is.ColumnSelections<ItemDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ItemData>(
      rows,
      columns: columns?.call(ItemData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ItemData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ItemData> updateRow(
    _is.DatabaseSession session,
    ItemData row, {
    _is.ColumnSelections<ItemDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ItemData>(
      row,
      columns: columns?.call(ItemData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ItemData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ItemData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ItemDataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ItemData>(
      id,
      columnValues: columnValues(ItemData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ItemData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ItemData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ItemDataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ItemDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ItemDataTable>? orderBy,
    _is.OrderByListBuilder<ItemDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ItemData>(
      columnValues: columnValues(ItemData.t.updateTable),
      where: where(ItemData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ItemData.t),
      orderByList: orderByList?.call(ItemData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ItemData]s in the list and returns the deleted rows.
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
  Future<List<ItemData>> delete(
    _is.DatabaseSession session,
    List<ItemData> rows, {
    _is.OrderByBuilder<ItemDataTable>? orderBy,
    _is.OrderByListBuilder<ItemDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ItemData>(
      rows,
      orderBy: orderBy?.call(ItemData.t),
      orderByList: orderByList?.call(ItemData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ItemData].
  Future<ItemData> deleteRow(
    _is.DatabaseSession session,
    ItemData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ItemData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ItemData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ItemDataTable> where,
    _is.OrderByBuilder<ItemDataTable>? orderBy,
    _is.OrderByListBuilder<ItemDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ItemData>(
      where: where(ItemData.t),
      orderBy: orderBy?.call(ItemData.t),
      orderByList: orderByList?.call(ItemData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ItemDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ItemData>(
      where: where?.call(ItemData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ItemData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ItemDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ItemData>(
      where: where(ItemData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
