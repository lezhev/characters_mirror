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
import '../../../enums/damage_type.dart' as _i3;
import '../../../data/general/race/race_feature_data.dart' as _i4;

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
    this.strengthBonus,
    this.dexterityBonus,
    this.constitutionBonus,
    this.intelligenceBonus,
    this.wisdomBonus,
    this.charismaBonus,
    this.traits,
    this.speedOverride,
    this.visionRangeOverride,
    this.skillProficiencies,
    this.resistances,
    this.armorProficiencies,
    this.weaponProficiencies,
    this.toolProficiencies,
    this.features,
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
    int? strengthBonus,
    int? dexterityBonus,
    int? constitutionBonus,
    int? intelligenceBonus,
    int? wisdomBonus,
    int? charismaBonus,
    List<String>? traits,
    int? speedOverride,
    int? visionRangeOverride,
    List<String>? skillProficiencies,
    List<_i3.DamageType>? resistances,
    List<String>? armorProficiencies,
    List<String>? weaponProficiencies,
    List<String>? toolProficiencies,
    List<_i4.RaceFeatureData>? features,
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
      strengthBonus: jsonSerialization['strengthBonus'] as int?,
      dexterityBonus: jsonSerialization['dexterityBonus'] as int?,
      constitutionBonus: jsonSerialization['constitutionBonus'] as int?,
      intelligenceBonus: jsonSerialization['intelligenceBonus'] as int?,
      wisdomBonus: jsonSerialization['wisdomBonus'] as int?,
      charismaBonus: jsonSerialization['charismaBonus'] as int?,
      traits: (jsonSerialization['traits'] as List?)
          ?.map((e) => e as String)
          .toList(),
      speedOverride: jsonSerialization['speedOverride'] as int?,
      visionRangeOverride: jsonSerialization['visionRangeOverride'] as int?,
      skillProficiencies: (jsonSerialization['skillProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      resistances: (jsonSerialization['resistances'] as List?)
          ?.map((e) => _i3.DamageType.fromJson((e as String)))
          .toList(),
      armorProficiencies: (jsonSerialization['armorProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      weaponProficiencies: (jsonSerialization['weaponProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      toolProficiencies: (jsonSerialization['toolProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      features: (jsonSerialization['features'] as List?)
          ?.map(
              (e) => _i4.RaceFeatureData.fromJson((e as Map<String, dynamic>)))
          .toList(),
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

  int? strengthBonus;

  int? dexterityBonus;

  int? constitutionBonus;

  int? intelligenceBonus;

  int? wisdomBonus;

  int? charismaBonus;

  List<String>? traits;

  int? speedOverride;

  int? visionRangeOverride;

  List<String>? skillProficiencies;

  List<_i3.DamageType>? resistances;

  List<String>? armorProficiencies;

  List<String>? weaponProficiencies;

  List<String>? toolProficiencies;

  List<_i4.RaceFeatureData>? features;

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
    int? strengthBonus,
    int? dexterityBonus,
    int? constitutionBonus,
    int? intelligenceBonus,
    int? wisdomBonus,
    int? charismaBonus,
    List<String>? traits,
    int? speedOverride,
    int? visionRangeOverride,
    List<String>? skillProficiencies,
    List<_i3.DamageType>? resistances,
    List<String>? armorProficiencies,
    List<String>? weaponProficiencies,
    List<String>? toolProficiencies,
    List<_i4.RaceFeatureData>? features,
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
      if (strengthBonus != null) 'strengthBonus': strengthBonus,
      if (dexterityBonus != null) 'dexterityBonus': dexterityBonus,
      if (constitutionBonus != null) 'constitutionBonus': constitutionBonus,
      if (intelligenceBonus != null) 'intelligenceBonus': intelligenceBonus,
      if (wisdomBonus != null) 'wisdomBonus': wisdomBonus,
      if (charismaBonus != null) 'charismaBonus': charismaBonus,
      if (traits != null) 'traits': traits?.toJson(),
      if (speedOverride != null) 'speedOverride': speedOverride,
      if (visionRangeOverride != null)
        'visionRangeOverride': visionRangeOverride,
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
      if (armorProficiencies != null)
        'armorProficiencies': armorProficiencies?.toJson(),
      if (weaponProficiencies != null)
        'weaponProficiencies': weaponProficiencies?.toJson(),
      if (toolProficiencies != null)
        'toolProficiencies': toolProficiencies?.toJson(),
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJson()),
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
      if (strengthBonus != null) 'strengthBonus': strengthBonus,
      if (dexterityBonus != null) 'dexterityBonus': dexterityBonus,
      if (constitutionBonus != null) 'constitutionBonus': constitutionBonus,
      if (intelligenceBonus != null) 'intelligenceBonus': intelligenceBonus,
      if (wisdomBonus != null) 'wisdomBonus': wisdomBonus,
      if (charismaBonus != null) 'charismaBonus': charismaBonus,
      if (traits != null) 'traits': traits?.toJson(),
      if (speedOverride != null) 'speedOverride': speedOverride,
      if (visionRangeOverride != null)
        'visionRangeOverride': visionRangeOverride,
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
      if (armorProficiencies != null)
        'armorProficiencies': armorProficiencies?.toJson(),
      if (weaponProficiencies != null)
        'weaponProficiencies': weaponProficiencies?.toJson(),
      if (toolProficiencies != null)
        'toolProficiencies': toolProficiencies?.toJson(),
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static SubraceDataInclude include({
    _i2.RaceDataInclude? parentRace,
    _i4.RaceFeatureDataIncludeList? features,
  }) {
    return SubraceDataInclude._(
      parentRace: parentRace,
      features: features,
    );
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
    int? strengthBonus,
    int? dexterityBonus,
    int? constitutionBonus,
    int? intelligenceBonus,
    int? wisdomBonus,
    int? charismaBonus,
    List<String>? traits,
    int? speedOverride,
    int? visionRangeOverride,
    List<String>? skillProficiencies,
    List<_i3.DamageType>? resistances,
    List<String>? armorProficiencies,
    List<String>? weaponProficiencies,
    List<String>? toolProficiencies,
    List<_i4.RaceFeatureData>? features,
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
          strengthBonus: strengthBonus,
          dexterityBonus: dexterityBonus,
          constitutionBonus: constitutionBonus,
          intelligenceBonus: intelligenceBonus,
          wisdomBonus: wisdomBonus,
          charismaBonus: charismaBonus,
          traits: traits,
          speedOverride: speedOverride,
          visionRangeOverride: visionRangeOverride,
          skillProficiencies: skillProficiencies,
          resistances: resistances,
          armorProficiencies: armorProficiencies,
          weaponProficiencies: weaponProficiencies,
          toolProficiencies: toolProficiencies,
          features: features,
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
    Object? strengthBonus = _Undefined,
    Object? dexterityBonus = _Undefined,
    Object? constitutionBonus = _Undefined,
    Object? intelligenceBonus = _Undefined,
    Object? wisdomBonus = _Undefined,
    Object? charismaBonus = _Undefined,
    Object? traits = _Undefined,
    Object? speedOverride = _Undefined,
    Object? visionRangeOverride = _Undefined,
    Object? skillProficiencies = _Undefined,
    Object? resistances = _Undefined,
    Object? armorProficiencies = _Undefined,
    Object? weaponProficiencies = _Undefined,
    Object? toolProficiencies = _Undefined,
    Object? features = _Undefined,
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
      strengthBonus: strengthBonus is int? ? strengthBonus : this.strengthBonus,
      dexterityBonus:
          dexterityBonus is int? ? dexterityBonus : this.dexterityBonus,
      constitutionBonus: constitutionBonus is int?
          ? constitutionBonus
          : this.constitutionBonus,
      intelligenceBonus: intelligenceBonus is int?
          ? intelligenceBonus
          : this.intelligenceBonus,
      wisdomBonus: wisdomBonus is int? ? wisdomBonus : this.wisdomBonus,
      charismaBonus: charismaBonus is int? ? charismaBonus : this.charismaBonus,
      traits: traits is List<String>?
          ? traits
          : this.traits?.map((e0) => e0).toList(),
      speedOverride: speedOverride is int? ? speedOverride : this.speedOverride,
      visionRangeOverride: visionRangeOverride is int?
          ? visionRangeOverride
          : this.visionRangeOverride,
      skillProficiencies: skillProficiencies is List<String>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      resistances: resistances is List<_i3.DamageType>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
      armorProficiencies: armorProficiencies is List<String>?
          ? armorProficiencies
          : this.armorProficiencies?.map((e0) => e0).toList(),
      weaponProficiencies: weaponProficiencies is List<String>?
          ? weaponProficiencies
          : this.weaponProficiencies?.map((e0) => e0).toList(),
      toolProficiencies: toolProficiencies is List<String>?
          ? toolProficiencies
          : this.toolProficiencies?.map((e0) => e0).toList(),
      features: features is List<_i4.RaceFeatureData>?
          ? features
          : this.features?.map((e0) => e0.copyWith()).toList(),
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
    strengthBonus = _i1.ColumnInt(
      'strengthBonus',
      this,
    );
    dexterityBonus = _i1.ColumnInt(
      'dexterityBonus',
      this,
    );
    constitutionBonus = _i1.ColumnInt(
      'constitutionBonus',
      this,
    );
    intelligenceBonus = _i1.ColumnInt(
      'intelligenceBonus',
      this,
    );
    wisdomBonus = _i1.ColumnInt(
      'wisdomBonus',
      this,
    );
    charismaBonus = _i1.ColumnInt(
      'charismaBonus',
      this,
    );
    traits = _i1.ColumnSerializable(
      'traits',
      this,
    );
    speedOverride = _i1.ColumnInt(
      'speedOverride',
      this,
    );
    visionRangeOverride = _i1.ColumnInt(
      'visionRangeOverride',
      this,
    );
    skillProficiencies = _i1.ColumnSerializable(
      'skillProficiencies',
      this,
    );
    resistances = _i1.ColumnSerializable(
      'resistances',
      this,
    );
    armorProficiencies = _i1.ColumnSerializable(
      'armorProficiencies',
      this,
    );
    weaponProficiencies = _i1.ColumnSerializable(
      'weaponProficiencies',
      this,
    );
    toolProficiencies = _i1.ColumnSerializable(
      'toolProficiencies',
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

  late final _i1.ColumnInt strengthBonus;

  late final _i1.ColumnInt dexterityBonus;

  late final _i1.ColumnInt constitutionBonus;

  late final _i1.ColumnInt intelligenceBonus;

  late final _i1.ColumnInt wisdomBonus;

  late final _i1.ColumnInt charismaBonus;

  late final _i1.ColumnSerializable traits;

  late final _i1.ColumnInt speedOverride;

  late final _i1.ColumnInt visionRangeOverride;

  late final _i1.ColumnSerializable skillProficiencies;

  late final _i1.ColumnSerializable resistances;

  late final _i1.ColumnSerializable armorProficiencies;

  late final _i1.ColumnSerializable weaponProficiencies;

  late final _i1.ColumnSerializable toolProficiencies;

  _i4.RaceFeatureDataTable? ___features;

  _i1.ManyRelation<_i4.RaceFeatureDataTable>? _features;

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

  _i4.RaceFeatureDataTable get __features {
    if (___features != null) return ___features!;
    ___features = _i1.createRelationTable(
      relationFieldName: '__features',
      field: SubraceData.t.id,
      foreignField: _i4.RaceFeatureData.t.subraceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return ___features!;
  }

  _i1.ManyRelation<_i4.RaceFeatureDataTable> get features {
    if (_features != null) return _features!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'features',
      field: SubraceData.t.id,
      foreignField: _i4.RaceFeatureData.t.subraceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    _features = _i1.ManyRelation<_i4.RaceFeatureDataTable>(
      tableWithRelations: relationTable,
      table: _i4.RaceFeatureDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _features!;
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
        strengthBonus,
        dexterityBonus,
        constitutionBonus,
        intelligenceBonus,
        wisdomBonus,
        charismaBonus,
        traits,
        speedOverride,
        visionRangeOverride,
        skillProficiencies,
        resistances,
        armorProficiencies,
        weaponProficiencies,
        toolProficiencies,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'parentRace') {
      return parentRace;
    }
    if (relationField == 'features') {
      return __features;
    }
    return null;
  }
}

class SubraceDataInclude extends _i1.IncludeObject {
  SubraceDataInclude._({
    _i2.RaceDataInclude? parentRace,
    _i4.RaceFeatureDataIncludeList? features,
  }) {
    _parentRace = parentRace;
    _features = features;
  }

  _i2.RaceDataInclude? _parentRace;

  _i4.RaceFeatureDataIncludeList? _features;

  @override
  Map<String, _i1.Include?> get includes => {
        'parentRace': _parentRace,
        'features': _features,
      };

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

  final attach = const SubraceDataAttachRepository._();

  final attachRow = const SubraceDataAttachRowRepository._();

  final detach = const SubraceDataDetachRepository._();

  final detachRow = const SubraceDataDetachRowRepository._();

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

class SubraceDataAttachRepository {
  const SubraceDataAttachRepository._();

  /// Creates a relation between this [SubraceData] and the given [RaceFeatureData]s
  /// by setting each [RaceFeatureData]'s foreign key `subraceId` to refer to this [SubraceData].
  Future<void> features(
    _i1.Session session,
    SubraceData subraceData,
    List<_i4.RaceFeatureData> raceFeatureData, {
    _i1.Transaction? transaction,
  }) async {
    if (raceFeatureData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }
    if (subraceData.id == null) {
      throw ArgumentError.notNull('subraceData.id');
    }

    var $raceFeatureData = raceFeatureData
        .map((e) => e.copyWith(subraceId: subraceData.id))
        .toList();
    await session.db.update<_i4.RaceFeatureData>(
      $raceFeatureData,
      columns: [_i4.RaceFeatureData.t.subraceId],
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

  /// Creates a relation between this [SubraceData] and the given [RaceFeatureData]
  /// by setting the [RaceFeatureData]'s foreign key `subraceId` to refer to this [SubraceData].
  Future<void> features(
    _i1.Session session,
    SubraceData subraceData,
    _i4.RaceFeatureData raceFeatureData, {
    _i1.Transaction? transaction,
  }) async {
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }
    if (subraceData.id == null) {
      throw ArgumentError.notNull('subraceData.id');
    }

    var $raceFeatureData = raceFeatureData.copyWith(subraceId: subraceData.id);
    await session.db.updateRow<_i4.RaceFeatureData>(
      $raceFeatureData,
      columns: [_i4.RaceFeatureData.t.subraceId],
      transaction: transaction,
    );
  }
}

class SubraceDataDetachRepository {
  const SubraceDataDetachRepository._();

  /// Detaches the relation between this [SubraceData] and the given [RaceFeatureData]
  /// by setting the [RaceFeatureData]'s foreign key `subraceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> features(
    _i1.Session session,
    List<_i4.RaceFeatureData> raceFeatureData, {
    _i1.Transaction? transaction,
  }) async {
    if (raceFeatureData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $raceFeatureData =
        raceFeatureData.map((e) => e.copyWith(subraceId: null)).toList();
    await session.db.update<_i4.RaceFeatureData>(
      $raceFeatureData,
      columns: [_i4.RaceFeatureData.t.subraceId],
      transaction: transaction,
    );
  }
}

class SubraceDataDetachRowRepository {
  const SubraceDataDetachRowRepository._();

  /// Detaches the relation between this [SubraceData] and the given [RaceFeatureData]
  /// by setting the [RaceFeatureData]'s foreign key `subraceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> features(
    _i1.Session session,
    _i4.RaceFeatureData raceFeatureData, {
    _i1.Transaction? transaction,
  }) async {
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $raceFeatureData = raceFeatureData.copyWith(subraceId: null);
    await session.db.updateRow<_i4.RaceFeatureData>(
      $raceFeatureData,
      columns: [_i4.RaceFeatureData.t.subraceId],
      transaction: transaction,
    );
  }
}
