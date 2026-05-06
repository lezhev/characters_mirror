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

abstract class ClassLevelData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ClassLevelData._({
    this.id,
    required this.classDataId,
    this.classData,
    required this.level,
    this.featureIds,
    this.subclassFeatureIds,
    this.knownCantrips,
    this.knownSpells,
    this.preparedSpellFormula,
    this.resourceSummary,
    this.notes,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassLevelData({
    int? id,
    required int classDataId,
    _i2.ClassData? classData,
    required int level,
    List<int>? featureIds,
    List<int>? subclassFeatureIds,
    int? knownCantrips,
    int? knownSpells,
    String? preparedSpellFormula,
    String? resourceSummary,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ClassLevelDataImpl;

  factory ClassLevelData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassLevelData(
      id: jsonSerialization['id'] as int?,
      classDataId: jsonSerialization['classDataId'] as int,
      classData: jsonSerialization['classData'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['classData'] as Map<String, dynamic>)),
      level: jsonSerialization['level'] as int,
      featureIds: (jsonSerialization['featureIds'] as List?)
          ?.map((e) => e as int)
          .toList(),
      subclassFeatureIds: (jsonSerialization['subclassFeatureIds'] as List?)
          ?.map((e) => e as int)
          .toList(),
      knownCantrips: jsonSerialization['knownCantrips'] as int?,
      knownSpells: jsonSerialization['knownSpells'] as int?,
      preparedSpellFormula:
          jsonSerialization['preparedSpellFormula'] as String?,
      resourceSummary: jsonSerialization['resourceSummary'] as String?,
      notes: jsonSerialization['notes'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ClassLevelDataTable();

  static const db = ClassLevelDataRepository._();

  @override
  int? id;

  int classDataId;

  _i2.ClassData? classData;

  int level;

  List<int>? featureIds;

  List<int>? subclassFeatureIds;

  int? knownCantrips;

  int? knownSpells;

  String? preparedSpellFormula;

  String? resourceSummary;

  String? notes;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClassLevelData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassLevelData copyWith({
    int? id,
    int? classDataId,
    _i2.ClassData? classData,
    int? level,
    List<int>? featureIds,
    List<int>? subclassFeatureIds,
    int? knownCantrips,
    int? knownSpells,
    String? preparedSpellFormula,
    String? resourceSummary,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJson(),
      'level': level,
      if (featureIds != null) 'featureIds': featureIds?.toJson(),
      if (subclassFeatureIds != null)
        'subclassFeatureIds': subclassFeatureIds?.toJson(),
      if (knownCantrips != null) 'knownCantrips': knownCantrips,
      if (knownSpells != null) 'knownSpells': knownSpells,
      if (preparedSpellFormula != null)
        'preparedSpellFormula': preparedSpellFormula,
      if (resourceSummary != null) 'resourceSummary': resourceSummary,
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJsonForProtocol(),
      'level': level,
      if (featureIds != null) 'featureIds': featureIds?.toJson(),
      if (subclassFeatureIds != null)
        'subclassFeatureIds': subclassFeatureIds?.toJson(),
      if (knownCantrips != null) 'knownCantrips': knownCantrips,
      if (knownSpells != null) 'knownSpells': knownSpells,
      if (preparedSpellFormula != null)
        'preparedSpellFormula': preparedSpellFormula,
      if (resourceSummary != null) 'resourceSummary': resourceSummary,
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static ClassLevelDataInclude include({_i2.ClassDataInclude? classData}) {
    return ClassLevelDataInclude._(classData: classData);
  }

  static ClassLevelDataIncludeList includeList({
    _i1.WhereExpressionBuilder<ClassLevelDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassLevelDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassLevelDataTable>? orderByList,
    ClassLevelDataInclude? include,
  }) {
    return ClassLevelDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassLevelData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ClassLevelData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassLevelDataImpl extends ClassLevelData {
  _ClassLevelDataImpl({
    int? id,
    required int classDataId,
    _i2.ClassData? classData,
    required int level,
    List<int>? featureIds,
    List<int>? subclassFeatureIds,
    int? knownCantrips,
    int? knownSpells,
    String? preparedSpellFormula,
    String? resourceSummary,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          classDataId: classDataId,
          classData: classData,
          level: level,
          featureIds: featureIds,
          subclassFeatureIds: subclassFeatureIds,
          knownCantrips: knownCantrips,
          knownSpells: knownSpells,
          preparedSpellFormula: preparedSpellFormula,
          resourceSummary: resourceSummary,
          notes: notes,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ClassLevelData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassLevelData copyWith({
    Object? id = _Undefined,
    int? classDataId,
    Object? classData = _Undefined,
    int? level,
    Object? featureIds = _Undefined,
    Object? subclassFeatureIds = _Undefined,
    Object? knownCantrips = _Undefined,
    Object? knownSpells = _Undefined,
    Object? preparedSpellFormula = _Undefined,
    Object? resourceSummary = _Undefined,
    Object? notes = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return ClassLevelData(
      id: id is int? ? id : this.id,
      classDataId: classDataId ?? this.classDataId,
      classData:
          classData is _i2.ClassData? ? classData : this.classData?.copyWith(),
      level: level ?? this.level,
      featureIds: featureIds is List<int>?
          ? featureIds
          : this.featureIds?.map((e0) => e0).toList(),
      subclassFeatureIds: subclassFeatureIds is List<int>?
          ? subclassFeatureIds
          : this.subclassFeatureIds?.map((e0) => e0).toList(),
      knownCantrips: knownCantrips is int? ? knownCantrips : this.knownCantrips,
      knownSpells: knownSpells is int? ? knownSpells : this.knownSpells,
      preparedSpellFormula: preparedSpellFormula is String?
          ? preparedSpellFormula
          : this.preparedSpellFormula,
      resourceSummary:
          resourceSummary is String? ? resourceSummary : this.resourceSummary,
      notes: notes is String? ? notes : this.notes,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class ClassLevelDataTable extends _i1.Table<int?> {
  ClassLevelDataTable({super.tableRelation})
      : super(tableName: 'class_level_data') {
    classDataId = _i1.ColumnInt(
      'classDataId',
      this,
    );
    level = _i1.ColumnInt(
      'level',
      this,
    );
    featureIds = _i1.ColumnSerializable(
      'featureIds',
      this,
    );
    subclassFeatureIds = _i1.ColumnSerializable(
      'subclassFeatureIds',
      this,
    );
    knownCantrips = _i1.ColumnInt(
      'knownCantrips',
      this,
    );
    knownSpells = _i1.ColumnInt(
      'knownSpells',
      this,
    );
    preparedSpellFormula = _i1.ColumnString(
      'preparedSpellFormula',
      this,
    );
    resourceSummary = _i1.ColumnString(
      'resourceSummary',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
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
  }

  late final _i1.ColumnInt classDataId;

  _i2.ClassDataTable? _classData;

  late final _i1.ColumnInt level;

  late final _i1.ColumnSerializable featureIds;

  late final _i1.ColumnSerializable subclassFeatureIds;

  late final _i1.ColumnInt knownCantrips;

  late final _i1.ColumnInt knownSpells;

  late final _i1.ColumnString preparedSpellFormula;

  late final _i1.ColumnString resourceSummary;

  late final _i1.ColumnString notes;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.ClassDataTable get classData {
    if (_classData != null) return _classData!;
    _classData = _i1.createRelationTable(
      relationFieldName: 'classData',
      field: ClassLevelData.t.classDataId,
      foreignField: _i2.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _classData!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        classDataId,
        level,
        featureIds,
        subclassFeatureIds,
        knownCantrips,
        knownSpells,
        preparedSpellFormula,
        resourceSummary,
        notes,
        source,
        version,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'classData') {
      return classData;
    }
    return null;
  }
}

class ClassLevelDataInclude extends _i1.IncludeObject {
  ClassLevelDataInclude._({_i2.ClassDataInclude? classData}) {
    _classData = classData;
  }

  _i2.ClassDataInclude? _classData;

  @override
  Map<String, _i1.Include?> get includes => {'classData': _classData};

  @override
  _i1.Table<int?> get table => ClassLevelData.t;
}

class ClassLevelDataIncludeList extends _i1.IncludeList {
  ClassLevelDataIncludeList._({
    _i1.WhereExpressionBuilder<ClassLevelDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClassLevelData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ClassLevelData.t;
}

class ClassLevelDataRepository {
  const ClassLevelDataRepository._();

  final attachRow = const ClassLevelDataAttachRowRepository._();

  /// Returns a list of [ClassLevelData]s matching the given query parameters.
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
  Future<List<ClassLevelData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassLevelDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassLevelDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassLevelDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassLevelDataInclude? include,
  }) async {
    return session.db.find<ClassLevelData>(
      where: where?.call(ClassLevelData.t),
      orderBy: orderBy?.call(ClassLevelData.t),
      orderByList: orderByList?.call(ClassLevelData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ClassLevelData] matching the given query parameters.
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
  Future<ClassLevelData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassLevelDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClassLevelDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassLevelDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassLevelDataInclude? include,
  }) async {
    return session.db.findFirstRow<ClassLevelData>(
      where: where?.call(ClassLevelData.t),
      orderBy: orderBy?.call(ClassLevelData.t),
      orderByList: orderByList?.call(ClassLevelData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ClassLevelData] by its [id] or null if no such row exists.
  Future<ClassLevelData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ClassLevelDataInclude? include,
  }) async {
    return session.db.findById<ClassLevelData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ClassLevelData]s in the list and returns the inserted rows.
  ///
  /// The returned [ClassLevelData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ClassLevelData>> insert(
    _i1.Session session,
    List<ClassLevelData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ClassLevelData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ClassLevelData] and returns the inserted row.
  ///
  /// The returned [ClassLevelData] will have its `id` field set.
  Future<ClassLevelData> insertRow(
    _i1.Session session,
    ClassLevelData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClassLevelData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ClassLevelData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ClassLevelData>> update(
    _i1.Session session,
    List<ClassLevelData> rows, {
    _i1.ColumnSelections<ClassLevelDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ClassLevelData>(
      rows,
      columns: columns?.call(ClassLevelData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClassLevelData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClassLevelData> updateRow(
    _i1.Session session,
    ClassLevelData row, {
    _i1.ColumnSelections<ClassLevelDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClassLevelData>(
      row,
      columns: columns?.call(ClassLevelData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ClassLevelData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ClassLevelData>> delete(
    _i1.Session session,
    List<ClassLevelData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ClassLevelData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ClassLevelData].
  Future<ClassLevelData> deleteRow(
    _i1.Session session,
    ClassLevelData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClassLevelData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ClassLevelData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClassLevelDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ClassLevelData>(
      where: where(ClassLevelData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassLevelDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ClassLevelData>(
      where: where?.call(ClassLevelData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ClassLevelDataAttachRowRepository {
  const ClassLevelDataAttachRowRepository._();

  /// Creates a relation between the given [ClassLevelData] and [ClassData]
  /// by setting the [ClassLevelData]'s foreign key `classDataId` to refer to the [ClassData].
  Future<void> classData(
    _i1.Session session,
    ClassLevelData classLevelData,
    _i2.ClassData classData, {
    _i1.Transaction? transaction,
  }) async {
    if (classLevelData.id == null) {
      throw ArgumentError.notNull('classLevelData.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $classLevelData = classLevelData.copyWith(classDataId: classData.id);
    await session.db.updateRow<ClassLevelData>(
      $classLevelData,
      columns: [ClassLevelData.t.classDataId],
      transaction: transaction,
    );
  }
}
