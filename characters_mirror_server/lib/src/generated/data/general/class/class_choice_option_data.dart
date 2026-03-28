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
import '../../../data/general/class/class_choice_group_data.dart' as _i2;
import '../../../enums/skill.dart' as _i3;
import '../../../enums/language.dart' as _i4;
import '../../../enums/armor_category.dart' as _i5;
import '../../../enums/weapon_category.dart' as _i6;
import '../../../enums/feature_tag.dart' as _i7;

abstract class ClassChoiceOptionData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ClassChoiceOptionData._({
    this.id,
    required this.choiceGroupId,
    this.choiceGroup,
    this.optionKey,
    this.name,
    this.description,
    this.grantedAbilityBonuses,
    this.grantedSkills,
    this.grantedLanguages,
    this.grantedArmorTraining,
    this.grantedWeaponTraining,
    this.grantedToolKeys,
    this.grantedItemKeys,
    this.grantedSpellKeys,
    this.grantedFeatureTags,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassChoiceOptionData({
    int? id,
    required int choiceGroupId,
    _i2.ClassChoiceGroupData? choiceGroup,
    String? optionKey,
    String? name,
    String? description,
    Map<String, int>? grantedAbilityBonuses,
    List<_i3.Skill>? grantedSkills,
    List<_i4.Language>? grantedLanguages,
    List<_i5.ArmorCategory>? grantedArmorTraining,
    List<_i6.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedItemKeys,
    List<String>? grantedSpellKeys,
    List<_i7.FeatureTag>? grantedFeatureTags,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ClassChoiceOptionDataImpl;

  factory ClassChoiceOptionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ClassChoiceOptionData(
      id: jsonSerialization['id'] as int?,
      choiceGroupId: jsonSerialization['choiceGroupId'] as int,
      choiceGroup: jsonSerialization['choiceGroup'] == null
          ? null
          : _i2.ClassChoiceGroupData.fromJson(
              (jsonSerialization['choiceGroup'] as Map<String, dynamic>)),
      optionKey: jsonSerialization['optionKey'] as String?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      grantedAbilityBonuses:
          (jsonSerialization['grantedAbilityBonuses'] as Map?)
              ?.map((k, v) => MapEntry(
                    k as String,
                    v as int,
                  )),
      grantedSkills: (jsonSerialization['grantedSkills'] as List?)
          ?.map((e) => _i3.Skill.fromJson((e as int)))
          .toList(),
      grantedLanguages: (jsonSerialization['grantedLanguages'] as List?)
          ?.map((e) => _i4.Language.fromJson((e as int)))
          .toList(),
      grantedArmorTraining: (jsonSerialization['grantedArmorTraining'] as List?)
          ?.map((e) => _i5.ArmorCategory.fromJson((e as int)))
          .toList(),
      grantedWeaponTraining:
          (jsonSerialization['grantedWeaponTraining'] as List?)
              ?.map((e) => _i6.WeaponCategory.fromJson((e as int)))
              .toList(),
      grantedToolKeys: (jsonSerialization['grantedToolKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      grantedItemKeys: (jsonSerialization['grantedItemKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      grantedSpellKeys: (jsonSerialization['grantedSpellKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      grantedFeatureTags: (jsonSerialization['grantedFeatureTags'] as List?)
          ?.map((e) => _i7.FeatureTag.fromJson((e as int)))
          .toList(),
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

  static final t = ClassChoiceOptionDataTable();

  static const db = ClassChoiceOptionDataRepository._();

  @override
  int? id;

  int choiceGroupId;

  _i2.ClassChoiceGroupData? choiceGroup;

  String? optionKey;

  String? name;

  String? description;

  Map<String, int>? grantedAbilityBonuses;

  List<_i3.Skill>? grantedSkills;

  List<_i4.Language>? grantedLanguages;

  List<_i5.ArmorCategory>? grantedArmorTraining;

  List<_i6.WeaponCategory>? grantedWeaponTraining;

  List<String>? grantedToolKeys;

  List<String>? grantedItemKeys;

  List<String>? grantedSpellKeys;

  List<_i7.FeatureTag>? grantedFeatureTags;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClassChoiceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassChoiceOptionData copyWith({
    int? id,
    int? choiceGroupId,
    _i2.ClassChoiceGroupData? choiceGroup,
    String? optionKey,
    String? name,
    String? description,
    Map<String, int>? grantedAbilityBonuses,
    List<_i3.Skill>? grantedSkills,
    List<_i4.Language>? grantedLanguages,
    List<_i5.ArmorCategory>? grantedArmorTraining,
    List<_i6.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedItemKeys,
    List<String>? grantedSpellKeys,
    List<_i7.FeatureTag>? grantedFeatureTags,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'choiceGroupId': choiceGroupId,
      if (choiceGroup != null) 'choiceGroup': choiceGroup?.toJson(),
      if (optionKey != null) 'optionKey': optionKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (grantedAbilityBonuses != null)
        'grantedAbilityBonuses': grantedAbilityBonuses?.toJson(),
      if (grantedSkills != null)
        'grantedSkills': grantedSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedLanguages != null)
        'grantedLanguages':
            grantedLanguages?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedArmorTraining != null)
        'grantedArmorTraining':
            grantedArmorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedWeaponTraining != null)
        'grantedWeaponTraining':
            grantedWeaponTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedToolKeys != null) 'grantedToolKeys': grantedToolKeys?.toJson(),
      if (grantedItemKeys != null) 'grantedItemKeys': grantedItemKeys?.toJson(),
      if (grantedSpellKeys != null)
        'grantedSpellKeys': grantedSpellKeys?.toJson(),
      if (grantedFeatureTags != null)
        'grantedFeatureTags':
            grantedFeatureTags?.toJson(valueToJson: (v) => v.toJson()),
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
      'choiceGroupId': choiceGroupId,
      if (choiceGroup != null) 'choiceGroup': choiceGroup?.toJsonForProtocol(),
      if (optionKey != null) 'optionKey': optionKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (grantedAbilityBonuses != null)
        'grantedAbilityBonuses': grantedAbilityBonuses?.toJson(),
      if (grantedSkills != null)
        'grantedSkills': grantedSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedLanguages != null)
        'grantedLanguages':
            grantedLanguages?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedArmorTraining != null)
        'grantedArmorTraining':
            grantedArmorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedWeaponTraining != null)
        'grantedWeaponTraining':
            grantedWeaponTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedToolKeys != null) 'grantedToolKeys': grantedToolKeys?.toJson(),
      if (grantedItemKeys != null) 'grantedItemKeys': grantedItemKeys?.toJson(),
      if (grantedSpellKeys != null)
        'grantedSpellKeys': grantedSpellKeys?.toJson(),
      if (grantedFeatureTags != null)
        'grantedFeatureTags':
            grantedFeatureTags?.toJson(valueToJson: (v) => v.toJson()),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static ClassChoiceOptionDataInclude include(
      {_i2.ClassChoiceGroupDataInclude? choiceGroup}) {
    return ClassChoiceOptionDataInclude._(choiceGroup: choiceGroup);
  }

  static ClassChoiceOptionDataIncludeList includeList({
    _i1.WhereExpressionBuilder<ClassChoiceOptionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassChoiceOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassChoiceOptionDataTable>? orderByList,
    ClassChoiceOptionDataInclude? include,
  }) {
    return ClassChoiceOptionDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassChoiceOptionData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ClassChoiceOptionData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassChoiceOptionDataImpl extends ClassChoiceOptionData {
  _ClassChoiceOptionDataImpl({
    int? id,
    required int choiceGroupId,
    _i2.ClassChoiceGroupData? choiceGroup,
    String? optionKey,
    String? name,
    String? description,
    Map<String, int>? grantedAbilityBonuses,
    List<_i3.Skill>? grantedSkills,
    List<_i4.Language>? grantedLanguages,
    List<_i5.ArmorCategory>? grantedArmorTraining,
    List<_i6.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedItemKeys,
    List<String>? grantedSpellKeys,
    List<_i7.FeatureTag>? grantedFeatureTags,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          choiceGroupId: choiceGroupId,
          choiceGroup: choiceGroup,
          optionKey: optionKey,
          name: name,
          description: description,
          grantedAbilityBonuses: grantedAbilityBonuses,
          grantedSkills: grantedSkills,
          grantedLanguages: grantedLanguages,
          grantedArmorTraining: grantedArmorTraining,
          grantedWeaponTraining: grantedWeaponTraining,
          grantedToolKeys: grantedToolKeys,
          grantedItemKeys: grantedItemKeys,
          grantedSpellKeys: grantedSpellKeys,
          grantedFeatureTags: grantedFeatureTags,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ClassChoiceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassChoiceOptionData copyWith({
    Object? id = _Undefined,
    int? choiceGroupId,
    Object? choiceGroup = _Undefined,
    Object? optionKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? grantedAbilityBonuses = _Undefined,
    Object? grantedSkills = _Undefined,
    Object? grantedLanguages = _Undefined,
    Object? grantedArmorTraining = _Undefined,
    Object? grantedWeaponTraining = _Undefined,
    Object? grantedToolKeys = _Undefined,
    Object? grantedItemKeys = _Undefined,
    Object? grantedSpellKeys = _Undefined,
    Object? grantedFeatureTags = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return ClassChoiceOptionData(
      id: id is int? ? id : this.id,
      choiceGroupId: choiceGroupId ?? this.choiceGroupId,
      choiceGroup: choiceGroup is _i2.ClassChoiceGroupData?
          ? choiceGroup
          : this.choiceGroup?.copyWith(),
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      grantedAbilityBonuses: grantedAbilityBonuses is Map<String, int>?
          ? grantedAbilityBonuses
          : this.grantedAbilityBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      grantedSkills: grantedSkills is List<_i3.Skill>?
          ? grantedSkills
          : this.grantedSkills?.map((e0) => e0).toList(),
      grantedLanguages: grantedLanguages is List<_i4.Language>?
          ? grantedLanguages
          : this.grantedLanguages?.map((e0) => e0).toList(),
      grantedArmorTraining: grantedArmorTraining is List<_i5.ArmorCategory>?
          ? grantedArmorTraining
          : this.grantedArmorTraining?.map((e0) => e0).toList(),
      grantedWeaponTraining: grantedWeaponTraining is List<_i6.WeaponCategory>?
          ? grantedWeaponTraining
          : this.grantedWeaponTraining?.map((e0) => e0).toList(),
      grantedToolKeys: grantedToolKeys is List<String>?
          ? grantedToolKeys
          : this.grantedToolKeys?.map((e0) => e0).toList(),
      grantedItemKeys: grantedItemKeys is List<String>?
          ? grantedItemKeys
          : this.grantedItemKeys?.map((e0) => e0).toList(),
      grantedSpellKeys: grantedSpellKeys is List<String>?
          ? grantedSpellKeys
          : this.grantedSpellKeys?.map((e0) => e0).toList(),
      grantedFeatureTags: grantedFeatureTags is List<_i7.FeatureTag>?
          ? grantedFeatureTags
          : this.grantedFeatureTags?.map((e0) => e0).toList(),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class ClassChoiceOptionDataTable extends _i1.Table<int?> {
  ClassChoiceOptionDataTable({super.tableRelation})
      : super(tableName: 'class_choice_option_data') {
    choiceGroupId = _i1.ColumnInt(
      'choiceGroupId',
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
    grantedAbilityBonuses = _i1.ColumnSerializable(
      'grantedAbilityBonuses',
      this,
    );
    grantedSkills = _i1.ColumnSerializable(
      'grantedSkills',
      this,
    );
    grantedLanguages = _i1.ColumnSerializable(
      'grantedLanguages',
      this,
    );
    grantedArmorTraining = _i1.ColumnSerializable(
      'grantedArmorTraining',
      this,
    );
    grantedWeaponTraining = _i1.ColumnSerializable(
      'grantedWeaponTraining',
      this,
    );
    grantedToolKeys = _i1.ColumnSerializable(
      'grantedToolKeys',
      this,
    );
    grantedItemKeys = _i1.ColumnSerializable(
      'grantedItemKeys',
      this,
    );
    grantedSpellKeys = _i1.ColumnSerializable(
      'grantedSpellKeys',
      this,
    );
    grantedFeatureTags = _i1.ColumnSerializable(
      'grantedFeatureTags',
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

  late final _i1.ColumnInt choiceGroupId;

  _i2.ClassChoiceGroupDataTable? _choiceGroup;

  late final _i1.ColumnString optionKey;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnSerializable grantedAbilityBonuses;

  late final _i1.ColumnSerializable grantedSkills;

  late final _i1.ColumnSerializable grantedLanguages;

  late final _i1.ColumnSerializable grantedArmorTraining;

  late final _i1.ColumnSerializable grantedWeaponTraining;

  late final _i1.ColumnSerializable grantedToolKeys;

  late final _i1.ColumnSerializable grantedItemKeys;

  late final _i1.ColumnSerializable grantedSpellKeys;

  late final _i1.ColumnSerializable grantedFeatureTags;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.ClassChoiceGroupDataTable get choiceGroup {
    if (_choiceGroup != null) return _choiceGroup!;
    _choiceGroup = _i1.createRelationTable(
      relationFieldName: 'choiceGroup',
      field: ClassChoiceOptionData.t.choiceGroupId,
      foreignField: _i2.ClassChoiceGroupData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ClassChoiceGroupDataTable(tableRelation: foreignTableRelation),
    );
    return _choiceGroup!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        choiceGroupId,
        optionKey,
        name,
        description,
        grantedAbilityBonuses,
        grantedSkills,
        grantedLanguages,
        grantedArmorTraining,
        grantedWeaponTraining,
        grantedToolKeys,
        grantedItemKeys,
        grantedSpellKeys,
        grantedFeatureTags,
        source,
        version,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'choiceGroup') {
      return choiceGroup;
    }
    return null;
  }
}

class ClassChoiceOptionDataInclude extends _i1.IncludeObject {
  ClassChoiceOptionDataInclude._(
      {_i2.ClassChoiceGroupDataInclude? choiceGroup}) {
    _choiceGroup = choiceGroup;
  }

  _i2.ClassChoiceGroupDataInclude? _choiceGroup;

  @override
  Map<String, _i1.Include?> get includes => {'choiceGroup': _choiceGroup};

  @override
  _i1.Table<int?> get table => ClassChoiceOptionData.t;
}

class ClassChoiceOptionDataIncludeList extends _i1.IncludeList {
  ClassChoiceOptionDataIncludeList._({
    _i1.WhereExpressionBuilder<ClassChoiceOptionDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClassChoiceOptionData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ClassChoiceOptionData.t;
}

class ClassChoiceOptionDataRepository {
  const ClassChoiceOptionDataRepository._();

  final attachRow = const ClassChoiceOptionDataAttachRowRepository._();

  /// Returns a list of [ClassChoiceOptionData]s matching the given query parameters.
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
  Future<List<ClassChoiceOptionData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassChoiceOptionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassChoiceOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassChoiceOptionDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassChoiceOptionDataInclude? include,
  }) async {
    return session.db.find<ClassChoiceOptionData>(
      where: where?.call(ClassChoiceOptionData.t),
      orderBy: orderBy?.call(ClassChoiceOptionData.t),
      orderByList: orderByList?.call(ClassChoiceOptionData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ClassChoiceOptionData] matching the given query parameters.
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
  Future<ClassChoiceOptionData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassChoiceOptionDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClassChoiceOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassChoiceOptionDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassChoiceOptionDataInclude? include,
  }) async {
    return session.db.findFirstRow<ClassChoiceOptionData>(
      where: where?.call(ClassChoiceOptionData.t),
      orderBy: orderBy?.call(ClassChoiceOptionData.t),
      orderByList: orderByList?.call(ClassChoiceOptionData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ClassChoiceOptionData] by its [id] or null if no such row exists.
  Future<ClassChoiceOptionData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ClassChoiceOptionDataInclude? include,
  }) async {
    return session.db.findById<ClassChoiceOptionData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ClassChoiceOptionData]s in the list and returns the inserted rows.
  ///
  /// The returned [ClassChoiceOptionData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ClassChoiceOptionData>> insert(
    _i1.Session session,
    List<ClassChoiceOptionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ClassChoiceOptionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ClassChoiceOptionData] and returns the inserted row.
  ///
  /// The returned [ClassChoiceOptionData] will have its `id` field set.
  Future<ClassChoiceOptionData> insertRow(
    _i1.Session session,
    ClassChoiceOptionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClassChoiceOptionData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ClassChoiceOptionData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ClassChoiceOptionData>> update(
    _i1.Session session,
    List<ClassChoiceOptionData> rows, {
    _i1.ColumnSelections<ClassChoiceOptionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ClassChoiceOptionData>(
      rows,
      columns: columns?.call(ClassChoiceOptionData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClassChoiceOptionData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClassChoiceOptionData> updateRow(
    _i1.Session session,
    ClassChoiceOptionData row, {
    _i1.ColumnSelections<ClassChoiceOptionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClassChoiceOptionData>(
      row,
      columns: columns?.call(ClassChoiceOptionData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ClassChoiceOptionData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ClassChoiceOptionData>> delete(
    _i1.Session session,
    List<ClassChoiceOptionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ClassChoiceOptionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ClassChoiceOptionData].
  Future<ClassChoiceOptionData> deleteRow(
    _i1.Session session,
    ClassChoiceOptionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClassChoiceOptionData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ClassChoiceOptionData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClassChoiceOptionDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ClassChoiceOptionData>(
      where: where(ClassChoiceOptionData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassChoiceOptionDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ClassChoiceOptionData>(
      where: where?.call(ClassChoiceOptionData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ClassChoiceOptionDataAttachRowRepository {
  const ClassChoiceOptionDataAttachRowRepository._();

  /// Creates a relation between the given [ClassChoiceOptionData] and [ClassChoiceGroupData]
  /// by setting the [ClassChoiceOptionData]'s foreign key `choiceGroupId` to refer to the [ClassChoiceGroupData].
  Future<void> choiceGroup(
    _i1.Session session,
    ClassChoiceOptionData classChoiceOptionData,
    _i2.ClassChoiceGroupData choiceGroup, {
    _i1.Transaction? transaction,
  }) async {
    if (classChoiceOptionData.id == null) {
      throw ArgumentError.notNull('classChoiceOptionData.id');
    }
    if (choiceGroup.id == null) {
      throw ArgumentError.notNull('choiceGroup.id');
    }

    var $classChoiceOptionData =
        classChoiceOptionData.copyWith(choiceGroupId: choiceGroup.id);
    await session.db.updateRow<ClassChoiceOptionData>(
      $classChoiceOptionData,
      columns: [ClassChoiceOptionData.t.choiceGroupId],
      transaction: transaction,
    );
  }
}
