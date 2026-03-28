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
import '../../../enums/feature_tag.dart' as _i3;

abstract class ClassFeatureData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ClassFeatureData._({
    this.id,
    required this.parentClassId,
    this.parentClass,
    this.name,
    this.description,
    required this.level,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.tags,
    this.choiceGroupKey,
  });

  factory ClassFeatureData({
    int? id,
    required int parentClassId,
    _i2.ClassData? parentClass,
    String? name,
    String? description,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i3.FeatureTag>? tags,
    String? choiceGroupKey,
  }) = _ClassFeatureDataImpl;

  factory ClassFeatureData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassFeatureData(
      id: jsonSerialization['id'] as int?,
      parentClassId: jsonSerialization['parentClassId'] as int,
      parentClass: jsonSerialization['parentClass'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['parentClass'] as Map<String, dynamic>)),
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      level: jsonSerialization['level'] as int,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => _i3.FeatureTag.fromJson((e as int)))
          .toList(),
      choiceGroupKey: jsonSerialization['choiceGroupKey'] as String?,
    );
  }

  static final t = ClassFeatureDataTable();

  static const db = ClassFeatureDataRepository._();

  @override
  int? id;

  int parentClassId;

  _i2.ClassData? parentClass;

  String? name;

  String? description;

  int level;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  List<_i3.FeatureTag>? tags;

  String? choiceGroupKey;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassFeatureData copyWith({
    int? id,
    int? parentClassId,
    _i2.ClassData? parentClass,
    String? name,
    String? description,
    int? level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i3.FeatureTag>? tags,
    String? choiceGroupKey,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJson(),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      'level': level,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (choiceGroupKey != null) 'choiceGroupKey': choiceGroupKey,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJsonForProtocol(),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      'level': level,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (choiceGroupKey != null) 'choiceGroupKey': choiceGroupKey,
    };
  }

  static ClassFeatureDataInclude include({_i2.ClassDataInclude? parentClass}) {
    return ClassFeatureDataInclude._(parentClass: parentClass);
  }

  static ClassFeatureDataIncludeList includeList({
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    ClassFeatureDataInclude? include,
  }) {
    return ClassFeatureDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ClassFeatureData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassFeatureDataImpl extends ClassFeatureData {
  _ClassFeatureDataImpl({
    int? id,
    required int parentClassId,
    _i2.ClassData? parentClass,
    String? name,
    String? description,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i3.FeatureTag>? tags,
    String? choiceGroupKey,
  }) : super._(
          id: id,
          parentClassId: parentClassId,
          parentClass: parentClass,
          name: name,
          description: description,
          level: level,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          tags: tags,
          choiceGroupKey: choiceGroupKey,
        );

  /// Returns a shallow copy of this [ClassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassFeatureData copyWith({
    Object? id = _Undefined,
    int? parentClassId,
    Object? parentClass = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    int? level,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? tags = _Undefined,
    Object? choiceGroupKey = _Undefined,
  }) {
    return ClassFeatureData(
      id: id is int? ? id : this.id,
      parentClassId: parentClassId ?? this.parentClassId,
      parentClass: parentClass is _i2.ClassData?
          ? parentClass
          : this.parentClass?.copyWith(),
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      level: level ?? this.level,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      tags: tags is List<_i3.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
      choiceGroupKey:
          choiceGroupKey is String? ? choiceGroupKey : this.choiceGroupKey,
    );
  }
}

class ClassFeatureDataTable extends _i1.Table<int?> {
  ClassFeatureDataTable({super.tableRelation})
      : super(tableName: 'class_feature_data') {
    parentClassId = _i1.ColumnInt(
      'parentClassId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    level = _i1.ColumnInt(
      'level',
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
    tags = _i1.ColumnSerializable(
      'tags',
      this,
    );
    choiceGroupKey = _i1.ColumnString(
      'choiceGroupKey',
      this,
    );
  }

  late final _i1.ColumnInt parentClassId;

  _i2.ClassDataTable? _parentClass;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt level;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnSerializable tags;

  late final _i1.ColumnString choiceGroupKey;

  _i2.ClassDataTable get parentClass {
    if (_parentClass != null) return _parentClass!;
    _parentClass = _i1.createRelationTable(
      relationFieldName: 'parentClass',
      field: ClassFeatureData.t.parentClassId,
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
        parentClassId,
        name,
        description,
        level,
        source,
        version,
        createdAt,
        updatedAt,
        tags,
        choiceGroupKey,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'parentClass') {
      return parentClass;
    }
    return null;
  }
}

class ClassFeatureDataInclude extends _i1.IncludeObject {
  ClassFeatureDataInclude._({_i2.ClassDataInclude? parentClass}) {
    _parentClass = parentClass;
  }

  _i2.ClassDataInclude? _parentClass;

  @override
  Map<String, _i1.Include?> get includes => {'parentClass': _parentClass};

  @override
  _i1.Table<int?> get table => ClassFeatureData.t;
}

class ClassFeatureDataIncludeList extends _i1.IncludeList {
  ClassFeatureDataIncludeList._({
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClassFeatureData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ClassFeatureData.t;
}

class ClassFeatureDataRepository {
  const ClassFeatureDataRepository._();

  final attachRow = const ClassFeatureDataAttachRowRepository._();

  /// Returns a list of [ClassFeatureData]s matching the given query parameters.
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
  Future<List<ClassFeatureData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassFeatureDataInclude? include,
  }) async {
    return session.db.find<ClassFeatureData>(
      where: where?.call(ClassFeatureData.t),
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderByList: orderByList?.call(ClassFeatureData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ClassFeatureData] matching the given query parameters.
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
  Future<ClassFeatureData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassFeatureDataInclude? include,
  }) async {
    return session.db.findFirstRow<ClassFeatureData>(
      where: where?.call(ClassFeatureData.t),
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderByList: orderByList?.call(ClassFeatureData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ClassFeatureData] by its [id] or null if no such row exists.
  Future<ClassFeatureData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ClassFeatureDataInclude? include,
  }) async {
    return session.db.findById<ClassFeatureData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ClassFeatureData]s in the list and returns the inserted rows.
  ///
  /// The returned [ClassFeatureData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ClassFeatureData>> insert(
    _i1.Session session,
    List<ClassFeatureData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ClassFeatureData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ClassFeatureData] and returns the inserted row.
  ///
  /// The returned [ClassFeatureData] will have its `id` field set.
  Future<ClassFeatureData> insertRow(
    _i1.Session session,
    ClassFeatureData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClassFeatureData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ClassFeatureData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ClassFeatureData>> update(
    _i1.Session session,
    List<ClassFeatureData> rows, {
    _i1.ColumnSelections<ClassFeatureDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ClassFeatureData>(
      rows,
      columns: columns?.call(ClassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClassFeatureData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClassFeatureData> updateRow(
    _i1.Session session,
    ClassFeatureData row, {
    _i1.ColumnSelections<ClassFeatureDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClassFeatureData>(
      row,
      columns: columns?.call(ClassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ClassFeatureData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ClassFeatureData>> delete(
    _i1.Session session,
    List<ClassFeatureData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ClassFeatureData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ClassFeatureData].
  Future<ClassFeatureData> deleteRow(
    _i1.Session session,
    ClassFeatureData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClassFeatureData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ClassFeatureData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClassFeatureDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ClassFeatureData>(
      where: where(ClassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ClassFeatureData>(
      where: where?.call(ClassFeatureData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ClassFeatureDataAttachRowRepository {
  const ClassFeatureDataAttachRowRepository._();

  /// Creates a relation between the given [ClassFeatureData] and [ClassData]
  /// by setting the [ClassFeatureData]'s foreign key `parentClassId` to refer to the [ClassData].
  Future<void> parentClass(
    _i1.Session session,
    ClassFeatureData classFeatureData,
    _i2.ClassData parentClass, {
    _i1.Transaction? transaction,
  }) async {
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }
    if (parentClass.id == null) {
      throw ArgumentError.notNull('parentClass.id');
    }

    var $classFeatureData =
        classFeatureData.copyWith(parentClassId: parentClass.id);
    await session.db.updateRow<ClassFeatureData>(
      $classFeatureData,
      columns: [ClassFeatureData.t.parentClassId],
      transaction: transaction,
    );
  }
}
