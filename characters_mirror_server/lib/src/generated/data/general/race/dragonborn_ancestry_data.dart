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

abstract class DragonbornAncestryData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DragonbornAncestryData._({
    this.id,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.damageType,
    this.breathShape,
    this.area,
    this.damageByLevel,
  });

  factory DragonbornAncestryData({
    int? id,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? damageType,
    String? breathShape,
    String? area,
    Map<String, String>? damageByLevel,
  }) = _DragonbornAncestryDataImpl;

  factory DragonbornAncestryData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return DragonbornAncestryData(
      id: jsonSerialization['id'] as int?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      name: jsonSerialization['name'] as String?,
      damageType: jsonSerialization['damageType'] as String?,
      breathShape: jsonSerialization['breathShape'] as String?,
      area: jsonSerialization['area'] as String?,
      damageByLevel:
          (jsonSerialization['damageByLevel'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as String,
              )),
    );
  }

  static final t = DragonbornAncestryDataTable();

  static const db = DragonbornAncestryDataRepository._();

  @override
  int? id;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  String? name;

  String? damageType;

  String? breathShape;

  String? area;

  Map<String, String>? damageByLevel;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DragonbornAncestryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DragonbornAncestryData copyWith({
    int? id,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? damageType,
    String? breathShape,
    String? area,
    Map<String, String>? damageByLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (name != null) 'name': name,
      if (damageType != null) 'damageType': damageType,
      if (breathShape != null) 'breathShape': breathShape,
      if (area != null) 'area': area,
      if (damageByLevel != null) 'damageByLevel': damageByLevel?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (name != null) 'name': name,
      if (damageType != null) 'damageType': damageType,
      if (breathShape != null) 'breathShape': breathShape,
      if (area != null) 'area': area,
      if (damageByLevel != null) 'damageByLevel': damageByLevel?.toJson(),
    };
  }

  static DragonbornAncestryDataInclude include() {
    return DragonbornAncestryDataInclude._();
  }

  static DragonbornAncestryDataIncludeList includeList({
    _i1.WhereExpressionBuilder<DragonbornAncestryDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DragonbornAncestryDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DragonbornAncestryDataTable>? orderByList,
    DragonbornAncestryDataInclude? include,
  }) {
    return DragonbornAncestryDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DragonbornAncestryData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DragonbornAncestryData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DragonbornAncestryDataImpl extends DragonbornAncestryData {
  _DragonbornAncestryDataImpl({
    int? id,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? damageType,
    String? breathShape,
    String? area,
    Map<String, String>? damageByLevel,
  }) : super._(
          id: id,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          name: name,
          damageType: damageType,
          breathShape: breathShape,
          area: area,
          damageByLevel: damageByLevel,
        );

  /// Returns a shallow copy of this [DragonbornAncestryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DragonbornAncestryData copyWith({
    Object? id = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? name = _Undefined,
    Object? damageType = _Undefined,
    Object? breathShape = _Undefined,
    Object? area = _Undefined,
    Object? damageByLevel = _Undefined,
  }) {
    return DragonbornAncestryData(
      id: id is int? ? id : this.id,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      name: name is String? ? name : this.name,
      damageType: damageType is String? ? damageType : this.damageType,
      breathShape: breathShape is String? ? breathShape : this.breathShape,
      area: area is String? ? area : this.area,
      damageByLevel: damageByLevel is Map<String, String>?
          ? damageByLevel
          : this.damageByLevel?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
    );
  }
}

class DragonbornAncestryDataTable extends _i1.Table<int?> {
  DragonbornAncestryDataTable({super.tableRelation})
      : super(tableName: 'dragonborn_ancestry_data') {
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
    name = _i1.ColumnString(
      'name',
      this,
    );
    damageType = _i1.ColumnString(
      'damageType',
      this,
    );
    breathShape = _i1.ColumnString(
      'breathShape',
      this,
    );
    area = _i1.ColumnString(
      'area',
      this,
    );
    damageByLevel = _i1.ColumnSerializable(
      'damageByLevel',
      this,
    );
  }

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnString name;

  late final _i1.ColumnString damageType;

  late final _i1.ColumnString breathShape;

  late final _i1.ColumnString area;

  late final _i1.ColumnSerializable damageByLevel;

  @override
  List<_i1.Column> get columns => [
        id,
        source,
        version,
        createdAt,
        updatedAt,
        name,
        damageType,
        breathShape,
        area,
        damageByLevel,
      ];
}

class DragonbornAncestryDataInclude extends _i1.IncludeObject {
  DragonbornAncestryDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DragonbornAncestryData.t;
}

class DragonbornAncestryDataIncludeList extends _i1.IncludeList {
  DragonbornAncestryDataIncludeList._({
    _i1.WhereExpressionBuilder<DragonbornAncestryDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DragonbornAncestryData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DragonbornAncestryData.t;
}

class DragonbornAncestryDataRepository {
  const DragonbornAncestryDataRepository._();

  /// Returns a list of [DragonbornAncestryData]s matching the given query parameters.
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
  Future<List<DragonbornAncestryData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DragonbornAncestryDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DragonbornAncestryDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DragonbornAncestryDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DragonbornAncestryData>(
      where: where?.call(DragonbornAncestryData.t),
      orderBy: orderBy?.call(DragonbornAncestryData.t),
      orderByList: orderByList?.call(DragonbornAncestryData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DragonbornAncestryData] matching the given query parameters.
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
  Future<DragonbornAncestryData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DragonbornAncestryDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<DragonbornAncestryDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DragonbornAncestryDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DragonbornAncestryData>(
      where: where?.call(DragonbornAncestryData.t),
      orderBy: orderBy?.call(DragonbornAncestryData.t),
      orderByList: orderByList?.call(DragonbornAncestryData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DragonbornAncestryData] by its [id] or null if no such row exists.
  Future<DragonbornAncestryData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DragonbornAncestryData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DragonbornAncestryData]s in the list and returns the inserted rows.
  ///
  /// The returned [DragonbornAncestryData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DragonbornAncestryData>> insert(
    _i1.Session session,
    List<DragonbornAncestryData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DragonbornAncestryData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DragonbornAncestryData] and returns the inserted row.
  ///
  /// The returned [DragonbornAncestryData] will have its `id` field set.
  Future<DragonbornAncestryData> insertRow(
    _i1.Session session,
    DragonbornAncestryData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DragonbornAncestryData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DragonbornAncestryData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DragonbornAncestryData>> update(
    _i1.Session session,
    List<DragonbornAncestryData> rows, {
    _i1.ColumnSelections<DragonbornAncestryDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DragonbornAncestryData>(
      rows,
      columns: columns?.call(DragonbornAncestryData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DragonbornAncestryData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DragonbornAncestryData> updateRow(
    _i1.Session session,
    DragonbornAncestryData row, {
    _i1.ColumnSelections<DragonbornAncestryDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DragonbornAncestryData>(
      row,
      columns: columns?.call(DragonbornAncestryData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [DragonbornAncestryData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DragonbornAncestryData>> delete(
    _i1.Session session,
    List<DragonbornAncestryData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DragonbornAncestryData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DragonbornAncestryData].
  Future<DragonbornAncestryData> deleteRow(
    _i1.Session session,
    DragonbornAncestryData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DragonbornAncestryData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DragonbornAncestryData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DragonbornAncestryDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DragonbornAncestryData>(
      where: where(DragonbornAncestryData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DragonbornAncestryDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DragonbornAncestryData>(
      where: where?.call(DragonbornAncestryData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
