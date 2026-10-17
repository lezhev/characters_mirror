/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../data/general/race/race_data.dart' as _ittxuxz1;
import '../../../data/general/race/race_feature_data.dart' as _ib72xv5p;
import '../../../enums/armor_category.dart' as _irzuusaf;
import '../../../enums/damage_type.dart' as _ij9bzpyl;
import '../../../enums/skill.dart' as _iqrhamom;

abstract class SubraceData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    this.weaponProficiencyKeys,
    this.toolProficiencyKeys,
    this.features,
  });

  factory SubraceData({
    int? id,
    String? name,
    required int parentRaceId,
    _ittxuxz1.RaceData? parentRace,
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
    List<_iqrhamom.Skill>? skillProficiencies,
    List<_ij9bzpyl.DamageType>? resistances,
    List<_irzuusaf.ArmorCategory>? armorProficiencies,
    List<String>? weaponProficiencyKeys,
    List<String>? toolProficiencyKeys,
    List<_ib72xv5p.RaceFeatureData>? features,
  }) = _SubraceDataImpl;

  factory SubraceData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubraceData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      parentRaceId: jsonSerialization['parentRaceId'] as int,
      parentRace: jsonSerialization['parentRace'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_ittxuxz1.RaceData>(
              jsonSerialization['parentRace'],
            ),
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      strengthBonus: jsonSerialization['strengthBonus'] as int?,
      dexterityBonus: jsonSerialization['dexterityBonus'] as int?,
      constitutionBonus: jsonSerialization['constitutionBonus'] as int?,
      intelligenceBonus: jsonSerialization['intelligenceBonus'] as int?,
      wisdomBonus: jsonSerialization['wisdomBonus'] as int?,
      charismaBonus: jsonSerialization['charismaBonus'] as int?,
      traits: jsonSerialization['traits'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['traits'],
            ),
      speedOverride: jsonSerialization['speedOverride'] as int?,
      visionRangeOverride: jsonSerialization['visionRangeOverride'] as int?,
      skillProficiencies: jsonSerialization['skillProficiencies'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iqrhamom.Skill>>(
              jsonSerialization['skillProficiencies'],
            ),
      resistances: jsonSerialization['resistances'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ij9bzpyl.DamageType>>(
              jsonSerialization['resistances'],
            ),
      armorProficiencies: jsonSerialization['armorProficiencies'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_irzuusaf.ArmorCategory>>(
              jsonSerialization['armorProficiencies'],
            ),
      weaponProficiencyKeys: jsonSerialization['weaponProficiencyKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['weaponProficiencyKeys'],
            ),
      toolProficiencyKeys: jsonSerialization['toolProficiencyKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['toolProficiencyKeys'],
            ),
      features: jsonSerialization['features'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ib72xv5p.RaceFeatureData>>(
              jsonSerialization['features'],
            ),
    );
  }

  static final t = SubraceDataTable();

  static const db = SubraceDataRepository._();

  @override
  int? id;

  String? name;

  int parentRaceId;

  _ittxuxz1.RaceData? parentRace;

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

  List<_iqrhamom.Skill>? skillProficiencies;

  List<_ij9bzpyl.DamageType>? resistances;

  List<_irzuusaf.ArmorCategory>? armorProficiencies;

  List<String>? weaponProficiencyKeys;

  List<String>? toolProficiencyKeys;

  List<_ib72xv5p.RaceFeatureData>? features;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubraceData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SubraceData copyWith({
    int? id,
    String? name,
    int? parentRaceId,
    _ittxuxz1.RaceData? parentRace,
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
    List<_iqrhamom.Skill>? skillProficiencies,
    List<_ij9bzpyl.DamageType>? resistances,
    List<_irzuusaf.ArmorCategory>? armorProficiencies,
    List<String>? weaponProficiencyKeys,
    List<String>? toolProficiencyKeys,
    List<_ib72xv5p.RaceFeatureData>? features,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubraceData',
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
        'skillProficiencies': skillProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
      if (armorProficiencies != null)
        'armorProficiencies': armorProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (weaponProficiencyKeys != null)
        'weaponProficiencyKeys': weaponProficiencyKeys?.toJson(),
      if (toolProficiencyKeys != null)
        'toolProficiencyKeys': toolProficiencyKeys?.toJson(),
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubraceData',
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
        'skillProficiencies': skillProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
      if (armorProficiencies != null)
        'armorProficiencies': armorProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (weaponProficiencyKeys != null)
        'weaponProficiencyKeys': weaponProficiencyKeys?.toJson(),
      if (toolProficiencyKeys != null)
        'toolProficiencyKeys': toolProficiencyKeys?.toJson(),
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static SubraceDataInclude include({
    _ittxuxz1.RaceDataInclude? parentRace,
    _ib72xv5p.RaceFeatureDataIncludeList? features,
  }) {
    return SubraceDataInclude._(parentRace: parentRace, features: features);
  }

  static SubraceDataIncludeList includeList({
    _is.WhereExpressionBuilder<SubraceDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SubraceDataTable>? orderBy,
    _is.OrderByListBuilder<SubraceDataTable>? orderByList,
    SubraceDataInclude? include,
  }) {
    return SubraceDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubraceData.t),
      orderByList: orderByList?.call(SubraceData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubraceDataImpl extends SubraceData {
  _SubraceDataImpl({
    int? id,
    String? name,
    required int parentRaceId,
    _ittxuxz1.RaceData? parentRace,
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
    List<_iqrhamom.Skill>? skillProficiencies,
    List<_ij9bzpyl.DamageType>? resistances,
    List<_irzuusaf.ArmorCategory>? armorProficiencies,
    List<String>? weaponProficiencyKeys,
    List<String>? toolProficiencyKeys,
    List<_ib72xv5p.RaceFeatureData>? features,
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
         weaponProficiencyKeys: weaponProficiencyKeys,
         toolProficiencyKeys: toolProficiencyKeys,
         features: features,
       );

  /// Returns a shallow copy of this [SubraceData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
    Object? weaponProficiencyKeys = _Undefined,
    Object? toolProficiencyKeys = _Undefined,
    Object? features = _Undefined,
  }) {
    return SubraceData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      parentRaceId: parentRaceId ?? this.parentRaceId,
      parentRace: parentRace is _ittxuxz1.RaceData?
          ? parentRace
          : this.parentRace?.copyWith(),
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      strengthBonus: strengthBonus is int? ? strengthBonus : this.strengthBonus,
      dexterityBonus: dexterityBonus is int?
          ? dexterityBonus
          : this.dexterityBonus,
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
      skillProficiencies: skillProficiencies is List<_iqrhamom.Skill>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      resistances: resistances is List<_ij9bzpyl.DamageType>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
      armorProficiencies: armorProficiencies is List<_irzuusaf.ArmorCategory>?
          ? armorProficiencies
          : this.armorProficiencies?.map((e0) => e0).toList(),
      weaponProficiencyKeys: weaponProficiencyKeys is List<String>?
          ? weaponProficiencyKeys
          : this.weaponProficiencyKeys?.map((e0) => e0).toList(),
      toolProficiencyKeys: toolProficiencyKeys is List<String>?
          ? toolProficiencyKeys
          : this.toolProficiencyKeys?.map((e0) => e0).toList(),
      features: features is List<_ib72xv5p.RaceFeatureData>?
          ? features
          : this.features?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class SubraceDataUpdateTable extends _is.UpdateTable<SubraceDataTable> {
  SubraceDataUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String? value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<int, int> parentRaceId(int value) =>
      _is.ColumnValue(table.parentRaceId, value);

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

  _is.ColumnValue<int, int> strengthBonus(int? value) =>
      _is.ColumnValue(table.strengthBonus, value);

  _is.ColumnValue<int, int> dexterityBonus(int? value) =>
      _is.ColumnValue(table.dexterityBonus, value);

  _is.ColumnValue<int, int> constitutionBonus(int? value) =>
      _is.ColumnValue(table.constitutionBonus, value);

  _is.ColumnValue<int, int> intelligenceBonus(int? value) =>
      _is.ColumnValue(table.intelligenceBonus, value);

  _is.ColumnValue<int, int> wisdomBonus(int? value) =>
      _is.ColumnValue(table.wisdomBonus, value);

  _is.ColumnValue<int, int> charismaBonus(int? value) =>
      _is.ColumnValue(table.charismaBonus, value);

  _is.ColumnValue<List<String>, List<String>> traits(List<String>? value) =>
      _is.ColumnValue(table.traits, value);

  _is.ColumnValue<int, int> speedOverride(int? value) =>
      _is.ColumnValue(table.speedOverride, value);

  _is.ColumnValue<int, int> visionRangeOverride(int? value) =>
      _is.ColumnValue(table.visionRangeOverride, value);

  _is.ColumnValue<List<_iqrhamom.Skill>, List<_iqrhamom.Skill>>
  skillProficiencies(List<_iqrhamom.Skill>? value) =>
      _is.ColumnValue(table.skillProficiencies, value);

  _is.ColumnValue<List<_ij9bzpyl.DamageType>, List<_ij9bzpyl.DamageType>>
  resistances(List<_ij9bzpyl.DamageType>? value) =>
      _is.ColumnValue(table.resistances, value);

  _is.ColumnValue<List<_irzuusaf.ArmorCategory>, List<_irzuusaf.ArmorCategory>>
  armorProficiencies(List<_irzuusaf.ArmorCategory>? value) =>
      _is.ColumnValue(table.armorProficiencies, value);

  _is.ColumnValue<List<String>, List<String>> weaponProficiencyKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.weaponProficiencyKeys, value);

  _is.ColumnValue<List<String>, List<String>> toolProficiencyKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.toolProficiencyKeys, value);
}

class SubraceDataTable extends _is.Table<int?> {
  SubraceDataTable({super.tableRelation}) : super(tableName: 'subrace_data') {
    updateTable = SubraceDataUpdateTable(this);
    name = _is.ColumnString('name', this);
    parentRaceId = _is.ColumnInt('parentRaceId', this);
    description = _is.ColumnString('description', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    strengthBonus = _is.ColumnInt('strengthBonus', this);
    dexterityBonus = _is.ColumnInt('dexterityBonus', this);
    constitutionBonus = _is.ColumnInt('constitutionBonus', this);
    intelligenceBonus = _is.ColumnInt('intelligenceBonus', this);
    wisdomBonus = _is.ColumnInt('wisdomBonus', this);
    charismaBonus = _is.ColumnInt('charismaBonus', this);
    traits = _is.ColumnSerializable<List<String>>('traits', this);
    speedOverride = _is.ColumnInt('speedOverride', this);
    visionRangeOverride = _is.ColumnInt('visionRangeOverride', this);
    skillProficiencies = _is.ColumnSerializable<List<_iqrhamom.Skill>>(
      'skillProficiencies',
      this,
    );
    resistances = _is.ColumnSerializable<List<_ij9bzpyl.DamageType>>(
      'resistances',
      this,
    );
    armorProficiencies = _is.ColumnSerializable<List<_irzuusaf.ArmorCategory>>(
      'armorProficiencies',
      this,
    );
    weaponProficiencyKeys = _is.ColumnSerializable<List<String>>(
      'weaponProficiencyKeys',
      this,
    );
    toolProficiencyKeys = _is.ColumnSerializable<List<String>>(
      'toolProficiencyKeys',
      this,
    );
  }

  late final SubraceDataUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnInt parentRaceId;

  _ittxuxz1.RaceDataTable? _parentRace;

  late final _is.ColumnString description;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnInt strengthBonus;

  late final _is.ColumnInt dexterityBonus;

  late final _is.ColumnInt constitutionBonus;

  late final _is.ColumnInt intelligenceBonus;

  late final _is.ColumnInt wisdomBonus;

  late final _is.ColumnInt charismaBonus;

  late final _is.ColumnSerializable<List<String>> traits;

  late final _is.ColumnInt speedOverride;

  late final _is.ColumnInt visionRangeOverride;

  late final _is.ColumnSerializable<List<_iqrhamom.Skill>> skillProficiencies;

  late final _is.ColumnSerializable<List<_ij9bzpyl.DamageType>> resistances;

  late final _is.ColumnSerializable<List<_irzuusaf.ArmorCategory>>
  armorProficiencies;

  late final _is.ColumnSerializable<List<String>> weaponProficiencyKeys;

  late final _is.ColumnSerializable<List<String>> toolProficiencyKeys;

  _ib72xv5p.RaceFeatureDataTable? ___features;

  _is.ManyRelation<_ib72xv5p.RaceFeatureDataTable>? _features;

  _ittxuxz1.RaceDataTable get parentRace {
    if (_parentRace != null) return _parentRace!;
    _parentRace = _is.createRelationTable(
      relationFieldName: 'parentRace',
      field: SubraceData.t.parentRaceId,
      foreignField: _ittxuxz1.RaceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ittxuxz1.RaceDataTable(tableRelation: foreignTableRelation),
    );
    return _parentRace!;
  }

  _ib72xv5p.RaceFeatureDataTable get __features {
    if (___features != null) return ___features!;
    ___features = _is.createRelationTable(
      relationFieldName: '__features',
      field: SubraceData.t.id,
      foreignField: _ib72xv5p.RaceFeatureData.t.subraceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ib72xv5p.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return ___features!;
  }

  _is.ManyRelation<_ib72xv5p.RaceFeatureDataTable> get features {
    if (_features != null) return _features!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'features',
      field: SubraceData.t.id,
      foreignField: _ib72xv5p.RaceFeatureData.t.subraceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ib72xv5p.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    _features = _is.ManyRelation<_ib72xv5p.RaceFeatureDataTable>(
      tableWithRelations: relationTable,
      table: _ib72xv5p.RaceFeatureDataTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _features!;
  }

  @override
  List<_is.Column> get columns => [
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
    weaponProficiencyKeys,
    toolProficiencyKeys,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'parentRace') {
      return parentRace;
    }
    if (relationField == 'features') {
      return __features;
    }
    return null;
  }
}

class SubraceDataInclude extends _is.IncludeObject {
  SubraceDataInclude._({
    _ittxuxz1.RaceDataInclude? parentRace,
    _ib72xv5p.RaceFeatureDataIncludeList? features,
  }) {
    _parentRace = parentRace;
    _features = features;
  }

  _ittxuxz1.RaceDataInclude? _parentRace;

  _ib72xv5p.RaceFeatureDataIncludeList? _features;

  @override
  Map<String, _is.Include?> get includes => {
    'parentRace': _parentRace,
    'features': _features,
  };

  @override
  _is.Table<int?> get table => SubraceData.t;
}

class SubraceDataIncludeList extends _is.IncludeList {
  SubraceDataIncludeList._({
    _is.WhereExpressionBuilder<SubraceDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubraceData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SubraceData.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SubraceDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SubraceDataTable>? orderBy,
    _is.OrderByListBuilder<SubraceDataTable>? orderByList,
    _is.Transaction? transaction,
    SubraceDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SubraceData>(
      where: where?.call(SubraceData.t),
      orderBy: orderBy?.call(SubraceData.t),
      orderByList: orderByList?.call(SubraceData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SubraceDataTable>? where,
    int? offset,
    _is.OrderByBuilder<SubraceDataTable>? orderBy,
    _is.OrderByListBuilder<SubraceDataTable>? orderByList,
    _is.Transaction? transaction,
    SubraceDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SubraceData>(
      where: where?.call(SubraceData.t),
      orderBy: orderBy?.call(SubraceData.t),
      orderByList: orderByList?.call(SubraceData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SubraceData] by its [id] or null if no such row exists.
  Future<SubraceData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    SubraceDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SubraceData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SubraceData]s in the list and returns the inserted rows.
  ///
  /// The returned [SubraceData]s will have their `id` fields set.
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
  Future<List<SubraceData>> insert(
    _is.DatabaseSession session,
    List<SubraceData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SubraceData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SubraceData] and returns the inserted row.
  ///
  /// The returned [SubraceData] will have its `id` field set.
  Future<SubraceData> insertRow(
    _is.DatabaseSession session,
    SubraceData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubraceData>(row, transaction: transaction);
  }

  /// Upserts all [SubraceData]s in the list and returns the resulting rows.
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
  /// The returned [SubraceData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SubraceData>> upsert(
    _is.DatabaseSession session,
    List<SubraceData> rows, {
    required _is.ColumnSelections<SubraceDataTable> conflictColumns,
    _is.ColumnSelections<SubraceDataTable>? updateColumns,
    _is.WhereExpressionBuilder<SubraceDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SubraceData>(
      rows,
      conflictColumns: conflictColumns(SubraceData.t),
      updateColumns: updateColumns?.call(SubraceData.t),
      updateWhere: updateWhere?.call(SubraceData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SubraceData] and returns the resulting row.
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
  /// The returned [SubraceData] will have its `id` field set.
  Future<SubraceData?> upsertRow(
    _is.DatabaseSession session,
    SubraceData row, {
    required _is.ColumnSelections<SubraceDataTable> conflictColumns,
    _is.ColumnSelections<SubraceDataTable>? updateColumns,
    _is.WhereExpressionBuilder<SubraceDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SubraceData>(
      row,
      conflictColumns: conflictColumns(SubraceData.t),
      updateColumns: updateColumns?.call(SubraceData.t),
      updateWhere: updateWhere?.call(SubraceData.t),
      transaction: transaction,
    );
  }

  /// Updates all [SubraceData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SubraceData>> update(
    _is.DatabaseSession session,
    List<SubraceData> rows, {
    _is.ColumnSelections<SubraceDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SubraceData>(
      rows,
      columns: columns?.call(SubraceData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SubraceData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubraceData> updateRow(
    _is.DatabaseSession session,
    SubraceData row, {
    _is.ColumnSelections<SubraceDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubraceData>(
      row,
      columns: columns?.call(SubraceData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubraceData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubraceData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SubraceDataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SubraceData>(
      id,
      columnValues: columnValues(SubraceData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubraceData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SubraceData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SubraceDataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SubraceDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SubraceDataTable>? orderBy,
    _is.OrderByListBuilder<SubraceDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SubraceData>(
      columnValues: columnValues(SubraceData.t.updateTable),
      where: where(SubraceData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubraceData.t),
      orderByList: orderByList?.call(SubraceData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SubraceData]s in the list and returns the deleted rows.
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
  Future<List<SubraceData>> delete(
    _is.DatabaseSession session,
    List<SubraceData> rows, {
    _is.OrderByBuilder<SubraceDataTable>? orderBy,
    _is.OrderByListBuilder<SubraceDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SubraceData>(
      rows,
      orderBy: orderBy?.call(SubraceData.t),
      orderByList: orderByList?.call(SubraceData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SubraceData].
  Future<SubraceData> deleteRow(
    _is.DatabaseSession session,
    SubraceData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubraceData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SubraceData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SubraceDataTable> where,
    _is.OrderByBuilder<SubraceDataTable>? orderBy,
    _is.OrderByListBuilder<SubraceDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SubraceData>(
      where: where(SubraceData.t),
      orderBy: orderBy?.call(SubraceData.t),
      orderByList: orderByList?.call(SubraceData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SubraceDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SubraceData>(
      where: where?.call(SubraceData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SubraceData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SubraceDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SubraceData>(
      where: where(SubraceData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SubraceDataAttachRepository {
  const SubraceDataAttachRepository._();

  /// Creates a relation between this [SubraceData] and the given [RaceFeatureData]s
  /// by setting each [RaceFeatureData]'s foreign key `subraceId` to refer to this [SubraceData].
  Future<void> features(
    _is.DatabaseSession session,
    SubraceData subraceData,
    List<_ib72xv5p.RaceFeatureData> raceFeatureData, {
    _is.Transaction? transaction,
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
    await session.db.update<_ib72xv5p.RaceFeatureData>(
      $raceFeatureData,
      columns: [_ib72xv5p.RaceFeatureData.t.subraceId],
      transaction: transaction,
    );
  }
}

class SubraceDataAttachRowRepository {
  const SubraceDataAttachRowRepository._();

  /// Creates a relation between the given [SubraceData] and [RaceData]
  /// by setting the [SubraceData]'s foreign key `parentRaceId` to refer to the [RaceData].
  Future<void> parentRace(
    _is.DatabaseSession session,
    SubraceData subraceData,
    _ittxuxz1.RaceData parentRace, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    SubraceData subraceData,
    _ib72xv5p.RaceFeatureData raceFeatureData, {
    _is.Transaction? transaction,
  }) async {
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }
    if (subraceData.id == null) {
      throw ArgumentError.notNull('subraceData.id');
    }

    var $raceFeatureData = raceFeatureData.copyWith(subraceId: subraceData.id);
    await session.db.updateRow<_ib72xv5p.RaceFeatureData>(
      $raceFeatureData,
      columns: [_ib72xv5p.RaceFeatureData.t.subraceId],
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
    _is.DatabaseSession session,
    List<_ib72xv5p.RaceFeatureData> raceFeatureData, {
    _is.Transaction? transaction,
  }) async {
    if (raceFeatureData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $raceFeatureData = raceFeatureData
        .map((e) => e.copyWith(subraceId: null))
        .toList();
    await session.db.update<_ib72xv5p.RaceFeatureData>(
      $raceFeatureData,
      columns: [_ib72xv5p.RaceFeatureData.t.subraceId],
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
    _is.DatabaseSession session,
    _ib72xv5p.RaceFeatureData raceFeatureData, {
    _is.Transaction? transaction,
  }) async {
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $raceFeatureData = raceFeatureData.copyWith(subraceId: null);
    await session.db.updateRow<_ib72xv5p.RaceFeatureData>(
      $raceFeatureData,
      columns: [_ib72xv5p.RaceFeatureData.t.subraceId],
      transaction: transaction,
    );
  }
}
