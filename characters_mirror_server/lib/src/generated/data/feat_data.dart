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
import '../enums/feature_tag.dart' as _i2;

abstract class FeatData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FeatData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.abilityBonuses,
    this.traits,
    this.tags,
    this.specialAbilities,
    this.proficiencies,
    this.prerequisites,
  });

  factory FeatData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<_i2.FeatureTag>? tags,
    List<String>? specialAbilities,
    List<String>? proficiencies,
    Map<String, int>? prerequisites,
  }) = _FeatDataImpl;

  factory FeatData.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatData(
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
      abilityBonuses:
          (jsonSerialization['abilityBonuses'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      traits: (jsonSerialization['traits'] as List?)
          ?.map((e) => e as String)
          .toList(),
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => _i2.FeatureTag.fromJson((e as String)))
          .toList(),
      specialAbilities: (jsonSerialization['specialAbilities'] as List?)
          ?.map((e) => e as String)
          .toList(),
      proficiencies: (jsonSerialization['proficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      prerequisites:
          (jsonSerialization['prerequisites'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
    );
  }

  static final t = FeatDataTable();

  static const db = FeatDataRepository._();

  @override
  int? id;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  Map<String, int>? abilityBonuses;

  List<String>? traits;

  List<_i2.FeatureTag>? tags;

  List<String>? specialAbilities;

  List<String>? proficiencies;

  Map<String, int>? prerequisites;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<_i2.FeatureTag>? tags,
    List<String>? specialAbilities,
    List<String>? proficiencies,
    Map<String, int>? prerequisites,
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
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (traits != null) 'traits': traits?.toJson(),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (specialAbilities != null)
        'specialAbilities': specialAbilities?.toJson(),
      if (proficiencies != null) 'proficiencies': proficiencies?.toJson(),
      if (prerequisites != null) 'prerequisites': prerequisites?.toJson(),
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
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (traits != null) 'traits': traits?.toJson(),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (specialAbilities != null)
        'specialAbilities': specialAbilities?.toJson(),
      if (proficiencies != null) 'proficiencies': proficiencies?.toJson(),
      if (prerequisites != null) 'prerequisites': prerequisites?.toJson(),
    };
  }

  static FeatDataInclude include() {
    return FeatDataInclude._();
  }

  static FeatDataIncludeList includeList({
    _i1.WhereExpressionBuilder<FeatDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatDataTable>? orderByList,
    FeatDataInclude? include,
  }) {
    return FeatDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FeatData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatDataImpl extends FeatData {
  _FeatDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<_i2.FeatureTag>? tags,
    List<String>? specialAbilities,
    List<String>? proficiencies,
    Map<String, int>? prerequisites,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          abilityBonuses: abilityBonuses,
          traits: traits,
          tags: tags,
          specialAbilities: specialAbilities,
          proficiencies: proficiencies,
          prerequisites: prerequisites,
        );

  /// Returns a shallow copy of this [FeatData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? abilityBonuses = _Undefined,
    Object? traits = _Undefined,
    Object? tags = _Undefined,
    Object? specialAbilities = _Undefined,
    Object? proficiencies = _Undefined,
    Object? prerequisites = _Undefined,
  }) {
    return FeatData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      abilityBonuses: abilityBonuses is Map<String, int>?
          ? abilityBonuses
          : this.abilityBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      traits: traits is List<String>?
          ? traits
          : this.traits?.map((e0) => e0).toList(),
      tags: tags is List<_i2.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
      specialAbilities: specialAbilities is List<String>?
          ? specialAbilities
          : this.specialAbilities?.map((e0) => e0).toList(),
      proficiencies: proficiencies is List<String>?
          ? proficiencies
          : this.proficiencies?.map((e0) => e0).toList(),
      prerequisites: prerequisites is Map<String, int>?
          ? prerequisites
          : this.prerequisites?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
    );
  }
}

class FeatDataTable extends _i1.Table<int?> {
  FeatDataTable({super.tableRelation}) : super(tableName: 'feat_data') {
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
    abilityBonuses = _i1.ColumnSerializable(
      'abilityBonuses',
      this,
    );
    traits = _i1.ColumnSerializable(
      'traits',
      this,
    );
    tags = _i1.ColumnSerializable(
      'tags',
      this,
    );
    specialAbilities = _i1.ColumnSerializable(
      'specialAbilities',
      this,
    );
    proficiencies = _i1.ColumnSerializable(
      'proficiencies',
      this,
    );
    prerequisites = _i1.ColumnSerializable(
      'prerequisites',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnSerializable abilityBonuses;

  late final _i1.ColumnSerializable traits;

  late final _i1.ColumnSerializable tags;

  late final _i1.ColumnSerializable specialAbilities;

  late final _i1.ColumnSerializable proficiencies;

  late final _i1.ColumnSerializable prerequisites;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        abilityBonuses,
        traits,
        tags,
        specialAbilities,
        proficiencies,
        prerequisites,
      ];
}

class FeatDataInclude extends _i1.IncludeObject {
  FeatDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FeatData.t;
}

class FeatDataIncludeList extends _i1.IncludeList {
  FeatDataIncludeList._({
    _i1.WhereExpressionBuilder<FeatDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FeatData.t;
}

class FeatDataRepository {
  const FeatDataRepository._();

  /// Returns a list of [FeatData]s matching the given query parameters.
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
  Future<List<FeatData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FeatData>(
      where: where?.call(FeatData.t),
      orderBy: orderBy?.call(FeatData.t),
      orderByList: orderByList?.call(FeatData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [FeatData] matching the given query parameters.
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
  Future<FeatData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<FeatDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<FeatData>(
      where: where?.call(FeatData.t),
      orderBy: orderBy?.call(FeatData.t),
      orderByList: orderByList?.call(FeatData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [FeatData] by its [id] or null if no such row exists.
  Future<FeatData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<FeatData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [FeatData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FeatData>> insert(
    _i1.Session session,
    List<FeatData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FeatData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FeatData] and returns the inserted row.
  ///
  /// The returned [FeatData] will have its `id` field set.
  Future<FeatData> insertRow(
    _i1.Session session,
    FeatData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FeatData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FeatData>> update(
    _i1.Session session,
    List<FeatData> rows, {
    _i1.ColumnSelections<FeatDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FeatData>(
      rows,
      columns: columns?.call(FeatData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatData> updateRow(
    _i1.Session session,
    FeatData row, {
    _i1.ColumnSelections<FeatDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatData>(
      row,
      columns: columns?.call(FeatData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [FeatData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FeatData>> delete(
    _i1.Session session,
    List<FeatData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FeatData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FeatData].
  Future<FeatData> deleteRow(
    _i1.Session session,
    FeatData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FeatData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FeatDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FeatData>(
      where: where(FeatData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FeatData>(
      where: where?.call(FeatData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
