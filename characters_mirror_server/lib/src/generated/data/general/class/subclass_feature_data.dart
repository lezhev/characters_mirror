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
import '../../../data/general/class/subclass_data.dart' as _i2;
import '../../../enums/feature_tag.dart' as _i3;

abstract class SubclassFeatureData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubclassFeatureData._({
    this.id,
    required this.parentSubclassId,
    this.parentSubclass,
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

  factory SubclassFeatureData({
    int? id,
    required int parentSubclassId,
    _i2.SubclassData? parentSubclass,
    String? name,
    String? description,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i3.FeatureTag>? tags,
    String? choiceGroupKey,
  }) = _SubclassFeatureDataImpl;

  factory SubclassFeatureData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubclassFeatureData(
      id: jsonSerialization['id'] as int?,
      parentSubclassId: jsonSerialization['parentSubclassId'] as int,
      parentSubclass: jsonSerialization['parentSubclass'] == null
          ? null
          : _i2.SubclassData.fromJson(
              (jsonSerialization['parentSubclass'] as Map<String, dynamic>)),
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
          ?.map((e) => _i3.FeatureTag.fromJson((e as String)))
          .toList(),
      choiceGroupKey: jsonSerialization['choiceGroupKey'] as String?,
    );
  }

  static final t = SubclassFeatureDataTable();

  static const db = SubclassFeatureDataRepository._();

  @override
  int? id;

  int parentSubclassId;

  _i2.SubclassData? parentSubclass;

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

  /// Returns a shallow copy of this [SubclassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubclassFeatureData copyWith({
    int? id,
    int? parentSubclassId,
    _i2.SubclassData? parentSubclass,
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
      'parentSubclassId': parentSubclassId,
      if (parentSubclass != null) 'parentSubclass': parentSubclass?.toJson(),
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
      'parentSubclassId': parentSubclassId,
      if (parentSubclass != null)
        'parentSubclass': parentSubclass?.toJsonForProtocol(),
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

  static SubclassFeatureDataInclude include(
      {_i2.SubclassDataInclude? parentSubclass}) {
    return SubclassFeatureDataInclude._(parentSubclass: parentSubclass);
  }

  static SubclassFeatureDataIncludeList includeList({
    _i1.WhereExpressionBuilder<SubclassFeatureDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubclassFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubclassFeatureDataTable>? orderByList,
    SubclassFeatureDataInclude? include,
  }) {
    return SubclassFeatureDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubclassFeatureData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubclassFeatureData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubclassFeatureDataImpl extends SubclassFeatureData {
  _SubclassFeatureDataImpl({
    int? id,
    required int parentSubclassId,
    _i2.SubclassData? parentSubclass,
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
          parentSubclassId: parentSubclassId,
          parentSubclass: parentSubclass,
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

  /// Returns a shallow copy of this [SubclassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubclassFeatureData copyWith({
    Object? id = _Undefined,
    int? parentSubclassId,
    Object? parentSubclass = _Undefined,
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
    return SubclassFeatureData(
      id: id is int? ? id : this.id,
      parentSubclassId: parentSubclassId ?? this.parentSubclassId,
      parentSubclass: parentSubclass is _i2.SubclassData?
          ? parentSubclass
          : this.parentSubclass?.copyWith(),
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

class SubclassFeatureDataTable extends _i1.Table<int?> {
  SubclassFeatureDataTable({super.tableRelation})
      : super(tableName: 'subclass_feature_data') {
    parentSubclassId = _i1.ColumnInt(
      'parentSubclassId',
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

  late final _i1.ColumnInt parentSubclassId;

  _i2.SubclassDataTable? _parentSubclass;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt level;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnSerializable tags;

  late final _i1.ColumnString choiceGroupKey;

  _i2.SubclassDataTable get parentSubclass {
    if (_parentSubclass != null) return _parentSubclass!;
    _parentSubclass = _i1.createRelationTable(
      relationFieldName: 'parentSubclass',
      field: SubclassFeatureData.t.parentSubclassId,
      foreignField: _i2.SubclassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SubclassDataTable(tableRelation: foreignTableRelation),
    );
    return _parentSubclass!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        parentSubclassId,
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
    if (relationField == 'parentSubclass') {
      return parentSubclass;
    }
    return null;
  }
}

class SubclassFeatureDataInclude extends _i1.IncludeObject {
  SubclassFeatureDataInclude._({_i2.SubclassDataInclude? parentSubclass}) {
    _parentSubclass = parentSubclass;
  }

  _i2.SubclassDataInclude? _parentSubclass;

  @override
  Map<String, _i1.Include?> get includes => {'parentSubclass': _parentSubclass};

  @override
  _i1.Table<int?> get table => SubclassFeatureData.t;
}

class SubclassFeatureDataIncludeList extends _i1.IncludeList {
  SubclassFeatureDataIncludeList._({
    _i1.WhereExpressionBuilder<SubclassFeatureDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubclassFeatureData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubclassFeatureData.t;
}

class SubclassFeatureDataRepository {
  const SubclassFeatureDataRepository._();

  final attachRow = const SubclassFeatureDataAttachRowRepository._();

  /// Returns a list of [SubclassFeatureData]s matching the given query parameters.
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
  Future<List<SubclassFeatureData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubclassFeatureDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubclassFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubclassFeatureDataTable>? orderByList,
    _i1.Transaction? transaction,
    SubclassFeatureDataInclude? include,
  }) async {
    return session.db.find<SubclassFeatureData>(
      where: where?.call(SubclassFeatureData.t),
      orderBy: orderBy?.call(SubclassFeatureData.t),
      orderByList: orderByList?.call(SubclassFeatureData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SubclassFeatureData] matching the given query parameters.
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
  Future<SubclassFeatureData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubclassFeatureDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubclassFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubclassFeatureDataTable>? orderByList,
    _i1.Transaction? transaction,
    SubclassFeatureDataInclude? include,
  }) async {
    return session.db.findFirstRow<SubclassFeatureData>(
      where: where?.call(SubclassFeatureData.t),
      orderBy: orderBy?.call(SubclassFeatureData.t),
      orderByList: orderByList?.call(SubclassFeatureData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SubclassFeatureData] by its [id] or null if no such row exists.
  Future<SubclassFeatureData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SubclassFeatureDataInclude? include,
  }) async {
    return session.db.findById<SubclassFeatureData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SubclassFeatureData]s in the list and returns the inserted rows.
  ///
  /// The returned [SubclassFeatureData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SubclassFeatureData>> insert(
    _i1.Session session,
    List<SubclassFeatureData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SubclassFeatureData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SubclassFeatureData] and returns the inserted row.
  ///
  /// The returned [SubclassFeatureData] will have its `id` field set.
  Future<SubclassFeatureData> insertRow(
    _i1.Session session,
    SubclassFeatureData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubclassFeatureData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubclassFeatureData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubclassFeatureData>> update(
    _i1.Session session,
    List<SubclassFeatureData> rows, {
    _i1.ColumnSelections<SubclassFeatureDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubclassFeatureData>(
      rows,
      columns: columns?.call(SubclassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubclassFeatureData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubclassFeatureData> updateRow(
    _i1.Session session,
    SubclassFeatureData row, {
    _i1.ColumnSelections<SubclassFeatureDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubclassFeatureData>(
      row,
      columns: columns?.call(SubclassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SubclassFeatureData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubclassFeatureData>> delete(
    _i1.Session session,
    List<SubclassFeatureData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubclassFeatureData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubclassFeatureData].
  Future<SubclassFeatureData> deleteRow(
    _i1.Session session,
    SubclassFeatureData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubclassFeatureData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubclassFeatureData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SubclassFeatureDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubclassFeatureData>(
      where: where(SubclassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubclassFeatureDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubclassFeatureData>(
      where: where?.call(SubclassFeatureData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SubclassFeatureDataAttachRowRepository {
  const SubclassFeatureDataAttachRowRepository._();

  /// Creates a relation between the given [SubclassFeatureData] and [SubclassData]
  /// by setting the [SubclassFeatureData]'s foreign key `parentSubclassId` to refer to the [SubclassData].
  Future<void> parentSubclass(
    _i1.Session session,
    SubclassFeatureData subclassFeatureData,
    _i2.SubclassData parentSubclass, {
    _i1.Transaction? transaction,
  }) async {
    if (subclassFeatureData.id == null) {
      throw ArgumentError.notNull('subclassFeatureData.id');
    }
    if (parentSubclass.id == null) {
      throw ArgumentError.notNull('parentSubclass.id');
    }

    var $subclassFeatureData =
        subclassFeatureData.copyWith(parentSubclassId: parentSubclass.id);
    await session.db.updateRow<SubclassFeatureData>(
      $subclassFeatureData,
      columns: [SubclassFeatureData.t.parentSubclassId],
      transaction: transaction,
    );
  }
}
