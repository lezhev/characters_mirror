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
import '../../../data/general/race/race_choice_set_data.dart' as _i2;
import '../../../enums/ability.dart' as _i3;
import '../../../enums/skill.dart' as _i4;
import '../../../enums/language.dart' as _i5;
import '../../../data/spell_data.dart' as _i6;
import '../../../data/feat_data.dart' as _i7;
import '../../../enums/damage_type.dart' as _i8;
import '../../../enums/spell/area_of_effect_type.dart' as _i9;

abstract class RaceChoiceOptionData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RaceChoiceOptionData._({
    this.id,
    required this.choiceSetId,
    this.choiceSet,
    this.optionKey,
    this.name,
    this.description,
    this.sortOrder,
    this.ability,
    this.skill,
    this.language,
    this.spellId,
    this.spell,
    this.featId,
    this.feat,
    this.toolKey,
    this.bonusValue,
    this.damageType,
    this.areaOfEffectType,
    this.areaText,
    this.saveAbility,
    this.damageByLevel,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory RaceChoiceOptionData({
    int? id,
    required int choiceSetId,
    _i2.RaceChoiceSetData? choiceSet,
    String? optionKey,
    String? name,
    String? description,
    int? sortOrder,
    _i3.Ability? ability,
    _i4.Skill? skill,
    _i5.Language? language,
    int? spellId,
    _i6.SpellData? spell,
    int? featId,
    _i7.FeatData? feat,
    String? toolKey,
    int? bonusValue,
    _i8.DamageType? damageType,
    _i9.AreaOfEffectType? areaOfEffectType,
    String? areaText,
    _i3.Ability? saveAbility,
    Map<String, String>? damageByLevel,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RaceChoiceOptionDataImpl;

  factory RaceChoiceOptionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return RaceChoiceOptionData(
      id: jsonSerialization['id'] as int?,
      choiceSetId: jsonSerialization['choiceSetId'] as int,
      choiceSet: jsonSerialization['choiceSet'] == null
          ? null
          : _i2.RaceChoiceSetData.fromJson(
              (jsonSerialization['choiceSet'] as Map<String, dynamic>)),
      optionKey: jsonSerialization['optionKey'] as String?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      ability: jsonSerialization['ability'] == null
          ? null
          : _i3.Ability.fromJson((jsonSerialization['ability'] as String)),
      skill: jsonSerialization['skill'] == null
          ? null
          : _i4.Skill.fromJson((jsonSerialization['skill'] as String)),
      language: jsonSerialization['language'] == null
          ? null
          : _i5.Language.fromJson((jsonSerialization['language'] as String)),
      spellId: jsonSerialization['spellId'] as int?,
      spell: jsonSerialization['spell'] == null
          ? null
          : _i6.SpellData.fromJson(
              (jsonSerialization['spell'] as Map<String, dynamic>)),
      featId: jsonSerialization['featId'] as int?,
      feat: jsonSerialization['feat'] == null
          ? null
          : _i7.FeatData.fromJson(
              (jsonSerialization['feat'] as Map<String, dynamic>)),
      toolKey: jsonSerialization['toolKey'] as String?,
      bonusValue: jsonSerialization['bonusValue'] as int?,
      damageType: jsonSerialization['damageType'] == null
          ? null
          : _i8.DamageType.fromJson(
              (jsonSerialization['damageType'] as String)),
      areaOfEffectType: jsonSerialization['areaOfEffectType'] == null
          ? null
          : _i9.AreaOfEffectType.fromJson(
              (jsonSerialization['areaOfEffectType'] as String)),
      areaText: jsonSerialization['areaText'] as String?,
      saveAbility: jsonSerialization['saveAbility'] == null
          ? null
          : _i3.Ability.fromJson((jsonSerialization['saveAbility'] as String)),
      damageByLevel:
          (jsonSerialization['damageByLevel'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as String,
              )),
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = RaceChoiceOptionDataTable();

  static const db = RaceChoiceOptionDataRepository._();

  @override
  int? id;

  int choiceSetId;

  _i2.RaceChoiceSetData? choiceSet;

  String? optionKey;

  String? name;

  String? description;

  int? sortOrder;

  _i3.Ability? ability;

  _i4.Skill? skill;

  _i5.Language? language;

  int? spellId;

  _i6.SpellData? spell;

  int? featId;

  _i7.FeatData? feat;

  String? toolKey;

  int? bonusValue;

  _i8.DamageType? damageType;

  _i9.AreaOfEffectType? areaOfEffectType;

  String? areaText;

  _i3.Ability? saveAbility;

  Map<String, String>? damageByLevel;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RaceChoiceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceChoiceOptionData copyWith({
    int? id,
    int? choiceSetId,
    _i2.RaceChoiceSetData? choiceSet,
    String? optionKey,
    String? name,
    String? description,
    int? sortOrder,
    _i3.Ability? ability,
    _i4.Skill? skill,
    _i5.Language? language,
    int? spellId,
    _i6.SpellData? spell,
    int? featId,
    _i7.FeatData? feat,
    String? toolKey,
    int? bonusValue,
    _i8.DamageType? damageType,
    _i9.AreaOfEffectType? areaOfEffectType,
    String? areaText,
    _i3.Ability? saveAbility,
    Map<String, String>? damageByLevel,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'choiceSetId': choiceSetId,
      if (choiceSet != null) 'choiceSet': choiceSet?.toJson(),
      if (optionKey != null) 'optionKey': optionKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (sortOrder != null) 'sortOrder': sortOrder,
      if (ability != null) 'ability': ability?.toJson(),
      if (skill != null) 'skill': skill?.toJson(),
      if (language != null) 'language': language?.toJson(),
      if (spellId != null) 'spellId': spellId,
      if (spell != null) 'spell': spell?.toJson(),
      if (featId != null) 'featId': featId,
      if (feat != null) 'feat': feat?.toJson(),
      if (toolKey != null) 'toolKey': toolKey,
      if (bonusValue != null) 'bonusValue': bonusValue,
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (areaOfEffectType != null)
        'areaOfEffectType': areaOfEffectType?.toJson(),
      if (areaText != null) 'areaText': areaText,
      if (saveAbility != null) 'saveAbility': saveAbility?.toJson(),
      if (damageByLevel != null) 'damageByLevel': damageByLevel?.toJson(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'choiceSetId': choiceSetId,
      if (choiceSet != null) 'choiceSet': choiceSet?.toJsonForProtocol(),
      if (optionKey != null) 'optionKey': optionKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (sortOrder != null) 'sortOrder': sortOrder,
      if (ability != null) 'ability': ability?.toJson(),
      if (skill != null) 'skill': skill?.toJson(),
      if (language != null) 'language': language?.toJson(),
      if (spellId != null) 'spellId': spellId,
      if (spell != null) 'spell': spell?.toJsonForProtocol(),
      if (featId != null) 'featId': featId,
      if (feat != null) 'feat': feat?.toJsonForProtocol(),
      if (toolKey != null) 'toolKey': toolKey,
      if (bonusValue != null) 'bonusValue': bonusValue,
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (areaOfEffectType != null)
        'areaOfEffectType': areaOfEffectType?.toJson(),
      if (areaText != null) 'areaText': areaText,
      if (saveAbility != null) 'saveAbility': saveAbility?.toJson(),
      if (damageByLevel != null) 'damageByLevel': damageByLevel?.toJson(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static RaceChoiceOptionDataInclude include({
    _i2.RaceChoiceSetDataInclude? choiceSet,
    _i6.SpellDataInclude? spell,
    _i7.FeatDataInclude? feat,
  }) {
    return RaceChoiceOptionDataInclude._(
      choiceSet: choiceSet,
      spell: spell,
      feat: feat,
    );
  }

  static RaceChoiceOptionDataIncludeList includeList({
    _i1.WhereExpressionBuilder<RaceChoiceOptionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RaceChoiceOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceChoiceOptionDataTable>? orderByList,
    RaceChoiceOptionDataInclude? include,
  }) {
    return RaceChoiceOptionDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RaceChoiceOptionData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RaceChoiceOptionData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceChoiceOptionDataImpl extends RaceChoiceOptionData {
  _RaceChoiceOptionDataImpl({
    int? id,
    required int choiceSetId,
    _i2.RaceChoiceSetData? choiceSet,
    String? optionKey,
    String? name,
    String? description,
    int? sortOrder,
    _i3.Ability? ability,
    _i4.Skill? skill,
    _i5.Language? language,
    int? spellId,
    _i6.SpellData? spell,
    int? featId,
    _i7.FeatData? feat,
    String? toolKey,
    int? bonusValue,
    _i8.DamageType? damageType,
    _i9.AreaOfEffectType? areaOfEffectType,
    String? areaText,
    _i3.Ability? saveAbility,
    Map<String, String>? damageByLevel,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          choiceSetId: choiceSetId,
          choiceSet: choiceSet,
          optionKey: optionKey,
          name: name,
          description: description,
          sortOrder: sortOrder,
          ability: ability,
          skill: skill,
          language: language,
          spellId: spellId,
          spell: spell,
          featId: featId,
          feat: feat,
          toolKey: toolKey,
          bonusValue: bonusValue,
          damageType: damageType,
          areaOfEffectType: areaOfEffectType,
          areaText: areaText,
          saveAbility: saveAbility,
          damageByLevel: damageByLevel,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [RaceChoiceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RaceChoiceOptionData copyWith({
    Object? id = _Undefined,
    int? choiceSetId,
    Object? choiceSet = _Undefined,
    Object? optionKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? sortOrder = _Undefined,
    Object? ability = _Undefined,
    Object? skill = _Undefined,
    Object? language = _Undefined,
    Object? spellId = _Undefined,
    Object? spell = _Undefined,
    Object? featId = _Undefined,
    Object? feat = _Undefined,
    Object? toolKey = _Undefined,
    Object? bonusValue = _Undefined,
    Object? damageType = _Undefined,
    Object? areaOfEffectType = _Undefined,
    Object? areaText = _Undefined,
    Object? saveAbility = _Undefined,
    Object? damageByLevel = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return RaceChoiceOptionData(
      id: id is int? ? id : this.id,
      choiceSetId: choiceSetId ?? this.choiceSetId,
      choiceSet: choiceSet is _i2.RaceChoiceSetData?
          ? choiceSet
          : this.choiceSet?.copyWith(),
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      sortOrder: sortOrder is int? ? sortOrder : this.sortOrder,
      ability: ability is _i3.Ability? ? ability : this.ability,
      skill: skill is _i4.Skill? ? skill : this.skill,
      language: language is _i5.Language? ? language : this.language,
      spellId: spellId is int? ? spellId : this.spellId,
      spell: spell is _i6.SpellData? ? spell : this.spell?.copyWith(),
      featId: featId is int? ? featId : this.featId,
      feat: feat is _i7.FeatData? ? feat : this.feat?.copyWith(),
      toolKey: toolKey is String? ? toolKey : this.toolKey,
      bonusValue: bonusValue is int? ? bonusValue : this.bonusValue,
      damageType: damageType is _i8.DamageType? ? damageType : this.damageType,
      areaOfEffectType: areaOfEffectType is _i9.AreaOfEffectType?
          ? areaOfEffectType
          : this.areaOfEffectType,
      areaText: areaText is String? ? areaText : this.areaText,
      saveAbility: saveAbility is _i3.Ability? ? saveAbility : this.saveAbility,
      damageByLevel: damageByLevel is Map<String, String>?
          ? damageByLevel
          : this.damageByLevel?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class RaceChoiceOptionDataTable extends _i1.Table<int?> {
  RaceChoiceOptionDataTable({super.tableRelation})
      : super(tableName: 'race_choice_option_data') {
    choiceSetId = _i1.ColumnInt(
      'choiceSetId',
      this,
    );
    optionKey = _i1.ColumnString(
      'optionKey',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    sortOrder = _i1.ColumnInt(
      'sortOrder',
      this,
    );
    ability = _i1.ColumnEnum(
      'ability',
      this,
      _i1.EnumSerialization.byName,
    );
    skill = _i1.ColumnEnum(
      'skill',
      this,
      _i1.EnumSerialization.byName,
    );
    language = _i1.ColumnEnum(
      'language',
      this,
      _i1.EnumSerialization.byName,
    );
    spellId = _i1.ColumnInt(
      'spellId',
      this,
    );
    featId = _i1.ColumnInt(
      'featId',
      this,
    );
    toolKey = _i1.ColumnString(
      'toolKey',
      this,
    );
    bonusValue = _i1.ColumnInt(
      'bonusValue',
      this,
    );
    damageType = _i1.ColumnEnum(
      'damageType',
      this,
      _i1.EnumSerialization.byName,
    );
    areaOfEffectType = _i1.ColumnEnum(
      'areaOfEffectType',
      this,
      _i1.EnumSerialization.byName,
    );
    areaText = _i1.ColumnString(
      'areaText',
      this,
    );
    saveAbility = _i1.ColumnEnum(
      'saveAbility',
      this,
      _i1.EnumSerialization.byName,
    );
    damageByLevel = _i1.ColumnSerializable(
      'damageByLevel',
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
  }

  late final _i1.ColumnInt choiceSetId;

  _i2.RaceChoiceSetDataTable? _choiceSet;

  late final _i1.ColumnString optionKey;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt sortOrder;

  late final _i1.ColumnEnum<_i3.Ability> ability;

  late final _i1.ColumnEnum<_i4.Skill> skill;

  late final _i1.ColumnEnum<_i5.Language> language;

  late final _i1.ColumnInt spellId;

  _i6.SpellDataTable? _spell;

  late final _i1.ColumnInt featId;

  _i7.FeatDataTable? _feat;

  late final _i1.ColumnString toolKey;

  late final _i1.ColumnInt bonusValue;

  late final _i1.ColumnEnum<_i8.DamageType> damageType;

  late final _i1.ColumnEnum<_i9.AreaOfEffectType> areaOfEffectType;

  late final _i1.ColumnString areaText;

  late final _i1.ColumnEnum<_i3.Ability> saveAbility;

  late final _i1.ColumnSerializable damageByLevel;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.RaceChoiceSetDataTable get choiceSet {
    if (_choiceSet != null) return _choiceSet!;
    _choiceSet = _i1.createRelationTable(
      relationFieldName: 'choiceSet',
      field: RaceChoiceOptionData.t.choiceSetId,
      foreignField: _i2.RaceChoiceSetData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RaceChoiceSetDataTable(tableRelation: foreignTableRelation),
    );
    return _choiceSet!;
  }

  _i6.SpellDataTable get spell {
    if (_spell != null) return _spell!;
    _spell = _i1.createRelationTable(
      relationFieldName: 'spell',
      field: RaceChoiceOptionData.t.spellId,
      foreignField: _i6.SpellData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.SpellDataTable(tableRelation: foreignTableRelation),
    );
    return _spell!;
  }

  _i7.FeatDataTable get feat {
    if (_feat != null) return _feat!;
    _feat = _i1.createRelationTable(
      relationFieldName: 'feat',
      field: RaceChoiceOptionData.t.featId,
      foreignField: _i7.FeatData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7.FeatDataTable(tableRelation: foreignTableRelation),
    );
    return _feat!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        choiceSetId,
        optionKey,
        name,
        description,
        sortOrder,
        ability,
        skill,
        language,
        spellId,
        featId,
        toolKey,
        bonusValue,
        damageType,
        areaOfEffectType,
        areaText,
        saveAbility,
        damageByLevel,
        source,
        version,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'choiceSet') {
      return choiceSet;
    }
    if (relationField == 'spell') {
      return spell;
    }
    if (relationField == 'feat') {
      return feat;
    }
    return null;
  }
}

class RaceChoiceOptionDataInclude extends _i1.IncludeObject {
  RaceChoiceOptionDataInclude._({
    _i2.RaceChoiceSetDataInclude? choiceSet,
    _i6.SpellDataInclude? spell,
    _i7.FeatDataInclude? feat,
  }) {
    _choiceSet = choiceSet;
    _spell = spell;
    _feat = feat;
  }

  _i2.RaceChoiceSetDataInclude? _choiceSet;

  _i6.SpellDataInclude? _spell;

  _i7.FeatDataInclude? _feat;

  @override
  Map<String, _i1.Include?> get includes => {
        'choiceSet': _choiceSet,
        'spell': _spell,
        'feat': _feat,
      };

  @override
  _i1.Table<int?> get table => RaceChoiceOptionData.t;
}

class RaceChoiceOptionDataIncludeList extends _i1.IncludeList {
  RaceChoiceOptionDataIncludeList._({
    _i1.WhereExpressionBuilder<RaceChoiceOptionDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RaceChoiceOptionData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RaceChoiceOptionData.t;
}

class RaceChoiceOptionDataRepository {
  const RaceChoiceOptionDataRepository._();

  final attachRow = const RaceChoiceOptionDataAttachRowRepository._();

  final detachRow = const RaceChoiceOptionDataDetachRowRepository._();

  /// Returns a list of [RaceChoiceOptionData]s matching the given query parameters.
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
  Future<List<RaceChoiceOptionData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceChoiceOptionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RaceChoiceOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceChoiceOptionDataTable>? orderByList,
    _i1.Transaction? transaction,
    RaceChoiceOptionDataInclude? include,
  }) async {
    return session.db.find<RaceChoiceOptionData>(
      where: where?.call(RaceChoiceOptionData.t),
      orderBy: orderBy?.call(RaceChoiceOptionData.t),
      orderByList: orderByList?.call(RaceChoiceOptionData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [RaceChoiceOptionData] matching the given query parameters.
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
  Future<RaceChoiceOptionData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceChoiceOptionDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<RaceChoiceOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceChoiceOptionDataTable>? orderByList,
    _i1.Transaction? transaction,
    RaceChoiceOptionDataInclude? include,
  }) async {
    return session.db.findFirstRow<RaceChoiceOptionData>(
      where: where?.call(RaceChoiceOptionData.t),
      orderBy: orderBy?.call(RaceChoiceOptionData.t),
      orderByList: orderByList?.call(RaceChoiceOptionData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [RaceChoiceOptionData] by its [id] or null if no such row exists.
  Future<RaceChoiceOptionData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    RaceChoiceOptionDataInclude? include,
  }) async {
    return session.db.findById<RaceChoiceOptionData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [RaceChoiceOptionData]s in the list and returns the inserted rows.
  ///
  /// The returned [RaceChoiceOptionData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<RaceChoiceOptionData>> insert(
    _i1.Session session,
    List<RaceChoiceOptionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<RaceChoiceOptionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [RaceChoiceOptionData] and returns the inserted row.
  ///
  /// The returned [RaceChoiceOptionData] will have its `id` field set.
  Future<RaceChoiceOptionData> insertRow(
    _i1.Session session,
    RaceChoiceOptionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RaceChoiceOptionData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RaceChoiceOptionData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RaceChoiceOptionData>> update(
    _i1.Session session,
    List<RaceChoiceOptionData> rows, {
    _i1.ColumnSelections<RaceChoiceOptionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RaceChoiceOptionData>(
      rows,
      columns: columns?.call(RaceChoiceOptionData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RaceChoiceOptionData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RaceChoiceOptionData> updateRow(
    _i1.Session session,
    RaceChoiceOptionData row, {
    _i1.ColumnSelections<RaceChoiceOptionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RaceChoiceOptionData>(
      row,
      columns: columns?.call(RaceChoiceOptionData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [RaceChoiceOptionData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RaceChoiceOptionData>> delete(
    _i1.Session session,
    List<RaceChoiceOptionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RaceChoiceOptionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RaceChoiceOptionData].
  Future<RaceChoiceOptionData> deleteRow(
    _i1.Session session,
    RaceChoiceOptionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RaceChoiceOptionData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RaceChoiceOptionData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RaceChoiceOptionDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RaceChoiceOptionData>(
      where: where(RaceChoiceOptionData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceChoiceOptionDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RaceChoiceOptionData>(
      where: where?.call(RaceChoiceOptionData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RaceChoiceOptionDataAttachRowRepository {
  const RaceChoiceOptionDataAttachRowRepository._();

  /// Creates a relation between the given [RaceChoiceOptionData] and [RaceChoiceSetData]
  /// by setting the [RaceChoiceOptionData]'s foreign key `choiceSetId` to refer to the [RaceChoiceSetData].
  Future<void> choiceSet(
    _i1.Session session,
    RaceChoiceOptionData raceChoiceOptionData,
    _i2.RaceChoiceSetData choiceSet, {
    _i1.Transaction? transaction,
  }) async {
    if (raceChoiceOptionData.id == null) {
      throw ArgumentError.notNull('raceChoiceOptionData.id');
    }
    if (choiceSet.id == null) {
      throw ArgumentError.notNull('choiceSet.id');
    }

    var $raceChoiceOptionData =
        raceChoiceOptionData.copyWith(choiceSetId: choiceSet.id);
    await session.db.updateRow<RaceChoiceOptionData>(
      $raceChoiceOptionData,
      columns: [RaceChoiceOptionData.t.choiceSetId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [RaceChoiceOptionData] and [SpellData]
  /// by setting the [RaceChoiceOptionData]'s foreign key `spellId` to refer to the [SpellData].
  Future<void> spell(
    _i1.Session session,
    RaceChoiceOptionData raceChoiceOptionData,
    _i6.SpellData spell, {
    _i1.Transaction? transaction,
  }) async {
    if (raceChoiceOptionData.id == null) {
      throw ArgumentError.notNull('raceChoiceOptionData.id');
    }
    if (spell.id == null) {
      throw ArgumentError.notNull('spell.id');
    }

    var $raceChoiceOptionData =
        raceChoiceOptionData.copyWith(spellId: spell.id);
    await session.db.updateRow<RaceChoiceOptionData>(
      $raceChoiceOptionData,
      columns: [RaceChoiceOptionData.t.spellId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [RaceChoiceOptionData] and [FeatData]
  /// by setting the [RaceChoiceOptionData]'s foreign key `featId` to refer to the [FeatData].
  Future<void> feat(
    _i1.Session session,
    RaceChoiceOptionData raceChoiceOptionData,
    _i7.FeatData feat, {
    _i1.Transaction? transaction,
  }) async {
    if (raceChoiceOptionData.id == null) {
      throw ArgumentError.notNull('raceChoiceOptionData.id');
    }
    if (feat.id == null) {
      throw ArgumentError.notNull('feat.id');
    }

    var $raceChoiceOptionData = raceChoiceOptionData.copyWith(featId: feat.id);
    await session.db.updateRow<RaceChoiceOptionData>(
      $raceChoiceOptionData,
      columns: [RaceChoiceOptionData.t.featId],
      transaction: transaction,
    );
  }
}

class RaceChoiceOptionDataDetachRowRepository {
  const RaceChoiceOptionDataDetachRowRepository._();

  /// Detaches the relation between this [RaceChoiceOptionData] and the [SpellData] set in `spell`
  /// by setting the [RaceChoiceOptionData]'s foreign key `spellId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> spell(
    _i1.Session session,
    RaceChoiceOptionData racechoiceoptiondata, {
    _i1.Transaction? transaction,
  }) async {
    if (racechoiceoptiondata.id == null) {
      throw ArgumentError.notNull('racechoiceoptiondata.id');
    }

    var $racechoiceoptiondata = racechoiceoptiondata.copyWith(spellId: null);
    await session.db.updateRow<RaceChoiceOptionData>(
      $racechoiceoptiondata,
      columns: [RaceChoiceOptionData.t.spellId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [RaceChoiceOptionData] and the [FeatData] set in `feat`
  /// by setting the [RaceChoiceOptionData]'s foreign key `featId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> feat(
    _i1.Session session,
    RaceChoiceOptionData racechoiceoptiondata, {
    _i1.Transaction? transaction,
  }) async {
    if (racechoiceoptiondata.id == null) {
      throw ArgumentError.notNull('racechoiceoptiondata.id');
    }

    var $racechoiceoptiondata = racechoiceoptiondata.copyWith(featId: null);
    await session.db.updateRow<RaceChoiceOptionData>(
      $racechoiceoptiondata,
      columns: [RaceChoiceOptionData.t.featId],
      transaction: transaction,
    );
  }
}
