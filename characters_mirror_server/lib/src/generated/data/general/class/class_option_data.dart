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

abstract class ClassOptionData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ClassOptionData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.parentClassId,
    this.levelRequired,
    this.type,
    this.isOptional,
  }) : _charactersVariantoptionsCharactersId = null;

  factory ClassOptionData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<int>? parentClassId,
    int? levelRequired,
    String? type,
    bool? isOptional,
  }) = _ClassOptionDataImpl;

  factory ClassOptionData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassOptionDataImplicit._(
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
      parentClassId: (jsonSerialization['parentClassId'] as List?)
          ?.map((e) => e as int)
          .toList(),
      levelRequired: jsonSerialization['levelRequired'] as int?,
      type: jsonSerialization['type'] as String?,
      isOptional: jsonSerialization['isOptional'] as bool?,
      $_charactersVariantoptionsCharactersId:
          jsonSerialization['_charactersVariantoptionsCharactersId'] as int?,
    );
  }

  static final t = ClassOptionDataTable();

  static const db = ClassOptionDataRepository._();

  @override
  int? id;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  List<int>? parentClassId;

  int? levelRequired;

  String? type;

  bool? isOptional;

  final int? _charactersVariantoptionsCharactersId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClassOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassOptionData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<int>? parentClassId,
    int? levelRequired,
    String? type,
    bool? isOptional,
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
      if (parentClassId != null) 'parentClassId': parentClassId?.toJson(),
      if (levelRequired != null) 'levelRequired': levelRequired,
      if (type != null) 'type': type,
      if (isOptional != null) 'isOptional': isOptional,
      if (_charactersVariantoptionsCharactersId != null)
        '_charactersVariantoptionsCharactersId':
            _charactersVariantoptionsCharactersId,
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
      if (parentClassId != null) 'parentClassId': parentClassId?.toJson(),
      if (levelRequired != null) 'levelRequired': levelRequired,
      if (type != null) 'type': type,
      if (isOptional != null) 'isOptional': isOptional,
    };
  }

  static ClassOptionDataInclude include() {
    return ClassOptionDataInclude._();
  }

  static ClassOptionDataIncludeList includeList({
    _i1.WhereExpressionBuilder<ClassOptionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassOptionDataTable>? orderByList,
    ClassOptionDataInclude? include,
  }) {
    return ClassOptionDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassOptionData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ClassOptionData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassOptionDataImpl extends ClassOptionData {
  _ClassOptionDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<int>? parentClassId,
    int? levelRequired,
    String? type,
    bool? isOptional,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          parentClassId: parentClassId,
          levelRequired: levelRequired,
          type: type,
          isOptional: isOptional,
        );

  /// Returns a shallow copy of this [ClassOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassOptionData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? parentClassId = _Undefined,
    Object? levelRequired = _Undefined,
    Object? type = _Undefined,
    Object? isOptional = _Undefined,
  }) {
    return ClassOptionDataImplicit._(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      parentClassId: parentClassId is List<int>?
          ? parentClassId
          : this.parentClassId?.map((e0) => e0).toList(),
      levelRequired: levelRequired is int? ? levelRequired : this.levelRequired,
      type: type is String? ? type : this.type,
      isOptional: isOptional is bool? ? isOptional : this.isOptional,
      $_charactersVariantoptionsCharactersId:
          this._charactersVariantoptionsCharactersId,
    );
  }
}

class ClassOptionDataImplicit extends _ClassOptionDataImpl {
  ClassOptionDataImplicit._({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<int>? parentClassId,
    int? levelRequired,
    String? type,
    bool? isOptional,
    int? $_charactersVariantoptionsCharactersId,
  })  : _charactersVariantoptionsCharactersId =
            $_charactersVariantoptionsCharactersId,
        super(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          parentClassId: parentClassId,
          levelRequired: levelRequired,
          type: type,
          isOptional: isOptional,
        );

  factory ClassOptionDataImplicit(
    ClassOptionData classOptionData, {
    int? $_charactersVariantoptionsCharactersId,
  }) {
    return ClassOptionDataImplicit._(
      id: classOptionData.id,
      name: classOptionData.name,
      description: classOptionData.description,
      source: classOptionData.source,
      version: classOptionData.version,
      createdAt: classOptionData.createdAt,
      updatedAt: classOptionData.updatedAt,
      parentClassId: classOptionData.parentClassId,
      levelRequired: classOptionData.levelRequired,
      type: classOptionData.type,
      isOptional: classOptionData.isOptional,
      $_charactersVariantoptionsCharactersId:
          $_charactersVariantoptionsCharactersId,
    );
  }

  @override
  final int? _charactersVariantoptionsCharactersId;
}

class ClassOptionDataTable extends _i1.Table<int?> {
  ClassOptionDataTable({super.tableRelation})
      : super(tableName: 'class_option_data') {
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
    parentClassId = _i1.ColumnSerializable(
      'parentClassId',
      this,
    );
    levelRequired = _i1.ColumnInt(
      'levelRequired',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    isOptional = _i1.ColumnBool(
      'isOptional',
      this,
    );
    $_charactersVariantoptionsCharactersId = _i1.ColumnInt(
      '_charactersVariantoptionsCharactersId',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnSerializable parentClassId;

  late final _i1.ColumnInt levelRequired;

  late final _i1.ColumnString type;

  late final _i1.ColumnBool isOptional;

  late final _i1.ColumnInt $_charactersVariantoptionsCharactersId;

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
        type,
        isOptional,
        $_charactersVariantoptionsCharactersId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        parentClassId,
        levelRequired,
        type,
        isOptional,
      ];
}

class ClassOptionDataInclude extends _i1.IncludeObject {
  ClassOptionDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ClassOptionData.t;
}

class ClassOptionDataIncludeList extends _i1.IncludeList {
  ClassOptionDataIncludeList._({
    _i1.WhereExpressionBuilder<ClassOptionDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClassOptionData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ClassOptionData.t;
}

class ClassOptionDataRepository {
  const ClassOptionDataRepository._();

  /// Returns a list of [ClassOptionData]s matching the given query parameters.
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
  Future<List<ClassOptionData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassOptionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassOptionDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ClassOptionData>(
      where: where?.call(ClassOptionData.t),
      orderBy: orderBy?.call(ClassOptionData.t),
      orderByList: orderByList?.call(ClassOptionData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ClassOptionData] matching the given query parameters.
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
  Future<ClassOptionData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassOptionDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClassOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassOptionDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ClassOptionData>(
      where: where?.call(ClassOptionData.t),
      orderBy: orderBy?.call(ClassOptionData.t),
      orderByList: orderByList?.call(ClassOptionData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ClassOptionData] by its [id] or null if no such row exists.
  Future<ClassOptionData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ClassOptionData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ClassOptionData]s in the list and returns the inserted rows.
  ///
  /// The returned [ClassOptionData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ClassOptionData>> insert(
    _i1.Session session,
    List<ClassOptionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ClassOptionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ClassOptionData] and returns the inserted row.
  ///
  /// The returned [ClassOptionData] will have its `id` field set.
  Future<ClassOptionData> insertRow(
    _i1.Session session,
    ClassOptionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClassOptionData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ClassOptionData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ClassOptionData>> update(
    _i1.Session session,
    List<ClassOptionData> rows, {
    _i1.ColumnSelections<ClassOptionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ClassOptionData>(
      rows,
      columns: columns?.call(ClassOptionData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClassOptionData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClassOptionData> updateRow(
    _i1.Session session,
    ClassOptionData row, {
    _i1.ColumnSelections<ClassOptionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClassOptionData>(
      row,
      columns: columns?.call(ClassOptionData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ClassOptionData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ClassOptionData>> delete(
    _i1.Session session,
    List<ClassOptionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ClassOptionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ClassOptionData].
  Future<ClassOptionData> deleteRow(
    _i1.Session session,
    ClassOptionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClassOptionData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ClassOptionData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClassOptionDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ClassOptionData>(
      where: where(ClassOptionData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassOptionDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ClassOptionData>(
      where: where?.call(ClassOptionData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
