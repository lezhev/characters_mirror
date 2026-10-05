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
import '../../../data/general/class/class_data.dart' as _i2;
import '../../../enums/feature_tag.dart' as _i3;
import '../../../enums/language.dart' as _i4;
import '../../../enums/unarmored_defense_rule.dart' as _i5;
import '../../../data/general/feature_resource_definition_data.dart' as _i6;
import '../../../data/general/feature_resource_effect_data.dart' as _i7;
import '../../../data/class_spell_grant_data.dart' as _i8;
import '../../../data/general/feature_modifier_data.dart' as _i9;

abstract class ClassFeatureData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ClassFeatureData._({
    this.id,
    required this.parentClassId,
    this.parentClass,
    this.name,
    this.referenceKey,
    this.description,
    this.shortDescription,
    required this.level,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.tags,
    this.choiceGroupKey,
    this.grantedLanguages,
    this.unarmoredDefenseRule,
    this.relatedTable,
    this.resources,
    this.resourceEffects,
    this.spellGrants,
    this.featureModifiers,
  });

  factory ClassFeatureData({
    int? id,
    required int parentClassId,
    _i2.ClassData? parentClass,
    String? name,
    String? referenceKey,
    String? description,
    String? shortDescription,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i3.FeatureTag>? tags,
    String? choiceGroupKey,
    List<_i4.Language>? grantedLanguages,
    _i5.UnarmoredDefenseRule? unarmoredDefenseRule,
    String? relatedTable,
    List<_i6.FeatureResourceDefinitionData>? resources,
    List<_i7.FeatureResourceEffectData>? resourceEffects,
    List<_i8.ClassSpellGrantData>? spellGrants,
    List<_i9.FeatureModifierData>? featureModifiers,
  }) = _ClassFeatureDataImpl;

  factory ClassFeatureData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassFeatureData(
      id: jsonSerialization['id'] as int?,
      parentClassId: jsonSerialization['parentClassId'] as int,
      parentClass: jsonSerialization['parentClass'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['parentClass'] as Map<String, dynamic>)),
      name: jsonSerialization['name'] as String?,
      referenceKey: jsonSerialization['referenceKey'] as String?,
      description: jsonSerialization['description'] as String?,
      shortDescription: jsonSerialization['shortDescription'] as String?,
      level: jsonSerialization['level'] as int,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => _i3.FeatureTag.fromJson((e as String)))
          .toList(),
      choiceGroupKey: jsonSerialization['choiceGroupKey'] as String?,
      grantedLanguages: (jsonSerialization['grantedLanguages'] as List?)
          ?.map((e) => _i4.Language.fromJson((e as String)))
          .toList(),
      unarmoredDefenseRule: jsonSerialization['unarmoredDefenseRule'] == null
          ? null
          : _i5.UnarmoredDefenseRule.fromJson(
              (jsonSerialization['unarmoredDefenseRule'] as String)),
      relatedTable: jsonSerialization['relatedTable'] as String?,
      resources: (jsonSerialization['resources'] as List?)
          ?.map((e) => _i6.FeatureResourceDefinitionData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      resourceEffects: (jsonSerialization['resourceEffects'] as List?)
          ?.map((e) => _i7.FeatureResourceEffectData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      spellGrants: (jsonSerialization['spellGrants'] as List?)
          ?.map((e) =>
              _i8.ClassSpellGrantData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      featureModifiers: (jsonSerialization['featureModifiers'] as List?)
          ?.map((e) =>
              _i9.FeatureModifierData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = ClassFeatureDataTable();

  static const db = ClassFeatureDataRepository._();

  @override
  int? id;

  int parentClassId;

  _i2.ClassData? parentClass;

  String? name;

  String? referenceKey;

  String? description;

  String? shortDescription;

  int level;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  List<_i3.FeatureTag>? tags;

  String? choiceGroupKey;

  List<_i4.Language>? grantedLanguages;

  _i5.UnarmoredDefenseRule? unarmoredDefenseRule;

  String? relatedTable;

  List<_i6.FeatureResourceDefinitionData>? resources;

  List<_i7.FeatureResourceEffectData>? resourceEffects;

  List<_i8.ClassSpellGrantData>? spellGrants;

  List<_i9.FeatureModifierData>? featureModifiers;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassFeatureData copyWith({
    int? id,
    int? parentClassId,
    _i2.ClassData? parentClass,
    String? name,
    String? referenceKey,
    String? description,
    String? shortDescription,
    int? level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i3.FeatureTag>? tags,
    String? choiceGroupKey,
    List<_i4.Language>? grantedLanguages,
    _i5.UnarmoredDefenseRule? unarmoredDefenseRule,
    String? relatedTable,
    List<_i6.FeatureResourceDefinitionData>? resources,
    List<_i7.FeatureResourceEffectData>? resourceEffects,
    List<_i8.ClassSpellGrantData>? spellGrants,
    List<_i9.FeatureModifierData>? featureModifiers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJson(),
      if (name != null) 'name': name,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (description != null) 'description': description,
      if (shortDescription != null) 'shortDescription': shortDescription,
      'level': level,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (choiceGroupKey != null) 'choiceGroupKey': choiceGroupKey,
      if (grantedLanguages != null)
        'grantedLanguages':
            grantedLanguages?.toJson(valueToJson: (v) => v.toJson()),
      if (unarmoredDefenseRule != null)
        'unarmoredDefenseRule': unarmoredDefenseRule?.toJson(),
      if (relatedTable != null) 'relatedTable': relatedTable,
      if (resources != null)
        'resources': resources?.toJson(valueToJson: (v) => v.toJson()),
      if (resourceEffects != null)
        'resourceEffects':
            resourceEffects?.toJson(valueToJson: (v) => v.toJson()),
      if (spellGrants != null)
        'spellGrants': spellGrants?.toJson(valueToJson: (v) => v.toJson()),
      if (featureModifiers != null)
        'featureModifiers':
            featureModifiers?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJsonForProtocol(),
      if (name != null) 'name': name,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (description != null) 'description': description,
      if (shortDescription != null) 'shortDescription': shortDescription,
      'level': level,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (choiceGroupKey != null) 'choiceGroupKey': choiceGroupKey,
      if (grantedLanguages != null)
        'grantedLanguages':
            grantedLanguages?.toJson(valueToJson: (v) => v.toJson()),
      if (unarmoredDefenseRule != null)
        'unarmoredDefenseRule': unarmoredDefenseRule?.toJson(),
      if (relatedTable != null) 'relatedTable': relatedTable,
      if (resources != null)
        'resources':
            resources?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (resourceEffects != null)
        'resourceEffects':
            resourceEffects?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (spellGrants != null)
        'spellGrants':
            spellGrants?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (featureModifiers != null)
        'featureModifiers':
            featureModifiers?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static ClassFeatureDataInclude include({
    _i2.ClassDataInclude? parentClass,
    _i6.FeatureResourceDefinitionDataIncludeList? resources,
    _i7.FeatureResourceEffectDataIncludeList? resourceEffects,
    _i8.ClassSpellGrantDataIncludeList? spellGrants,
    _i9.FeatureModifierDataIncludeList? featureModifiers,
  }) {
    return ClassFeatureDataInclude._(
      parentClass: parentClass,
      resources: resources,
      resourceEffects: resourceEffects,
      spellGrants: spellGrants,
      featureModifiers: featureModifiers,
    );
  }

  static ClassFeatureDataIncludeList includeList({
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    ClassFeatureDataInclude? include,
  }) {
    return ClassFeatureDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ClassFeatureData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassFeatureDataImpl extends ClassFeatureData {
  _ClassFeatureDataImpl({
    int? id,
    required int parentClassId,
    _i2.ClassData? parentClass,
    String? name,
    String? referenceKey,
    String? description,
    String? shortDescription,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i3.FeatureTag>? tags,
    String? choiceGroupKey,
    List<_i4.Language>? grantedLanguages,
    _i5.UnarmoredDefenseRule? unarmoredDefenseRule,
    String? relatedTable,
    List<_i6.FeatureResourceDefinitionData>? resources,
    List<_i7.FeatureResourceEffectData>? resourceEffects,
    List<_i8.ClassSpellGrantData>? spellGrants,
    List<_i9.FeatureModifierData>? featureModifiers,
  }) : super._(
          id: id,
          parentClassId: parentClassId,
          parentClass: parentClass,
          name: name,
          referenceKey: referenceKey,
          description: description,
          shortDescription: shortDescription,
          level: level,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          tags: tags,
          choiceGroupKey: choiceGroupKey,
          grantedLanguages: grantedLanguages,
          unarmoredDefenseRule: unarmoredDefenseRule,
          relatedTable: relatedTable,
          resources: resources,
          resourceEffects: resourceEffects,
          spellGrants: spellGrants,
          featureModifiers: featureModifiers,
        );

  /// Returns a shallow copy of this [ClassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassFeatureData copyWith({
    Object? id = _Undefined,
    int? parentClassId,
    Object? parentClass = _Undefined,
    Object? name = _Undefined,
    Object? referenceKey = _Undefined,
    Object? description = _Undefined,
    Object? shortDescription = _Undefined,
    int? level,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? tags = _Undefined,
    Object? choiceGroupKey = _Undefined,
    Object? grantedLanguages = _Undefined,
    Object? unarmoredDefenseRule = _Undefined,
    Object? relatedTable = _Undefined,
    Object? resources = _Undefined,
    Object? resourceEffects = _Undefined,
    Object? spellGrants = _Undefined,
    Object? featureModifiers = _Undefined,
  }) {
    return ClassFeatureData(
      id: id is int? ? id : this.id,
      parentClassId: parentClassId ?? this.parentClassId,
      parentClass: parentClass is _i2.ClassData?
          ? parentClass
          : this.parentClass?.copyWith(),
      name: name is String? ? name : this.name,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      description: description is String? ? description : this.description,
      shortDescription: shortDescription is String?
          ? shortDescription
          : this.shortDescription,
      level: level ?? this.level,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      tags: tags is List<_i3.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
      choiceGroupKey:
          choiceGroupKey is String? ? choiceGroupKey : this.choiceGroupKey,
      grantedLanguages: grantedLanguages is List<_i4.Language>?
          ? grantedLanguages
          : this.grantedLanguages?.map((e0) => e0).toList(),
      unarmoredDefenseRule: unarmoredDefenseRule is _i5.UnarmoredDefenseRule?
          ? unarmoredDefenseRule
          : this.unarmoredDefenseRule,
      relatedTable: relatedTable is String? ? relatedTable : this.relatedTable,
      resources: resources is List<_i6.FeatureResourceDefinitionData>?
          ? resources
          : this.resources?.map((e0) => e0.copyWith()).toList(),
      resourceEffects: resourceEffects is List<_i7.FeatureResourceEffectData>?
          ? resourceEffects
          : this.resourceEffects?.map((e0) => e0.copyWith()).toList(),
      spellGrants: spellGrants is List<_i8.ClassSpellGrantData>?
          ? spellGrants
          : this.spellGrants?.map((e0) => e0.copyWith()).toList(),
      featureModifiers: featureModifiers is List<_i9.FeatureModifierData>?
          ? featureModifiers
          : this.featureModifiers?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class ClassFeatureDataTable extends _i1.Table<int?> {
  ClassFeatureDataTable({super.tableRelation})
      : super(tableName: 'class_feature_data') {
    parentClassId = _i1.ColumnInt(
      'parentClassId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    referenceKey = _i1.ColumnString(
      'referenceKey',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    shortDescription = _i1.ColumnString(
      'shortDescription',
      this,
    );
    level = _i1.ColumnInt(
      'level',
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
    tags = _i1.ColumnSerializable(
      'tags',
      this,
    );
    choiceGroupKey = _i1.ColumnString(
      'choiceGroupKey',
      this,
    );
    grantedLanguages = _i1.ColumnSerializable(
      'grantedLanguages',
      this,
    );
    unarmoredDefenseRule = _i1.ColumnEnum(
      'unarmoredDefenseRule',
      this,
      _i1.EnumSerialization.byName,
    );
    relatedTable = _i1.ColumnString(
      'relatedTable',
      this,
    );
  }

  late final _i1.ColumnInt parentClassId;

  _i2.ClassDataTable? _parentClass;

  late final _i1.ColumnString name;

  late final _i1.ColumnString referenceKey;

  late final _i1.ColumnString description;

  late final _i1.ColumnString shortDescription;

  late final _i1.ColumnInt level;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnSerializable tags;

  late final _i1.ColumnString choiceGroupKey;

  late final _i1.ColumnSerializable grantedLanguages;

  late final _i1.ColumnEnum<_i5.UnarmoredDefenseRule> unarmoredDefenseRule;

  late final _i1.ColumnString relatedTable;

  _i6.FeatureResourceDefinitionDataTable? ___resources;

  _i1.ManyRelation<_i6.FeatureResourceDefinitionDataTable>? _resources;

  _i7.FeatureResourceEffectDataTable? ___resourceEffects;

  _i1.ManyRelation<_i7.FeatureResourceEffectDataTable>? _resourceEffects;

  _i8.ClassSpellGrantDataTable? ___spellGrants;

  _i1.ManyRelation<_i8.ClassSpellGrantDataTable>? _spellGrants;

  _i9.FeatureModifierDataTable? ___featureModifiers;

  _i1.ManyRelation<_i9.FeatureModifierDataTable>? _featureModifiers;

  _i2.ClassDataTable get parentClass {
    if (_parentClass != null) return _parentClass!;
    _parentClass = _i1.createRelationTable(
      relationFieldName: 'parentClass',
      field: ClassFeatureData.t.parentClassId,
      foreignField: _i2.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _parentClass!;
  }

  _i6.FeatureResourceDefinitionDataTable get __resources {
    if (___resources != null) return ___resources!;
    ___resources = _i1.createRelationTable(
      relationFieldName: '__resources',
      field: ClassFeatureData.t.id,
      foreignField: _i6.FeatureResourceDefinitionData.t.classFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.FeatureResourceDefinitionDataTable(
              tableRelation: foreignTableRelation),
    );
    return ___resources!;
  }

  _i7.FeatureResourceEffectDataTable get __resourceEffects {
    if (___resourceEffects != null) return ___resourceEffects!;
    ___resourceEffects = _i1.createRelationTable(
      relationFieldName: '__resourceEffects',
      field: ClassFeatureData.t.id,
      foreignField: _i7.FeatureResourceEffectData.t.classFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i7.FeatureResourceEffectDataTable(
          tableRelation: foreignTableRelation),
    );
    return ___resourceEffects!;
  }

  _i8.ClassSpellGrantDataTable get __spellGrants {
    if (___spellGrants != null) return ___spellGrants!;
    ___spellGrants = _i1.createRelationTable(
      relationFieldName: '__spellGrants',
      field: ClassFeatureData.t.id,
      foreignField: _i8.ClassSpellGrantData.t.sourceFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.ClassSpellGrantDataTable(tableRelation: foreignTableRelation),
    );
    return ___spellGrants!;
  }

  _i9.FeatureModifierDataTable get __featureModifiers {
    if (___featureModifiers != null) return ___featureModifiers!;
    ___featureModifiers = _i1.createRelationTable(
      relationFieldName: '__featureModifiers',
      field: ClassFeatureData.t.id,
      foreignField: _i9.FeatureModifierData.t.classFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i9.FeatureModifierDataTable(tableRelation: foreignTableRelation),
    );
    return ___featureModifiers!;
  }

  _i1.ManyRelation<_i6.FeatureResourceDefinitionDataTable> get resources {
    if (_resources != null) return _resources!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'resources',
      field: ClassFeatureData.t.id,
      foreignField: _i6.FeatureResourceDefinitionData.t.classFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.FeatureResourceDefinitionDataTable(
              tableRelation: foreignTableRelation),
    );
    _resources = _i1.ManyRelation<_i6.FeatureResourceDefinitionDataTable>(
      tableWithRelations: relationTable,
      table: _i6.FeatureResourceDefinitionDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _resources!;
  }

  _i1.ManyRelation<_i7.FeatureResourceEffectDataTable> get resourceEffects {
    if (_resourceEffects != null) return _resourceEffects!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'resourceEffects',
      field: ClassFeatureData.t.id,
      foreignField: _i7.FeatureResourceEffectData.t.classFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i7.FeatureResourceEffectDataTable(
          tableRelation: foreignTableRelation),
    );
    _resourceEffects = _i1.ManyRelation<_i7.FeatureResourceEffectDataTable>(
      tableWithRelations: relationTable,
      table: _i7.FeatureResourceEffectDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _resourceEffects!;
  }

  _i1.ManyRelation<_i8.ClassSpellGrantDataTable> get spellGrants {
    if (_spellGrants != null) return _spellGrants!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'spellGrants',
      field: ClassFeatureData.t.id,
      foreignField: _i8.ClassSpellGrantData.t.sourceFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.ClassSpellGrantDataTable(tableRelation: foreignTableRelation),
    );
    _spellGrants = _i1.ManyRelation<_i8.ClassSpellGrantDataTable>(
      tableWithRelations: relationTable,
      table: _i8.ClassSpellGrantDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _spellGrants!;
  }

  _i1.ManyRelation<_i9.FeatureModifierDataTable> get featureModifiers {
    if (_featureModifiers != null) return _featureModifiers!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'featureModifiers',
      field: ClassFeatureData.t.id,
      foreignField: _i9.FeatureModifierData.t.classFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i9.FeatureModifierDataTable(tableRelation: foreignTableRelation),
    );
    _featureModifiers = _i1.ManyRelation<_i9.FeatureModifierDataTable>(
      tableWithRelations: relationTable,
      table: _i9.FeatureModifierDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _featureModifiers!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        parentClassId,
        name,
        referenceKey,
        description,
        shortDescription,
        level,
        source,
        version,
        createdAt,
        updatedAt,
        tags,
        choiceGroupKey,
        grantedLanguages,
        unarmoredDefenseRule,
        relatedTable,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'parentClass') {
      return parentClass;
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
    if (relationField == 'featureModifiers') {
      return __featureModifiers;
    }
    return null;
  }
}

class ClassFeatureDataInclude extends _i1.IncludeObject {
  ClassFeatureDataInclude._({
    _i2.ClassDataInclude? parentClass,
    _i6.FeatureResourceDefinitionDataIncludeList? resources,
    _i7.FeatureResourceEffectDataIncludeList? resourceEffects,
    _i8.ClassSpellGrantDataIncludeList? spellGrants,
    _i9.FeatureModifierDataIncludeList? featureModifiers,
  }) {
    _parentClass = parentClass;
    _resources = resources;
    _resourceEffects = resourceEffects;
    _spellGrants = spellGrants;
    _featureModifiers = featureModifiers;
  }

  _i2.ClassDataInclude? _parentClass;

  _i6.FeatureResourceDefinitionDataIncludeList? _resources;

  _i7.FeatureResourceEffectDataIncludeList? _resourceEffects;

  _i8.ClassSpellGrantDataIncludeList? _spellGrants;

  _i9.FeatureModifierDataIncludeList? _featureModifiers;

  @override
  Map<String, _i1.Include?> get includes => {
        'parentClass': _parentClass,
        'resources': _resources,
        'resourceEffects': _resourceEffects,
        'spellGrants': _spellGrants,
        'featureModifiers': _featureModifiers,
      };

  @override
  _i1.Table<int?> get table => ClassFeatureData.t;
}

class ClassFeatureDataIncludeList extends _i1.IncludeList {
  ClassFeatureDataIncludeList._({
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClassFeatureData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ClassFeatureData.t;
}

class ClassFeatureDataRepository {
  const ClassFeatureDataRepository._();

  final attach = const ClassFeatureDataAttachRepository._();

  final attachRow = const ClassFeatureDataAttachRowRepository._();

  final detach = const ClassFeatureDataDetachRepository._();

  final detachRow = const ClassFeatureDataDetachRowRepository._();

  /// Returns a list of [ClassFeatureData]s matching the given query parameters.
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
  Future<List<ClassFeatureData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassFeatureDataInclude? include,
  }) async {
    return session.db.find<ClassFeatureData>(
      where: where?.call(ClassFeatureData.t),
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderByList: orderByList?.call(ClassFeatureData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ClassFeatureData] matching the given query parameters.
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
  Future<ClassFeatureData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassFeatureDataInclude? include,
  }) async {
    return session.db.findFirstRow<ClassFeatureData>(
      where: where?.call(ClassFeatureData.t),
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderByList: orderByList?.call(ClassFeatureData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ClassFeatureData] by its [id] or null if no such row exists.
  Future<ClassFeatureData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ClassFeatureDataInclude? include,
  }) async {
    return session.db.findById<ClassFeatureData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ClassFeatureData]s in the list and returns the inserted rows.
  ///
  /// The returned [ClassFeatureData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ClassFeatureData>> insert(
    _i1.Session session,
    List<ClassFeatureData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ClassFeatureData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ClassFeatureData] and returns the inserted row.
  ///
  /// The returned [ClassFeatureData] will have its `id` field set.
  Future<ClassFeatureData> insertRow(
    _i1.Session session,
    ClassFeatureData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClassFeatureData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ClassFeatureData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ClassFeatureData>> update(
    _i1.Session session,
    List<ClassFeatureData> rows, {
    _i1.ColumnSelections<ClassFeatureDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ClassFeatureData>(
      rows,
      columns: columns?.call(ClassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClassFeatureData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClassFeatureData> updateRow(
    _i1.Session session,
    ClassFeatureData row, {
    _i1.ColumnSelections<ClassFeatureDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClassFeatureData>(
      row,
      columns: columns?.call(ClassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ClassFeatureData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ClassFeatureData>> delete(
    _i1.Session session,
    List<ClassFeatureData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ClassFeatureData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ClassFeatureData].
  Future<ClassFeatureData> deleteRow(
    _i1.Session session,
    ClassFeatureData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClassFeatureData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ClassFeatureData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClassFeatureDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ClassFeatureData>(
      where: where(ClassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ClassFeatureData>(
      where: where?.call(ClassFeatureData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ClassFeatureDataAttachRepository {
  const ClassFeatureDataAttachRepository._();

  /// Creates a relation between this [ClassFeatureData] and the given [FeatureResourceDefinitionData]s
  /// by setting each [FeatureResourceDefinitionData]'s foreign key `classFeatureId` to refer to this [ClassFeatureData].
  Future<void> resources(
    _i1.Session session,
    ClassFeatureData classFeatureData,
    List<_i6.FeatureResourceDefinitionData> featureResourceDefinitionData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData
        .map((e) => e.copyWith(classFeatureId: classFeatureData.id))
        .toList();
    await session.db.update<_i6.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_i6.FeatureResourceDefinitionData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [FeatureResourceEffectData]s
  /// by setting each [FeatureResourceEffectData]'s foreign key `classFeatureId` to refer to this [ClassFeatureData].
  Future<void> resourceEffects(
    _i1.Session session,
    ClassFeatureData classFeatureData,
    List<_i7.FeatureResourceEffectData> featureResourceEffectData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData
        .map((e) => e.copyWith(classFeatureId: classFeatureData.id))
        .toList();
    await session.db.update<_i7.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_i7.FeatureResourceEffectData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [ClassSpellGrantData]s
  /// by setting each [ClassSpellGrantData]'s foreign key `sourceFeatureId` to refer to this [ClassFeatureData].
  Future<void> spellGrants(
    _i1.Session session,
    ClassFeatureData classFeatureData,
    List<_i8.ClassSpellGrantData> classSpellGrantData, {
    _i1.Transaction? transaction,
  }) async {
    if (classSpellGrantData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $classSpellGrantData = classSpellGrantData
        .map((e) => e.copyWith(sourceFeatureId: classFeatureData.id))
        .toList();
    await session.db.update<_i8.ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [_i8.ClassSpellGrantData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [FeatureModifierData]s
  /// by setting each [FeatureModifierData]'s foreign key `classFeatureId` to refer to this [ClassFeatureData].
  Future<void> featureModifiers(
    _i1.Session session,
    ClassFeatureData classFeatureData,
    List<_i9.FeatureModifierData> featureModifierData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureModifierData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureModifierData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $featureModifierData = featureModifierData
        .map((e) => e.copyWith(classFeatureId: classFeatureData.id))
        .toList();
    await session.db.update<_i9.FeatureModifierData>(
      $featureModifierData,
      columns: [_i9.FeatureModifierData.t.classFeatureId],
      transaction: transaction,
    );
  }
}

class ClassFeatureDataAttachRowRepository {
  const ClassFeatureDataAttachRowRepository._();

  /// Creates a relation between the given [ClassFeatureData] and [ClassData]
  /// by setting the [ClassFeatureData]'s foreign key `parentClassId` to refer to the [ClassData].
  Future<void> parentClass(
    _i1.Session session,
    ClassFeatureData classFeatureData,
    _i2.ClassData parentClass, {
    _i1.Transaction? transaction,
  }) async {
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }
    if (parentClass.id == null) {
      throw ArgumentError.notNull('parentClass.id');
    }

    var $classFeatureData =
        classFeatureData.copyWith(parentClassId: parentClass.id);
    await session.db.updateRow<ClassFeatureData>(
      $classFeatureData,
      columns: [ClassFeatureData.t.parentClassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `classFeatureId` to refer to this [ClassFeatureData].
  Future<void> resources(
    _i1.Session session,
    ClassFeatureData classFeatureData,
    _i6.FeatureResourceDefinitionData featureResourceDefinitionData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
        classFeatureId: classFeatureData.id);
    await session.db.updateRow<_i6.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_i6.FeatureResourceDefinitionData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [FeatureResourceEffectData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `classFeatureId` to refer to this [ClassFeatureData].
  Future<void> resourceEffects(
    _i1.Session session,
    ClassFeatureData classFeatureData,
    _i7.FeatureResourceEffectData featureResourceEffectData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $featureResourceEffectData =
        featureResourceEffectData.copyWith(classFeatureId: classFeatureData.id);
    await session.db.updateRow<_i7.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_i7.FeatureResourceEffectData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [ClassSpellGrantData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceFeatureId` to refer to this [ClassFeatureData].
  Future<void> spellGrants(
    _i1.Session session,
    ClassFeatureData classFeatureData,
    _i8.ClassSpellGrantData classSpellGrantData, {
    _i1.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $classSpellGrantData =
        classSpellGrantData.copyWith(sourceFeatureId: classFeatureData.id);
    await session.db.updateRow<_i8.ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [_i8.ClassSpellGrantData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [FeatureModifierData]
  /// by setting the [FeatureModifierData]'s foreign key `classFeatureId` to refer to this [ClassFeatureData].
  Future<void> featureModifiers(
    _i1.Session session,
    ClassFeatureData classFeatureData,
    _i9.FeatureModifierData featureModifierData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureModifierData.id == null) {
      throw ArgumentError.notNull('featureModifierData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $featureModifierData =
        featureModifierData.copyWith(classFeatureId: classFeatureData.id);
    await session.db.updateRow<_i9.FeatureModifierData>(
      $featureModifierData,
      columns: [_i9.FeatureModifierData.t.classFeatureId],
      transaction: transaction,
    );
  }
}

class ClassFeatureDataDetachRepository {
  const ClassFeatureDataDetachRepository._();

  /// Detaches the relation between this [ClassFeatureData] and the given [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resources(
    _i1.Session session,
    List<_i6.FeatureResourceDefinitionData> featureResourceDefinitionData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData
        .map((e) => e.copyWith(classFeatureId: null))
        .toList();
    await session.db.update<_i6.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_i6.FeatureResourceDefinitionData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassFeatureData] and the given [FeatureResourceEffectData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resourceEffects(
    _i1.Session session,
    List<_i7.FeatureResourceEffectData> featureResourceEffectData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData
        .map((e) => e.copyWith(classFeatureId: null))
        .toList();
    await session.db.update<_i7.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_i7.FeatureResourceEffectData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassFeatureData] and the given [ClassSpellGrantData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> spellGrants(
    _i1.Session session,
    List<_i8.ClassSpellGrantData> classSpellGrantData, {
    _i1.Transaction? transaction,
  }) async {
    if (classSpellGrantData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }

    var $classSpellGrantData = classSpellGrantData
        .map((e) => e.copyWith(sourceFeatureId: null))
        .toList();
    await session.db.update<_i8.ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [_i8.ClassSpellGrantData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassFeatureData] and the given [FeatureModifierData]
  /// by setting the [FeatureModifierData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> featureModifiers(
    _i1.Session session,
    List<_i9.FeatureModifierData> featureModifierData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureModifierData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureModifierData.id');
    }

    var $featureModifierData = featureModifierData
        .map((e) => e.copyWith(classFeatureId: null))
        .toList();
    await session.db.update<_i9.FeatureModifierData>(
      $featureModifierData,
      columns: [_i9.FeatureModifierData.t.classFeatureId],
      transaction: transaction,
    );
  }
}

class ClassFeatureDataDetachRowRepository {
  const ClassFeatureDataDetachRowRepository._();

  /// Detaches the relation between this [ClassFeatureData] and the given [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resources(
    _i1.Session session,
    _i6.FeatureResourceDefinitionData featureResourceDefinitionData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceDefinitionData =
        featureResourceDefinitionData.copyWith(classFeatureId: null);
    await session.db.updateRow<_i6.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_i6.FeatureResourceDefinitionData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassFeatureData] and the given [FeatureResourceEffectData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resourceEffects(
    _i1.Session session,
    _i7.FeatureResourceEffectData featureResourceEffectData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }

    var $featureResourceEffectData =
        featureResourceEffectData.copyWith(classFeatureId: null);
    await session.db.updateRow<_i7.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_i7.FeatureResourceEffectData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassFeatureData] and the given [ClassSpellGrantData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> spellGrants(
    _i1.Session session,
    _i8.ClassSpellGrantData classSpellGrantData, {
    _i1.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }

    var $classSpellGrantData =
        classSpellGrantData.copyWith(sourceFeatureId: null);
    await session.db.updateRow<_i8.ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [_i8.ClassSpellGrantData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassFeatureData] and the given [FeatureModifierData]
  /// by setting the [FeatureModifierData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> featureModifiers(
    _i1.Session session,
    _i9.FeatureModifierData featureModifierData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureModifierData.id == null) {
      throw ArgumentError.notNull('featureModifierData.id');
    }

    var $featureModifierData =
        featureModifierData.copyWith(classFeatureId: null);
    await session.db.updateRow<_i9.FeatureModifierData>(
      $featureModifierData,
      columns: [_i9.FeatureModifierData.t.classFeatureId],
      transaction: transaction,
    );
  }
}
