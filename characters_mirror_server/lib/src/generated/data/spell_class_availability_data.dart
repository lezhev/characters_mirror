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
import '../data/spell_data.dart' as _i2;
import '../data/general/class/class_data.dart' as _i3;

abstract class SpellClassAvailabilityData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SpellClassAvailabilityData._({
    this.id,
    required this.spellId,
    this.spell,
    required this.classDataId,
    this.classData,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory SpellClassAvailabilityData({
    int? id,
    required int spellId,
    _i2.SpellData? spell,
    required int classDataId,
    _i3.ClassData? classData,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SpellClassAvailabilityDataImpl;

  factory SpellClassAvailabilityData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SpellClassAvailabilityData(
      id: jsonSerialization['id'] as int?,
      spellId: jsonSerialization['spellId'] as int,
      spell: jsonSerialization['spell'] == null
          ? null
          : _i2.SpellData.fromJson(
              (jsonSerialization['spell'] as Map<String, dynamic>)),
      classDataId: jsonSerialization['classDataId'] as int,
      classData: jsonSerialization['classData'] == null
          ? null
          : _i3.ClassData.fromJson(
              (jsonSerialization['classData'] as Map<String, dynamic>)),
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

  static final t = SpellClassAvailabilityDataTable();

  static const db = SpellClassAvailabilityDataRepository._();

  @override
  int? id;

  int spellId;

  _i2.SpellData? spell;

  int classDataId;

  _i3.ClassData? classData;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SpellClassAvailabilityData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpellClassAvailabilityData copyWith({
    int? id,
    int? spellId,
    _i2.SpellData? spell,
    int? classDataId,
    _i3.ClassData? classData,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'spellId': spellId,
      if (spell != null) 'spell': spell?.toJson(),
      'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJson(),
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
      'spellId': spellId,
      if (spell != null) 'spell': spell?.toJsonForProtocol(),
      'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJsonForProtocol(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static SpellClassAvailabilityDataInclude include({
    _i2.SpellDataInclude? spell,
    _i3.ClassDataInclude? classData,
  }) {
    return SpellClassAvailabilityDataInclude._(
      spell: spell,
      classData: classData,
    );
  }

  static SpellClassAvailabilityDataIncludeList includeList({
    _i1.WhereExpressionBuilder<SpellClassAvailabilityDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpellClassAvailabilityDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpellClassAvailabilityDataTable>? orderByList,
    SpellClassAvailabilityDataInclude? include,
  }) {
    return SpellClassAvailabilityDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SpellClassAvailabilityData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SpellClassAvailabilityData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellClassAvailabilityDataImpl extends SpellClassAvailabilityData {
  _SpellClassAvailabilityDataImpl({
    int? id,
    required int spellId,
    _i2.SpellData? spell,
    required int classDataId,
    _i3.ClassData? classData,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          spellId: spellId,
          spell: spell,
          classDataId: classDataId,
          classData: classData,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [SpellClassAvailabilityData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpellClassAvailabilityData copyWith({
    Object? id = _Undefined,
    int? spellId,
    Object? spell = _Undefined,
    int? classDataId,
    Object? classData = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return SpellClassAvailabilityData(
      id: id is int? ? id : this.id,
      spellId: spellId ?? this.spellId,
      spell: spell is _i2.SpellData? ? spell : this.spell?.copyWith(),
      classDataId: classDataId ?? this.classDataId,
      classData:
          classData is _i3.ClassData? ? classData : this.classData?.copyWith(),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class SpellClassAvailabilityDataTable extends _i1.Table<int?> {
  SpellClassAvailabilityDataTable({super.tableRelation})
      : super(tableName: 'spell_class_availability_data') {
    spellId = _i1.ColumnInt(
      'spellId',
      this,
    );
    classDataId = _i1.ColumnInt(
      'classDataId',
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

  late final _i1.ColumnInt spellId;

  _i2.SpellDataTable? _spell;

  late final _i1.ColumnInt classDataId;

  _i3.ClassDataTable? _classData;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.SpellDataTable get spell {
    if (_spell != null) return _spell!;
    _spell = _i1.createRelationTable(
      relationFieldName: 'spell',
      field: SpellClassAvailabilityData.t.spellId,
      foreignField: _i2.SpellData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SpellDataTable(tableRelation: foreignTableRelation),
    );
    return _spell!;
  }

  _i3.ClassDataTable get classData {
    if (_classData != null) return _classData!;
    _classData = _i1.createRelationTable(
      relationFieldName: 'classData',
      field: SpellClassAvailabilityData.t.classDataId,
      foreignField: _i3.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _classData!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        spellId,
        classDataId,
        source,
        version,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'spell') {
      return spell;
    }
    if (relationField == 'classData') {
      return classData;
    }
    return null;
  }
}

class SpellClassAvailabilityDataInclude extends _i1.IncludeObject {
  SpellClassAvailabilityDataInclude._({
    _i2.SpellDataInclude? spell,
    _i3.ClassDataInclude? classData,
  }) {
    _spell = spell;
    _classData = classData;
  }

  _i2.SpellDataInclude? _spell;

  _i3.ClassDataInclude? _classData;

  @override
  Map<String, _i1.Include?> get includes => {
        'spell': _spell,
        'classData': _classData,
      };

  @override
  _i1.Table<int?> get table => SpellClassAvailabilityData.t;
}

class SpellClassAvailabilityDataIncludeList extends _i1.IncludeList {
  SpellClassAvailabilityDataIncludeList._({
    _i1.WhereExpressionBuilder<SpellClassAvailabilityDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SpellClassAvailabilityData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SpellClassAvailabilityData.t;
}

class SpellClassAvailabilityDataRepository {
  const SpellClassAvailabilityDataRepository._();

  final attachRow = const SpellClassAvailabilityDataAttachRowRepository._();

  /// Returns a list of [SpellClassAvailabilityData]s matching the given query parameters.
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
  Future<List<SpellClassAvailabilityData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpellClassAvailabilityDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpellClassAvailabilityDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpellClassAvailabilityDataTable>? orderByList,
    _i1.Transaction? transaction,
    SpellClassAvailabilityDataInclude? include,
  }) async {
    return session.db.find<SpellClassAvailabilityData>(
      where: where?.call(SpellClassAvailabilityData.t),
      orderBy: orderBy?.call(SpellClassAvailabilityData.t),
      orderByList: orderByList?.call(SpellClassAvailabilityData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SpellClassAvailabilityData] matching the given query parameters.
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
  Future<SpellClassAvailabilityData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpellClassAvailabilityDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<SpellClassAvailabilityDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpellClassAvailabilityDataTable>? orderByList,
    _i1.Transaction? transaction,
    SpellClassAvailabilityDataInclude? include,
  }) async {
    return session.db.findFirstRow<SpellClassAvailabilityData>(
      where: where?.call(SpellClassAvailabilityData.t),
      orderBy: orderBy?.call(SpellClassAvailabilityData.t),
      orderByList: orderByList?.call(SpellClassAvailabilityData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SpellClassAvailabilityData] by its [id] or null if no such row exists.
  Future<SpellClassAvailabilityData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SpellClassAvailabilityDataInclude? include,
  }) async {
    return session.db.findById<SpellClassAvailabilityData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SpellClassAvailabilityData]s in the list and returns the inserted rows.
  ///
  /// The returned [SpellClassAvailabilityData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SpellClassAvailabilityData>> insert(
    _i1.Session session,
    List<SpellClassAvailabilityData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SpellClassAvailabilityData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SpellClassAvailabilityData] and returns the inserted row.
  ///
  /// The returned [SpellClassAvailabilityData] will have its `id` field set.
  Future<SpellClassAvailabilityData> insertRow(
    _i1.Session session,
    SpellClassAvailabilityData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SpellClassAvailabilityData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SpellClassAvailabilityData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SpellClassAvailabilityData>> update(
    _i1.Session session,
    List<SpellClassAvailabilityData> rows, {
    _i1.ColumnSelections<SpellClassAvailabilityDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SpellClassAvailabilityData>(
      rows,
      columns: columns?.call(SpellClassAvailabilityData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SpellClassAvailabilityData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SpellClassAvailabilityData> updateRow(
    _i1.Session session,
    SpellClassAvailabilityData row, {
    _i1.ColumnSelections<SpellClassAvailabilityDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SpellClassAvailabilityData>(
      row,
      columns: columns?.call(SpellClassAvailabilityData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SpellClassAvailabilityData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SpellClassAvailabilityData>> delete(
    _i1.Session session,
    List<SpellClassAvailabilityData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SpellClassAvailabilityData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SpellClassAvailabilityData].
  Future<SpellClassAvailabilityData> deleteRow(
    _i1.Session session,
    SpellClassAvailabilityData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SpellClassAvailabilityData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SpellClassAvailabilityData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SpellClassAvailabilityDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SpellClassAvailabilityData>(
      where: where(SpellClassAvailabilityData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpellClassAvailabilityDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SpellClassAvailabilityData>(
      where: where?.call(SpellClassAvailabilityData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SpellClassAvailabilityDataAttachRowRepository {
  const SpellClassAvailabilityDataAttachRowRepository._();

  /// Creates a relation between the given [SpellClassAvailabilityData] and [SpellData]
  /// by setting the [SpellClassAvailabilityData]'s foreign key `spellId` to refer to the [SpellData].
  Future<void> spell(
    _i1.Session session,
    SpellClassAvailabilityData spellClassAvailabilityData,
    _i2.SpellData spell, {
    _i1.Transaction? transaction,
  }) async {
    if (spellClassAvailabilityData.id == null) {
      throw ArgumentError.notNull('spellClassAvailabilityData.id');
    }
    if (spell.id == null) {
      throw ArgumentError.notNull('spell.id');
    }

    var $spellClassAvailabilityData =
        spellClassAvailabilityData.copyWith(spellId: spell.id);
    await session.db.updateRow<SpellClassAvailabilityData>(
      $spellClassAvailabilityData,
      columns: [SpellClassAvailabilityData.t.spellId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [SpellClassAvailabilityData] and [ClassData]
  /// by setting the [SpellClassAvailabilityData]'s foreign key `classDataId` to refer to the [ClassData].
  Future<void> classData(
    _i1.Session session,
    SpellClassAvailabilityData spellClassAvailabilityData,
    _i3.ClassData classData, {
    _i1.Transaction? transaction,
  }) async {
    if (spellClassAvailabilityData.id == null) {
      throw ArgumentError.notNull('spellClassAvailabilityData.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $spellClassAvailabilityData =
        spellClassAvailabilityData.copyWith(classDataId: classData.id);
    await session.db.updateRow<SpellClassAvailabilityData>(
      $spellClassAvailabilityData,
      columns: [SpellClassAvailabilityData.t.classDataId],
      transaction: transaction,
    );
  }
}
