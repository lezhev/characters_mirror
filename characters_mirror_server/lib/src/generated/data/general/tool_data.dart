/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../enums/tool_category.dart' as _i2;

abstract class ToolData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    _i2.ToolCategory? category,
  }) = _ToolDataImpl;

  factory ToolData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ToolData(
      id: jsonSerialization['id'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String,
      name: jsonSerialization['name'] as String,
      category: jsonSerialization['category'] == null
          ? null
          : _i2.ToolCategory.fromJson((jsonSerialization['category'] as int)),
    );
  }

  static final t = ToolDataTable();

  static const db = ToolDataRepository._();

  @override
  int? id;

  String referenceKey;

  String name;

  _i2.ToolCategory? category;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ToolData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ToolData copyWith({
    int? id,
    String? referenceKey,
    String? name,
    _i2.ToolCategory? category,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'referenceKey': referenceKey,
      'name': name,
      if (category != null) 'category': category?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
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
    _i1.WhereExpressionBuilder<ToolDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ToolDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ToolDataTable>? orderByList,
    ToolDataInclude? include,
  }) {
    return ToolDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ToolData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ToolData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ToolDataImpl extends ToolData {
  _ToolDataImpl({
    int? id,
    required String referenceKey,
    required String name,
    _i2.ToolCategory? category,
  }) : super._(
          id: id,
          referenceKey: referenceKey,
          name: name,
          category: category,
        );

  /// Returns a shallow copy of this [ToolData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
      category: category is _i2.ToolCategory? ? category : this.category,
    );
  }
}

class ToolDataTable extends _i1.Table<int?> {
  ToolDataTable({super.tableRelation}) : super(tableName: 'tool_data') {
    referenceKey = _i1.ColumnString(
      'referenceKey',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    category = _i1.ColumnEnum(
      'category',
      this,
      _i1.EnumSerialization.byIndex,
    );
  }

  late final _i1.ColumnString referenceKey;

  late final _i1.ColumnString name;

  late final _i1.ColumnEnum<_i2.ToolCategory> category;

  @override
  List<_i1.Column> get columns => [
        id,
        referenceKey,
        name,
        category,
      ];
}

class ToolDataInclude extends _i1.IncludeObject {
  ToolDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ToolData.t;
}

class ToolDataIncludeList extends _i1.IncludeList {
  ToolDataIncludeList._({
    _i1.WhereExpressionBuilder<ToolDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ToolData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ToolData.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ToolDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ToolDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ToolDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ToolData>(
      where: where?.call(ToolData.t),
      orderBy: orderBy?.call(ToolData.t),
      orderByList: orderByList?.call(ToolData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ToolDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ToolDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ToolDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ToolData>(
      where: where?.call(ToolData.t),
      orderBy: orderBy?.call(ToolData.t),
      orderByList: orderByList?.call(ToolData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ToolData] by its [id] or null if no such row exists.
  Future<ToolData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ToolData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ToolData]s in the list and returns the inserted rows.
  ///
  /// The returned [ToolData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ToolData>> insert(
    _i1.Session session,
    List<ToolData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ToolData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ToolData] and returns the inserted row.
  ///
  /// The returned [ToolData] will have its `id` field set.
  Future<ToolData> insertRow(
    _i1.Session session,
    ToolData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ToolData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ToolData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ToolData>> update(
    _i1.Session session,
    List<ToolData> rows, {
    _i1.ColumnSelections<ToolDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ToolData>(
      rows,
      columns: columns?.call(ToolData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ToolData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ToolData> updateRow(
    _i1.Session session,
    ToolData row, {
    _i1.ColumnSelections<ToolDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ToolData>(
      row,
      columns: columns?.call(ToolData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ToolData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ToolData>> delete(
    _i1.Session session,
    List<ToolData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ToolData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ToolData].
  Future<ToolData> deleteRow(
    _i1.Session session,
    ToolData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ToolData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ToolData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ToolDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ToolData>(
      where: where(ToolData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ToolDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ToolData>(
      where: where?.call(ToolData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
