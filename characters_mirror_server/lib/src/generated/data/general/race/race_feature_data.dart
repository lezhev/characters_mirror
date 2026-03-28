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
import '../../../data/general/race/subrace_data.dart' as _i3;
import '../../../enums/feature_tag.dart' as _i4;

abstract class RaceFeatureData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RaceFeatureData._({
    this.id,
    this.raceId,
    this.race,
    this.subraceId,
    this.subrace,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.level,
    this.spells,
    this.usesPerRest,
    this.usesFormula,
    this.tags,
  });

  factory RaceFeatureData({
    int? id,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    Map<String, int>? spells,
    String? usesPerRest,
    String? usesFormula,
    List<_i4.FeatureTag>? tags,
  }) = _RaceFeatureDataImpl;

  factory RaceFeatureData.fromJson(Map<String, dynamic> jsonSerialization) {
    return RaceFeatureData(
      id: jsonSerialization['id'] as int?,
      raceId: jsonSerialization['raceId'] as int?,
      race: jsonSerialization['race'] == null
          ? null
          : _i2.RaceData.fromJson(
              (jsonSerialization['race'] as Map<String, dynamic>)),
      subraceId: jsonSerialization['subraceId'] as int?,
      subrace: jsonSerialization['subrace'] == null
          ? null
          : _i3.SubraceData.fromJson(
              (jsonSerialization['subrace'] as Map<String, dynamic>)),
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
      level: jsonSerialization['level'] as int?,
      spells: (jsonSerialization['spells'] as Map?)?.map((k, v) => MapEntry(
            k as String,
            v as int,
          )),
      usesPerRest: jsonSerialization['usesPerRest'] as String?,
      usesFormula: jsonSerialization['usesFormula'] as String?,
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => _i4.FeatureTag.fromJson((e as int)))
          .toList(),
    );
  }

  static final t = RaceFeatureDataTable();

  static const db = RaceFeatureDataRepository._();

  @override
  int? id;

  int? raceId;

  _i2.RaceData? race;

  int? subraceId;

  _i3.SubraceData? subrace;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? level;

  Map<String, int>? spells;

  String? usesPerRest;

  String? usesFormula;

  List<_i4.FeatureTag>? tags;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RaceFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceFeatureData copyWith({
    int? id,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    Map<String, int>? spells,
    String? usesPerRest,
    String? usesFormula,
    List<_i4.FeatureTag>? tags,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (raceId != null) 'raceId': raceId,
      if (race != null) 'race': race?.toJson(),
      if (subraceId != null) 'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJson(),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (level != null) 'level': level,
      if (spells != null) 'spells': spells?.toJson(),
      if (usesPerRest != null) 'usesPerRest': usesPerRest,
      if (usesFormula != null) 'usesFormula': usesFormula,
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (raceId != null) 'raceId': raceId,
      if (race != null) 'race': race?.toJsonForProtocol(),
      if (subraceId != null) 'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJsonForProtocol(),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (level != null) 'level': level,
      if (spells != null) 'spells': spells?.toJson(),
      if (usesPerRest != null) 'usesPerRest': usesPerRest,
      if (usesFormula != null) 'usesFormula': usesFormula,
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  static RaceFeatureDataInclude include({
    _i2.RaceDataInclude? race,
    _i3.SubraceDataInclude? subrace,
  }) {
    return RaceFeatureDataInclude._(
      race: race,
      subrace: subrace,
    );
  }

  static RaceFeatureDataIncludeList includeList({
    _i1.WhereExpressionBuilder<RaceFeatureDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RaceFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceFeatureDataTable>? orderByList,
    RaceFeatureDataInclude? include,
  }) {
    return RaceFeatureDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RaceFeatureData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RaceFeatureData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceFeatureDataImpl extends RaceFeatureData {
  _RaceFeatureDataImpl({
    int? id,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    Map<String, int>? spells,
    String? usesPerRest,
    String? usesFormula,
    List<_i4.FeatureTag>? tags,
  }) : super._(
          id: id,
          raceId: raceId,
          race: race,
          subraceId: subraceId,
          subrace: subrace,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          level: level,
          spells: spells,
          usesPerRest: usesPerRest,
          usesFormula: usesFormula,
          tags: tags,
        );

  /// Returns a shallow copy of this [RaceFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RaceFeatureData copyWith({
    Object? id = _Undefined,
    Object? raceId = _Undefined,
    Object? race = _Undefined,
    Object? subraceId = _Undefined,
    Object? subrace = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? level = _Undefined,
    Object? spells = _Undefined,
    Object? usesPerRest = _Undefined,
    Object? usesFormula = _Undefined,
    Object? tags = _Undefined,
  }) {
    return RaceFeatureData(
      id: id is int? ? id : this.id,
      raceId: raceId is int? ? raceId : this.raceId,
      race: race is _i2.RaceData? ? race : this.race?.copyWith(),
      subraceId: subraceId is int? ? subraceId : this.subraceId,
      subrace: subrace is _i3.SubraceData? ? subrace : this.subrace?.copyWith(),
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      level: level is int? ? level : this.level,
      spells: spells is Map<String, int>?
          ? spells
          : this.spells?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      usesPerRest: usesPerRest is String? ? usesPerRest : this.usesPerRest,
      usesFormula: usesFormula is String? ? usesFormula : this.usesFormula,
      tags: tags is List<_i4.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
    );
  }
}

class RaceFeatureDataTable extends _i1.Table<int?> {
  RaceFeatureDataTable({super.tableRelation})
      : super(tableName: 'race_feature_data') {
    raceId = _i1.ColumnInt(
      'raceId',
      this,
    );
    subraceId = _i1.ColumnInt(
      'subraceId',
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
    level = _i1.ColumnInt(
      'level',
      this,
    );
    spells = _i1.ColumnSerializable(
      'spells',
      this,
    );
    usesPerRest = _i1.ColumnString(
      'usesPerRest',
      this,
    );
    usesFormula = _i1.ColumnString(
      'usesFormula',
      this,
    );
    tags = _i1.ColumnSerializable(
      'tags',
      this,
    );
  }

  late final _i1.ColumnInt raceId;

  _i2.RaceDataTable? _race;

  late final _i1.ColumnInt subraceId;

  _i3.SubraceDataTable? _subrace;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt level;

  late final _i1.ColumnSerializable spells;

  late final _i1.ColumnString usesPerRest;

  late final _i1.ColumnString usesFormula;

  late final _i1.ColumnSerializable tags;

  _i2.RaceDataTable get race {
    if (_race != null) return _race!;
    _race = _i1.createRelationTable(
      relationFieldName: 'race',
      field: RaceFeatureData.t.raceId,
      foreignField: _i2.RaceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RaceDataTable(tableRelation: foreignTableRelation),
    );
    return _race!;
  }

  _i3.SubraceDataTable get subrace {
    if (_subrace != null) return _subrace!;
    _subrace = _i1.createRelationTable(
      relationFieldName: 'subrace',
      field: RaceFeatureData.t.subraceId,
      foreignField: _i3.SubraceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SubraceDataTable(tableRelation: foreignTableRelation),
    );
    return _subrace!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        raceId,
        subraceId,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        level,
        spells,
        usesPerRest,
        usesFormula,
        tags,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'race') {
      return race;
    }
    if (relationField == 'subrace') {
      return subrace;
    }
    return null;
  }
}

class RaceFeatureDataInclude extends _i1.IncludeObject {
  RaceFeatureDataInclude._({
    _i2.RaceDataInclude? race,
    _i3.SubraceDataInclude? subrace,
  }) {
    _race = race;
    _subrace = subrace;
  }

  _i2.RaceDataInclude? _race;

  _i3.SubraceDataInclude? _subrace;

  @override
  Map<String, _i1.Include?> get includes => {
        'race': _race,
        'subrace': _subrace,
      };

  @override
  _i1.Table<int?> get table => RaceFeatureData.t;
}

class RaceFeatureDataIncludeList extends _i1.IncludeList {
  RaceFeatureDataIncludeList._({
    _i1.WhereExpressionBuilder<RaceFeatureDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RaceFeatureData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RaceFeatureData.t;
}

class RaceFeatureDataRepository {
  const RaceFeatureDataRepository._();

  final attachRow = const RaceFeatureDataAttachRowRepository._();

  final detachRow = const RaceFeatureDataDetachRowRepository._();

  /// Returns a list of [RaceFeatureData]s matching the given query parameters.
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
  Future<List<RaceFeatureData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceFeatureDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RaceFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceFeatureDataTable>? orderByList,
    _i1.Transaction? transaction,
    RaceFeatureDataInclude? include,
  }) async {
    return session.db.find<RaceFeatureData>(
      where: where?.call(RaceFeatureData.t),
      orderBy: orderBy?.call(RaceFeatureData.t),
      orderByList: orderByList?.call(RaceFeatureData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [RaceFeatureData] matching the given query parameters.
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
  Future<RaceFeatureData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceFeatureDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<RaceFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceFeatureDataTable>? orderByList,
    _i1.Transaction? transaction,
    RaceFeatureDataInclude? include,
  }) async {
    return session.db.findFirstRow<RaceFeatureData>(
      where: where?.call(RaceFeatureData.t),
      orderBy: orderBy?.call(RaceFeatureData.t),
      orderByList: orderByList?.call(RaceFeatureData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [RaceFeatureData] by its [id] or null if no such row exists.
  Future<RaceFeatureData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    RaceFeatureDataInclude? include,
  }) async {
    return session.db.findById<RaceFeatureData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [RaceFeatureData]s in the list and returns the inserted rows.
  ///
  /// The returned [RaceFeatureData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<RaceFeatureData>> insert(
    _i1.Session session,
    List<RaceFeatureData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<RaceFeatureData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [RaceFeatureData] and returns the inserted row.
  ///
  /// The returned [RaceFeatureData] will have its `id` field set.
  Future<RaceFeatureData> insertRow(
    _i1.Session session,
    RaceFeatureData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RaceFeatureData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RaceFeatureData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RaceFeatureData>> update(
    _i1.Session session,
    List<RaceFeatureData> rows, {
    _i1.ColumnSelections<RaceFeatureDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RaceFeatureData>(
      rows,
      columns: columns?.call(RaceFeatureData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RaceFeatureData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RaceFeatureData> updateRow(
    _i1.Session session,
    RaceFeatureData row, {
    _i1.ColumnSelections<RaceFeatureDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RaceFeatureData>(
      row,
      columns: columns?.call(RaceFeatureData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [RaceFeatureData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RaceFeatureData>> delete(
    _i1.Session session,
    List<RaceFeatureData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RaceFeatureData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RaceFeatureData].
  Future<RaceFeatureData> deleteRow(
    _i1.Session session,
    RaceFeatureData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RaceFeatureData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RaceFeatureData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RaceFeatureDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RaceFeatureData>(
      where: where(RaceFeatureData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceFeatureDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RaceFeatureData>(
      where: where?.call(RaceFeatureData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RaceFeatureDataAttachRowRepository {
  const RaceFeatureDataAttachRowRepository._();

  /// Creates a relation between the given [RaceFeatureData] and [RaceData]
  /// by setting the [RaceFeatureData]'s foreign key `raceId` to refer to the [RaceData].
  Future<void> race(
    _i1.Session session,
    RaceFeatureData raceFeatureData,
    _i2.RaceData race, {
    _i1.Transaction? transaction,
  }) async {
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }
    if (race.id == null) {
      throw ArgumentError.notNull('race.id');
    }

    var $raceFeatureData = raceFeatureData.copyWith(raceId: race.id);
    await session.db.updateRow<RaceFeatureData>(
      $raceFeatureData,
      columns: [RaceFeatureData.t.raceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [RaceFeatureData] and [SubraceData]
  /// by setting the [RaceFeatureData]'s foreign key `subraceId` to refer to the [SubraceData].
  Future<void> subrace(
    _i1.Session session,
    RaceFeatureData raceFeatureData,
    _i3.SubraceData subrace, {
    _i1.Transaction? transaction,
  }) async {
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }
    if (subrace.id == null) {
      throw ArgumentError.notNull('subrace.id');
    }

    var $raceFeatureData = raceFeatureData.copyWith(subraceId: subrace.id);
    await session.db.updateRow<RaceFeatureData>(
      $raceFeatureData,
      columns: [RaceFeatureData.t.subraceId],
      transaction: transaction,
    );
  }
}

class RaceFeatureDataDetachRowRepository {
  const RaceFeatureDataDetachRowRepository._();

  /// Detaches the relation between this [RaceFeatureData] and the [RaceData] set in `race`
  /// by setting the [RaceFeatureData]'s foreign key `raceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> race(
    _i1.Session session,
    RaceFeatureData racefeaturedata, {
    _i1.Transaction? transaction,
  }) async {
    if (racefeaturedata.id == null) {
      throw ArgumentError.notNull('racefeaturedata.id');
    }

    var $racefeaturedata = racefeaturedata.copyWith(raceId: null);
    await session.db.updateRow<RaceFeatureData>(
      $racefeaturedata,
      columns: [RaceFeatureData.t.raceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [RaceFeatureData] and the [SubraceData] set in `subrace`
  /// by setting the [RaceFeatureData]'s foreign key `subraceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subrace(
    _i1.Session session,
    RaceFeatureData racefeaturedata, {
    _i1.Transaction? transaction,
  }) async {
    if (racefeaturedata.id == null) {
      throw ArgumentError.notNull('racefeaturedata.id');
    }

    var $racefeaturedata = racefeaturedata.copyWith(subraceId: null);
    await session.db.updateRow<RaceFeatureData>(
      $racefeaturedata,
      columns: [RaceFeatureData.t.subraceId],
      transaction: transaction,
    );
  }
}
