/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../enums/ability.dart' as _i2;
import '../../../enums/armor_category.dart' as _i3;
import '../../../enums/weapon_category.dart' as _i4;
import '../../../enums/skill.dart' as _i5;
import '../../../enums/spellcasting_progression.dart' as _i6;

abstract class ClassData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ClassData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.hitDieValue,
    this.primaryAbilities,
    this.savingThrowProficiencies,
    this.armorTraining,
    this.weaponTraining,
    this.toolTraining,
    this.availableSkills,
    this.skillCount,
    this.subclassChoiceLevel,
    this.spellcastingProgression,
    this.spellcastingAbilityValue,
    this.multiclassPrerequisites,
    this.multiclassArmorTraining,
    this.multiclassWeaponTraining,
    this.multiclassToolTraining,
    this.imageURL,
  });

  factory ClassData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hitDieValue,
    List<_i2.Ability>? primaryAbilities,
    List<_i2.Ability>? savingThrowProficiencies,
    List<_i3.ArmorCategory>? armorTraining,
    List<_i4.WeaponCategory>? weaponTraining,
    List<String>? toolTraining,
    List<_i5.Skill>? availableSkills,
    int? skillCount,
    int? subclassChoiceLevel,
    _i6.SpellcastingProgression? spellcastingProgression,
    _i2.Ability? spellcastingAbilityValue,
    Map<String, int>? multiclassPrerequisites,
    List<_i3.ArmorCategory>? multiclassArmorTraining,
    List<_i4.WeaponCategory>? multiclassWeaponTraining,
    List<String>? multiclassToolTraining,
    String? imageURL,
  }) = _ClassDataImpl;

  factory ClassData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassData(
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
      hitDieValue: jsonSerialization['hitDieValue'] as int?,
      primaryAbilities: (jsonSerialization['primaryAbilities'] as List?)
          ?.map((e) => _i2.Ability.fromJson((e as int)))
          .toList(),
      savingThrowProficiencies:
          (jsonSerialization['savingThrowProficiencies'] as List?)
              ?.map((e) => _i2.Ability.fromJson((e as int)))
              .toList(),
      armorTraining: (jsonSerialization['armorTraining'] as List?)
          ?.map((e) => _i3.ArmorCategory.fromJson((e as int)))
          .toList(),
      weaponTraining: (jsonSerialization['weaponTraining'] as List?)
          ?.map((e) => _i4.WeaponCategory.fromJson((e as int)))
          .toList(),
      toolTraining: (jsonSerialization['toolTraining'] as List?)
          ?.map((e) => e as String)
          .toList(),
      availableSkills: (jsonSerialization['availableSkills'] as List?)
          ?.map((e) => _i5.Skill.fromJson((e as int)))
          .toList(),
      skillCount: jsonSerialization['skillCount'] as int?,
      subclassChoiceLevel: jsonSerialization['subclassChoiceLevel'] as int?,
      spellcastingProgression:
          jsonSerialization['spellcastingProgression'] == null
              ? null
              : _i6.SpellcastingProgression.fromJson(
                  (jsonSerialization['spellcastingProgression'] as int)),
      spellcastingAbilityValue:
          jsonSerialization['spellcastingAbilityValue'] == null
              ? null
              : _i2.Ability.fromJson(
                  (jsonSerialization['spellcastingAbilityValue'] as int)),
      multiclassPrerequisites:
          (jsonSerialization['multiclassPrerequisites'] as Map?)
              ?.map((k, v) => MapEntry(
                    k as String,
                    v as int,
                  )),
      multiclassArmorTraining:
          (jsonSerialization['multiclassArmorTraining'] as List?)
              ?.map((e) => _i3.ArmorCategory.fromJson((e as int)))
              .toList(),
      multiclassWeaponTraining:
          (jsonSerialization['multiclassWeaponTraining'] as List?)
              ?.map((e) => _i4.WeaponCategory.fromJson((e as int)))
              .toList(),
      multiclassToolTraining:
          (jsonSerialization['multiclassToolTraining'] as List?)
              ?.map((e) => e as String)
              .toList(),
      imageURL: jsonSerialization['imageURL'] as String?,
    );
  }

  static final t = ClassDataTable();

  static const db = ClassDataRepository._();

  @override
  int? id;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? hitDieValue;

  List<_i2.Ability>? primaryAbilities;

  List<_i2.Ability>? savingThrowProficiencies;

  List<_i3.ArmorCategory>? armorTraining;

  List<_i4.WeaponCategory>? weaponTraining;

  List<String>? toolTraining;

  List<_i5.Skill>? availableSkills;

  int? skillCount;

  int? subclassChoiceLevel;

  _i6.SpellcastingProgression? spellcastingProgression;

  _i2.Ability? spellcastingAbilityValue;

  Map<String, int>? multiclassPrerequisites;

  List<_i3.ArmorCategory>? multiclassArmorTraining;

  List<_i4.WeaponCategory>? multiclassWeaponTraining;

  List<String>? multiclassToolTraining;

  String? imageURL;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClassData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hitDieValue,
    List<_i2.Ability>? primaryAbilities,
    List<_i2.Ability>? savingThrowProficiencies,
    List<_i3.ArmorCategory>? armorTraining,
    List<_i4.WeaponCategory>? weaponTraining,
    List<String>? toolTraining,
    List<_i5.Skill>? availableSkills,
    int? skillCount,
    int? subclassChoiceLevel,
    _i6.SpellcastingProgression? spellcastingProgression,
    _i2.Ability? spellcastingAbilityValue,
    Map<String, int>? multiclassPrerequisites,
    List<_i3.ArmorCategory>? multiclassArmorTraining,
    List<_i4.WeaponCategory>? multiclassWeaponTraining,
    List<String>? multiclassToolTraining,
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
      if (hitDieValue != null) 'hitDieValue': hitDieValue,
      if (primaryAbilities != null)
        'primaryAbilities':
            primaryAbilities?.toJson(valueToJson: (v) => v.toJson()),
      if (savingThrowProficiencies != null)
        'savingThrowProficiencies':
            savingThrowProficiencies?.toJson(valueToJson: (v) => v.toJson()),
      if (armorTraining != null)
        'armorTraining': armorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (weaponTraining != null)
        'weaponTraining':
            weaponTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (toolTraining != null) 'toolTraining': toolTraining?.toJson(),
      if (availableSkills != null)
        'availableSkills':
            availableSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (skillCount != null) 'skillCount': skillCount,
      if (subclassChoiceLevel != null)
        'subclassChoiceLevel': subclassChoiceLevel,
      if (spellcastingProgression != null)
        'spellcastingProgression': spellcastingProgression?.toJson(),
      if (spellcastingAbilityValue != null)
        'spellcastingAbilityValue': spellcastingAbilityValue?.toJson(),
      if (multiclassPrerequisites != null)
        'multiclassPrerequisites': multiclassPrerequisites?.toJson(),
      if (multiclassArmorTraining != null)
        'multiclassArmorTraining':
            multiclassArmorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (multiclassWeaponTraining != null)
        'multiclassWeaponTraining':
            multiclassWeaponTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (multiclassToolTraining != null)
        'multiclassToolTraining': multiclassToolTraining?.toJson(),
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
      if (hitDieValue != null) 'hitDieValue': hitDieValue,
      if (primaryAbilities != null)
        'primaryAbilities':
            primaryAbilities?.toJson(valueToJson: (v) => v.toJson()),
      if (savingThrowProficiencies != null)
        'savingThrowProficiencies':
            savingThrowProficiencies?.toJson(valueToJson: (v) => v.toJson()),
      if (armorTraining != null)
        'armorTraining': armorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (weaponTraining != null)
        'weaponTraining':
            weaponTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (toolTraining != null) 'toolTraining': toolTraining?.toJson(),
      if (availableSkills != null)
        'availableSkills':
            availableSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (skillCount != null) 'skillCount': skillCount,
      if (subclassChoiceLevel != null)
        'subclassChoiceLevel': subclassChoiceLevel,
      if (spellcastingProgression != null)
        'spellcastingProgression': spellcastingProgression?.toJson(),
      if (spellcastingAbilityValue != null)
        'spellcastingAbilityValue': spellcastingAbilityValue?.toJson(),
      if (multiclassPrerequisites != null)
        'multiclassPrerequisites': multiclassPrerequisites?.toJson(),
      if (multiclassArmorTraining != null)
        'multiclassArmorTraining':
            multiclassArmorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (multiclassWeaponTraining != null)
        'multiclassWeaponTraining':
            multiclassWeaponTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (multiclassToolTraining != null)
        'multiclassToolTraining': multiclassToolTraining?.toJson(),
      if (imageURL != null) 'imageURL': imageURL,
    };
  }

  static ClassDataInclude include() {
    return ClassDataInclude._();
  }

  static ClassDataIncludeList includeList({
    _i1.WhereExpressionBuilder<ClassDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassDataTable>? orderByList,
    ClassDataInclude? include,
  }) {
    return ClassDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ClassData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassDataImpl extends ClassData {
  _ClassDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hitDieValue,
    List<_i2.Ability>? primaryAbilities,
    List<_i2.Ability>? savingThrowProficiencies,
    List<_i3.ArmorCategory>? armorTraining,
    List<_i4.WeaponCategory>? weaponTraining,
    List<String>? toolTraining,
    List<_i5.Skill>? availableSkills,
    int? skillCount,
    int? subclassChoiceLevel,
    _i6.SpellcastingProgression? spellcastingProgression,
    _i2.Ability? spellcastingAbilityValue,
    Map<String, int>? multiclassPrerequisites,
    List<_i3.ArmorCategory>? multiclassArmorTraining,
    List<_i4.WeaponCategory>? multiclassWeaponTraining,
    List<String>? multiclassToolTraining,
    String? imageURL,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          hitDieValue: hitDieValue,
          primaryAbilities: primaryAbilities,
          savingThrowProficiencies: savingThrowProficiencies,
          armorTraining: armorTraining,
          weaponTraining: weaponTraining,
          toolTraining: toolTraining,
          availableSkills: availableSkills,
          skillCount: skillCount,
          subclassChoiceLevel: subclassChoiceLevel,
          spellcastingProgression: spellcastingProgression,
          spellcastingAbilityValue: spellcastingAbilityValue,
          multiclassPrerequisites: multiclassPrerequisites,
          multiclassArmorTraining: multiclassArmorTraining,
          multiclassWeaponTraining: multiclassWeaponTraining,
          multiclassToolTraining: multiclassToolTraining,
          imageURL: imageURL,
        );

  /// Returns a shallow copy of this [ClassData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? hitDieValue = _Undefined,
    Object? primaryAbilities = _Undefined,
    Object? savingThrowProficiencies = _Undefined,
    Object? armorTraining = _Undefined,
    Object? weaponTraining = _Undefined,
    Object? toolTraining = _Undefined,
    Object? availableSkills = _Undefined,
    Object? skillCount = _Undefined,
    Object? subclassChoiceLevel = _Undefined,
    Object? spellcastingProgression = _Undefined,
    Object? spellcastingAbilityValue = _Undefined,
    Object? multiclassPrerequisites = _Undefined,
    Object? multiclassArmorTraining = _Undefined,
    Object? multiclassWeaponTraining = _Undefined,
    Object? multiclassToolTraining = _Undefined,
    Object? imageURL = _Undefined,
  }) {
    return ClassData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      hitDieValue: hitDieValue is int? ? hitDieValue : this.hitDieValue,
      primaryAbilities: primaryAbilities is List<_i2.Ability>?
          ? primaryAbilities
          : this.primaryAbilities?.map((e0) => e0).toList(),
      savingThrowProficiencies: savingThrowProficiencies is List<_i2.Ability>?
          ? savingThrowProficiencies
          : this.savingThrowProficiencies?.map((e0) => e0).toList(),
      armorTraining: armorTraining is List<_i3.ArmorCategory>?
          ? armorTraining
          : this.armorTraining?.map((e0) => e0).toList(),
      weaponTraining: weaponTraining is List<_i4.WeaponCategory>?
          ? weaponTraining
          : this.weaponTraining?.map((e0) => e0).toList(),
      toolTraining: toolTraining is List<String>?
          ? toolTraining
          : this.toolTraining?.map((e0) => e0).toList(),
      availableSkills: availableSkills is List<_i5.Skill>?
          ? availableSkills
          : this.availableSkills?.map((e0) => e0).toList(),
      skillCount: skillCount is int? ? skillCount : this.skillCount,
      subclassChoiceLevel: subclassChoiceLevel is int?
          ? subclassChoiceLevel
          : this.subclassChoiceLevel,
      spellcastingProgression:
          spellcastingProgression is _i6.SpellcastingProgression?
              ? spellcastingProgression
              : this.spellcastingProgression,
      spellcastingAbilityValue: spellcastingAbilityValue is _i2.Ability?
          ? spellcastingAbilityValue
          : this.spellcastingAbilityValue,
      multiclassPrerequisites: multiclassPrerequisites is Map<String, int>?
          ? multiclassPrerequisites
          : this.multiclassPrerequisites?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      multiclassArmorTraining:
          multiclassArmorTraining is List<_i3.ArmorCategory>?
              ? multiclassArmorTraining
              : this.multiclassArmorTraining?.map((e0) => e0).toList(),
      multiclassWeaponTraining:
          multiclassWeaponTraining is List<_i4.WeaponCategory>?
              ? multiclassWeaponTraining
              : this.multiclassWeaponTraining?.map((e0) => e0).toList(),
      multiclassToolTraining: multiclassToolTraining is List<String>?
          ? multiclassToolTraining
          : this.multiclassToolTraining?.map((e0) => e0).toList(),
      imageURL: imageURL is String? ? imageURL : this.imageURL,
    );
  }
}

class ClassDataTable extends _i1.Table<int?> {
  ClassDataTable({super.tableRelation}) : super(tableName: 'class_data') {
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
    hitDieValue = _i1.ColumnInt(
      'hitDieValue',
      this,
    );
    primaryAbilities = _i1.ColumnSerializable(
      'primaryAbilities',
      this,
    );
    savingThrowProficiencies = _i1.ColumnSerializable(
      'savingThrowProficiencies',
      this,
    );
    armorTraining = _i1.ColumnSerializable(
      'armorTraining',
      this,
    );
    weaponTraining = _i1.ColumnSerializable(
      'weaponTraining',
      this,
    );
    toolTraining = _i1.ColumnSerializable(
      'toolTraining',
      this,
    );
    availableSkills = _i1.ColumnSerializable(
      'availableSkills',
      this,
    );
    skillCount = _i1.ColumnInt(
      'skillCount',
      this,
    );
    subclassChoiceLevel = _i1.ColumnInt(
      'subclassChoiceLevel',
      this,
    );
    spellcastingProgression = _i1.ColumnEnum(
      'spellcastingProgression',
      this,
      _i1.EnumSerialization.byIndex,
    );
    spellcastingAbilityValue = _i1.ColumnEnum(
      'spellcastingAbilityValue',
      this,
      _i1.EnumSerialization.byIndex,
    );
    multiclassPrerequisites = _i1.ColumnSerializable(
      'multiclassPrerequisites',
      this,
    );
    multiclassArmorTraining = _i1.ColumnSerializable(
      'multiclassArmorTraining',
      this,
    );
    multiclassWeaponTraining = _i1.ColumnSerializable(
      'multiclassWeaponTraining',
      this,
    );
    multiclassToolTraining = _i1.ColumnSerializable(
      'multiclassToolTraining',
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

  late final _i1.ColumnInt hitDieValue;

  late final _i1.ColumnSerializable primaryAbilities;

  late final _i1.ColumnSerializable savingThrowProficiencies;

  late final _i1.ColumnSerializable armorTraining;

  late final _i1.ColumnSerializable weaponTraining;

  late final _i1.ColumnSerializable toolTraining;

  late final _i1.ColumnSerializable availableSkills;

  late final _i1.ColumnInt skillCount;

  late final _i1.ColumnInt subclassChoiceLevel;

  late final _i1.ColumnEnum<_i6.SpellcastingProgression>
      spellcastingProgression;

  late final _i1.ColumnEnum<_i2.Ability> spellcastingAbilityValue;

  late final _i1.ColumnSerializable multiclassPrerequisites;

  late final _i1.ColumnSerializable multiclassArmorTraining;

  late final _i1.ColumnSerializable multiclassWeaponTraining;

  late final _i1.ColumnSerializable multiclassToolTraining;

  late final _i1.ColumnString imageURL;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        hitDieValue,
        primaryAbilities,
        savingThrowProficiencies,
        armorTraining,
        weaponTraining,
        toolTraining,
        availableSkills,
        skillCount,
        subclassChoiceLevel,
        spellcastingProgression,
        spellcastingAbilityValue,
        multiclassPrerequisites,
        multiclassArmorTraining,
        multiclassWeaponTraining,
        multiclassToolTraining,
        imageURL,
      ];
}

class ClassDataInclude extends _i1.IncludeObject {
  ClassDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ClassData.t;
}

class ClassDataIncludeList extends _i1.IncludeList {
  ClassDataIncludeList._({
    _i1.WhereExpressionBuilder<ClassDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClassData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ClassData.t;
}

class ClassDataRepository {
  const ClassDataRepository._();

  /// Returns a list of [ClassData]s matching the given query parameters.
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
  Future<List<ClassData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ClassData>(
      where: where?.call(ClassData.t),
      orderBy: orderBy?.call(ClassData.t),
      orderByList: orderByList?.call(ClassData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ClassData] matching the given query parameters.
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
  Future<ClassData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClassDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ClassData>(
      where: where?.call(ClassData.t),
      orderBy: orderBy?.call(ClassData.t),
      orderByList: orderByList?.call(ClassData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ClassData] by its [id] or null if no such row exists.
  Future<ClassData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ClassData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ClassData]s in the list and returns the inserted rows.
  ///
  /// The returned [ClassData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ClassData>> insert(
    _i1.Session session,
    List<ClassData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ClassData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ClassData] and returns the inserted row.
  ///
  /// The returned [ClassData] will have its `id` field set.
  Future<ClassData> insertRow(
    _i1.Session session,
    ClassData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClassData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ClassData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ClassData>> update(
    _i1.Session session,
    List<ClassData> rows, {
    _i1.ColumnSelections<ClassDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ClassData>(
      rows,
      columns: columns?.call(ClassData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClassData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClassData> updateRow(
    _i1.Session session,
    ClassData row, {
    _i1.ColumnSelections<ClassDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClassData>(
      row,
      columns: columns?.call(ClassData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ClassData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ClassData>> delete(
    _i1.Session session,
    List<ClassData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ClassData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ClassData].
  Future<ClassData> deleteRow(
    _i1.Session session,
    ClassData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClassData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ClassData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClassDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ClassData>(
      where: where(ClassData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ClassData>(
      where: where?.call(ClassData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
