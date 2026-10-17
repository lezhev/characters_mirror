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
import '../../../data/general/race/race_feature_data.dart' as _ib72xv5p;
import '../../../enums/armor_category.dart' as _irzuusaf;
import '../../../enums/creature_size.dart' as _i0folz3s;
import '../../../enums/damage_type.dart' as _ij9bzpyl;
import '../../../enums/language.dart' as _iiw0j43j;
import '../../../enums/sense_type.dart' as _irak22vn;
import '../../../enums/skill.dart' as _iqrhamom;

abstract class RaceData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RaceData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.speed,
    this.size,
    this.strengthBonus,
    this.dexterityBonus,
    this.constitutionBonus,
    this.intelligenceBonus,
    this.wisdomBonus,
    this.charismaBonus,
    this.traits,
    this.languages,
    this.visionType,
    this.visionRange,
    this.resistances,
    this.skillProficiencies,
    this.armorProficiencies,
    this.weaponProficiencyKeys,
    this.toolProficiencyKeys,
    this.features,
    this.imageURL,
  });

  factory RaceData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? speed,
    _i0folz3s.CreatureSize? size,
    int? strengthBonus,
    int? dexterityBonus,
    int? constitutionBonus,
    int? intelligenceBonus,
    int? wisdomBonus,
    int? charismaBonus,
    List<String>? traits,
    List<_iiw0j43j.Language>? languages,
    _irak22vn.SenseType? visionType,
    int? visionRange,
    List<_ij9bzpyl.DamageType>? resistances,
    List<_iqrhamom.Skill>? skillProficiencies,
    List<_irzuusaf.ArmorCategory>? armorProficiencies,
    List<String>? weaponProficiencyKeys,
    List<String>? toolProficiencyKeys,
    List<_ib72xv5p.RaceFeatureData>? features,
    String? imageURL,
  }) = _RaceDataImpl;

  factory RaceData.fromJson(Map<String, dynamic> jsonSerialization) {
    return RaceData(
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
      speed: jsonSerialization['speed'] as int?,
      size: jsonSerialization['size'] == null
          ? null
          : _i0folz3s.CreatureSize.fromJson((jsonSerialization['size'] as int)),
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
      languages: jsonSerialization['languages'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iiw0j43j.Language>>(
              jsonSerialization['languages'],
            ),
      visionType: jsonSerialization['visionType'] == null
          ? null
          : _irak22vn.SenseType.fromJson(
              (jsonSerialization['visionType'] as String),
            ),
      visionRange: jsonSerialization['visionRange'] as int?,
      resistances: jsonSerialization['resistances'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ij9bzpyl.DamageType>>(
              jsonSerialization['resistances'],
            ),
      skillProficiencies: jsonSerialization['skillProficiencies'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iqrhamom.Skill>>(
              jsonSerialization['skillProficiencies'],
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
      imageURL: jsonSerialization['imageURL'] as String?,
    );
  }

  static final t = RaceDataTable();

  static const db = RaceDataRepository._();

  @override
  int? id;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? speed;

  _i0folz3s.CreatureSize? size;

  int? strengthBonus;

  int? dexterityBonus;

  int? constitutionBonus;

  int? intelligenceBonus;

  int? wisdomBonus;

  int? charismaBonus;

  List<String>? traits;

  List<_iiw0j43j.Language>? languages;

  _irak22vn.SenseType? visionType;

  int? visionRange;

  List<_ij9bzpyl.DamageType>? resistances;

  List<_iqrhamom.Skill>? skillProficiencies;

  List<_irzuusaf.ArmorCategory>? armorProficiencies;

  List<String>? weaponProficiencyKeys;

  List<String>? toolProficiencyKeys;

  List<_ib72xv5p.RaceFeatureData>? features;

  String? imageURL;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RaceData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RaceData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? speed,
    _i0folz3s.CreatureSize? size,
    int? strengthBonus,
    int? dexterityBonus,
    int? constitutionBonus,
    int? intelligenceBonus,
    int? wisdomBonus,
    int? charismaBonus,
    List<String>? traits,
    List<_iiw0j43j.Language>? languages,
    _irak22vn.SenseType? visionType,
    int? visionRange,
    List<_ij9bzpyl.DamageType>? resistances,
    List<_iqrhamom.Skill>? skillProficiencies,
    List<_irzuusaf.ArmorCategory>? armorProficiencies,
    List<String>? weaponProficiencyKeys,
    List<String>? toolProficiencyKeys,
    List<_ib72xv5p.RaceFeatureData>? features,
    String? imageURL,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RaceData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (speed != null) 'speed': speed,
      if (size != null) 'size': size?.toJson(),
      if (strengthBonus != null) 'strengthBonus': strengthBonus,
      if (dexterityBonus != null) 'dexterityBonus': dexterityBonus,
      if (constitutionBonus != null) 'constitutionBonus': constitutionBonus,
      if (intelligenceBonus != null) 'intelligenceBonus': intelligenceBonus,
      if (wisdomBonus != null) 'wisdomBonus': wisdomBonus,
      if (charismaBonus != null) 'charismaBonus': charismaBonus,
      if (traits != null) 'traits': traits?.toJson(),
      if (languages != null)
        'languages': languages?.toJson(valueToJson: (v) => v.toJson()),
      if (visionType != null) 'visionType': visionType?.toJson(),
      if (visionRange != null) 'visionRange': visionRange,
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
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
      if (imageURL != null) 'imageURL': imageURL,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RaceData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (speed != null) 'speed': speed,
      if (size != null) 'size': size?.toJson(),
      if (strengthBonus != null) 'strengthBonus': strengthBonus,
      if (dexterityBonus != null) 'dexterityBonus': dexterityBonus,
      if (constitutionBonus != null) 'constitutionBonus': constitutionBonus,
      if (intelligenceBonus != null) 'intelligenceBonus': intelligenceBonus,
      if (wisdomBonus != null) 'wisdomBonus': wisdomBonus,
      if (charismaBonus != null) 'charismaBonus': charismaBonus,
      if (traits != null) 'traits': traits?.toJson(),
      if (languages != null)
        'languages': languages?.toJson(valueToJson: (v) => v.toJson()),
      if (visionType != null) 'visionType': visionType?.toJson(),
      if (visionRange != null) 'visionRange': visionRange,
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
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
      if (imageURL != null) 'imageURL': imageURL,
    };
  }

  static RaceDataInclude include({
    _ib72xv5p.RaceFeatureDataIncludeList? features,
  }) {
    return RaceDataInclude._(features: features);
  }

  static RaceDataIncludeList includeList({
    _is.WhereExpressionBuilder<RaceDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RaceDataTable>? orderBy,
    _is.OrderByListBuilder<RaceDataTable>? orderByList,
    RaceDataInclude? include,
  }) {
    return RaceDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RaceData.t),
      orderByList: orderByList?.call(RaceData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceDataImpl extends RaceData {
  _RaceDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? speed,
    _i0folz3s.CreatureSize? size,
    int? strengthBonus,
    int? dexterityBonus,
    int? constitutionBonus,
    int? intelligenceBonus,
    int? wisdomBonus,
    int? charismaBonus,
    List<String>? traits,
    List<_iiw0j43j.Language>? languages,
    _irak22vn.SenseType? visionType,
    int? visionRange,
    List<_ij9bzpyl.DamageType>? resistances,
    List<_iqrhamom.Skill>? skillProficiencies,
    List<_irzuusaf.ArmorCategory>? armorProficiencies,
    List<String>? weaponProficiencyKeys,
    List<String>? toolProficiencyKeys,
    List<_ib72xv5p.RaceFeatureData>? features,
    String? imageURL,
  }) : super._(
         id: id,
         name: name,
         description: description,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
         speed: speed,
         size: size,
         strengthBonus: strengthBonus,
         dexterityBonus: dexterityBonus,
         constitutionBonus: constitutionBonus,
         intelligenceBonus: intelligenceBonus,
         wisdomBonus: wisdomBonus,
         charismaBonus: charismaBonus,
         traits: traits,
         languages: languages,
         visionType: visionType,
         visionRange: visionRange,
         resistances: resistances,
         skillProficiencies: skillProficiencies,
         armorProficiencies: armorProficiencies,
         weaponProficiencyKeys: weaponProficiencyKeys,
         toolProficiencyKeys: toolProficiencyKeys,
         features: features,
         imageURL: imageURL,
       );

  /// Returns a shallow copy of this [RaceData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RaceData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? speed = _Undefined,
    Object? size = _Undefined,
    Object? strengthBonus = _Undefined,
    Object? dexterityBonus = _Undefined,
    Object? constitutionBonus = _Undefined,
    Object? intelligenceBonus = _Undefined,
    Object? wisdomBonus = _Undefined,
    Object? charismaBonus = _Undefined,
    Object? traits = _Undefined,
    Object? languages = _Undefined,
    Object? visionType = _Undefined,
    Object? visionRange = _Undefined,
    Object? resistances = _Undefined,
    Object? skillProficiencies = _Undefined,
    Object? armorProficiencies = _Undefined,
    Object? weaponProficiencyKeys = _Undefined,
    Object? toolProficiencyKeys = _Undefined,
    Object? features = _Undefined,
    Object? imageURL = _Undefined,
  }) {
    return RaceData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      speed: speed is int? ? speed : this.speed,
      size: size is _i0folz3s.CreatureSize? ? size : this.size,
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
      languages: languages is List<_iiw0j43j.Language>?
          ? languages
          : this.languages?.map((e0) => e0).toList(),
      visionType: visionType is _irak22vn.SenseType?
          ? visionType
          : this.visionType,
      visionRange: visionRange is int? ? visionRange : this.visionRange,
      resistances: resistances is List<_ij9bzpyl.DamageType>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
      skillProficiencies: skillProficiencies is List<_iqrhamom.Skill>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
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
      imageURL: imageURL is String? ? imageURL : this.imageURL,
    );
  }
}

class RaceDataUpdateTable extends _is.UpdateTable<RaceDataTable> {
  RaceDataUpdateTable(super.table);

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

  _is.ColumnValue<int, int> speed(int? value) =>
      _is.ColumnValue(table.speed, value);

  _is.ColumnValue<_i0folz3s.CreatureSize, _i0folz3s.CreatureSize> size(
    _i0folz3s.CreatureSize? value,
  ) => _is.ColumnValue(table.size, value);

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

  _is.ColumnValue<List<_iiw0j43j.Language>, List<_iiw0j43j.Language>> languages(
    List<_iiw0j43j.Language>? value,
  ) => _is.ColumnValue(table.languages, value);

  _is.ColumnValue<_irak22vn.SenseType, _irak22vn.SenseType> visionType(
    _irak22vn.SenseType? value,
  ) => _is.ColumnValue(table.visionType, value);

  _is.ColumnValue<int, int> visionRange(int? value) =>
      _is.ColumnValue(table.visionRange, value);

  _is.ColumnValue<List<_ij9bzpyl.DamageType>, List<_ij9bzpyl.DamageType>>
  resistances(List<_ij9bzpyl.DamageType>? value) =>
      _is.ColumnValue(table.resistances, value);

  _is.ColumnValue<List<_iqrhamom.Skill>, List<_iqrhamom.Skill>>
  skillProficiencies(List<_iqrhamom.Skill>? value) =>
      _is.ColumnValue(table.skillProficiencies, value);

  _is.ColumnValue<List<_irzuusaf.ArmorCategory>, List<_irzuusaf.ArmorCategory>>
  armorProficiencies(List<_irzuusaf.ArmorCategory>? value) =>
      _is.ColumnValue(table.armorProficiencies, value);

  _is.ColumnValue<List<String>, List<String>> weaponProficiencyKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.weaponProficiencyKeys, value);

  _is.ColumnValue<List<String>, List<String>> toolProficiencyKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.toolProficiencyKeys, value);

  _is.ColumnValue<String, String> imageURL(String? value) =>
      _is.ColumnValue(table.imageURL, value);
}

class RaceDataTable extends _is.Table<int?> {
  RaceDataTable({super.tableRelation}) : super(tableName: 'race_data') {
    updateTable = RaceDataUpdateTable(this);
    name = _is.ColumnString('name', this);
    description = _is.ColumnString('description', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    speed = _is.ColumnInt('speed', this);
    size = _is.ColumnEnum('size', this, _is.EnumSerialization.byIndex);
    strengthBonus = _is.ColumnInt('strengthBonus', this);
    dexterityBonus = _is.ColumnInt('dexterityBonus', this);
    constitutionBonus = _is.ColumnInt('constitutionBonus', this);
    intelligenceBonus = _is.ColumnInt('intelligenceBonus', this);
    wisdomBonus = _is.ColumnInt('wisdomBonus', this);
    charismaBonus = _is.ColumnInt('charismaBonus', this);
    traits = _is.ColumnSerializable<List<String>>('traits', this);
    languages = _is.ColumnSerializable<List<_iiw0j43j.Language>>(
      'languages',
      this,
    );
    visionType = _is.ColumnEnum(
      'visionType',
      this,
      _is.EnumSerialization.byName,
    );
    visionRange = _is.ColumnInt('visionRange', this);
    resistances = _is.ColumnSerializable<List<_ij9bzpyl.DamageType>>(
      'resistances',
      this,
    );
    skillProficiencies = _is.ColumnSerializable<List<_iqrhamom.Skill>>(
      'skillProficiencies',
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
    imageURL = _is.ColumnString('imageURL', this);
  }

  late final RaceDataUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnInt speed;

  late final _is.ColumnEnum<_i0folz3s.CreatureSize> size;

  late final _is.ColumnInt strengthBonus;

  late final _is.ColumnInt dexterityBonus;

  late final _is.ColumnInt constitutionBonus;

  late final _is.ColumnInt intelligenceBonus;

  late final _is.ColumnInt wisdomBonus;

  late final _is.ColumnInt charismaBonus;

  late final _is.ColumnSerializable<List<String>> traits;

  late final _is.ColumnSerializable<List<_iiw0j43j.Language>> languages;

  late final _is.ColumnEnum<_irak22vn.SenseType> visionType;

  late final _is.ColumnInt visionRange;

  late final _is.ColumnSerializable<List<_ij9bzpyl.DamageType>> resistances;

  late final _is.ColumnSerializable<List<_iqrhamom.Skill>> skillProficiencies;

  late final _is.ColumnSerializable<List<_irzuusaf.ArmorCategory>>
  armorProficiencies;

  late final _is.ColumnSerializable<List<String>> weaponProficiencyKeys;

  late final _is.ColumnSerializable<List<String>> toolProficiencyKeys;

  _ib72xv5p.RaceFeatureDataTable? ___features;

  _is.ManyRelation<_ib72xv5p.RaceFeatureDataTable>? _features;

  late final _is.ColumnString imageURL;

  _ib72xv5p.RaceFeatureDataTable get __features {
    if (___features != null) return ___features!;
    ___features = _is.createRelationTable(
      relationFieldName: '__features',
      field: RaceData.t.id,
      foreignField: _ib72xv5p.RaceFeatureData.t.raceId,
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
      field: RaceData.t.id,
      foreignField: _ib72xv5p.RaceFeatureData.t.raceId,
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
    description,
    source,
    version,
    createdAt,
    updatedAt,
    speed,
    size,
    strengthBonus,
    dexterityBonus,
    constitutionBonus,
    intelligenceBonus,
    wisdomBonus,
    charismaBonus,
    traits,
    languages,
    visionType,
    visionRange,
    resistances,
    skillProficiencies,
    armorProficiencies,
    weaponProficiencyKeys,
    toolProficiencyKeys,
    imageURL,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'features') {
      return __features;
    }
    return null;
  }
}

class RaceDataInclude extends _is.IncludeObject {
  RaceDataInclude._({_ib72xv5p.RaceFeatureDataIncludeList? features}) {
    _features = features;
  }

  _ib72xv5p.RaceFeatureDataIncludeList? _features;

  @override
  Map<String, _is.Include?> get includes => {'features': _features};

  @override
  _is.Table<int?> get table => RaceData.t;
}

class RaceDataIncludeList extends _is.IncludeList {
  RaceDataIncludeList._({
    _is.WhereExpressionBuilder<RaceDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RaceData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RaceData.t;
}

class RaceDataRepository {
  const RaceDataRepository._();

  final attach = const RaceDataAttachRepository._();

  final attachRow = const RaceDataAttachRowRepository._();

  final detach = const RaceDataDetachRepository._();

  final detachRow = const RaceDataDetachRowRepository._();

  /// Returns a list of [RaceData]s matching the given query parameters.
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
  Future<List<RaceData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RaceDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RaceDataTable>? orderBy,
    _is.OrderByListBuilder<RaceDataTable>? orderByList,
    _is.Transaction? transaction,
    RaceDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RaceData>(
      where: where?.call(RaceData.t),
      orderBy: orderBy?.call(RaceData.t),
      orderByList: orderByList?.call(RaceData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RaceData] matching the given query parameters.
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
  Future<RaceData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RaceDataTable>? where,
    int? offset,
    _is.OrderByBuilder<RaceDataTable>? orderBy,
    _is.OrderByListBuilder<RaceDataTable>? orderByList,
    _is.Transaction? transaction,
    RaceDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RaceData>(
      where: where?.call(RaceData.t),
      orderBy: orderBy?.call(RaceData.t),
      orderByList: orderByList?.call(RaceData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RaceData] by its [id] or null if no such row exists.
  Future<RaceData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    RaceDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RaceData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RaceData]s in the list and returns the inserted rows.
  ///
  /// The returned [RaceData]s will have their `id` fields set.
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
  Future<List<RaceData>> insert(
    _is.DatabaseSession session,
    List<RaceData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RaceData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RaceData] and returns the inserted row.
  ///
  /// The returned [RaceData] will have its `id` field set.
  Future<RaceData> insertRow(
    _is.DatabaseSession session,
    RaceData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RaceData>(row, transaction: transaction);
  }

  /// Upserts all [RaceData]s in the list and returns the resulting rows.
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
  /// The returned [RaceData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceData>> upsert(
    _is.DatabaseSession session,
    List<RaceData> rows, {
    required _is.ColumnSelections<RaceDataTable> conflictColumns,
    _is.ColumnSelections<RaceDataTable>? updateColumns,
    _is.WhereExpressionBuilder<RaceDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RaceData>(
      rows,
      conflictColumns: conflictColumns(RaceData.t),
      updateColumns: updateColumns?.call(RaceData.t),
      updateWhere: updateWhere?.call(RaceData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RaceData] and returns the resulting row.
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
  /// The returned [RaceData] will have its `id` field set.
  Future<RaceData?> upsertRow(
    _is.DatabaseSession session,
    RaceData row, {
    required _is.ColumnSelections<RaceDataTable> conflictColumns,
    _is.ColumnSelections<RaceDataTable>? updateColumns,
    _is.WhereExpressionBuilder<RaceDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RaceData>(
      row,
      conflictColumns: conflictColumns(RaceData.t),
      updateColumns: updateColumns?.call(RaceData.t),
      updateWhere: updateWhere?.call(RaceData.t),
      transaction: transaction,
    );
  }

  /// Updates all [RaceData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceData>> update(
    _is.DatabaseSession session,
    List<RaceData> rows, {
    _is.ColumnSelections<RaceDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RaceData>(
      rows,
      columns: columns?.call(RaceData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RaceData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RaceData> updateRow(
    _is.DatabaseSession session,
    RaceData row, {
    _is.ColumnSelections<RaceDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RaceData>(
      row,
      columns: columns?.call(RaceData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RaceData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RaceData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RaceDataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RaceData>(
      id,
      columnValues: columnValues(RaceData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RaceData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RaceDataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RaceDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RaceDataTable>? orderBy,
    _is.OrderByListBuilder<RaceDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RaceData>(
      columnValues: columnValues(RaceData.t.updateTable),
      where: where(RaceData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RaceData.t),
      orderByList: orderByList?.call(RaceData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RaceData]s in the list and returns the deleted rows.
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
  Future<List<RaceData>> delete(
    _is.DatabaseSession session,
    List<RaceData> rows, {
    _is.OrderByBuilder<RaceDataTable>? orderBy,
    _is.OrderByListBuilder<RaceDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RaceData>(
      rows,
      orderBy: orderBy?.call(RaceData.t),
      orderByList: orderByList?.call(RaceData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RaceData].
  Future<RaceData> deleteRow(
    _is.DatabaseSession session,
    RaceData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RaceData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RaceDataTable> where,
    _is.OrderByBuilder<RaceDataTable>? orderBy,
    _is.OrderByListBuilder<RaceDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RaceData>(
      where: where(RaceData.t),
      orderBy: orderBy?.call(RaceData.t),
      orderByList: orderByList?.call(RaceData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RaceDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RaceData>(
      where: where?.call(RaceData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RaceData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RaceDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RaceData>(
      where: where(RaceData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class RaceDataAttachRepository {
  const RaceDataAttachRepository._();

  /// Creates a relation between this [RaceData] and the given [RaceFeatureData]s
  /// by setting each [RaceFeatureData]'s foreign key `raceId` to refer to this [RaceData].
  Future<void> features(
    _is.DatabaseSession session,
    RaceData raceData,
    List<_ib72xv5p.RaceFeatureData> raceFeatureData, {
    _is.Transaction? transaction,
  }) async {
    if (raceFeatureData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }
    if (raceData.id == null) {
      throw ArgumentError.notNull('raceData.id');
    }

    var $raceFeatureData = raceFeatureData
        .map((e) => e.copyWith(raceId: raceData.id))
        .toList();
    await session.db.update<_ib72xv5p.RaceFeatureData>(
      $raceFeatureData,
      columns: [_ib72xv5p.RaceFeatureData.t.raceId],
      transaction: transaction,
    );
  }
}

class RaceDataAttachRowRepository {
  const RaceDataAttachRowRepository._();

  /// Creates a relation between this [RaceData] and the given [RaceFeatureData]
  /// by setting the [RaceFeatureData]'s foreign key `raceId` to refer to this [RaceData].
  Future<void> features(
    _is.DatabaseSession session,
    RaceData raceData,
    _ib72xv5p.RaceFeatureData raceFeatureData, {
    _is.Transaction? transaction,
  }) async {
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }
    if (raceData.id == null) {
      throw ArgumentError.notNull('raceData.id');
    }

    var $raceFeatureData = raceFeatureData.copyWith(raceId: raceData.id);
    await session.db.updateRow<_ib72xv5p.RaceFeatureData>(
      $raceFeatureData,
      columns: [_ib72xv5p.RaceFeatureData.t.raceId],
      transaction: transaction,
    );
  }
}

class RaceDataDetachRepository {
  const RaceDataDetachRepository._();

  /// Detaches the relation between this [RaceData] and the given [RaceFeatureData]
  /// by setting the [RaceFeatureData]'s foreign key `raceId` to `null`.
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
        .map((e) => e.copyWith(raceId: null))
        .toList();
    await session.db.update<_ib72xv5p.RaceFeatureData>(
      $raceFeatureData,
      columns: [_ib72xv5p.RaceFeatureData.t.raceId],
      transaction: transaction,
    );
  }
}

class RaceDataDetachRowRepository {
  const RaceDataDetachRowRepository._();

  /// Detaches the relation between this [RaceData] and the given [RaceFeatureData]
  /// by setting the [RaceFeatureData]'s foreign key `raceId` to `null`.
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

    var $raceFeatureData = raceFeatureData.copyWith(raceId: null);
    await session.db.updateRow<_ib72xv5p.RaceFeatureData>(
      $raceFeatureData,
      columns: [_ib72xv5p.RaceFeatureData.t.raceId],
      transaction: transaction,
    );
  }
}
