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
import '../../../data/general/feature_resource_definition_data.dart'
    as _iib0ncbr;
import '../../../data/general/feature_resource_effect_data.dart' as _ipujnj10;
import '../../../data/general/race/race_data.dart' as _ittxuxz1;
import '../../../data/general/race/race_feature_spell_grant_data.dart'
    as _iu7c1iaq;
import '../../../data/general/race/subrace_data.dart' as _i2k66n75;
import '../../../enums/feature_tag.dart' as _ixkx8coo;
import '../../../enums/rest_type.dart' as _igwcjrvt;

abstract class RaceFeatureData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RaceFeatureData._({
    this.id,
    this.raceId,
    this.race,
    this.subraceId,
    this.subrace,
    this.name,
    this.referenceKey,
    this.description,
    this.shortDescription,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.level,
    this.usesPerRest,
    this.usesFormula,
    this.resources,
    this.resourceEffects,
    this.tags,
    this.spellGrants,
  });

  factory RaceFeatureData({
    int? id,
    int? raceId,
    _ittxuxz1.RaceData? race,
    int? subraceId,
    _i2k66n75.SubraceData? subrace,
    String? name,
    String? referenceKey,
    String? description,
    String? shortDescription,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    _igwcjrvt.RestType? usesPerRest,
    String? usesFormula,
    List<_iib0ncbr.FeatureResourceDefinitionData>? resources,
    List<_ipujnj10.FeatureResourceEffectData>? resourceEffects,
    List<_ixkx8coo.FeatureTag>? tags,
    List<_iu7c1iaq.RaceFeatureSpellGrantData>? spellGrants,
  }) = _RaceFeatureDataImpl;

  factory RaceFeatureData.fromJson(Map<String, dynamic> jsonSerialization) {
    return RaceFeatureData(
      id: jsonSerialization['id'] as int?,
      raceId: jsonSerialization['raceId'] as int?,
      race: jsonSerialization['race'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_ittxuxz1.RaceData>(
              jsonSerialization['race'],
            ),
      subraceId: jsonSerialization['subraceId'] as int?,
      subrace: jsonSerialization['subrace'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i2k66n75.SubraceData>(
              jsonSerialization['subrace'],
            ),
      name: jsonSerialization['name'] as String?,
      referenceKey: jsonSerialization['referenceKey'] as String?,
      description: jsonSerialization['description'] as String?,
      shortDescription: jsonSerialization['shortDescription'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      level: jsonSerialization['level'] as int?,
      usesPerRest: jsonSerialization['usesPerRest'] == null
          ? null
          : _igwcjrvt.RestType.fromJson(
              (jsonSerialization['usesPerRest'] as String),
            ),
      usesFormula: jsonSerialization['usesFormula'] as String?,
      resources: jsonSerialization['resources'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_iib0ncbr.FeatureResourceDefinitionData>>(
                  jsonSerialization['resources'],
                ),
      resourceEffects: jsonSerialization['resourceEffects'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ipujnj10.FeatureResourceEffectData>>(
                  jsonSerialization['resourceEffects'],
                ),
      tags: jsonSerialization['tags'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ixkx8coo.FeatureTag>>(
              jsonSerialization['tags'],
            ),
      spellGrants: jsonSerialization['spellGrants'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_iu7c1iaq.RaceFeatureSpellGrantData>>(
                  jsonSerialization['spellGrants'],
                ),
    );
  }

  static final t = RaceFeatureDataTable();

  static const db = RaceFeatureDataRepository._();

  @override
  int? id;

  int? raceId;

  _ittxuxz1.RaceData? race;

  int? subraceId;

  _i2k66n75.SubraceData? subrace;

  String? name;

  String? referenceKey;

  String? description;

  String? shortDescription;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? level;

  _igwcjrvt.RestType? usesPerRest;

  String? usesFormula;

  List<_iib0ncbr.FeatureResourceDefinitionData>? resources;

  List<_ipujnj10.FeatureResourceEffectData>? resourceEffects;

  List<_ixkx8coo.FeatureTag>? tags;

  List<_iu7c1iaq.RaceFeatureSpellGrantData>? spellGrants;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RaceFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RaceFeatureData copyWith({
    int? id,
    int? raceId,
    _ittxuxz1.RaceData? race,
    int? subraceId,
    _i2k66n75.SubraceData? subrace,
    String? name,
    String? referenceKey,
    String? description,
    String? shortDescription,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    _igwcjrvt.RestType? usesPerRest,
    String? usesFormula,
    List<_iib0ncbr.FeatureResourceDefinitionData>? resources,
    List<_ipujnj10.FeatureResourceEffectData>? resourceEffects,
    List<_ixkx8coo.FeatureTag>? tags,
    List<_iu7c1iaq.RaceFeatureSpellGrantData>? spellGrants,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RaceFeatureData',
      if (id != null) 'id': id,
      if (raceId != null) 'raceId': raceId,
      if (race != null) 'race': race?.toJson(),
      if (subraceId != null) 'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJson(),
      if (name != null) 'name': name,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (description != null) 'description': description,
      if (shortDescription != null) 'shortDescription': shortDescription,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (level != null) 'level': level,
      if (usesPerRest != null) 'usesPerRest': usesPerRest?.toJson(),
      if (usesFormula != null) 'usesFormula': usesFormula,
      if (resources != null)
        'resources': resources?.toJson(valueToJson: (v) => v.toJson()),
      if (resourceEffects != null)
        'resourceEffects': resourceEffects?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (spellGrants != null)
        'spellGrants': spellGrants?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RaceFeatureData',
      if (id != null) 'id': id,
      if (raceId != null) 'raceId': raceId,
      if (race != null) 'race': race?.toJsonForProtocol(),
      if (subraceId != null) 'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJsonForProtocol(),
      if (name != null) 'name': name,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (description != null) 'description': description,
      if (shortDescription != null) 'shortDescription': shortDescription,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (level != null) 'level': level,
      if (usesPerRest != null) 'usesPerRest': usesPerRest?.toJson(),
      if (usesFormula != null) 'usesFormula': usesFormula,
      if (resources != null)
        'resources': resources?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (resourceEffects != null)
        'resourceEffects': resourceEffects?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (spellGrants != null)
        'spellGrants': spellGrants?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static RaceFeatureDataInclude include({
    _ittxuxz1.RaceDataInclude? race,
    _i2k66n75.SubraceDataInclude? subrace,
    _iib0ncbr.FeatureResourceDefinitionDataIncludeList? resources,
    _ipujnj10.FeatureResourceEffectDataIncludeList? resourceEffects,
    _iu7c1iaq.RaceFeatureSpellGrantDataIncludeList? spellGrants,
  }) {
    return RaceFeatureDataInclude._(
      race: race,
      subrace: subrace,
      resources: resources,
      resourceEffects: resourceEffects,
      spellGrants: spellGrants,
    );
  }

  static RaceFeatureDataIncludeList includeList({
    _is.WhereExpressionBuilder<RaceFeatureDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RaceFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<RaceFeatureDataTable>? orderByList,
    RaceFeatureDataInclude? include,
  }) {
    return RaceFeatureDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RaceFeatureData.t),
      orderByList: orderByList?.call(RaceFeatureData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceFeatureDataImpl extends RaceFeatureData {
  _RaceFeatureDataImpl({
    int? id,
    int? raceId,
    _ittxuxz1.RaceData? race,
    int? subraceId,
    _i2k66n75.SubraceData? subrace,
    String? name,
    String? referenceKey,
    String? description,
    String? shortDescription,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    _igwcjrvt.RestType? usesPerRest,
    String? usesFormula,
    List<_iib0ncbr.FeatureResourceDefinitionData>? resources,
    List<_ipujnj10.FeatureResourceEffectData>? resourceEffects,
    List<_ixkx8coo.FeatureTag>? tags,
    List<_iu7c1iaq.RaceFeatureSpellGrantData>? spellGrants,
  }) : super._(
         id: id,
         raceId: raceId,
         race: race,
         subraceId: subraceId,
         subrace: subrace,
         name: name,
         referenceKey: referenceKey,
         description: description,
         shortDescription: shortDescription,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
         level: level,
         usesPerRest: usesPerRest,
         usesFormula: usesFormula,
         resources: resources,
         resourceEffects: resourceEffects,
         tags: tags,
         spellGrants: spellGrants,
       );

  /// Returns a shallow copy of this [RaceFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RaceFeatureData copyWith({
    Object? id = _Undefined,
    Object? raceId = _Undefined,
    Object? race = _Undefined,
    Object? subraceId = _Undefined,
    Object? subrace = _Undefined,
    Object? name = _Undefined,
    Object? referenceKey = _Undefined,
    Object? description = _Undefined,
    Object? shortDescription = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? level = _Undefined,
    Object? usesPerRest = _Undefined,
    Object? usesFormula = _Undefined,
    Object? resources = _Undefined,
    Object? resourceEffects = _Undefined,
    Object? tags = _Undefined,
    Object? spellGrants = _Undefined,
  }) {
    return RaceFeatureData(
      id: id is int? ? id : this.id,
      raceId: raceId is int? ? raceId : this.raceId,
      race: race is _ittxuxz1.RaceData? ? race : this.race?.copyWith(),
      subraceId: subraceId is int? ? subraceId : this.subraceId,
      subrace: subrace is _i2k66n75.SubraceData?
          ? subrace
          : this.subrace?.copyWith(),
      name: name is String? ? name : this.name,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      description: description is String? ? description : this.description,
      shortDescription: shortDescription is String?
          ? shortDescription
          : this.shortDescription,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      level: level is int? ? level : this.level,
      usesPerRest: usesPerRest is _igwcjrvt.RestType?
          ? usesPerRest
          : this.usesPerRest,
      usesFormula: usesFormula is String? ? usesFormula : this.usesFormula,
      resources: resources is List<_iib0ncbr.FeatureResourceDefinitionData>?
          ? resources
          : this.resources?.map((e0) => e0.copyWith()).toList(),
      resourceEffects:
          resourceEffects is List<_ipujnj10.FeatureResourceEffectData>?
          ? resourceEffects
          : this.resourceEffects?.map((e0) => e0.copyWith()).toList(),
      tags: tags is List<_ixkx8coo.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
      spellGrants: spellGrants is List<_iu7c1iaq.RaceFeatureSpellGrantData>?
          ? spellGrants
          : this.spellGrants?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class RaceFeatureDataUpdateTable extends _is.UpdateTable<RaceFeatureDataTable> {
  RaceFeatureDataUpdateTable(super.table);

  _is.ColumnValue<int, int> raceId(int? value) =>
      _is.ColumnValue(table.raceId, value);

  _is.ColumnValue<int, int> subraceId(int? value) =>
      _is.ColumnValue(table.subraceId, value);

  _is.ColumnValue<String, String> name(String? value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> referenceKey(String? value) =>
      _is.ColumnValue(table.referenceKey, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<String, String> shortDescription(String? value) =>
      _is.ColumnValue(table.shortDescription, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);

  _is.ColumnValue<int, int> level(int? value) =>
      _is.ColumnValue(table.level, value);

  _is.ColumnValue<_igwcjrvt.RestType, _igwcjrvt.RestType> usesPerRest(
    _igwcjrvt.RestType? value,
  ) => _is.ColumnValue(table.usesPerRest, value);

  _is.ColumnValue<String, String> usesFormula(String? value) =>
      _is.ColumnValue(table.usesFormula, value);

  _is.ColumnValue<List<_ixkx8coo.FeatureTag>, List<_ixkx8coo.FeatureTag>> tags(
    List<_ixkx8coo.FeatureTag>? value,
  ) => _is.ColumnValue(table.tags, value);
}

class RaceFeatureDataTable extends _is.Table<int?> {
  RaceFeatureDataTable({super.tableRelation})
    : super(tableName: 'race_feature_data') {
    updateTable = RaceFeatureDataUpdateTable(this);
    raceId = _is.ColumnInt('raceId', this);
    subraceId = _is.ColumnInt('subraceId', this);
    name = _is.ColumnString('name', this);
    referenceKey = _is.ColumnString('referenceKey', this);
    description = _is.ColumnString('description', this);
    shortDescription = _is.ColumnString('shortDescription', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    level = _is.ColumnInt('level', this);
    usesPerRest = _is.ColumnEnum(
      'usesPerRest',
      this,
      _is.EnumSerialization.byName,
    );
    usesFormula = _is.ColumnString('usesFormula', this);
    tags = _is.ColumnSerializable<List<_ixkx8coo.FeatureTag>>('tags', this);
  }

  late final RaceFeatureDataUpdateTable updateTable;

  late final _is.ColumnInt raceId;

  _ittxuxz1.RaceDataTable? _race;

  late final _is.ColumnInt subraceId;

  _i2k66n75.SubraceDataTable? _subrace;

  late final _is.ColumnString name;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnString description;

  late final _is.ColumnString shortDescription;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnInt level;

  late final _is.ColumnEnum<_igwcjrvt.RestType> usesPerRest;

  late final _is.ColumnString usesFormula;

  _iib0ncbr.FeatureResourceDefinitionDataTable? ___resources;

  _is.ManyRelation<_iib0ncbr.FeatureResourceDefinitionDataTable>? _resources;

  _ipujnj10.FeatureResourceEffectDataTable? ___resourceEffects;

  _is.ManyRelation<_ipujnj10.FeatureResourceEffectDataTable>? _resourceEffects;

  late final _is.ColumnSerializable<List<_ixkx8coo.FeatureTag>> tags;

  _iu7c1iaq.RaceFeatureSpellGrantDataTable? ___spellGrants;

  _is.ManyRelation<_iu7c1iaq.RaceFeatureSpellGrantDataTable>? _spellGrants;

  _ittxuxz1.RaceDataTable get race {
    if (_race != null) return _race!;
    _race = _is.createRelationTable(
      relationFieldName: 'race',
      field: RaceFeatureData.t.raceId,
      foreignField: _ittxuxz1.RaceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ittxuxz1.RaceDataTable(tableRelation: foreignTableRelation),
    );
    return _race!;
  }

  _i2k66n75.SubraceDataTable get subrace {
    if (_subrace != null) return _subrace!;
    _subrace = _is.createRelationTable(
      relationFieldName: 'subrace',
      field: RaceFeatureData.t.subraceId,
      foreignField: _i2k66n75.SubraceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2k66n75.SubraceDataTable(tableRelation: foreignTableRelation),
    );
    return _subrace!;
  }

  _iib0ncbr.FeatureResourceDefinitionDataTable get __resources {
    if (___resources != null) return ___resources!;
    ___resources = _is.createRelationTable(
      relationFieldName: '__resources',
      field: RaceFeatureData.t.id,
      foreignField: _iib0ncbr.FeatureResourceDefinitionData.t.raceFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iib0ncbr.FeatureResourceDefinitionDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return ___resources!;
  }

  _ipujnj10.FeatureResourceEffectDataTable get __resourceEffects {
    if (___resourceEffects != null) return ___resourceEffects!;
    ___resourceEffects = _is.createRelationTable(
      relationFieldName: '__resourceEffects',
      field: RaceFeatureData.t.id,
      foreignField: _ipujnj10.FeatureResourceEffectData.t.raceFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ipujnj10.FeatureResourceEffectDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return ___resourceEffects!;
  }

  _iu7c1iaq.RaceFeatureSpellGrantDataTable get __spellGrants {
    if (___spellGrants != null) return ___spellGrants!;
    ___spellGrants = _is.createRelationTable(
      relationFieldName: '__spellGrants',
      field: RaceFeatureData.t.id,
      foreignField: _iu7c1iaq.RaceFeatureSpellGrantData.t.featureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iu7c1iaq.RaceFeatureSpellGrantDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return ___spellGrants!;
  }

  _is.ManyRelation<_iib0ncbr.FeatureResourceDefinitionDataTable> get resources {
    if (_resources != null) return _resources!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'resources',
      field: RaceFeatureData.t.id,
      foreignField: _iib0ncbr.FeatureResourceDefinitionData.t.raceFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iib0ncbr.FeatureResourceDefinitionDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    _resources = _is.ManyRelation<_iib0ncbr.FeatureResourceDefinitionDataTable>(
      tableWithRelations: relationTable,
      table: _iib0ncbr.FeatureResourceDefinitionDataTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _resources!;
  }

  _is.ManyRelation<_ipujnj10.FeatureResourceEffectDataTable>
  get resourceEffects {
    if (_resourceEffects != null) return _resourceEffects!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'resourceEffects',
      field: RaceFeatureData.t.id,
      foreignField: _ipujnj10.FeatureResourceEffectData.t.raceFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ipujnj10.FeatureResourceEffectDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    _resourceEffects =
        _is.ManyRelation<_ipujnj10.FeatureResourceEffectDataTable>(
          tableWithRelations: relationTable,
          table: _ipujnj10.FeatureResourceEffectDataTable(
            tableRelation: relationTable.tableRelation!.lastRelation,
          ),
        );
    return _resourceEffects!;
  }

  _is.ManyRelation<_iu7c1iaq.RaceFeatureSpellGrantDataTable> get spellGrants {
    if (_spellGrants != null) return _spellGrants!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'spellGrants',
      field: RaceFeatureData.t.id,
      foreignField: _iu7c1iaq.RaceFeatureSpellGrantData.t.featureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iu7c1iaq.RaceFeatureSpellGrantDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    _spellGrants = _is.ManyRelation<_iu7c1iaq.RaceFeatureSpellGrantDataTable>(
      tableWithRelations: relationTable,
      table: _iu7c1iaq.RaceFeatureSpellGrantDataTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _spellGrants!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    raceId,
    subraceId,
    name,
    referenceKey,
    description,
    shortDescription,
    source,
    version,
    createdAt,
    updatedAt,
    level,
    usesPerRest,
    usesFormula,
    tags,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'race') {
      return race;
    }
    if (relationField == 'subrace') {
      return subrace;
    }
    if (relationField == 'resources') {
      return __resources;
    }
    if (relationField == 'resourceEffects') {
      return __resourceEffects;
    }
    if (relationField == 'spellGrants') {
      return __spellGrants;
    }
    return null;
  }
}

class RaceFeatureDataInclude extends _is.IncludeObject {
  RaceFeatureDataInclude._({
    _ittxuxz1.RaceDataInclude? race,
    _i2k66n75.SubraceDataInclude? subrace,
    _iib0ncbr.FeatureResourceDefinitionDataIncludeList? resources,
    _ipujnj10.FeatureResourceEffectDataIncludeList? resourceEffects,
    _iu7c1iaq.RaceFeatureSpellGrantDataIncludeList? spellGrants,
  }) {
    _race = race;
    _subrace = subrace;
    _resources = resources;
    _resourceEffects = resourceEffects;
    _spellGrants = spellGrants;
  }

  _ittxuxz1.RaceDataInclude? _race;

  _i2k66n75.SubraceDataInclude? _subrace;

  _iib0ncbr.FeatureResourceDefinitionDataIncludeList? _resources;

  _ipujnj10.FeatureResourceEffectDataIncludeList? _resourceEffects;

  _iu7c1iaq.RaceFeatureSpellGrantDataIncludeList? _spellGrants;

  @override
  Map<String, _is.Include?> get includes => {
    'race': _race,
    'subrace': _subrace,
    'resources': _resources,
    'resourceEffects': _resourceEffects,
    'spellGrants': _spellGrants,
  };

  @override
  _is.Table<int?> get table => RaceFeatureData.t;
}

class RaceFeatureDataIncludeList extends _is.IncludeList {
  RaceFeatureDataIncludeList._({
    _is.WhereExpressionBuilder<RaceFeatureDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RaceFeatureData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RaceFeatureData.t;
}

class RaceFeatureDataRepository {
  const RaceFeatureDataRepository._();

  final attach = const RaceFeatureDataAttachRepository._();

  final attachRow = const RaceFeatureDataAttachRowRepository._();

  final detach = const RaceFeatureDataDetachRepository._();

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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RaceFeatureDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RaceFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<RaceFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    RaceFeatureDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RaceFeatureData>(
      where: where?.call(RaceFeatureData.t),
      orderBy: orderBy?.call(RaceFeatureData.t),
      orderByList: orderByList?.call(RaceFeatureData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RaceFeatureDataTable>? where,
    int? offset,
    _is.OrderByBuilder<RaceFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<RaceFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    RaceFeatureDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RaceFeatureData>(
      where: where?.call(RaceFeatureData.t),
      orderBy: orderBy?.call(RaceFeatureData.t),
      orderByList: orderByList?.call(RaceFeatureData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RaceFeatureData] by its [id] or null if no such row exists.
  Future<RaceFeatureData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    RaceFeatureDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RaceFeatureData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RaceFeatureData]s in the list and returns the inserted rows.
  ///
  /// The returned [RaceFeatureData]s will have their `id` fields set.
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
  Future<List<RaceFeatureData>> insert(
    _is.DatabaseSession session,
    List<RaceFeatureData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RaceFeatureData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RaceFeatureData] and returns the inserted row.
  ///
  /// The returned [RaceFeatureData] will have its `id` field set.
  Future<RaceFeatureData> insertRow(
    _is.DatabaseSession session,
    RaceFeatureData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RaceFeatureData>(row, transaction: transaction);
  }

  /// Upserts all [RaceFeatureData]s in the list and returns the resulting rows.
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
  /// The returned [RaceFeatureData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceFeatureData>> upsert(
    _is.DatabaseSession session,
    List<RaceFeatureData> rows, {
    required _is.ColumnSelections<RaceFeatureDataTable> conflictColumns,
    _is.ColumnSelections<RaceFeatureDataTable>? updateColumns,
    _is.WhereExpressionBuilder<RaceFeatureDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RaceFeatureData>(
      rows,
      conflictColumns: conflictColumns(RaceFeatureData.t),
      updateColumns: updateColumns?.call(RaceFeatureData.t),
      updateWhere: updateWhere?.call(RaceFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RaceFeatureData] and returns the resulting row.
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
  /// The returned [RaceFeatureData] will have its `id` field set.
  Future<RaceFeatureData?> upsertRow(
    _is.DatabaseSession session,
    RaceFeatureData row, {
    required _is.ColumnSelections<RaceFeatureDataTable> conflictColumns,
    _is.ColumnSelections<RaceFeatureDataTable>? updateColumns,
    _is.WhereExpressionBuilder<RaceFeatureDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RaceFeatureData>(
      row,
      conflictColumns: conflictColumns(RaceFeatureData.t),
      updateColumns: updateColumns?.call(RaceFeatureData.t),
      updateWhere: updateWhere?.call(RaceFeatureData.t),
      transaction: transaction,
    );
  }

  /// Updates all [RaceFeatureData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceFeatureData>> update(
    _is.DatabaseSession session,
    List<RaceFeatureData> rows, {
    _is.ColumnSelections<RaceFeatureDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RaceFeatureData>(
      rows,
      columns: columns?.call(RaceFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RaceFeatureData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RaceFeatureData> updateRow(
    _is.DatabaseSession session,
    RaceFeatureData row, {
    _is.ColumnSelections<RaceFeatureDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RaceFeatureData>(
      row,
      columns: columns?.call(RaceFeatureData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RaceFeatureData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RaceFeatureData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RaceFeatureDataUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RaceFeatureData>(
      id,
      columnValues: columnValues(RaceFeatureData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RaceFeatureData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceFeatureData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RaceFeatureDataUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<RaceFeatureDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RaceFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<RaceFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RaceFeatureData>(
      columnValues: columnValues(RaceFeatureData.t.updateTable),
      where: where(RaceFeatureData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RaceFeatureData.t),
      orderByList: orderByList?.call(RaceFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RaceFeatureData]s in the list and returns the deleted rows.
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
  Future<List<RaceFeatureData>> delete(
    _is.DatabaseSession session,
    List<RaceFeatureData> rows, {
    _is.OrderByBuilder<RaceFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<RaceFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RaceFeatureData>(
      rows,
      orderBy: orderBy?.call(RaceFeatureData.t),
      orderByList: orderByList?.call(RaceFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RaceFeatureData].
  Future<RaceFeatureData> deleteRow(
    _is.DatabaseSession session,
    RaceFeatureData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RaceFeatureData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceFeatureData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RaceFeatureDataTable> where,
    _is.OrderByBuilder<RaceFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<RaceFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RaceFeatureData>(
      where: where(RaceFeatureData.t),
      orderBy: orderBy?.call(RaceFeatureData.t),
      orderByList: orderByList?.call(RaceFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RaceFeatureDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RaceFeatureData>(
      where: where?.call(RaceFeatureData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RaceFeatureData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RaceFeatureDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RaceFeatureData>(
      where: where(RaceFeatureData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class RaceFeatureDataAttachRepository {
  const RaceFeatureDataAttachRepository._();

  /// Creates a relation between this [RaceFeatureData] and the given [FeatureResourceDefinitionData]s
  /// by setting each [FeatureResourceDefinitionData]'s foreign key `raceFeatureId` to refer to this [RaceFeatureData].
  Future<void> resources(
    _is.DatabaseSession session,
    RaceFeatureData raceFeatureData,
    List<_iib0ncbr.FeatureResourceDefinitionData>
    featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData
        .map((e) => e.copyWith(raceFeatureId: raceFeatureData.id))
        .toList();
    await session.db.update<_iib0ncbr.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_iib0ncbr.FeatureResourceDefinitionData.t.raceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [RaceFeatureData] and the given [FeatureResourceEffectData]s
  /// by setting each [FeatureResourceEffectData]'s foreign key `raceFeatureId` to refer to this [RaceFeatureData].
  Future<void> resourceEffects(
    _is.DatabaseSession session,
    RaceFeatureData raceFeatureData,
    List<_ipujnj10.FeatureResourceEffectData> featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData
        .map((e) => e.copyWith(raceFeatureId: raceFeatureData.id))
        .toList();
    await session.db.update<_ipujnj10.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_ipujnj10.FeatureResourceEffectData.t.raceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [RaceFeatureData] and the given [RaceFeatureSpellGrantData]s
  /// by setting each [RaceFeatureSpellGrantData]'s foreign key `featureId` to refer to this [RaceFeatureData].
  Future<void> spellGrants(
    _is.DatabaseSession session,
    RaceFeatureData raceFeatureData,
    List<_iu7c1iaq.RaceFeatureSpellGrantData> raceFeatureSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (raceFeatureSpellGrantData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('raceFeatureSpellGrantData.id');
    }
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $raceFeatureSpellGrantData = raceFeatureSpellGrantData
        .map((e) => e.copyWith(featureId: raceFeatureData.id))
        .toList();
    await session.db.update<_iu7c1iaq.RaceFeatureSpellGrantData>(
      $raceFeatureSpellGrantData,
      columns: [_iu7c1iaq.RaceFeatureSpellGrantData.t.featureId],
      transaction: transaction,
    );
  }
}

class RaceFeatureDataAttachRowRepository {
  const RaceFeatureDataAttachRowRepository._();

  /// Creates a relation between the given [RaceFeatureData] and [RaceData]
  /// by setting the [RaceFeatureData]'s foreign key `raceId` to refer to the [RaceData].
  Future<void> race(
    _is.DatabaseSession session,
    RaceFeatureData raceFeatureData,
    _ittxuxz1.RaceData race, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    RaceFeatureData raceFeatureData,
    _i2k66n75.SubraceData subrace, {
    _is.Transaction? transaction,
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

  /// Creates a relation between this [RaceFeatureData] and the given [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `raceFeatureId` to refer to this [RaceFeatureData].
  Future<void> resources(
    _is.DatabaseSession session,
    RaceFeatureData raceFeatureData,
    _iib0ncbr.FeatureResourceDefinitionData featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
      raceFeatureId: raceFeatureData.id,
    );
    await session.db.updateRow<_iib0ncbr.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_iib0ncbr.FeatureResourceDefinitionData.t.raceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [RaceFeatureData] and the given [FeatureResourceEffectData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `raceFeatureId` to refer to this [RaceFeatureData].
  Future<void> resourceEffects(
    _is.DatabaseSession session,
    RaceFeatureData raceFeatureData,
    _ipujnj10.FeatureResourceEffectData featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
      raceFeatureId: raceFeatureData.id,
    );
    await session.db.updateRow<_ipujnj10.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_ipujnj10.FeatureResourceEffectData.t.raceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [RaceFeatureData] and the given [RaceFeatureSpellGrantData]
  /// by setting the [RaceFeatureSpellGrantData]'s foreign key `featureId` to refer to this [RaceFeatureData].
  Future<void> spellGrants(
    _is.DatabaseSession session,
    RaceFeatureData raceFeatureData,
    _iu7c1iaq.RaceFeatureSpellGrantData raceFeatureSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (raceFeatureSpellGrantData.id == null) {
      throw ArgumentError.notNull('raceFeatureSpellGrantData.id');
    }
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $raceFeatureSpellGrantData = raceFeatureSpellGrantData.copyWith(
      featureId: raceFeatureData.id,
    );
    await session.db.updateRow<_iu7c1iaq.RaceFeatureSpellGrantData>(
      $raceFeatureSpellGrantData,
      columns: [_iu7c1iaq.RaceFeatureSpellGrantData.t.featureId],
      transaction: transaction,
    );
  }
}

class RaceFeatureDataDetachRepository {
  const RaceFeatureDataDetachRepository._();

  /// Detaches the relation between this [RaceFeatureData] and the given [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `raceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resources(
    _is.DatabaseSession session,
    List<_iib0ncbr.FeatureResourceDefinitionData>
    featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData
        .map((e) => e.copyWith(raceFeatureId: null))
        .toList();
    await session.db.update<_iib0ncbr.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_iib0ncbr.FeatureResourceDefinitionData.t.raceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [RaceFeatureData] and the given [FeatureResourceEffectData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `raceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resourceEffects(
    _is.DatabaseSession session,
    List<_ipujnj10.FeatureResourceEffectData> featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData
        .map((e) => e.copyWith(raceFeatureId: null))
        .toList();
    await session.db.update<_ipujnj10.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_ipujnj10.FeatureResourceEffectData.t.raceFeatureId],
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
    _is.DatabaseSession session,
    RaceFeatureData raceFeatureData, {
    _is.Transaction? transaction,
  }) async {
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $raceFeatureData = raceFeatureData.copyWith(raceId: null);
    await session.db.updateRow<RaceFeatureData>(
      $raceFeatureData,
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
    _is.DatabaseSession session,
    RaceFeatureData raceFeatureData, {
    _is.Transaction? transaction,
  }) async {
    if (raceFeatureData.id == null) {
      throw ArgumentError.notNull('raceFeatureData.id');
    }

    var $raceFeatureData = raceFeatureData.copyWith(subraceId: null);
    await session.db.updateRow<RaceFeatureData>(
      $raceFeatureData,
      columns: [RaceFeatureData.t.subraceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [RaceFeatureData] and the given [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `raceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resources(
    _is.DatabaseSession session,
    _iib0ncbr.FeatureResourceDefinitionData featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
      raceFeatureId: null,
    );
    await session.db.updateRow<_iib0ncbr.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_iib0ncbr.FeatureResourceDefinitionData.t.raceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [RaceFeatureData] and the given [FeatureResourceEffectData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `raceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resourceEffects(
    _is.DatabaseSession session,
    _ipujnj10.FeatureResourceEffectData featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
      raceFeatureId: null,
    );
    await session.db.updateRow<_ipujnj10.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_ipujnj10.FeatureResourceEffectData.t.raceFeatureId],
      transaction: transaction,
    );
  }
}
