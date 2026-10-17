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
import '../data/general/choice_option_data.dart' as _ivap0b5b;
import '../data/general/class/class_data.dart' as _iazz3r73;
import '../data/general/class/class_feature_data.dart' as _ikfzlvib;
import '../data/general/class/subclass_data.dart' as _ijcb6jld;
import '../data/general/class/subclass_feature_data.dart' as _itaxdcfb;
import '../data/general/spell_activation_data.dart' as _iyix4imv;
import '../data/spell_data.dart' as _iavpgfjb;
import '../enums/ability.dart' as _i26h74c2;

abstract class ClassSpellGrantData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ClassSpellGrantData._({
    this.id,
    this.spellId,
    this.spell,
    this.spellReferenceKey,
    this.sourceClassId,
    this.sourceClass,
    this.sourceSubclassId,
    this.sourceSubclass,
    this.sourceFeatureId,
    this.sourceFeature,
    this.sourceSubclassFeatureId,
    this.sourceSubclassFeature,
    this.grantedAtLevel,
    this.activation,
    this.castingAbility,
    this.alwaysPrepared,
    this.choiceOptionId,
    this.choiceOption,
    this.notes,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassSpellGrantData({
    int? id,
    int? spellId,
    _iavpgfjb.SpellData? spell,
    String? spellReferenceKey,
    int? sourceClassId,
    _iazz3r73.ClassData? sourceClass,
    int? sourceSubclassId,
    _ijcb6jld.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _ikfzlvib.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _itaxdcfb.SubclassFeatureData? sourceSubclassFeature,
    int? grantedAtLevel,
    _iyix4imv.SpellActivationData? activation,
    _i26h74c2.Ability? castingAbility,
    bool? alwaysPrepared,
    int? choiceOptionId,
    _ivap0b5b.ChoiceOptionData? choiceOption,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ClassSpellGrantDataImpl;

  factory ClassSpellGrantData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassSpellGrantData(
      id: jsonSerialization['id'] as int?,
      spellId: jsonSerialization['spellId'] as int?,
      spell: jsonSerialization['spell'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_iavpgfjb.SpellData>(
              jsonSerialization['spell'],
            ),
      spellReferenceKey: jsonSerialization['spellReferenceKey'] as String?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_iazz3r73.ClassData>(
              jsonSerialization['sourceClass'],
            ),
      sourceSubclassId: jsonSerialization['sourceSubclassId'] as int?,
      sourceSubclass: jsonSerialization['sourceSubclass'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_ijcb6jld.SubclassData>(
              jsonSerialization['sourceSubclass'],
            ),
      sourceFeatureId: jsonSerialization['sourceFeatureId'] as int?,
      sourceFeature: jsonSerialization['sourceFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_ikfzlvib.ClassFeatureData>(
              jsonSerialization['sourceFeature'],
            ),
      sourceSubclassFeatureId:
          jsonSerialization['sourceSubclassFeatureId'] as int?,
      sourceSubclassFeature: jsonSerialization['sourceSubclassFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_itaxdcfb.SubclassFeatureData>(
              jsonSerialization['sourceSubclassFeature'],
            ),
      grantedAtLevel: jsonSerialization['grantedAtLevel'] as int?,
      activation: jsonSerialization['activation'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_iyix4imv.SpellActivationData>(
              jsonSerialization['activation'],
            ),
      castingAbility: jsonSerialization['castingAbility'] == null
          ? null
          : _i26h74c2.Ability.fromJson(
              (jsonSerialization['castingAbility'] as String),
            ),
      alwaysPrepared: jsonSerialization['alwaysPrepared'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['alwaysPrepared']),
      choiceOptionId: jsonSerialization['choiceOptionId'] as int?,
      choiceOption: jsonSerialization['choiceOption'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_ivap0b5b.ChoiceOptionData>(
              jsonSerialization['choiceOption'],
            ),
      notes: jsonSerialization['notes'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ClassSpellGrantDataTable();

  static const db = ClassSpellGrantDataRepository._();

  @override
  int? id;

  int? spellId;

  _iavpgfjb.SpellData? spell;

  String? spellReferenceKey;

  int? sourceClassId;

  _iazz3r73.ClassData? sourceClass;

  int? sourceSubclassId;

  _ijcb6jld.SubclassData? sourceSubclass;

  int? sourceFeatureId;

  _ikfzlvib.ClassFeatureData? sourceFeature;

  int? sourceSubclassFeatureId;

  _itaxdcfb.SubclassFeatureData? sourceSubclassFeature;

  int? grantedAtLevel;

  _iyix4imv.SpellActivationData? activation;

  _i26h74c2.Ability? castingAbility;

  bool? alwaysPrepared;

  int? choiceOptionId;

  _ivap0b5b.ChoiceOptionData? choiceOption;

  String? notes;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClassSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ClassSpellGrantData copyWith({
    int? id,
    int? spellId,
    _iavpgfjb.SpellData? spell,
    String? spellReferenceKey,
    int? sourceClassId,
    _iazz3r73.ClassData? sourceClass,
    int? sourceSubclassId,
    _ijcb6jld.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _ikfzlvib.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _itaxdcfb.SubclassFeatureData? sourceSubclassFeature,
    int? grantedAtLevel,
    _iyix4imv.SpellActivationData? activation,
    _i26h74c2.Ability? castingAbility,
    bool? alwaysPrepared,
    int? choiceOptionId,
    _ivap0b5b.ChoiceOptionData? choiceOption,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClassSpellGrantData',
      if (id != null) 'id': id,
      if (spellId != null) 'spellId': spellId,
      if (spell != null) 'spell': spell?.toJson(),
      if (spellReferenceKey != null) 'spellReferenceKey': spellReferenceKey,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJson(),
      if (sourceSubclassId != null) 'sourceSubclassId': sourceSubclassId,
      if (sourceSubclass != null) 'sourceSubclass': sourceSubclass?.toJson(),
      if (sourceFeatureId != null) 'sourceFeatureId': sourceFeatureId,
      if (sourceFeature != null) 'sourceFeature': sourceFeature?.toJson(),
      if (sourceSubclassFeatureId != null)
        'sourceSubclassFeatureId': sourceSubclassFeatureId,
      if (sourceSubclassFeature != null)
        'sourceSubclassFeature': sourceSubclassFeature?.toJson(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (activation != null) 'activation': activation?.toJson(),
      if (castingAbility != null) 'castingAbility': castingAbility?.toJson(),
      if (alwaysPrepared != null) 'alwaysPrepared': alwaysPrepared,
      if (choiceOptionId != null) 'choiceOptionId': choiceOptionId,
      if (choiceOption != null) 'choiceOption': choiceOption?.toJson(),
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClassSpellGrantData',
      if (id != null) 'id': id,
      if (spellId != null) 'spellId': spellId,
      if (spell != null) 'spell': spell?.toJsonForProtocol(),
      if (spellReferenceKey != null) 'spellReferenceKey': spellReferenceKey,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJsonForProtocol(),
      if (sourceSubclassId != null) 'sourceSubclassId': sourceSubclassId,
      if (sourceSubclass != null)
        'sourceSubclass': sourceSubclass?.toJsonForProtocol(),
      if (sourceFeatureId != null) 'sourceFeatureId': sourceFeatureId,
      if (sourceFeature != null)
        'sourceFeature': sourceFeature?.toJsonForProtocol(),
      if (sourceSubclassFeatureId != null)
        'sourceSubclassFeatureId': sourceSubclassFeatureId,
      if (sourceSubclassFeature != null)
        'sourceSubclassFeature': sourceSubclassFeature?.toJsonForProtocol(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (activation != null) 'activation': activation?.toJsonForProtocol(),
      if (castingAbility != null) 'castingAbility': castingAbility?.toJson(),
      if (alwaysPrepared != null) 'alwaysPrepared': alwaysPrepared,
      if (choiceOptionId != null) 'choiceOptionId': choiceOptionId,
      if (choiceOption != null)
        'choiceOption': choiceOption?.toJsonForProtocol(),
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static ClassSpellGrantDataInclude include({
    _iavpgfjb.SpellDataInclude? spell,
    _iazz3r73.ClassDataInclude? sourceClass,
    _ijcb6jld.SubclassDataInclude? sourceSubclass,
    _ikfzlvib.ClassFeatureDataInclude? sourceFeature,
    _itaxdcfb.SubclassFeatureDataInclude? sourceSubclassFeature,
    _ivap0b5b.ChoiceOptionDataInclude? choiceOption,
  }) {
    return ClassSpellGrantDataInclude._(
      spell: spell,
      sourceClass: sourceClass,
      sourceSubclass: sourceSubclass,
      sourceFeature: sourceFeature,
      sourceSubclassFeature: sourceSubclassFeature,
      choiceOption: choiceOption,
    );
  }

  static ClassSpellGrantDataIncludeList includeList({
    _is.WhereExpressionBuilder<ClassSpellGrantDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClassSpellGrantDataTable>? orderBy,
    _is.OrderByListBuilder<ClassSpellGrantDataTable>? orderByList,
    ClassSpellGrantDataInclude? include,
  }) {
    return ClassSpellGrantDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassSpellGrantData.t),
      orderByList: orderByList?.call(ClassSpellGrantData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassSpellGrantDataImpl extends ClassSpellGrantData {
  _ClassSpellGrantDataImpl({
    int? id,
    int? spellId,
    _iavpgfjb.SpellData? spell,
    String? spellReferenceKey,
    int? sourceClassId,
    _iazz3r73.ClassData? sourceClass,
    int? sourceSubclassId,
    _ijcb6jld.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _ikfzlvib.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _itaxdcfb.SubclassFeatureData? sourceSubclassFeature,
    int? grantedAtLevel,
    _iyix4imv.SpellActivationData? activation,
    _i26h74c2.Ability? castingAbility,
    bool? alwaysPrepared,
    int? choiceOptionId,
    _ivap0b5b.ChoiceOptionData? choiceOption,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         spellId: spellId,
         spell: spell,
         spellReferenceKey: spellReferenceKey,
         sourceClassId: sourceClassId,
         sourceClass: sourceClass,
         sourceSubclassId: sourceSubclassId,
         sourceSubclass: sourceSubclass,
         sourceFeatureId: sourceFeatureId,
         sourceFeature: sourceFeature,
         sourceSubclassFeatureId: sourceSubclassFeatureId,
         sourceSubclassFeature: sourceSubclassFeature,
         grantedAtLevel: grantedAtLevel,
         activation: activation,
         castingAbility: castingAbility,
         alwaysPrepared: alwaysPrepared,
         choiceOptionId: choiceOptionId,
         choiceOption: choiceOption,
         notes: notes,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ClassSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ClassSpellGrantData copyWith({
    Object? id = _Undefined,
    Object? spellId = _Undefined,
    Object? spell = _Undefined,
    Object? spellReferenceKey = _Undefined,
    Object? sourceClassId = _Undefined,
    Object? sourceClass = _Undefined,
    Object? sourceSubclassId = _Undefined,
    Object? sourceSubclass = _Undefined,
    Object? sourceFeatureId = _Undefined,
    Object? sourceFeature = _Undefined,
    Object? sourceSubclassFeatureId = _Undefined,
    Object? sourceSubclassFeature = _Undefined,
    Object? grantedAtLevel = _Undefined,
    Object? activation = _Undefined,
    Object? castingAbility = _Undefined,
    Object? alwaysPrepared = _Undefined,
    Object? choiceOptionId = _Undefined,
    Object? choiceOption = _Undefined,
    Object? notes = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return ClassSpellGrantData(
      id: id is int? ? id : this.id,
      spellId: spellId is int? ? spellId : this.spellId,
      spell: spell is _iavpgfjb.SpellData? ? spell : this.spell?.copyWith(),
      spellReferenceKey: spellReferenceKey is String?
          ? spellReferenceKey
          : this.spellReferenceKey,
      sourceClassId: sourceClassId is int? ? sourceClassId : this.sourceClassId,
      sourceClass: sourceClass is _iazz3r73.ClassData?
          ? sourceClass
          : this.sourceClass?.copyWith(),
      sourceSubclassId: sourceSubclassId is int?
          ? sourceSubclassId
          : this.sourceSubclassId,
      sourceSubclass: sourceSubclass is _ijcb6jld.SubclassData?
          ? sourceSubclass
          : this.sourceSubclass?.copyWith(),
      sourceFeatureId: sourceFeatureId is int?
          ? sourceFeatureId
          : this.sourceFeatureId,
      sourceFeature: sourceFeature is _ikfzlvib.ClassFeatureData?
          ? sourceFeature
          : this.sourceFeature?.copyWith(),
      sourceSubclassFeatureId: sourceSubclassFeatureId is int?
          ? sourceSubclassFeatureId
          : this.sourceSubclassFeatureId,
      sourceSubclassFeature:
          sourceSubclassFeature is _itaxdcfb.SubclassFeatureData?
          ? sourceSubclassFeature
          : this.sourceSubclassFeature?.copyWith(),
      grantedAtLevel: grantedAtLevel is int?
          ? grantedAtLevel
          : this.grantedAtLevel,
      activation: activation is _iyix4imv.SpellActivationData?
          ? activation
          : this.activation?.copyWith(),
      castingAbility: castingAbility is _i26h74c2.Ability?
          ? castingAbility
          : this.castingAbility,
      alwaysPrepared: alwaysPrepared is bool?
          ? alwaysPrepared
          : this.alwaysPrepared,
      choiceOptionId: choiceOptionId is int?
          ? choiceOptionId
          : this.choiceOptionId,
      choiceOption: choiceOption is _ivap0b5b.ChoiceOptionData?
          ? choiceOption
          : this.choiceOption?.copyWith(),
      notes: notes is String? ? notes : this.notes,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class ClassSpellGrantDataUpdateTable
    extends _is.UpdateTable<ClassSpellGrantDataTable> {
  ClassSpellGrantDataUpdateTable(super.table);

  _is.ColumnValue<int, int> spellId(int? value) =>
      _is.ColumnValue(table.spellId, value);

  _is.ColumnValue<int, int> sourceClassId(int? value) =>
      _is.ColumnValue(table.sourceClassId, value);

  _is.ColumnValue<int, int> sourceSubclassId(int? value) =>
      _is.ColumnValue(table.sourceSubclassId, value);

  _is.ColumnValue<int, int> sourceFeatureId(int? value) =>
      _is.ColumnValue(table.sourceFeatureId, value);

  _is.ColumnValue<int, int> sourceSubclassFeatureId(int? value) =>
      _is.ColumnValue(table.sourceSubclassFeatureId, value);

  _is.ColumnValue<int, int> grantedAtLevel(int? value) =>
      _is.ColumnValue(table.grantedAtLevel, value);

  _is.ColumnValue<_iyix4imv.SpellActivationData, _iyix4imv.SpellActivationData>
  activation(_iyix4imv.SpellActivationData? value) =>
      _is.ColumnValue(table.activation, value);

  _is.ColumnValue<_i26h74c2.Ability, _i26h74c2.Ability> castingAbility(
    _i26h74c2.Ability? value,
  ) => _is.ColumnValue(table.castingAbility, value);

  _is.ColumnValue<bool, bool> alwaysPrepared(bool? value) =>
      _is.ColumnValue(table.alwaysPrepared, value);

  _is.ColumnValue<int, int> choiceOptionId(int? value) =>
      _is.ColumnValue(table.choiceOptionId, value);

  _is.ColumnValue<String, String> notes(String? value) =>
      _is.ColumnValue(table.notes, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class ClassSpellGrantDataTable extends _is.Table<int?> {
  ClassSpellGrantDataTable({super.tableRelation})
    : super(tableName: 'class_spell_grant_data') {
    updateTable = ClassSpellGrantDataUpdateTable(this);
    spellId = _is.ColumnInt('spellId', this);
    sourceClassId = _is.ColumnInt('sourceClassId', this);
    sourceSubclassId = _is.ColumnInt('sourceSubclassId', this);
    sourceFeatureId = _is.ColumnInt('sourceFeatureId', this);
    sourceSubclassFeatureId = _is.ColumnInt('sourceSubclassFeatureId', this);
    grantedAtLevel = _is.ColumnInt('grantedAtLevel', this);
    activation = _is.ColumnSerializable<_iyix4imv.SpellActivationData>(
      'activation',
      this,
    );
    castingAbility = _is.ColumnEnum(
      'castingAbility',
      this,
      _is.EnumSerialization.byName,
    );
    alwaysPrepared = _is.ColumnBool('alwaysPrepared', this);
    choiceOptionId = _is.ColumnInt('choiceOptionId', this);
    notes = _is.ColumnString('notes', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final ClassSpellGrantDataUpdateTable updateTable;

  late final _is.ColumnInt spellId;

  _iavpgfjb.SpellDataTable? _spell;

  late final _is.ColumnInt sourceClassId;

  _iazz3r73.ClassDataTable? _sourceClass;

  late final _is.ColumnInt sourceSubclassId;

  _ijcb6jld.SubclassDataTable? _sourceSubclass;

  late final _is.ColumnInt sourceFeatureId;

  _ikfzlvib.ClassFeatureDataTable? _sourceFeature;

  late final _is.ColumnInt sourceSubclassFeatureId;

  _itaxdcfb.SubclassFeatureDataTable? _sourceSubclassFeature;

  late final _is.ColumnInt grantedAtLevel;

  late final _is.ColumnSerializable<_iyix4imv.SpellActivationData> activation;

  late final _is.ColumnEnum<_i26h74c2.Ability> castingAbility;

  late final _is.ColumnBool alwaysPrepared;

  late final _is.ColumnInt choiceOptionId;

  _ivap0b5b.ChoiceOptionDataTable? _choiceOption;

  late final _is.ColumnString notes;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _iavpgfjb.SpellDataTable get spell {
    if (_spell != null) return _spell!;
    _spell = _is.createRelationTable(
      relationFieldName: 'spell',
      field: ClassSpellGrantData.t.spellId,
      foreignField: _iavpgfjb.SpellData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iavpgfjb.SpellDataTable(tableRelation: foreignTableRelation),
    );
    return _spell!;
  }

  _iazz3r73.ClassDataTable get sourceClass {
    if (_sourceClass != null) return _sourceClass!;
    _sourceClass = _is.createRelationTable(
      relationFieldName: 'sourceClass',
      field: ClassSpellGrantData.t.sourceClassId,
      foreignField: _iazz3r73.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iazz3r73.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceClass!;
  }

  _ijcb6jld.SubclassDataTable get sourceSubclass {
    if (_sourceSubclass != null) return _sourceSubclass!;
    _sourceSubclass = _is.createRelationTable(
      relationFieldName: 'sourceSubclass',
      field: ClassSpellGrantData.t.sourceSubclassId,
      foreignField: _ijcb6jld.SubclassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ijcb6jld.SubclassDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceSubclass!;
  }

  _ikfzlvib.ClassFeatureDataTable get sourceFeature {
    if (_sourceFeature != null) return _sourceFeature!;
    _sourceFeature = _is.createRelationTable(
      relationFieldName: 'sourceFeature',
      field: ClassSpellGrantData.t.sourceFeatureId,
      foreignField: _ikfzlvib.ClassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ikfzlvib.ClassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceFeature!;
  }

  _itaxdcfb.SubclassFeatureDataTable get sourceSubclassFeature {
    if (_sourceSubclassFeature != null) return _sourceSubclassFeature!;
    _sourceSubclassFeature = _is.createRelationTable(
      relationFieldName: 'sourceSubclassFeature',
      field: ClassSpellGrantData.t.sourceSubclassFeatureId,
      foreignField: _itaxdcfb.SubclassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _itaxdcfb.SubclassFeatureDataTable(
        tableRelation: foreignTableRelation,
      ),
    );
    return _sourceSubclassFeature!;
  }

  _ivap0b5b.ChoiceOptionDataTable get choiceOption {
    if (_choiceOption != null) return _choiceOption!;
    _choiceOption = _is.createRelationTable(
      relationFieldName: 'choiceOption',
      field: ClassSpellGrantData.t.choiceOptionId,
      foreignField: _ivap0b5b.ChoiceOptionData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ivap0b5b.ChoiceOptionDataTable(tableRelation: foreignTableRelation),
    );
    return _choiceOption!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    spellId,
    sourceClassId,
    sourceSubclassId,
    sourceFeatureId,
    sourceSubclassFeatureId,
    grantedAtLevel,
    activation,
    castingAbility,
    alwaysPrepared,
    choiceOptionId,
    notes,
    source,
    version,
    createdAt,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'spell') {
      return spell;
    }
    if (relationField == 'sourceClass') {
      return sourceClass;
    }
    if (relationField == 'sourceSubclass') {
      return sourceSubclass;
    }
    if (relationField == 'sourceFeature') {
      return sourceFeature;
    }
    if (relationField == 'sourceSubclassFeature') {
      return sourceSubclassFeature;
    }
    if (relationField == 'choiceOption') {
      return choiceOption;
    }
    return null;
  }
}

class ClassSpellGrantDataInclude extends _is.IncludeObject {
  ClassSpellGrantDataInclude._({
    _iavpgfjb.SpellDataInclude? spell,
    _iazz3r73.ClassDataInclude? sourceClass,
    _ijcb6jld.SubclassDataInclude? sourceSubclass,
    _ikfzlvib.ClassFeatureDataInclude? sourceFeature,
    _itaxdcfb.SubclassFeatureDataInclude? sourceSubclassFeature,
    _ivap0b5b.ChoiceOptionDataInclude? choiceOption,
  }) {
    _spell = spell;
    _sourceClass = sourceClass;
    _sourceSubclass = sourceSubclass;
    _sourceFeature = sourceFeature;
    _sourceSubclassFeature = sourceSubclassFeature;
    _choiceOption = choiceOption;
  }

  _iavpgfjb.SpellDataInclude? _spell;

  _iazz3r73.ClassDataInclude? _sourceClass;

  _ijcb6jld.SubclassDataInclude? _sourceSubclass;

  _ikfzlvib.ClassFeatureDataInclude? _sourceFeature;

  _itaxdcfb.SubclassFeatureDataInclude? _sourceSubclassFeature;

  _ivap0b5b.ChoiceOptionDataInclude? _choiceOption;

  @override
  Map<String, _is.Include?> get includes => {
    'spell': _spell,
    'sourceClass': _sourceClass,
    'sourceSubclass': _sourceSubclass,
    'sourceFeature': _sourceFeature,
    'sourceSubclassFeature': _sourceSubclassFeature,
    'choiceOption': _choiceOption,
  };

  @override
  _is.Table<int?> get table => ClassSpellGrantData.t;
}

class ClassSpellGrantDataIncludeList extends _is.IncludeList {
  ClassSpellGrantDataIncludeList._({
    _is.WhereExpressionBuilder<ClassSpellGrantDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClassSpellGrantData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ClassSpellGrantData.t;
}

class ClassSpellGrantDataRepository {
  const ClassSpellGrantDataRepository._();

  final attachRow = const ClassSpellGrantDataAttachRowRepository._();

  final detachRow = const ClassSpellGrantDataDetachRowRepository._();

  /// Returns a list of [ClassSpellGrantData]s matching the given query parameters.
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
  Future<List<ClassSpellGrantData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClassSpellGrantDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClassSpellGrantDataTable>? orderBy,
    _is.OrderByListBuilder<ClassSpellGrantDataTable>? orderByList,
    _is.Transaction? transaction,
    ClassSpellGrantDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ClassSpellGrantData>(
      where: where?.call(ClassSpellGrantData.t),
      orderBy: orderBy?.call(ClassSpellGrantData.t),
      orderByList: orderByList?.call(ClassSpellGrantData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ClassSpellGrantData] matching the given query parameters.
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
  Future<ClassSpellGrantData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClassSpellGrantDataTable>? where,
    int? offset,
    _is.OrderByBuilder<ClassSpellGrantDataTable>? orderBy,
    _is.OrderByListBuilder<ClassSpellGrantDataTable>? orderByList,
    _is.Transaction? transaction,
    ClassSpellGrantDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ClassSpellGrantData>(
      where: where?.call(ClassSpellGrantData.t),
      orderBy: orderBy?.call(ClassSpellGrantData.t),
      orderByList: orderByList?.call(ClassSpellGrantData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ClassSpellGrantData] by its [id] or null if no such row exists.
  Future<ClassSpellGrantData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ClassSpellGrantDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ClassSpellGrantData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ClassSpellGrantData]s in the list and returns the inserted rows.
  ///
  /// The returned [ClassSpellGrantData]s will have their `id` fields set.
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
  Future<List<ClassSpellGrantData>> insert(
    _is.DatabaseSession session,
    List<ClassSpellGrantData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ClassSpellGrantData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ClassSpellGrantData] and returns the inserted row.
  ///
  /// The returned [ClassSpellGrantData] will have its `id` field set.
  Future<ClassSpellGrantData> insertRow(
    _is.DatabaseSession session,
    ClassSpellGrantData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClassSpellGrantData>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ClassSpellGrantData]s in the list and returns the resulting rows.
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
  /// The returned [ClassSpellGrantData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassSpellGrantData>> upsert(
    _is.DatabaseSession session,
    List<ClassSpellGrantData> rows, {
    required _is.ColumnSelections<ClassSpellGrantDataTable> conflictColumns,
    _is.ColumnSelections<ClassSpellGrantDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ClassSpellGrantDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ClassSpellGrantData>(
      rows,
      conflictColumns: conflictColumns(ClassSpellGrantData.t),
      updateColumns: updateColumns?.call(ClassSpellGrantData.t),
      updateWhere: updateWhere?.call(ClassSpellGrantData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ClassSpellGrantData] and returns the resulting row.
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
  /// The returned [ClassSpellGrantData] will have its `id` field set.
  Future<ClassSpellGrantData?> upsertRow(
    _is.DatabaseSession session,
    ClassSpellGrantData row, {
    required _is.ColumnSelections<ClassSpellGrantDataTable> conflictColumns,
    _is.ColumnSelections<ClassSpellGrantDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ClassSpellGrantDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ClassSpellGrantData>(
      row,
      conflictColumns: conflictColumns(ClassSpellGrantData.t),
      updateColumns: updateColumns?.call(ClassSpellGrantData.t),
      updateWhere: updateWhere?.call(ClassSpellGrantData.t),
      transaction: transaction,
    );
  }

  /// Updates all [ClassSpellGrantData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassSpellGrantData>> update(
    _is.DatabaseSession session,
    List<ClassSpellGrantData> rows, {
    _is.ColumnSelections<ClassSpellGrantDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ClassSpellGrantData>(
      rows,
      columns: columns?.call(ClassSpellGrantData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ClassSpellGrantData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClassSpellGrantData> updateRow(
    _is.DatabaseSession session,
    ClassSpellGrantData row, {
    _is.ColumnSelections<ClassSpellGrantDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClassSpellGrantData>(
      row,
      columns: columns?.call(ClassSpellGrantData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClassSpellGrantData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ClassSpellGrantData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ClassSpellGrantDataUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ClassSpellGrantData>(
      id,
      columnValues: columnValues(ClassSpellGrantData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ClassSpellGrantData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassSpellGrantData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ClassSpellGrantDataUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ClassSpellGrantDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClassSpellGrantDataTable>? orderBy,
    _is.OrderByListBuilder<ClassSpellGrantDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ClassSpellGrantData>(
      columnValues: columnValues(ClassSpellGrantData.t.updateTable),
      where: where(ClassSpellGrantData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassSpellGrantData.t),
      orderByList: orderByList?.call(ClassSpellGrantData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ClassSpellGrantData]s in the list and returns the deleted rows.
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
  Future<List<ClassSpellGrantData>> delete(
    _is.DatabaseSession session,
    List<ClassSpellGrantData> rows, {
    _is.OrderByBuilder<ClassSpellGrantDataTable>? orderBy,
    _is.OrderByListBuilder<ClassSpellGrantDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ClassSpellGrantData>(
      rows,
      orderBy: orderBy?.call(ClassSpellGrantData.t),
      orderByList: orderByList?.call(ClassSpellGrantData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ClassSpellGrantData].
  Future<ClassSpellGrantData> deleteRow(
    _is.DatabaseSession session,
    ClassSpellGrantData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClassSpellGrantData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassSpellGrantData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClassSpellGrantDataTable> where,
    _is.OrderByBuilder<ClassSpellGrantDataTable>? orderBy,
    _is.OrderByListBuilder<ClassSpellGrantDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ClassSpellGrantData>(
      where: where(ClassSpellGrantData.t),
      orderBy: orderBy?.call(ClassSpellGrantData.t),
      orderByList: orderByList?.call(ClassSpellGrantData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClassSpellGrantDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ClassSpellGrantData>(
      where: where?.call(ClassSpellGrantData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ClassSpellGrantData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClassSpellGrantDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ClassSpellGrantData>(
      where: where(ClassSpellGrantData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ClassSpellGrantDataAttachRowRepository {
  const ClassSpellGrantDataAttachRowRepository._();

  /// Creates a relation between the given [ClassSpellGrantData] and [SpellData]
  /// by setting the [ClassSpellGrantData]'s foreign key `spellId` to refer to the [SpellData].
  Future<void> spell(
    _is.DatabaseSession session,
    ClassSpellGrantData classSpellGrantData,
    _iavpgfjb.SpellData spell, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (spell.id == null) {
      throw ArgumentError.notNull('spell.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(spellId: spell.id);
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.spellId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassSpellGrantData] and [ClassData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceClassId` to refer to the [ClassData].
  Future<void> sourceClass(
    _is.DatabaseSession session,
    ClassSpellGrantData classSpellGrantData,
    _iazz3r73.ClassData sourceClass, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (sourceClass.id == null) {
      throw ArgumentError.notNull('sourceClass.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
      sourceClassId: sourceClass.id,
    );
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassSpellGrantData] and [SubclassData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceSubclassId` to refer to the [SubclassData].
  Future<void> sourceSubclass(
    _is.DatabaseSession session,
    ClassSpellGrantData classSpellGrantData,
    _ijcb6jld.SubclassData sourceSubclass, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (sourceSubclass.id == null) {
      throw ArgumentError.notNull('sourceSubclass.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
      sourceSubclassId: sourceSubclass.id,
    );
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.sourceSubclassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassSpellGrantData] and [ClassFeatureData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceFeatureId` to refer to the [ClassFeatureData].
  Future<void> sourceFeature(
    _is.DatabaseSession session,
    ClassSpellGrantData classSpellGrantData,
    _ikfzlvib.ClassFeatureData sourceFeature, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (sourceFeature.id == null) {
      throw ArgumentError.notNull('sourceFeature.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
      sourceFeatureId: sourceFeature.id,
    );
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassSpellGrantData] and [SubclassFeatureData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceSubclassFeatureId` to refer to the [SubclassFeatureData].
  Future<void> sourceSubclassFeature(
    _is.DatabaseSession session,
    ClassSpellGrantData classSpellGrantData,
    _itaxdcfb.SubclassFeatureData sourceSubclassFeature, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (sourceSubclassFeature.id == null) {
      throw ArgumentError.notNull('sourceSubclassFeature.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
      sourceSubclassFeatureId: sourceSubclassFeature.id,
    );
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassSpellGrantData] and [ChoiceOptionData]
  /// by setting the [ClassSpellGrantData]'s foreign key `choiceOptionId` to refer to the [ChoiceOptionData].
  Future<void> choiceOption(
    _is.DatabaseSession session,
    ClassSpellGrantData classSpellGrantData,
    _ivap0b5b.ChoiceOptionData choiceOption, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (choiceOption.id == null) {
      throw ArgumentError.notNull('choiceOption.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
      choiceOptionId: choiceOption.id,
    );
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.choiceOptionId],
      transaction: transaction,
    );
  }
}

class ClassSpellGrantDataDetachRowRepository {
  const ClassSpellGrantDataDetachRowRepository._();

  /// Detaches the relation between this [ClassSpellGrantData] and the [SpellData] set in `spell`
  /// by setting the [ClassSpellGrantData]'s foreign key `spellId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> spell(
    _is.DatabaseSession session,
    ClassSpellGrantData classSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(spellId: null);
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.spellId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassSpellGrantData] and the [ClassData] set in `sourceClass`
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceClassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceClass(
    _is.DatabaseSession session,
    ClassSpellGrantData classSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
      sourceClassId: null,
    );
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassSpellGrantData] and the [SubclassData] set in `sourceSubclass`
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceSubclassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceSubclass(
    _is.DatabaseSession session,
    ClassSpellGrantData classSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
      sourceSubclassId: null,
    );
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.sourceSubclassId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassSpellGrantData] and the [ClassFeatureData] set in `sourceFeature`
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceFeature(
    _is.DatabaseSession session,
    ClassSpellGrantData classSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
      sourceFeatureId: null,
    );
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassSpellGrantData] and the [SubclassFeatureData] set in `sourceSubclassFeature`
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceSubclassFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceSubclassFeature(
    _is.DatabaseSession session,
    ClassSpellGrantData classSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
      sourceSubclassFeatureId: null,
    );
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassSpellGrantData] and the [ChoiceOptionData] set in `choiceOption`
  /// by setting the [ClassSpellGrantData]'s foreign key `choiceOptionId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> choiceOption(
    _is.DatabaseSession session,
    ClassSpellGrantData classSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
      choiceOptionId: null,
    );
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.choiceOptionId],
      transaction: transaction,
    );
  }
}
