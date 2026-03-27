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
import '../../../data/general/race/race_data.dart' as _i2;

abstract class RaceOptionData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RaceOptionData._({
    this.id,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    required this.raceId,
    this.race,
    this.type,
    this.uses,
    this.options,
  });

  factory RaceOptionData({
    int? id,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    required int raceId,
    _i2.RaceData? race,
    String? type,
    int? uses,
    List<String>? options,
  }) = _RaceOptionDataImpl;

  factory RaceOptionData.fromJson(Map<String, dynamic> jsonSerialization) {
    return RaceOptionData(
      id: jsonSerialization['id'] as int?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      raceId: jsonSerialization['raceId'] as int,
      race: jsonSerialization['race'] == null
          ? null
          : _i2.RaceData.fromJson(
              (jsonSerialization['race'] as Map<String, dynamic>)),
      type: jsonSerialization['type'] as String?,
      uses: jsonSerialization['uses'] as int?,
      options: (jsonSerialization['options'] as List?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  static final t = RaceOptionDataTable();

  static const db = RaceOptionDataRepository._();

  @override
  int? id;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int raceId;

  _i2.RaceData? race;

  String? type;

  int? uses;

  List<String>? options;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RaceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceOptionData copyWith({
    int? id,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? raceId,
    _i2.RaceData? race,
    String? type,
    int? uses,
    List<String>? options,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      'raceId': raceId,
      if (race != null) 'race': race?.toJson(),
      if (type != null) 'type': type,
      if (uses != null) 'uses': uses,
      if (options != null) 'options': options?.toJson(),
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
      'raceId': raceId,
      if (race != null) 'race': race?.toJsonForProtocol(),
      if (type != null) 'type': type,
      if (uses != null) 'uses': uses,
      if (options != null) 'options': options?.toJson(),
    };
  }

  static RaceOptionDataInclude include({_i2.RaceDataInclude? race}) {
    return RaceOptionDataInclude._(race: race);
  }

  static RaceOptionDataIncludeList includeList({
    _i1.WhereExpressionBuilder<RaceOptionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RaceOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceOptionDataTable>? orderByList,
    RaceOptionDataInclude? include,
  }) {
    return RaceOptionDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RaceOptionData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RaceOptionData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceOptionDataImpl extends RaceOptionData {
  _RaceOptionDataImpl({
    int? id,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    required int raceId,
    _i2.RaceData? race,
    String? type,
    int? uses,
    List<String>? options,
  }) : super._(
          id: id,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          raceId: raceId,
          race: race,
          type: type,
          uses: uses,
          options: options,
        );

  /// Returns a shallow copy of this [RaceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RaceOptionData copyWith({
    Object? id = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    int? raceId,
    Object? race = _Undefined,
    Object? type = _Undefined,
    Object? uses = _Undefined,
    Object? options = _Undefined,
  }) {
    return RaceOptionData(
      id: id is int? ? id : this.id,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      raceId: raceId ?? this.raceId,
      race: race is _i2.RaceData? ? race : this.race?.copyWith(),
      type: type is String? ? type : this.type,
      uses: uses is int? ? uses : this.uses,
      options: options is List<String>?
          ? options
          : this.options?.map((e0) => e0).toList(),
    );
  }
}

class RaceOptionDataTable extends _i1.Table<int?> {
  RaceOptionDataTable({super.tableRelation})
      : super(tableName: 'race_option_data') {
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
    raceId = _i1.ColumnInt(
      'raceId',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    uses = _i1.ColumnInt(
      'uses',
      this,
    );
    options = _i1.ColumnSerializable(
      'options',
      this,
    );
  }

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt raceId;

  _i2.RaceDataTable? _race;

  late final _i1.ColumnString type;

  late final _i1.ColumnInt uses;

  late final _i1.ColumnSerializable options;

  _i2.RaceDataTable get race {
    if (_race != null) return _race!;
    _race = _i1.createRelationTable(
      relationFieldName: 'race',
      field: RaceOptionData.t.raceId,
      foreignField: _i2.RaceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RaceDataTable(tableRelation: foreignTableRelation),
    );
    return _race!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        source,
        version,
        createdAt,
        updatedAt,
        raceId,
        type,
        uses,
        options,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'race') {
      return race;
    }
    return null;
  }
}

class RaceOptionDataInclude extends _i1.IncludeObject {
  RaceOptionDataInclude._({_i2.RaceDataInclude? race}) {
    _race = race;
  }

  _i2.RaceDataInclude? _race;

  @override
  Map<String, _i1.Include?> get includes => {'race': _race};

  @override
  _i1.Table<int?> get table => RaceOptionData.t;
}

class RaceOptionDataIncludeList extends _i1.IncludeList {
  RaceOptionDataIncludeList._({
    _i1.WhereExpressionBuilder<RaceOptionDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RaceOptionData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RaceOptionData.t;
}

class RaceOptionDataRepository {
  const RaceOptionDataRepository._();

  final attachRow = const RaceOptionDataAttachRowRepository._();

  /// Returns a list of [RaceOptionData]s matching the given query parameters.
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
  Future<List<RaceOptionData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceOptionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RaceOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceOptionDataTable>? orderByList,
    _i1.Transaction? transaction,
    RaceOptionDataInclude? include,
  }) async {
    return session.db.find<RaceOptionData>(
      where: where?.call(RaceOptionData.t),
      orderBy: orderBy?.call(RaceOptionData.t),
      orderByList: orderByList?.call(RaceOptionData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [RaceOptionData] matching the given query parameters.
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
  Future<RaceOptionData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceOptionDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<RaceOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceOptionDataTable>? orderByList,
    _i1.Transaction? transaction,
    RaceOptionDataInclude? include,
  }) async {
    return session.db.findFirstRow<RaceOptionData>(
      where: where?.call(RaceOptionData.t),
      orderBy: orderBy?.call(RaceOptionData.t),
      orderByList: orderByList?.call(RaceOptionData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [RaceOptionData] by its [id] or null if no such row exists.
  Future<RaceOptionData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    RaceOptionDataInclude? include,
  }) async {
    return session.db.findById<RaceOptionData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [RaceOptionData]s in the list and returns the inserted rows.
  ///
  /// The returned [RaceOptionData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<RaceOptionData>> insert(
    _i1.Session session,
    List<RaceOptionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<RaceOptionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [RaceOptionData] and returns the inserted row.
  ///
  /// The returned [RaceOptionData] will have its `id` field set.
  Future<RaceOptionData> insertRow(
    _i1.Session session,
    RaceOptionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RaceOptionData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RaceOptionData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RaceOptionData>> update(
    _i1.Session session,
    List<RaceOptionData> rows, {
    _i1.ColumnSelections<RaceOptionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RaceOptionData>(
      rows,
      columns: columns?.call(RaceOptionData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RaceOptionData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RaceOptionData> updateRow(
    _i1.Session session,
    RaceOptionData row, {
    _i1.ColumnSelections<RaceOptionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RaceOptionData>(
      row,
      columns: columns?.call(RaceOptionData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [RaceOptionData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RaceOptionData>> delete(
    _i1.Session session,
    List<RaceOptionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RaceOptionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RaceOptionData].
  Future<RaceOptionData> deleteRow(
    _i1.Session session,
    RaceOptionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RaceOptionData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RaceOptionData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RaceOptionDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RaceOptionData>(
      where: where(RaceOptionData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceOptionDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RaceOptionData>(
      where: where?.call(RaceOptionData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RaceOptionDataAttachRowRepository {
  const RaceOptionDataAttachRowRepository._();

  /// Creates a relation between the given [RaceOptionData] and [RaceData]
  /// by setting the [RaceOptionData]'s foreign key `raceId` to refer to the [RaceData].
  Future<void> race(
    _i1.Session session,
    RaceOptionData raceOptionData,
    _i2.RaceData race, {
    _i1.Transaction? transaction,
  }) async {
    if (raceOptionData.id == null) {
      throw ArgumentError.notNull('raceOptionData.id');
    }
    if (race.id == null) {
      throw ArgumentError.notNull('race.id');
    }

    var $raceOptionData = raceOptionData.copyWith(raceId: race.id);
    await session.db.updateRow<RaceOptionData>(
      $raceOptionData,
      columns: [RaceOptionData.t.raceId],
      transaction: transaction,
    );
  }
}
