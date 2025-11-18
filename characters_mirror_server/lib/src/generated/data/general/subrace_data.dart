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
import '../../data/general/race/race_data.dart' as _i2;

abstract class SubraceData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubraceData._({
    this.id,
    this.name,
    required this.parentRaceId,
    this.parentRace,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.abilityBonuses,
    this.traits,
    this.specialAbilities,
    this.skillProficiencies,
    this.speedBonus,
    this.swimSpeed,
    this.climbSpeed,
    this.flySpeed,
    this.visionType,
    this.resistances,
    this.variantOptions,
    this.ageDescription,
    this.alignmentDescription,
    this.physicalDescription,
  });

  factory SubraceData({
    int? id,
    String? name,
    required int parentRaceId,
    _i2.RaceData? parentRace,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? specialAbilities,
    List<String>? skillProficiencies,
    int? speedBonus,
    int? swimSpeed,
    int? climbSpeed,
    int? flySpeed,
    String? visionType,
    List<String>? resistances,
    List<String>? variantOptions,
    String? ageDescription,
    String? alignmentDescription,
    String? physicalDescription,
  }) = _SubraceDataImpl;

  factory SubraceData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubraceData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      parentRaceId: jsonSerialization['parentRaceId'] as int,
      parentRace: jsonSerialization['parentRace'] == null
          ? null
          : _i2.RaceData.fromJson(
              (jsonSerialization['parentRace'] as Map<String, dynamic>)),
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
      specialAbilities: (jsonSerialization['specialAbilities'] as List?)
          ?.map((e) => e as String)
          .toList(),
      skillProficiencies: (jsonSerialization['skillProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      speedBonus: jsonSerialization['speedBonus'] as int?,
      swimSpeed: jsonSerialization['swimSpeed'] as int?,
      climbSpeed: jsonSerialization['climbSpeed'] as int?,
      flySpeed: jsonSerialization['flySpeed'] as int?,
      visionType: jsonSerialization['visionType'] as String?,
      resistances: (jsonSerialization['resistances'] as List?)
          ?.map((e) => e as String)
          .toList(),
      variantOptions: (jsonSerialization['variantOptions'] as List?)
          ?.map((e) => e as String)
          .toList(),
      ageDescription: jsonSerialization['ageDescription'] as String?,
      alignmentDescription:
          jsonSerialization['alignmentDescription'] as String?,
      physicalDescription: jsonSerialization['physicalDescription'] as String?,
    );
  }

  static final t = SubraceDataTable();

  static const db = SubraceDataRepository._();

  @override
  int? id;

  String? name;

  int parentRaceId;

  _i2.RaceData? parentRace;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  Map<String, int>? abilityBonuses;

  List<String>? traits;

  List<String>? specialAbilities;

  List<String>? skillProficiencies;

  int? speedBonus;

  int? swimSpeed;

  int? climbSpeed;

  int? flySpeed;

  String? visionType;

  List<String>? resistances;

  List<String>? variantOptions;

  String? ageDescription;

  String? alignmentDescription;

  String? physicalDescription;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubraceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubraceData copyWith({
    int? id,
    String? name,
    int? parentRaceId,
    _i2.RaceData? parentRace,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? specialAbilities,
    List<String>? skillProficiencies,
    int? speedBonus,
    int? swimSpeed,
    int? climbSpeed,
    int? flySpeed,
    String? visionType,
    List<String>? resistances,
    List<String>? variantOptions,
    String? ageDescription,
    String? alignmentDescription,
    String? physicalDescription,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      'parentRaceId': parentRaceId,
      if (parentRace != null) 'parentRace': parentRace?.toJson(),
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (traits != null) 'traits': traits?.toJson(),
      if (specialAbilities != null)
        'specialAbilities': specialAbilities?.toJson(),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (speedBonus != null) 'speedBonus': speedBonus,
      if (swimSpeed != null) 'swimSpeed': swimSpeed,
      if (climbSpeed != null) 'climbSpeed': climbSpeed,
      if (flySpeed != null) 'flySpeed': flySpeed,
      if (visionType != null) 'visionType': visionType,
      if (resistances != null) 'resistances': resistances?.toJson(),
      if (variantOptions != null) 'variantOptions': variantOptions?.toJson(),
      if (ageDescription != null) 'ageDescription': ageDescription,
      if (alignmentDescription != null)
        'alignmentDescription': alignmentDescription,
      if (physicalDescription != null)
        'physicalDescription': physicalDescription,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      'parentRaceId': parentRaceId,
      if (parentRace != null) 'parentRace': parentRace?.toJsonForProtocol(),
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (traits != null) 'traits': traits?.toJson(),
      if (specialAbilities != null)
        'specialAbilities': specialAbilities?.toJson(),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (speedBonus != null) 'speedBonus': speedBonus,
      if (swimSpeed != null) 'swimSpeed': swimSpeed,
      if (climbSpeed != null) 'climbSpeed': climbSpeed,
      if (flySpeed != null) 'flySpeed': flySpeed,
      if (visionType != null) 'visionType': visionType,
      if (resistances != null) 'resistances': resistances?.toJson(),
      if (variantOptions != null) 'variantOptions': variantOptions?.toJson(),
      if (ageDescription != null) 'ageDescription': ageDescription,
      if (alignmentDescription != null)
        'alignmentDescription': alignmentDescription,
      if (physicalDescription != null)
        'physicalDescription': physicalDescription,
    };
  }

  static SubraceDataInclude include({_i2.RaceDataInclude? parentRace}) {
    return SubraceDataInclude._(parentRace: parentRace);
  }

  static SubraceDataIncludeList includeList({
    _i1.WhereExpressionBuilder<SubraceDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubraceDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubraceDataTable>? orderByList,
    SubraceDataInclude? include,
  }) {
    return SubraceDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubraceData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubraceData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubraceDataImpl extends SubraceData {
  _SubraceDataImpl({
    int? id,
    String? name,
    required int parentRaceId,
    _i2.RaceData? parentRace,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? specialAbilities,
    List<String>? skillProficiencies,
    int? speedBonus,
    int? swimSpeed,
    int? climbSpeed,
    int? flySpeed,
    String? visionType,
    List<String>? resistances,
    List<String>? variantOptions,
    String? ageDescription,
    String? alignmentDescription,
    String? physicalDescription,
  }) : super._(
          id: id,
          name: name,
          parentRaceId: parentRaceId,
          parentRace: parentRace,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          abilityBonuses: abilityBonuses,
          traits: traits,
          specialAbilities: specialAbilities,
          skillProficiencies: skillProficiencies,
          speedBonus: speedBonus,
          swimSpeed: swimSpeed,
          climbSpeed: climbSpeed,
          flySpeed: flySpeed,
          visionType: visionType,
          resistances: resistances,
          variantOptions: variantOptions,
          ageDescription: ageDescription,
          alignmentDescription: alignmentDescription,
          physicalDescription: physicalDescription,
        );

  /// Returns a shallow copy of this [SubraceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubraceData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    int? parentRaceId,
    Object? parentRace = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? abilityBonuses = _Undefined,
    Object? traits = _Undefined,
    Object? specialAbilities = _Undefined,
    Object? skillProficiencies = _Undefined,
    Object? speedBonus = _Undefined,
    Object? swimSpeed = _Undefined,
    Object? climbSpeed = _Undefined,
    Object? flySpeed = _Undefined,
    Object? visionType = _Undefined,
    Object? resistances = _Undefined,
    Object? variantOptions = _Undefined,
    Object? ageDescription = _Undefined,
    Object? alignmentDescription = _Undefined,
    Object? physicalDescription = _Undefined,
  }) {
    return SubraceData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      parentRaceId: parentRaceId ?? this.parentRaceId,
      parentRace: parentRace is _i2.RaceData?
          ? parentRace
          : this.parentRace?.copyWith(),
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
      specialAbilities: specialAbilities is List<String>?
          ? specialAbilities
          : this.specialAbilities?.map((e0) => e0).toList(),
      skillProficiencies: skillProficiencies is List<String>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      speedBonus: speedBonus is int? ? speedBonus : this.speedBonus,
      swimSpeed: swimSpeed is int? ? swimSpeed : this.swimSpeed,
      climbSpeed: climbSpeed is int? ? climbSpeed : this.climbSpeed,
      flySpeed: flySpeed is int? ? flySpeed : this.flySpeed,
      visionType: visionType is String? ? visionType : this.visionType,
      resistances: resistances is List<String>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
      variantOptions: variantOptions is List<String>?
          ? variantOptions
          : this.variantOptions?.map((e0) => e0).toList(),
      ageDescription:
          ageDescription is String? ? ageDescription : this.ageDescription,
      alignmentDescription: alignmentDescription is String?
          ? alignmentDescription
          : this.alignmentDescription,
      physicalDescription: physicalDescription is String?
          ? physicalDescription
          : this.physicalDescription,
    );
  }
}

class SubraceDataTable extends _i1.Table<int?> {
  SubraceDataTable({super.tableRelation}) : super(tableName: 'subrace_data') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    parentRaceId = _i1.ColumnInt(
      'parentRaceId',
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
    specialAbilities = _i1.ColumnSerializable(
      'specialAbilities',
      this,
    );
    skillProficiencies = _i1.ColumnSerializable(
      'skillProficiencies',
      this,
    );
    speedBonus = _i1.ColumnInt(
      'speedBonus',
      this,
    );
    swimSpeed = _i1.ColumnInt(
      'swimSpeed',
      this,
    );
    climbSpeed = _i1.ColumnInt(
      'climbSpeed',
      this,
    );
    flySpeed = _i1.ColumnInt(
      'flySpeed',
      this,
    );
    visionType = _i1.ColumnString(
      'visionType',
      this,
    );
    resistances = _i1.ColumnSerializable(
      'resistances',
      this,
    );
    variantOptions = _i1.ColumnSerializable(
      'variantOptions',
      this,
    );
    ageDescription = _i1.ColumnString(
      'ageDescription',
      this,
    );
    alignmentDescription = _i1.ColumnString(
      'alignmentDescription',
      this,
    );
    physicalDescription = _i1.ColumnString(
      'physicalDescription',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnInt parentRaceId;

  _i2.RaceDataTable? _parentRace;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnSerializable abilityBonuses;

  late final _i1.ColumnSerializable traits;

  late final _i1.ColumnSerializable specialAbilities;

  late final _i1.ColumnSerializable skillProficiencies;

  late final _i1.ColumnInt speedBonus;

  late final _i1.ColumnInt swimSpeed;

  late final _i1.ColumnInt climbSpeed;

  late final _i1.ColumnInt flySpeed;

  late final _i1.ColumnString visionType;

  late final _i1.ColumnSerializable resistances;

  late final _i1.ColumnSerializable variantOptions;

  late final _i1.ColumnString ageDescription;

  late final _i1.ColumnString alignmentDescription;

  late final _i1.ColumnString physicalDescription;

  _i2.RaceDataTable get parentRace {
    if (_parentRace != null) return _parentRace!;
    _parentRace = _i1.createRelationTable(
      relationFieldName: 'parentRace',
      field: SubraceData.t.parentRaceId,
      foreignField: _i2.RaceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RaceDataTable(tableRelation: foreignTableRelation),
    );
    return _parentRace!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        parentRaceId,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        abilityBonuses,
        traits,
        specialAbilities,
        skillProficiencies,
        speedBonus,
        swimSpeed,
        climbSpeed,
        flySpeed,
        visionType,
        resistances,
        variantOptions,
        ageDescription,
        alignmentDescription,
        physicalDescription,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'parentRace') {
      return parentRace;
    }
    return null;
  }
}

class SubraceDataInclude extends _i1.IncludeObject {
  SubraceDataInclude._({_i2.RaceDataInclude? parentRace}) {
    _parentRace = parentRace;
  }

  _i2.RaceDataInclude? _parentRace;

  @override
  Map<String, _i1.Include?> get includes => {'parentRace': _parentRace};

  @override
  _i1.Table<int?> get table => SubraceData.t;
}

class SubraceDataIncludeList extends _i1.IncludeList {
  SubraceDataIncludeList._({
    _i1.WhereExpressionBuilder<SubraceDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubraceData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubraceData.t;
}

class SubraceDataRepository {
  const SubraceDataRepository._();

  final attachRow = const SubraceDataAttachRowRepository._();

  /// Returns a list of [SubraceData]s matching the given query parameters.
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
  Future<List<SubraceData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubraceDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubraceDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubraceDataTable>? orderByList,
    _i1.Transaction? transaction,
    SubraceDataInclude? include,
  }) async {
    return session.db.find<SubraceData>(
      where: where?.call(SubraceData.t),
      orderBy: orderBy?.call(SubraceData.t),
      orderByList: orderByList?.call(SubraceData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SubraceData] matching the given query parameters.
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
  Future<SubraceData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubraceDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubraceDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubraceDataTable>? orderByList,
    _i1.Transaction? transaction,
    SubraceDataInclude? include,
  }) async {
    return session.db.findFirstRow<SubraceData>(
      where: where?.call(SubraceData.t),
      orderBy: orderBy?.call(SubraceData.t),
      orderByList: orderByList?.call(SubraceData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SubraceData] by its [id] or null if no such row exists.
  Future<SubraceData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SubraceDataInclude? include,
  }) async {
    return session.db.findById<SubraceData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SubraceData]s in the list and returns the inserted rows.
  ///
  /// The returned [SubraceData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SubraceData>> insert(
    _i1.Session session,
    List<SubraceData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SubraceData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SubraceData] and returns the inserted row.
  ///
  /// The returned [SubraceData] will have its `id` field set.
  Future<SubraceData> insertRow(
    _i1.Session session,
    SubraceData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubraceData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubraceData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubraceData>> update(
    _i1.Session session,
    List<SubraceData> rows, {
    _i1.ColumnSelections<SubraceDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubraceData>(
      rows,
      columns: columns?.call(SubraceData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubraceData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubraceData> updateRow(
    _i1.Session session,
    SubraceData row, {
    _i1.ColumnSelections<SubraceDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubraceData>(
      row,
      columns: columns?.call(SubraceData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SubraceData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubraceData>> delete(
    _i1.Session session,
    List<SubraceData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubraceData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubraceData].
  Future<SubraceData> deleteRow(
    _i1.Session session,
    SubraceData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubraceData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubraceData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SubraceDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubraceData>(
      where: where(SubraceData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubraceDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubraceData>(
      where: where?.call(SubraceData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SubraceDataAttachRowRepository {
  const SubraceDataAttachRowRepository._();

  /// Creates a relation between the given [SubraceData] and [RaceData]
  /// by setting the [SubraceData]'s foreign key `parentRaceId` to refer to the [RaceData].
  Future<void> parentRace(
    _i1.Session session,
    SubraceData subraceData,
    _i2.RaceData parentRace, {
    _i1.Transaction? transaction,
  }) async {
    if (subraceData.id == null) {
      throw ArgumentError.notNull('subraceData.id');
    }
    if (parentRace.id == null) {
      throw ArgumentError.notNull('parentRace.id');
    }

    var $subraceData = subraceData.copyWith(parentRaceId: parentRace.id);
    await session.db.updateRow<SubraceData>(
      $subraceData,
      columns: [SubraceData.t.parentRaceId],
      transaction: transaction,
    );
  }
}
