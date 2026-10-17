/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../enums/skill.dart' as _ic5go03x;

abstract class BackgroundData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  BackgroundData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.skillProficiencies,
    this.availableSkills,
    this.skillCount,
    this.toolProficiencyKeys,
    this.languageCount,
    this.items,
    this.coins,
    this.feature,
    this.suggestedPersonality,
    this.suggestedIdeal,
    this.suggestedBond,
    this.suggestedFlaw,
  });

  factory BackgroundData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_ic5go03x.Skill>? skillProficiencies,
    List<_ic5go03x.Skill>? availableSkills,
    int? skillCount,
    List<String>? toolProficiencyKeys,
    int? languageCount,
    List<String>? items,
    double? coins,
    String? feature,
    List<String>? suggestedPersonality,
    List<String>? suggestedIdeal,
    List<String>? suggestedBond,
    List<String>? suggestedFlaw,
  }) = _BackgroundDataImpl;

  factory BackgroundData.fromJson(Map<String, dynamic> jsonSerialization) {
    return BackgroundData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      skillProficiencies: jsonSerialization['skillProficiencies'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ic5go03x.Skill>>(
              jsonSerialization['skillProficiencies'],
            ),
      availableSkills: jsonSerialization['availableSkills'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ic5go03x.Skill>>(
              jsonSerialization['availableSkills'],
            ),
      skillCount: jsonSerialization['skillCount'] as int?,
      toolProficiencyKeys: jsonSerialization['toolProficiencyKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['toolProficiencyKeys'],
            ),
      languageCount: jsonSerialization['languageCount'] as int?,
      items: jsonSerialization['items'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['items'],
            ),
      coins: (jsonSerialization['coins'] as num?)?.toDouble(),
      feature: jsonSerialization['feature'] as String?,
      suggestedPersonality: jsonSerialization['suggestedPersonality'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['suggestedPersonality'],
            ),
      suggestedIdeal: jsonSerialization['suggestedIdeal'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['suggestedIdeal'],
            ),
      suggestedBond: jsonSerialization['suggestedBond'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['suggestedBond'],
            ),
      suggestedFlaw: jsonSerialization['suggestedFlaw'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['suggestedFlaw'],
            ),
    );
  }

  static final t = BackgroundDataTable();

  static const db = BackgroundDataRepository._();

  @override
  int? id;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  List<_ic5go03x.Skill>? skillProficiencies;

  List<_ic5go03x.Skill>? availableSkills;

  int? skillCount;

  List<String>? toolProficiencyKeys;

  int? languageCount;

  List<String>? items;

  double? coins;

  String? feature;

  List<String>? suggestedPersonality;

  List<String>? suggestedIdeal;

  List<String>? suggestedBond;

  List<String>? suggestedFlaw;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [BackgroundData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BackgroundData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_ic5go03x.Skill>? skillProficiencies,
    List<_ic5go03x.Skill>? availableSkills,
    int? skillCount,
    List<String>? toolProficiencyKeys,
    int? languageCount,
    List<String>? items,
    double? coins,
    String? feature,
    List<String>? suggestedPersonality,
    List<String>? suggestedIdeal,
    List<String>? suggestedBond,
    List<String>? suggestedFlaw,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BackgroundData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (availableSkills != null)
        'availableSkills': availableSkills?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (skillCount != null) 'skillCount': skillCount,
      if (toolProficiencyKeys != null)
        'toolProficiencyKeys': toolProficiencyKeys?.toJson(),
      if (languageCount != null) 'languageCount': languageCount,
      if (items != null) 'items': items?.toJson(),
      if (coins != null) 'coins': coins,
      if (feature != null) 'feature': feature,
      if (suggestedPersonality != null)
        'suggestedPersonality': suggestedPersonality?.toJson(),
      if (suggestedIdeal != null) 'suggestedIdeal': suggestedIdeal?.toJson(),
      if (suggestedBond != null) 'suggestedBond': suggestedBond?.toJson(),
      if (suggestedFlaw != null) 'suggestedFlaw': suggestedFlaw?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BackgroundData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (availableSkills != null)
        'availableSkills': availableSkills?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (skillCount != null) 'skillCount': skillCount,
      if (toolProficiencyKeys != null)
        'toolProficiencyKeys': toolProficiencyKeys?.toJson(),
      if (languageCount != null) 'languageCount': languageCount,
      if (items != null) 'items': items?.toJson(),
      if (coins != null) 'coins': coins,
      if (feature != null) 'feature': feature,
      if (suggestedPersonality != null)
        'suggestedPersonality': suggestedPersonality?.toJson(),
      if (suggestedIdeal != null) 'suggestedIdeal': suggestedIdeal?.toJson(),
      if (suggestedBond != null) 'suggestedBond': suggestedBond?.toJson(),
      if (suggestedFlaw != null) 'suggestedFlaw': suggestedFlaw?.toJson(),
    };
  }

  static BackgroundDataInclude include() {
    return BackgroundDataInclude._();
  }

  static BackgroundDataIncludeList includeList({
    _is.WhereExpressionBuilder<BackgroundDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BackgroundDataTable>? orderBy,
    _is.OrderByListBuilder<BackgroundDataTable>? orderByList,
    BackgroundDataInclude? include,
  }) {
    return BackgroundDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BackgroundData.t),
      orderByList: orderByList?.call(BackgroundData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BackgroundDataImpl extends BackgroundData {
  _BackgroundDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_ic5go03x.Skill>? skillProficiencies,
    List<_ic5go03x.Skill>? availableSkills,
    int? skillCount,
    List<String>? toolProficiencyKeys,
    int? languageCount,
    List<String>? items,
    double? coins,
    String? feature,
    List<String>? suggestedPersonality,
    List<String>? suggestedIdeal,
    List<String>? suggestedBond,
    List<String>? suggestedFlaw,
  }) : super._(
         id: id,
         name: name,
         description: description,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
         skillProficiencies: skillProficiencies,
         availableSkills: availableSkills,
         skillCount: skillCount,
         toolProficiencyKeys: toolProficiencyKeys,
         languageCount: languageCount,
         items: items,
         coins: coins,
         feature: feature,
         suggestedPersonality: suggestedPersonality,
         suggestedIdeal: suggestedIdeal,
         suggestedBond: suggestedBond,
         suggestedFlaw: suggestedFlaw,
       );

  /// Returns a shallow copy of this [BackgroundData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BackgroundData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? skillProficiencies = _Undefined,
    Object? availableSkills = _Undefined,
    Object? skillCount = _Undefined,
    Object? toolProficiencyKeys = _Undefined,
    Object? languageCount = _Undefined,
    Object? items = _Undefined,
    Object? coins = _Undefined,
    Object? feature = _Undefined,
    Object? suggestedPersonality = _Undefined,
    Object? suggestedIdeal = _Undefined,
    Object? suggestedBond = _Undefined,
    Object? suggestedFlaw = _Undefined,
  }) {
    return BackgroundData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      skillProficiencies: skillProficiencies is List<_ic5go03x.Skill>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      availableSkills: availableSkills is List<_ic5go03x.Skill>?
          ? availableSkills
          : this.availableSkills?.map((e0) => e0).toList(),
      skillCount: skillCount is int? ? skillCount : this.skillCount,
      toolProficiencyKeys: toolProficiencyKeys is List<String>?
          ? toolProficiencyKeys
          : this.toolProficiencyKeys?.map((e0) => e0).toList(),
      languageCount: languageCount is int? ? languageCount : this.languageCount,
      items: items is List<String>?
          ? items
          : this.items?.map((e0) => e0).toList(),
      coins: coins is double? ? coins : this.coins,
      feature: feature is String? ? feature : this.feature,
      suggestedPersonality: suggestedPersonality is List<String>?
          ? suggestedPersonality
          : this.suggestedPersonality?.map((e0) => e0).toList(),
      suggestedIdeal: suggestedIdeal is List<String>?
          ? suggestedIdeal
          : this.suggestedIdeal?.map((e0) => e0).toList(),
      suggestedBond: suggestedBond is List<String>?
          ? suggestedBond
          : this.suggestedBond?.map((e0) => e0).toList(),
      suggestedFlaw: suggestedFlaw is List<String>?
          ? suggestedFlaw
          : this.suggestedFlaw?.map((e0) => e0).toList(),
    );
  }
}

class BackgroundDataUpdateTable extends _is.UpdateTable<BackgroundDataTable> {
  BackgroundDataUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String? value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);

  _is.ColumnValue<List<_ic5go03x.Skill>, List<_ic5go03x.Skill>>
  skillProficiencies(List<_ic5go03x.Skill>? value) =>
      _is.ColumnValue(table.skillProficiencies, value);

  _is.ColumnValue<List<_ic5go03x.Skill>, List<_ic5go03x.Skill>> availableSkills(
    List<_ic5go03x.Skill>? value,
  ) => _is.ColumnValue(table.availableSkills, value);

  _is.ColumnValue<int, int> skillCount(int? value) =>
      _is.ColumnValue(table.skillCount, value);

  _is.ColumnValue<List<String>, List<String>> toolProficiencyKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.toolProficiencyKeys, value);

  _is.ColumnValue<int, int> languageCount(int? value) =>
      _is.ColumnValue(table.languageCount, value);

  _is.ColumnValue<List<String>, List<String>> items(List<String>? value) =>
      _is.ColumnValue(table.items, value);

  _is.ColumnValue<double, double> coins(double? value) =>
      _is.ColumnValue(table.coins, value);

  _is.ColumnValue<String, String> feature(String? value) =>
      _is.ColumnValue(table.feature, value);

  _is.ColumnValue<List<String>, List<String>> suggestedPersonality(
    List<String>? value,
  ) => _is.ColumnValue(table.suggestedPersonality, value);

  _is.ColumnValue<List<String>, List<String>> suggestedIdeal(
    List<String>? value,
  ) => _is.ColumnValue(table.suggestedIdeal, value);

  _is.ColumnValue<List<String>, List<String>> suggestedBond(
    List<String>? value,
  ) => _is.ColumnValue(table.suggestedBond, value);

  _is.ColumnValue<List<String>, List<String>> suggestedFlaw(
    List<String>? value,
  ) => _is.ColumnValue(table.suggestedFlaw, value);
}

class BackgroundDataTable extends _is.Table<int?> {
  BackgroundDataTable({super.tableRelation})
    : super(tableName: 'background_data') {
    updateTable = BackgroundDataUpdateTable(this);
    name = _is.ColumnString('name', this);
    description = _is.ColumnString('description', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    skillProficiencies = _is.ColumnSerializable<List<_ic5go03x.Skill>>(
      'skillProficiencies',
      this,
    );
    availableSkills = _is.ColumnSerializable<List<_ic5go03x.Skill>>(
      'availableSkills',
      this,
    );
    skillCount = _is.ColumnInt('skillCount', this);
    toolProficiencyKeys = _is.ColumnSerializable<List<String>>(
      'toolProficiencyKeys',
      this,
    );
    languageCount = _is.ColumnInt('languageCount', this);
    items = _is.ColumnSerializable<List<String>>('items', this);
    coins = _is.ColumnDouble('coins', this);
    feature = _is.ColumnString('feature', this);
    suggestedPersonality = _is.ColumnSerializable<List<String>>(
      'suggestedPersonality',
      this,
    );
    suggestedIdeal = _is.ColumnSerializable<List<String>>(
      'suggestedIdeal',
      this,
    );
    suggestedBond = _is.ColumnSerializable<List<String>>('suggestedBond', this);
    suggestedFlaw = _is.ColumnSerializable<List<String>>('suggestedFlaw', this);
  }

  late final BackgroundDataUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnSerializable<List<_ic5go03x.Skill>> skillProficiencies;

  late final _is.ColumnSerializable<List<_ic5go03x.Skill>> availableSkills;

  late final _is.ColumnInt skillCount;

  late final _is.ColumnSerializable<List<String>> toolProficiencyKeys;

  late final _is.ColumnInt languageCount;

  late final _is.ColumnSerializable<List<String>> items;

  late final _is.ColumnDouble coins;

  late final _is.ColumnString feature;

  late final _is.ColumnSerializable<List<String>> suggestedPersonality;

  late final _is.ColumnSerializable<List<String>> suggestedIdeal;

  late final _is.ColumnSerializable<List<String>> suggestedBond;

  late final _is.ColumnSerializable<List<String>> suggestedFlaw;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    description,
    source,
    version,
    createdAt,
    updatedAt,
    skillProficiencies,
    availableSkills,
    skillCount,
    toolProficiencyKeys,
    languageCount,
    items,
    coins,
    feature,
    suggestedPersonality,
    suggestedIdeal,
    suggestedBond,
    suggestedFlaw,
  ];
}

class BackgroundDataInclude extends _is.IncludeObject {
  BackgroundDataInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => BackgroundData.t;
}

class BackgroundDataIncludeList extends _is.IncludeList {
  BackgroundDataIncludeList._({
    _is.WhereExpressionBuilder<BackgroundDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BackgroundData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => BackgroundData.t;
}

class BackgroundDataRepository {
  const BackgroundDataRepository._();

  /// Returns a list of [BackgroundData]s matching the given query parameters.
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
  Future<List<BackgroundData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BackgroundDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BackgroundDataTable>? orderBy,
    _is.OrderByListBuilder<BackgroundDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BackgroundData>(
      where: where?.call(BackgroundData.t),
      orderBy: orderBy?.call(BackgroundData.t),
      orderByList: orderByList?.call(BackgroundData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BackgroundData] matching the given query parameters.
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
  Future<BackgroundData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BackgroundDataTable>? where,
    int? offset,
    _is.OrderByBuilder<BackgroundDataTable>? orderBy,
    _is.OrderByListBuilder<BackgroundDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BackgroundData>(
      where: where?.call(BackgroundData.t),
      orderBy: orderBy?.call(BackgroundData.t),
      orderByList: orderByList?.call(BackgroundData.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BackgroundData] by its [id] or null if no such row exists.
  Future<BackgroundData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BackgroundData>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BackgroundData]s in the list and returns the inserted rows.
  ///
  /// The returned [BackgroundData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BackgroundData>> insert(
    _is.DatabaseSession session,
    List<BackgroundData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BackgroundData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BackgroundData] and returns the inserted row.
  ///
  /// The returned [BackgroundData] will have its `id` field set.
  Future<BackgroundData> insertRow(
    _is.DatabaseSession session,
    BackgroundData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BackgroundData>(row, transaction: transaction);
  }

  /// Upserts all [BackgroundData]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [BackgroundData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BackgroundData>> upsert(
    _is.DatabaseSession session,
    List<BackgroundData> rows, {
    required _is.ColumnSelections<BackgroundDataTable> conflictColumns,
    _is.ColumnSelections<BackgroundDataTable>? updateColumns,
    _is.WhereExpressionBuilder<BackgroundDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BackgroundData>(
      rows,
      conflictColumns: conflictColumns(BackgroundData.t),
      updateColumns: updateColumns?.call(BackgroundData.t),
      updateWhere: updateWhere?.call(BackgroundData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BackgroundData] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [BackgroundData] will have its `id` field set.
  Future<BackgroundData?> upsertRow(
    _is.DatabaseSession session,
    BackgroundData row, {
    required _is.ColumnSelections<BackgroundDataTable> conflictColumns,
    _is.ColumnSelections<BackgroundDataTable>? updateColumns,
    _is.WhereExpressionBuilder<BackgroundDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BackgroundData>(
      row,
      conflictColumns: conflictColumns(BackgroundData.t),
      updateColumns: updateColumns?.call(BackgroundData.t),
      updateWhere: updateWhere?.call(BackgroundData.t),
      transaction: transaction,
    );
  }

  /// Updates all [BackgroundData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BackgroundData>> update(
    _is.DatabaseSession session,
    List<BackgroundData> rows, {
    _is.ColumnSelections<BackgroundDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BackgroundData>(
      rows,
      columns: columns?.call(BackgroundData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BackgroundData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BackgroundData> updateRow(
    _is.DatabaseSession session,
    BackgroundData row, {
    _is.ColumnSelections<BackgroundDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BackgroundData>(
      row,
      columns: columns?.call(BackgroundData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BackgroundData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BackgroundData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BackgroundDataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BackgroundData>(
      id,
      columnValues: columnValues(BackgroundData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BackgroundData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BackgroundData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BackgroundDataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BackgroundDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BackgroundDataTable>? orderBy,
    _is.OrderByListBuilder<BackgroundDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BackgroundData>(
      columnValues: columnValues(BackgroundData.t.updateTable),
      where: where(BackgroundData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BackgroundData.t),
      orderByList: orderByList?.call(BackgroundData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BackgroundData]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BackgroundData>> delete(
    _is.DatabaseSession session,
    List<BackgroundData> rows, {
    _is.OrderByBuilder<BackgroundDataTable>? orderBy,
    _is.OrderByListBuilder<BackgroundDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BackgroundData>(
      rows,
      orderBy: orderBy?.call(BackgroundData.t),
      orderByList: orderByList?.call(BackgroundData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BackgroundData].
  Future<BackgroundData> deleteRow(
    _is.DatabaseSession session,
    BackgroundData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BackgroundData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BackgroundData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BackgroundDataTable> where,
    _is.OrderByBuilder<BackgroundDataTable>? orderBy,
    _is.OrderByListBuilder<BackgroundDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BackgroundData>(
      where: where(BackgroundData.t),
      orderBy: orderBy?.call(BackgroundData.t),
      orderByList: orderByList?.call(BackgroundData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BackgroundDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BackgroundData>(
      where: where?.call(BackgroundData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BackgroundData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BackgroundDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BackgroundData>(
      where: where(BackgroundData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
