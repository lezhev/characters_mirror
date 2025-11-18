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
import '../../../data/general/class/class_data.dart' as _i2;

abstract class SubclassData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubclassData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    required this.parentClassId,
    this.parentClass,
    this.levelRequired,
  });

  factory SubclassData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    required int parentClassId,
    _i2.ClassData? parentClass,
    int? levelRequired,
  }) = _SubclassDataImpl;

  factory SubclassData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubclassData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      parentClassId: jsonSerialization['parentClassId'] as int,
      parentClass: jsonSerialization['parentClass'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['parentClass'] as Map<String, dynamic>)),
      levelRequired: jsonSerialization['levelRequired'] as int?,
    );
  }

  static final t = SubclassDataTable();

  static const db = SubclassDataRepository._();

  @override
  int? id;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int parentClassId;

  _i2.ClassData? parentClass;

  int? levelRequired;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubclassData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubclassData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? parentClassId,
    _i2.ClassData? parentClass,
    int? levelRequired,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJson(),
      if (levelRequired != null) 'levelRequired': levelRequired,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJsonForProtocol(),
      if (levelRequired != null) 'levelRequired': levelRequired,
    };
  }

  static SubclassDataInclude include({_i2.ClassDataInclude? parentClass}) {
    return SubclassDataInclude._(parentClass: parentClass);
  }

  static SubclassDataIncludeList includeList({
    _i1.WhereExpressionBuilder<SubclassDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubclassDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubclassDataTable>? orderByList,
    SubclassDataInclude? include,
  }) {
    return SubclassDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubclassData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubclassData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubclassDataImpl extends SubclassData {
  _SubclassDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    required int parentClassId,
    _i2.ClassData? parentClass,
    int? levelRequired,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          parentClassId: parentClassId,
          parentClass: parentClass,
          levelRequired: levelRequired,
        );

  /// Returns a shallow copy of this [SubclassData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubclassData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    int? parentClassId,
    Object? parentClass = _Undefined,
    Object? levelRequired = _Undefined,
  }) {
    return SubclassData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      parentClassId: parentClassId ?? this.parentClassId,
      parentClass: parentClass is _i2.ClassData?
          ? parentClass
          : this.parentClass?.copyWith(),
      levelRequired: levelRequired is int? ? levelRequired : this.levelRequired,
    );
  }
}

class SubclassDataTable extends _i1.Table<int?> {
  SubclassDataTable({super.tableRelation}) : super(tableName: 'subclass_data') {
    name = _i1.ColumnString(
      'name',
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
    parentClassId = _i1.ColumnInt(
      'parentClassId',
      this,
    );
    levelRequired = _i1.ColumnInt(
      'levelRequired',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt parentClassId;

  _i2.ClassDataTable? _parentClass;

  late final _i1.ColumnInt levelRequired;

  _i2.ClassDataTable get parentClass {
    if (_parentClass != null) return _parentClass!;
    _parentClass = _i1.createRelationTable(
      relationFieldName: 'parentClass',
      field: SubclassData.t.parentClassId,
      foreignField: _i2.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _parentClass!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        parentClassId,
        levelRequired,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'parentClass') {
      return parentClass;
    }
    return null;
  }
}

class SubclassDataInclude extends _i1.IncludeObject {
  SubclassDataInclude._({_i2.ClassDataInclude? parentClass}) {
    _parentClass = parentClass;
  }

  _i2.ClassDataInclude? _parentClass;

  @override
  Map<String, _i1.Include?> get includes => {'parentClass': _parentClass};

  @override
  _i1.Table<int?> get table => SubclassData.t;
}

class SubclassDataIncludeList extends _i1.IncludeList {
  SubclassDataIncludeList._({
    _i1.WhereExpressionBuilder<SubclassDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubclassData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubclassData.t;
}

class SubclassDataRepository {
  const SubclassDataRepository._();

  final attachRow = const SubclassDataAttachRowRepository._();

  /// Returns a list of [SubclassData]s matching the given query parameters.
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
  Future<List<SubclassData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubclassDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubclassDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubclassDataTable>? orderByList,
    _i1.Transaction? transaction,
    SubclassDataInclude? include,
  }) async {
    return session.db.find<SubclassData>(
      where: where?.call(SubclassData.t),
      orderBy: orderBy?.call(SubclassData.t),
      orderByList: orderByList?.call(SubclassData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SubclassData] matching the given query parameters.
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
  Future<SubclassData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubclassDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubclassDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubclassDataTable>? orderByList,
    _i1.Transaction? transaction,
    SubclassDataInclude? include,
  }) async {
    return session.db.findFirstRow<SubclassData>(
      where: where?.call(SubclassData.t),
      orderBy: orderBy?.call(SubclassData.t),
      orderByList: orderByList?.call(SubclassData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SubclassData] by its [id] or null if no such row exists.
  Future<SubclassData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SubclassDataInclude? include,
  }) async {
    return session.db.findById<SubclassData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SubclassData]s in the list and returns the inserted rows.
  ///
  /// The returned [SubclassData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SubclassData>> insert(
    _i1.Session session,
    List<SubclassData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SubclassData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SubclassData] and returns the inserted row.
  ///
  /// The returned [SubclassData] will have its `id` field set.
  Future<SubclassData> insertRow(
    _i1.Session session,
    SubclassData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubclassData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubclassData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubclassData>> update(
    _i1.Session session,
    List<SubclassData> rows, {
    _i1.ColumnSelections<SubclassDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubclassData>(
      rows,
      columns: columns?.call(SubclassData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubclassData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubclassData> updateRow(
    _i1.Session session,
    SubclassData row, {
    _i1.ColumnSelections<SubclassDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubclassData>(
      row,
      columns: columns?.call(SubclassData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SubclassData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubclassData>> delete(
    _i1.Session session,
    List<SubclassData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubclassData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubclassData].
  Future<SubclassData> deleteRow(
    _i1.Session session,
    SubclassData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubclassData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubclassData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SubclassDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubclassData>(
      where: where(SubclassData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubclassDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubclassData>(
      where: where?.call(SubclassData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SubclassDataAttachRowRepository {
  const SubclassDataAttachRowRepository._();

  /// Creates a relation between the given [SubclassData] and [ClassData]
  /// by setting the [SubclassData]'s foreign key `parentClassId` to refer to the [ClassData].
  Future<void> parentClass(
    _i1.Session session,
    SubclassData subclassData,
    _i2.ClassData parentClass, {
    _i1.Transaction? transaction,
  }) async {
    if (subclassData.id == null) {
      throw ArgumentError.notNull('subclassData.id');
    }
    if (parentClass.id == null) {
      throw ArgumentError.notNull('parentClass.id');
    }

    var $subclassData = subclassData.copyWith(parentClassId: parentClass.id);
    await session.db.updateRow<SubclassData>(
      $subclassData,
      columns: [SubclassData.t.parentClassId],
      transaction: transaction,
    );
  }
}
