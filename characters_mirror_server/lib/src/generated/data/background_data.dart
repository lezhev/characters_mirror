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
import '../enums/skill.dart' as _i2;

abstract class BackgroundData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    this.toolProficiencies,
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
    List<String>? skillProficiencies,
    List<_i2.Skill>? availableSkills,
    int? skillCount,
    List<String>? toolProficiencies,
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
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      skillProficiencies: (jsonSerialization['skillProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      availableSkills: (jsonSerialization['availableSkills'] as List?)
          ?.map((e) => _i2.Skill.fromJson((e as String)))
          .toList(),
      skillCount: jsonSerialization['skillCount'] as int?,
      toolProficiencies: (jsonSerialization['toolProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      languageCount: jsonSerialization['languageCount'] as int?,
      items: (jsonSerialization['items'] as List?)
          ?.map((e) => e as String)
          .toList(),
      coins: (jsonSerialization['coins'] as num?)?.toDouble(),
      feature: jsonSerialization['feature'] as String?,
      suggestedPersonality: (jsonSerialization['suggestedPersonality'] as List?)
          ?.map((e) => e as String)
          .toList(),
      suggestedIdeal: (jsonSerialization['suggestedIdeal'] as List?)
          ?.map((e) => e as String)
          .toList(),
      suggestedBond: (jsonSerialization['suggestedBond'] as List?)
          ?.map((e) => e as String)
          .toList(),
      suggestedFlaw: (jsonSerialization['suggestedFlaw'] as List?)
          ?.map((e) => e as String)
          .toList(),
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

  List<String>? skillProficiencies;

  List<_i2.Skill>? availableSkills;

  int? skillCount;

  List<String>? toolProficiencies;

  int? languageCount;

  List<String>? items;

  double? coins;

  String? feature;

  List<String>? suggestedPersonality;

  List<String>? suggestedIdeal;

  List<String>? suggestedBond;

  List<String>? suggestedFlaw;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BackgroundData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BackgroundData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? skillProficiencies,
    List<_i2.Skill>? availableSkills,
    int? skillCount,
    List<String>? toolProficiencies,
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
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (availableSkills != null)
        'availableSkills':
            availableSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (skillCount != null) 'skillCount': skillCount,
      if (toolProficiencies != null)
        'toolProficiencies': toolProficiencies?.toJson(),
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
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (availableSkills != null)
        'availableSkills':
            availableSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (skillCount != null) 'skillCount': skillCount,
      if (toolProficiencies != null)
        'toolProficiencies': toolProficiencies?.toJson(),
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
    _i1.WhereExpressionBuilder<BackgroundDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BackgroundDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BackgroundDataTable>? orderByList,
    BackgroundDataInclude? include,
  }) {
    return BackgroundDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BackgroundData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BackgroundData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
    List<String>? skillProficiencies,
    List<_i2.Skill>? availableSkills,
    int? skillCount,
    List<String>? toolProficiencies,
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
          toolProficiencies: toolProficiencies,
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
  @_i1.useResult
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
    Object? toolProficiencies = _Undefined,
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
      skillProficiencies: skillProficiencies is List<String>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      availableSkills: availableSkills is List<_i2.Skill>?
          ? availableSkills
          : this.availableSkills?.map((e0) => e0).toList(),
      skillCount: skillCount is int? ? skillCount : this.skillCount,
      toolProficiencies: toolProficiencies is List<String>?
          ? toolProficiencies
          : this.toolProficiencies?.map((e0) => e0).toList(),
      languageCount: languageCount is int? ? languageCount : this.languageCount,
      items:
          items is List<String>? ? items : this.items?.map((e0) => e0).toList(),
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

class BackgroundDataTable extends _i1.Table<int?> {
  BackgroundDataTable({super.tableRelation})
      : super(tableName: 'background_data') {
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
    skillProficiencies = _i1.ColumnSerializable(
      'skillProficiencies',
      this,
    );
    availableSkills = _i1.ColumnSerializable(
      'availableSkills',
      this,
    );
    skillCount = _i1.ColumnInt(
      'skillCount',
      this,
    );
    toolProficiencies = _i1.ColumnSerializable(
      'toolProficiencies',
      this,
    );
    languageCount = _i1.ColumnInt(
      'languageCount',
      this,
    );
    items = _i1.ColumnSerializable(
      'items',
      this,
    );
    coins = _i1.ColumnDouble(
      'coins',
      this,
    );
    feature = _i1.ColumnString(
      'feature',
      this,
    );
    suggestedPersonality = _i1.ColumnSerializable(
      'suggestedPersonality',
      this,
    );
    suggestedIdeal = _i1.ColumnSerializable(
      'suggestedIdeal',
      this,
    );
    suggestedBond = _i1.ColumnSerializable(
      'suggestedBond',
      this,
    );
    suggestedFlaw = _i1.ColumnSerializable(
      'suggestedFlaw',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnSerializable skillProficiencies;

  late final _i1.ColumnSerializable availableSkills;

  late final _i1.ColumnInt skillCount;

  late final _i1.ColumnSerializable toolProficiencies;

  late final _i1.ColumnInt languageCount;

  late final _i1.ColumnSerializable items;

  late final _i1.ColumnDouble coins;

  late final _i1.ColumnString feature;

  late final _i1.ColumnSerializable suggestedPersonality;

  late final _i1.ColumnSerializable suggestedIdeal;

  late final _i1.ColumnSerializable suggestedBond;

  late final _i1.ColumnSerializable suggestedFlaw;

  @override
  List<_i1.Column> get columns => [
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
        toolProficiencies,
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

class BackgroundDataInclude extends _i1.IncludeObject {
  BackgroundDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BackgroundData.t;
}

class BackgroundDataIncludeList extends _i1.IncludeList {
  BackgroundDataIncludeList._({
    _i1.WhereExpressionBuilder<BackgroundDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BackgroundData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BackgroundData.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BackgroundDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BackgroundDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BackgroundDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<BackgroundData>(
      where: where?.call(BackgroundData.t),
      orderBy: orderBy?.call(BackgroundData.t),
      orderByList: orderByList?.call(BackgroundData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BackgroundDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<BackgroundDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BackgroundDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<BackgroundData>(
      where: where?.call(BackgroundData.t),
      orderBy: orderBy?.call(BackgroundData.t),
      orderByList: orderByList?.call(BackgroundData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [BackgroundData] by its [id] or null if no such row exists.
  Future<BackgroundData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<BackgroundData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [BackgroundData]s in the list and returns the inserted rows.
  ///
  /// The returned [BackgroundData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<BackgroundData>> insert(
    _i1.Session session,
    List<BackgroundData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<BackgroundData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [BackgroundData] and returns the inserted row.
  ///
  /// The returned [BackgroundData] will have its `id` field set.
  Future<BackgroundData> insertRow(
    _i1.Session session,
    BackgroundData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BackgroundData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BackgroundData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BackgroundData>> update(
    _i1.Session session,
    List<BackgroundData> rows, {
    _i1.ColumnSelections<BackgroundDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BackgroundData>(
      rows,
      columns: columns?.call(BackgroundData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BackgroundData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BackgroundData> updateRow(
    _i1.Session session,
    BackgroundData row, {
    _i1.ColumnSelections<BackgroundDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BackgroundData>(
      row,
      columns: columns?.call(BackgroundData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [BackgroundData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BackgroundData>> delete(
    _i1.Session session,
    List<BackgroundData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BackgroundData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BackgroundData].
  Future<BackgroundData> deleteRow(
    _i1.Session session,
    BackgroundData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BackgroundData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BackgroundData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BackgroundDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BackgroundData>(
      where: where(BackgroundData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BackgroundDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BackgroundData>(
      where: where?.call(BackgroundData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
