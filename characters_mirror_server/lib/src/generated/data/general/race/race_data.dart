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
import '../../../enums/creature_size.dart' as _i2;
import '../../../enums/sense_type.dart' as _i3;
import '../../../enums/damage_type.dart' as _i4;
import '../../../data/general/race/race_feature_data.dart' as _i5;

abstract class RaceData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    this.weaponProficiencies,
    this.toolProficiencies,
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
    _i2.CreatureSize? size,
    int? strengthBonus,
    int? dexterityBonus,
    int? constitutionBonus,
    int? intelligenceBonus,
    int? wisdomBonus,
    int? charismaBonus,
    List<String>? traits,
    List<String>? languages,
    _i3.SenseType? visionType,
    int? visionRange,
    List<_i4.DamageType>? resistances,
    List<String>? skillProficiencies,
    List<String>? armorProficiencies,
    List<String>? weaponProficiencies,
    List<String>? toolProficiencies,
    List<_i5.RaceFeatureData>? features,
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
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      speed: jsonSerialization['speed'] as int?,
      size: jsonSerialization['size'] == null
          ? null
          : _i2.CreatureSize.fromJson((jsonSerialization['size'] as int)),
      strengthBonus: jsonSerialization['strengthBonus'] as int?,
      dexterityBonus: jsonSerialization['dexterityBonus'] as int?,
      constitutionBonus: jsonSerialization['constitutionBonus'] as int?,
      intelligenceBonus: jsonSerialization['intelligenceBonus'] as int?,
      wisdomBonus: jsonSerialization['wisdomBonus'] as int?,
      charismaBonus: jsonSerialization['charismaBonus'] as int?,
      traits: (jsonSerialization['traits'] as List?)
          ?.map((e) => e as String)
          .toList(),
      languages: (jsonSerialization['languages'] as List?)
          ?.map((e) => e as String)
          .toList(),
      visionType: jsonSerialization['visionType'] == null
          ? null
          : _i3.SenseType.fromJson((jsonSerialization['visionType'] as String)),
      visionRange: jsonSerialization['visionRange'] as int?,
      resistances: (jsonSerialization['resistances'] as List?)
          ?.map((e) => _i4.DamageType.fromJson((e as String)))
          .toList(),
      skillProficiencies: (jsonSerialization['skillProficiencies'] as List?)
          ?.map((e) => e as String)
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
              (e) => _i5.RaceFeatureData.fromJson((e as Map<String, dynamic>)))
          .toList(),
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

  _i2.CreatureSize? size;

  int? strengthBonus;

  int? dexterityBonus;

  int? constitutionBonus;

  int? intelligenceBonus;

  int? wisdomBonus;

  int? charismaBonus;

  List<String>? traits;

  List<String>? languages;

  _i3.SenseType? visionType;

  int? visionRange;

  List<_i4.DamageType>? resistances;

  List<String>? skillProficiencies;

  List<String>? armorProficiencies;

  List<String>? weaponProficiencies;

  List<String>? toolProficiencies;

  List<_i5.RaceFeatureData>? features;

  String? imageURL;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RaceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? speed,
    _i2.CreatureSize? size,
    int? strengthBonus,
    int? dexterityBonus,
    int? constitutionBonus,
    int? intelligenceBonus,
    int? wisdomBonus,
    int? charismaBonus,
    List<String>? traits,
    List<String>? languages,
    _i3.SenseType? visionType,
    int? visionRange,
    List<_i4.DamageType>? resistances,
    List<String>? skillProficiencies,
    List<String>? armorProficiencies,
    List<String>? weaponProficiencies,
    List<String>? toolProficiencies,
    List<_i5.RaceFeatureData>? features,
    String? imageURL,
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
      if (speed != null) 'speed': speed,
      if (size != null) 'size': size?.toJson(),
      if (strengthBonus != null) 'strengthBonus': strengthBonus,
      if (dexterityBonus != null) 'dexterityBonus': dexterityBonus,
      if (constitutionBonus != null) 'constitutionBonus': constitutionBonus,
      if (intelligenceBonus != null) 'intelligenceBonus': intelligenceBonus,
      if (wisdomBonus != null) 'wisdomBonus': wisdomBonus,
      if (charismaBonus != null) 'charismaBonus': charismaBonus,
      if (traits != null) 'traits': traits?.toJson(),
      if (languages != null) 'languages': languages?.toJson(),
      if (visionType != null) 'visionType': visionType?.toJson(),
      if (visionRange != null) 'visionRange': visionRange,
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (armorProficiencies != null)
        'armorProficiencies': armorProficiencies?.toJson(),
      if (weaponProficiencies != null)
        'weaponProficiencies': weaponProficiencies?.toJson(),
      if (toolProficiencies != null)
        'toolProficiencies': toolProficiencies?.toJson(),
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJson()),
      if (imageURL != null) 'imageURL': imageURL,
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
      if (speed != null) 'speed': speed,
      if (size != null) 'size': size?.toJson(),
      if (strengthBonus != null) 'strengthBonus': strengthBonus,
      if (dexterityBonus != null) 'dexterityBonus': dexterityBonus,
      if (constitutionBonus != null) 'constitutionBonus': constitutionBonus,
      if (intelligenceBonus != null) 'intelligenceBonus': intelligenceBonus,
      if (wisdomBonus != null) 'wisdomBonus': wisdomBonus,
      if (charismaBonus != null) 'charismaBonus': charismaBonus,
      if (traits != null) 'traits': traits?.toJson(),
      if (languages != null) 'languages': languages?.toJson(),
      if (visionType != null) 'visionType': visionType?.toJson(),
      if (visionRange != null) 'visionRange': visionRange,
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (armorProficiencies != null)
        'armorProficiencies': armorProficiencies?.toJson(),
      if (weaponProficiencies != null)
        'weaponProficiencies': weaponProficiencies?.toJson(),
      if (toolProficiencies != null)
        'toolProficiencies': toolProficiencies?.toJson(),
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (imageURL != null) 'imageURL': imageURL,
    };
  }

  static RaceDataInclude include({_i5.RaceFeatureDataIncludeList? features}) {
    return RaceDataInclude._(features: features);
  }

  static RaceDataIncludeList includeList({
    _i1.WhereExpressionBuilder<RaceDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RaceDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceDataTable>? orderByList,
    RaceDataInclude? include,
  }) {
    return RaceDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RaceData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RaceData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
    _i2.CreatureSize? size,
    int? strengthBonus,
    int? dexterityBonus,
    int? constitutionBonus,
    int? intelligenceBonus,
    int? wisdomBonus,
    int? charismaBonus,
    List<String>? traits,
    List<String>? languages,
    _i3.SenseType? visionType,
    int? visionRange,
    List<_i4.DamageType>? resistances,
    List<String>? skillProficiencies,
    List<String>? armorProficiencies,
    List<String>? weaponProficiencies,
    List<String>? toolProficiencies,
    List<_i5.RaceFeatureData>? features,
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
          weaponProficiencies: weaponProficiencies,
          toolProficiencies: toolProficiencies,
          features: features,
          imageURL: imageURL,
        );

  /// Returns a shallow copy of this [RaceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
    Object? weaponProficiencies = _Undefined,
    Object? toolProficiencies = _Undefined,
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
      size: size is _i2.CreatureSize? ? size : this.size,
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
      languages: languages is List<String>?
          ? languages
          : this.languages?.map((e0) => e0).toList(),
      visionType: visionType is _i3.SenseType? ? visionType : this.visionType,
      visionRange: visionRange is int? ? visionRange : this.visionRange,
      resistances: resistances is List<_i4.DamageType>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
      skillProficiencies: skillProficiencies is List<String>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      armorProficiencies: armorProficiencies is List<String>?
          ? armorProficiencies
          : this.armorProficiencies?.map((e0) => e0).toList(),
      weaponProficiencies: weaponProficiencies is List<String>?
          ? weaponProficiencies
          : this.weaponProficiencies?.map((e0) => e0).toList(),
      toolProficiencies: toolProficiencies is List<String>?
          ? toolProficiencies
          : this.toolProficiencies?.map((e0) => e0).toList(),
      features: features is List<_i5.RaceFeatureData>?
          ? features
          : this.features?.map((e0) => e0.copyWith()).toList(),
      imageURL: imageURL is String? ? imageURL : this.imageURL,
    );
  }
}

class RaceDataTable extends _i1.Table<int?> {
  RaceDataTable({super.tableRelation}) : super(tableName: 'race_data') {
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
    speed = _i1.ColumnInt(
      'speed',
      this,
    );
    size = _i1.ColumnEnum(
      'size',
      this,
      _i1.EnumSerialization.byIndex,
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
    languages = _i1.ColumnSerializable(
      'languages',
      this,
    );
    visionType = _i1.ColumnEnum(
      'visionType',
      this,
      _i1.EnumSerialization.byName,
    );
    visionRange = _i1.ColumnInt(
      'visionRange',
      this,
    );
    resistances = _i1.ColumnSerializable(
      'resistances',
      this,
    );
    skillProficiencies = _i1.ColumnSerializable(
      'skillProficiencies',
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
    imageURL = _i1.ColumnString(
      'imageURL',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt speed;

  late final _i1.ColumnEnum<_i2.CreatureSize> size;

  late final _i1.ColumnInt strengthBonus;

  late final _i1.ColumnInt dexterityBonus;

  late final _i1.ColumnInt constitutionBonus;

  late final _i1.ColumnInt intelligenceBonus;

  late final _i1.ColumnInt wisdomBonus;

  late final _i1.ColumnInt charismaBonus;

  late final _i1.ColumnSerializable traits;

  late final _i1.ColumnSerializable languages;

  late final _i1.ColumnEnum<_i3.SenseType> visionType;

  late final _i1.ColumnInt visionRange;

  late final _i1.ColumnSerializable resistances;

  late final _i1.ColumnSerializable skillProficiencies;

  late final _i1.ColumnSerializable armorProficiencies;

  late final _i1.ColumnSerializable weaponProficiencies;

  late final _i1.ColumnSerializable toolProficiencies;

  _i5.RaceFeatureDataTable? ___features;

  _i1.ManyRelation<_i5.RaceFeatureDataTable>? _features;

  late final _i1.ColumnString imageURL;

  _i5.RaceFeatureDataTable get __features {
    if (___features != null) return ___features!;
    ___features = _i1.createRelationTable(
      relationFieldName: '__features',
      field: RaceData.t.id,
      foreignField: _i5.RaceFeatureData.t.raceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return ___features!;
  }

  _i1.ManyRelation<_i5.RaceFeatureDataTable> get features {
    if (_features != null) return _features!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'features',
      field: RaceData.t.id,
      foreignField: _i5.RaceFeatureData.t.raceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    _features = _i1.ManyRelation<_i5.RaceFeatureDataTable>(
      tableWithRelations: relationTable,
      table: _i5.RaceFeatureDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _features!;
  }

  @override
  List<_i1.Column> get columns => [
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
        weaponProficiencies,
        toolProficiencies,
        imageURL,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'features') {
      return __features;
    }
    return null;
  }
}

class RaceDataInclude extends _i1.IncludeObject {
  RaceDataInclude._({_i5.RaceFeatureDataIncludeList? features}) {
    _features = features;
  }

  _i5.RaceFeatureDataIncludeList? _features;

  @override
  Map<String, _i1.Include?> get includes => {'features': _features};

  @override
  _i1.Table<int?> get table => RaceData.t;
}

class RaceDataIncludeList extends _i1.IncludeList {
  RaceDataIncludeList._({
    _i1.WhereExpressionBuilder<RaceDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RaceData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RaceData.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RaceDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceDataTable>? orderByList,
    _i1.Transaction? transaction,
    RaceDataInclude? include,
  }) async {
    return session.db.find<RaceData>(
      where: where?.call(RaceData.t),
      orderBy: orderBy?.call(RaceData.t),
      orderByList: orderByList?.call(RaceData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<RaceDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceDataTable>? orderByList,
    _i1.Transaction? transaction,
    RaceDataInclude? include,
  }) async {
    return session.db.findFirstRow<RaceData>(
      where: where?.call(RaceData.t),
      orderBy: orderBy?.call(RaceData.t),
      orderByList: orderByList?.call(RaceData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [RaceData] by its [id] or null if no such row exists.
  Future<RaceData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    RaceDataInclude? include,
  }) async {
    return session.db.findById<RaceData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [RaceData]s in the list and returns the inserted rows.
  ///
  /// The returned [RaceData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<RaceData>> insert(
    _i1.Session session,
    List<RaceData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<RaceData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [RaceData] and returns the inserted row.
  ///
  /// The returned [RaceData] will have its `id` field set.
  Future<RaceData> insertRow(
    _i1.Session session,
    RaceData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RaceData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RaceData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RaceData>> update(
    _i1.Session session,
    List<RaceData> rows, {
    _i1.ColumnSelections<RaceDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RaceData>(
      rows,
      columns: columns?.call(RaceData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RaceData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RaceData> updateRow(
    _i1.Session session,
    RaceData row, {
    _i1.ColumnSelections<RaceDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RaceData>(
      row,
      columns: columns?.call(RaceData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [RaceData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RaceData>> delete(
    _i1.Session session,
    List<RaceData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RaceData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RaceData].
  Future<RaceData> deleteRow(
    _i1.Session session,
    RaceData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RaceData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RaceData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RaceDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RaceData>(
      where: where(RaceData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RaceData>(
      where: where?.call(RaceData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RaceDataAttachRepository {
  const RaceDataAttachRepository._();

  /// Creates a relation between this [RaceData] and the given [RaceFeatureData]s
  /// by setting each [RaceFeatureData]'s foreign key `raceId` to refer to this [RaceData].
  Future<void> features(
    _i1.Session session,
    RaceData raceData,
    List<_i5.RaceFeatureData> raceFeatureData, {
    _i1.Transaction? transaction,
  }) async {
    if (raceFeatureData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }
    if (raceData.id == null) {
      throw ArgumentError.notNull('raceData.id');
    }

    var $raceFeatureData =
        raceFeatureData.map((e) => e.copyWith(raceId: raceData.id)).toList();
    await session.db.update<_i5.RaceFeatureData>(
      $raceFeatureData,
      columns: [_i5.RaceFeatureData.t.raceId],
      transaction: transaction,
    );
  }
}

class RaceDataAttachRowRepository {
  const RaceDataAttachRowRepository._();

  /// Creates a relation between this [RaceData] and the given [RaceFeatureData]
  /// by setting the [RaceFeatureData]'s foreign key `raceId` to refer to this [RaceData].
  Future<void> features(
    _i1.Session session,
    RaceData raceData,
    _i5.RaceFeatureData raceFeatureData, {
    _i1.Transaction? transaction,
  }) async {
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }
    if (raceData.id == null) {
      throw ArgumentError.notNull('raceData.id');
    }

    var $raceFeatureData = raceFeatureData.copyWith(raceId: raceData.id);
    await session.db.updateRow<_i5.RaceFeatureData>(
      $raceFeatureData,
      columns: [_i5.RaceFeatureData.t.raceId],
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
    _i1.Session session,
    List<_i5.RaceFeatureData> raceFeatureData, {
    _i1.Transaction? transaction,
  }) async {
    if (raceFeatureData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $raceFeatureData =
        raceFeatureData.map((e) => e.copyWith(raceId: null)).toList();
    await session.db.update<_i5.RaceFeatureData>(
      $raceFeatureData,
      columns: [_i5.RaceFeatureData.t.raceId],
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
    _i1.Session session,
    _i5.RaceFeatureData raceFeatureData, {
    _i1.Transaction? transaction,
  }) async {
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $raceFeatureData = raceFeatureData.copyWith(raceId: null);
    await session.db.updateRow<_i5.RaceFeatureData>(
      $raceFeatureData,
      columns: [_i5.RaceFeatureData.t.raceId],
      transaction: transaction,
    );
  }
}
