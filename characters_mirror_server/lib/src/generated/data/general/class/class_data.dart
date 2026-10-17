/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../data/general/spell_selection_filter_data.dart' as _iv73j5oi;
import '../../../enums/ability.dart' as _iw3bk51e;
import '../../../enums/armor_category.dart' as _irzuusaf;
import '../../../enums/class_spell_selection_mode.dart' as _iax70tek;
import '../../../enums/skill.dart' as _iqrhamom;
import '../../../enums/spellcasting_progression.dart' as _if4imcqg;

abstract class ClassData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ClassData._({
    this.id,
    this.spellSelectionFilter,
    this.referenceKey,
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
    this.toolTrainingKeys,
    this.availableSkills,
    this.skillCount,
    this.subclassChoiceLevel,
    this.subclassChoiceFeatureId,
    this.spellcastingProgression,
    this.spellSelectionMode,
    this.spellcastingAbilityValue,
    this.multiclassPrerequisites,
    this.multiclassArmorTraining,
    this.multiclassWeaponTraining,
    this.multiclassToolTrainingKeys,
    this.imageURL,
  });

  factory ClassData({
    int? id,
    _iv73j5oi.SpellSelectionFilterData? spellSelectionFilter,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hitDieValue,
    List<_iw3bk51e.Ability>? primaryAbilities,
    List<_iw3bk51e.Ability>? savingThrowProficiencies,
    List<_irzuusaf.ArmorCategory>? armorTraining,
    List<String>? weaponTraining,
    List<String>? toolTrainingKeys,
    List<_iqrhamom.Skill>? availableSkills,
    int? skillCount,
    int? subclassChoiceLevel,
    int? subclassChoiceFeatureId,
    _if4imcqg.SpellcastingProgression? spellcastingProgression,
    _iax70tek.ClassSpellSelectionMode? spellSelectionMode,
    _iw3bk51e.Ability? spellcastingAbilityValue,
    Map<String, int>? multiclassPrerequisites,
    List<_irzuusaf.ArmorCategory>? multiclassArmorTraining,
    List<String>? multiclassWeaponTraining,
    List<String>? multiclassToolTrainingKeys,
    String? imageURL,
  }) = _ClassDataImpl;

  factory ClassData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassData(
      id: jsonSerialization['id'] as int?,
      spellSelectionFilter: jsonSerialization['spellSelectionFilter'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_iv73j5oi.SpellSelectionFilterData>(
                  jsonSerialization['spellSelectionFilter'],
                ),
      referenceKey: jsonSerialization['referenceKey'] as String?,
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
      hitDieValue: jsonSerialization['hitDieValue'] as int?,
      primaryAbilities: jsonSerialization['primaryAbilities'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iw3bk51e.Ability>>(
              jsonSerialization['primaryAbilities'],
            ),
      savingThrowProficiencies:
          jsonSerialization['savingThrowProficiencies'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iw3bk51e.Ability>>(
              jsonSerialization['savingThrowProficiencies'],
            ),
      armorTraining: jsonSerialization['armorTraining'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_irzuusaf.ArmorCategory>>(
              jsonSerialization['armorTraining'],
            ),
      weaponTraining: jsonSerialization['weaponTraining'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['weaponTraining'],
            ),
      toolTrainingKeys: jsonSerialization['toolTrainingKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['toolTrainingKeys'],
            ),
      availableSkills: jsonSerialization['availableSkills'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iqrhamom.Skill>>(
              jsonSerialization['availableSkills'],
            ),
      skillCount: jsonSerialization['skillCount'] as int?,
      subclassChoiceLevel: jsonSerialization['subclassChoiceLevel'] as int?,
      subclassChoiceFeatureId:
          jsonSerialization['subclassChoiceFeatureId'] as int?,
      spellcastingProgression:
          jsonSerialization['spellcastingProgression'] == null
          ? null
          : _if4imcqg.SpellcastingProgression.fromJson(
              (jsonSerialization['spellcastingProgression'] as String),
            ),
      spellSelectionMode: jsonSerialization['spellSelectionMode'] == null
          ? null
          : _iax70tek.ClassSpellSelectionMode.fromJson(
              (jsonSerialization['spellSelectionMode'] as String),
            ),
      spellcastingAbilityValue:
          jsonSerialization['spellcastingAbilityValue'] == null
          ? null
          : _iw3bk51e.Ability.fromJson(
              (jsonSerialization['spellcastingAbilityValue'] as String),
            ),
      multiclassPrerequisites:
          jsonSerialization['multiclassPrerequisites'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['multiclassPrerequisites'],
            ),
      multiclassArmorTraining:
          jsonSerialization['multiclassArmorTraining'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_irzuusaf.ArmorCategory>>(
              jsonSerialization['multiclassArmorTraining'],
            ),
      multiclassWeaponTraining:
          jsonSerialization['multiclassWeaponTraining'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['multiclassWeaponTraining'],
            ),
      multiclassToolTrainingKeys:
          jsonSerialization['multiclassToolTrainingKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['multiclassToolTrainingKeys'],
            ),
      imageURL: jsonSerialization['imageURL'] as String?,
    );
  }

  static final t = ClassDataTable();

  static const db = ClassDataRepository._();

  @override
  int? id;

  _iv73j5oi.SpellSelectionFilterData? spellSelectionFilter;

  String? referenceKey;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? hitDieValue;

  List<_iw3bk51e.Ability>? primaryAbilities;

  List<_iw3bk51e.Ability>? savingThrowProficiencies;

  List<_irzuusaf.ArmorCategory>? armorTraining;

  List<String>? weaponTraining;

  List<String>? toolTrainingKeys;

  List<_iqrhamom.Skill>? availableSkills;

  int? skillCount;

  int? subclassChoiceLevel;

  int? subclassChoiceFeatureId;

  _if4imcqg.SpellcastingProgression? spellcastingProgression;

  _iax70tek.ClassSpellSelectionMode? spellSelectionMode;

  _iw3bk51e.Ability? spellcastingAbilityValue;

  Map<String, int>? multiclassPrerequisites;

  List<_irzuusaf.ArmorCategory>? multiclassArmorTraining;

  List<String>? multiclassWeaponTraining;

  List<String>? multiclassToolTrainingKeys;

  String? imageURL;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClassData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ClassData copyWith({
    int? id,
    _iv73j5oi.SpellSelectionFilterData? spellSelectionFilter,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hitDieValue,
    List<_iw3bk51e.Ability>? primaryAbilities,
    List<_iw3bk51e.Ability>? savingThrowProficiencies,
    List<_irzuusaf.ArmorCategory>? armorTraining,
    List<String>? weaponTraining,
    List<String>? toolTrainingKeys,
    List<_iqrhamom.Skill>? availableSkills,
    int? skillCount,
    int? subclassChoiceLevel,
    int? subclassChoiceFeatureId,
    _if4imcqg.SpellcastingProgression? spellcastingProgression,
    _iax70tek.ClassSpellSelectionMode? spellSelectionMode,
    _iw3bk51e.Ability? spellcastingAbilityValue,
    Map<String, int>? multiclassPrerequisites,
    List<_irzuusaf.ArmorCategory>? multiclassArmorTraining,
    List<String>? multiclassWeaponTraining,
    List<String>? multiclassToolTrainingKeys,
    String? imageURL,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClassData',
      if (id != null) 'id': id,
      if (spellSelectionFilter != null)
        'spellSelectionFilter': spellSelectionFilter?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (hitDieValue != null) 'hitDieValue': hitDieValue,
      if (primaryAbilities != null)
        'primaryAbilities': primaryAbilities?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (savingThrowProficiencies != null)
        'savingThrowProficiencies': savingThrowProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (armorTraining != null)
        'armorTraining': armorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (weaponTraining != null) 'weaponTraining': weaponTraining?.toJson(),
      if (toolTrainingKeys != null)
        'toolTrainingKeys': toolTrainingKeys?.toJson(),
      if (availableSkills != null)
        'availableSkills': availableSkills?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (skillCount != null) 'skillCount': skillCount,
      if (subclassChoiceLevel != null)
        'subclassChoiceLevel': subclassChoiceLevel,
      if (subclassChoiceFeatureId != null)
        'subclassChoiceFeatureId': subclassChoiceFeatureId,
      if (spellcastingProgression != null)
        'spellcastingProgression': spellcastingProgression?.toJson(),
      if (spellSelectionMode != null)
        'spellSelectionMode': spellSelectionMode?.toJson(),
      if (spellcastingAbilityValue != null)
        'spellcastingAbilityValue': spellcastingAbilityValue?.toJson(),
      if (multiclassPrerequisites != null)
        'multiclassPrerequisites': multiclassPrerequisites?.toJson(),
      if (multiclassArmorTraining != null)
        'multiclassArmorTraining': multiclassArmorTraining?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (multiclassWeaponTraining != null)
        'multiclassWeaponTraining': multiclassWeaponTraining?.toJson(),
      if (multiclassToolTrainingKeys != null)
        'multiclassToolTrainingKeys': multiclassToolTrainingKeys?.toJson(),
      if (imageURL != null) 'imageURL': imageURL,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClassData',
      if (id != null) 'id': id,
      if (spellSelectionFilter != null)
        'spellSelectionFilter': spellSelectionFilter?.toJsonForProtocol(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (hitDieValue != null) 'hitDieValue': hitDieValue,
      if (primaryAbilities != null)
        'primaryAbilities': primaryAbilities?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (savingThrowProficiencies != null)
        'savingThrowProficiencies': savingThrowProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (armorTraining != null)
        'armorTraining': armorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (weaponTraining != null) 'weaponTraining': weaponTraining?.toJson(),
      if (toolTrainingKeys != null)
        'toolTrainingKeys': toolTrainingKeys?.toJson(),
      if (availableSkills != null)
        'availableSkills': availableSkills?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (skillCount != null) 'skillCount': skillCount,
      if (subclassChoiceLevel != null)
        'subclassChoiceLevel': subclassChoiceLevel,
      if (subclassChoiceFeatureId != null)
        'subclassChoiceFeatureId': subclassChoiceFeatureId,
      if (spellcastingProgression != null)
        'spellcastingProgression': spellcastingProgression?.toJson(),
      if (spellSelectionMode != null)
        'spellSelectionMode': spellSelectionMode?.toJson(),
      if (spellcastingAbilityValue != null)
        'spellcastingAbilityValue': spellcastingAbilityValue?.toJson(),
      if (multiclassPrerequisites != null)
        'multiclassPrerequisites': multiclassPrerequisites?.toJson(),
      if (multiclassArmorTraining != null)
        'multiclassArmorTraining': multiclassArmorTraining?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (multiclassWeaponTraining != null)
        'multiclassWeaponTraining': multiclassWeaponTraining?.toJson(),
      if (multiclassToolTrainingKeys != null)
        'multiclassToolTrainingKeys': multiclassToolTrainingKeys?.toJson(),
      if (imageURL != null) 'imageURL': imageURL,
    };
  }

  static ClassDataInclude include() {
    return ClassDataInclude._();
  }

  static ClassDataIncludeList includeList({
    _is.WhereExpressionBuilder<ClassDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClassDataTable>? orderBy,
    _is.OrderByListBuilder<ClassDataTable>? orderByList,
    ClassDataInclude? include,
  }) {
    return ClassDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassData.t),
      orderByList: orderByList?.call(ClassData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassDataImpl extends ClassData {
  _ClassDataImpl({
    int? id,
    _iv73j5oi.SpellSelectionFilterData? spellSelectionFilter,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hitDieValue,
    List<_iw3bk51e.Ability>? primaryAbilities,
    List<_iw3bk51e.Ability>? savingThrowProficiencies,
    List<_irzuusaf.ArmorCategory>? armorTraining,
    List<String>? weaponTraining,
    List<String>? toolTrainingKeys,
    List<_iqrhamom.Skill>? availableSkills,
    int? skillCount,
    int? subclassChoiceLevel,
    int? subclassChoiceFeatureId,
    _if4imcqg.SpellcastingProgression? spellcastingProgression,
    _iax70tek.ClassSpellSelectionMode? spellSelectionMode,
    _iw3bk51e.Ability? spellcastingAbilityValue,
    Map<String, int>? multiclassPrerequisites,
    List<_irzuusaf.ArmorCategory>? multiclassArmorTraining,
    List<String>? multiclassWeaponTraining,
    List<String>? multiclassToolTrainingKeys,
    String? imageURL,
  }) : super._(
         id: id,
         spellSelectionFilter: spellSelectionFilter,
         referenceKey: referenceKey,
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
         toolTrainingKeys: toolTrainingKeys,
         availableSkills: availableSkills,
         skillCount: skillCount,
         subclassChoiceLevel: subclassChoiceLevel,
         subclassChoiceFeatureId: subclassChoiceFeatureId,
         spellcastingProgression: spellcastingProgression,
         spellSelectionMode: spellSelectionMode,
         spellcastingAbilityValue: spellcastingAbilityValue,
         multiclassPrerequisites: multiclassPrerequisites,
         multiclassArmorTraining: multiclassArmorTraining,
         multiclassWeaponTraining: multiclassWeaponTraining,
         multiclassToolTrainingKeys: multiclassToolTrainingKeys,
         imageURL: imageURL,
       );

  /// Returns a shallow copy of this [ClassData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ClassData copyWith({
    Object? id = _Undefined,
    Object? spellSelectionFilter = _Undefined,
    Object? referenceKey = _Undefined,
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
    Object? toolTrainingKeys = _Undefined,
    Object? availableSkills = _Undefined,
    Object? skillCount = _Undefined,
    Object? subclassChoiceLevel = _Undefined,
    Object? subclassChoiceFeatureId = _Undefined,
    Object? spellcastingProgression = _Undefined,
    Object? spellSelectionMode = _Undefined,
    Object? spellcastingAbilityValue = _Undefined,
    Object? multiclassPrerequisites = _Undefined,
    Object? multiclassArmorTraining = _Undefined,
    Object? multiclassWeaponTraining = _Undefined,
    Object? multiclassToolTrainingKeys = _Undefined,
    Object? imageURL = _Undefined,
  }) {
    return ClassData(
      id: id is int? ? id : this.id,
      spellSelectionFilter:
          spellSelectionFilter is _iv73j5oi.SpellSelectionFilterData?
          ? spellSelectionFilter
          : this.spellSelectionFilter?.copyWith(),
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      hitDieValue: hitDieValue is int? ? hitDieValue : this.hitDieValue,
      primaryAbilities: primaryAbilities is List<_iw3bk51e.Ability>?
          ? primaryAbilities
          : this.primaryAbilities?.map((e0) => e0).toList(),
      savingThrowProficiencies:
          savingThrowProficiencies is List<_iw3bk51e.Ability>?
          ? savingThrowProficiencies
          : this.savingThrowProficiencies?.map((e0) => e0).toList(),
      armorTraining: armorTraining is List<_irzuusaf.ArmorCategory>?
          ? armorTraining
          : this.armorTraining?.map((e0) => e0).toList(),
      weaponTraining: weaponTraining is List<String>?
          ? weaponTraining
          : this.weaponTraining?.map((e0) => e0).toList(),
      toolTrainingKeys: toolTrainingKeys is List<String>?
          ? toolTrainingKeys
          : this.toolTrainingKeys?.map((e0) => e0).toList(),
      availableSkills: availableSkills is List<_iqrhamom.Skill>?
          ? availableSkills
          : this.availableSkills?.map((e0) => e0).toList(),
      skillCount: skillCount is int? ? skillCount : this.skillCount,
      subclassChoiceLevel: subclassChoiceLevel is int?
          ? subclassChoiceLevel
          : this.subclassChoiceLevel,
      subclassChoiceFeatureId: subclassChoiceFeatureId is int?
          ? subclassChoiceFeatureId
          : this.subclassChoiceFeatureId,
      spellcastingProgression:
          spellcastingProgression is _if4imcqg.SpellcastingProgression?
          ? spellcastingProgression
          : this.spellcastingProgression,
      spellSelectionMode:
          spellSelectionMode is _iax70tek.ClassSpellSelectionMode?
          ? spellSelectionMode
          : this.spellSelectionMode,
      spellcastingAbilityValue: spellcastingAbilityValue is _iw3bk51e.Ability?
          ? spellcastingAbilityValue
          : this.spellcastingAbilityValue,
      multiclassPrerequisites: multiclassPrerequisites is Map<String, int>?
          ? multiclassPrerequisites
          : this.multiclassPrerequisites?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      multiclassArmorTraining:
          multiclassArmorTraining is List<_irzuusaf.ArmorCategory>?
          ? multiclassArmorTraining
          : this.multiclassArmorTraining?.map((e0) => e0).toList(),
      multiclassWeaponTraining: multiclassWeaponTraining is List<String>?
          ? multiclassWeaponTraining
          : this.multiclassWeaponTraining?.map((e0) => e0).toList(),
      multiclassToolTrainingKeys: multiclassToolTrainingKeys is List<String>?
          ? multiclassToolTrainingKeys
          : this.multiclassToolTrainingKeys?.map((e0) => e0).toList(),
      imageURL: imageURL is String? ? imageURL : this.imageURL,
    );
  }
}

class ClassDataUpdateTable extends _is.UpdateTable<ClassDataTable> {
  ClassDataUpdateTable(super.table);

  _is.ColumnValue<
    _iv73j5oi.SpellSelectionFilterData,
    _iv73j5oi.SpellSelectionFilterData
  >
  spellSelectionFilter(_iv73j5oi.SpellSelectionFilterData? value) =>
      _is.ColumnValue(table.spellSelectionFilter, value);

  _is.ColumnValue<String, String> referenceKey(String? value) =>
      _is.ColumnValue(table.referenceKey, value);

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

  _is.ColumnValue<int, int> hitDieValue(int? value) =>
      _is.ColumnValue(table.hitDieValue, value);

  _is.ColumnValue<List<_iw3bk51e.Ability>, List<_iw3bk51e.Ability>>
  primaryAbilities(List<_iw3bk51e.Ability>? value) =>
      _is.ColumnValue(table.primaryAbilities, value);

  _is.ColumnValue<List<_iw3bk51e.Ability>, List<_iw3bk51e.Ability>>
  savingThrowProficiencies(List<_iw3bk51e.Ability>? value) =>
      _is.ColumnValue(table.savingThrowProficiencies, value);

  _is.ColumnValue<List<_irzuusaf.ArmorCategory>, List<_irzuusaf.ArmorCategory>>
  armorTraining(List<_irzuusaf.ArmorCategory>? value) =>
      _is.ColumnValue(table.armorTraining, value);

  _is.ColumnValue<List<String>, List<String>> weaponTraining(
    List<String>? value,
  ) => _is.ColumnValue(table.weaponTraining, value);

  _is.ColumnValue<List<String>, List<String>> toolTrainingKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.toolTrainingKeys, value);

  _is.ColumnValue<List<_iqrhamom.Skill>, List<_iqrhamom.Skill>> availableSkills(
    List<_iqrhamom.Skill>? value,
  ) => _is.ColumnValue(table.availableSkills, value);

  _is.ColumnValue<int, int> skillCount(int? value) =>
      _is.ColumnValue(table.skillCount, value);

  _is.ColumnValue<int, int> subclassChoiceLevel(int? value) =>
      _is.ColumnValue(table.subclassChoiceLevel, value);

  _is.ColumnValue<int, int> subclassChoiceFeatureId(int? value) =>
      _is.ColumnValue(table.subclassChoiceFeatureId, value);

  _is.ColumnValue<
    _if4imcqg.SpellcastingProgression,
    _if4imcqg.SpellcastingProgression
  >
  spellcastingProgression(_if4imcqg.SpellcastingProgression? value) =>
      _is.ColumnValue(table.spellcastingProgression, value);

  _is.ColumnValue<
    _iax70tek.ClassSpellSelectionMode,
    _iax70tek.ClassSpellSelectionMode
  >
  spellSelectionMode(_iax70tek.ClassSpellSelectionMode? value) =>
      _is.ColumnValue(table.spellSelectionMode, value);

  _is.ColumnValue<_iw3bk51e.Ability, _iw3bk51e.Ability>
  spellcastingAbilityValue(_iw3bk51e.Ability? value) =>
      _is.ColumnValue(table.spellcastingAbilityValue, value);

  _is.ColumnValue<Map<String, int>, Map<String, int>> multiclassPrerequisites(
    Map<String, int>? value,
  ) => _is.ColumnValue(table.multiclassPrerequisites, value);

  _is.ColumnValue<List<_irzuusaf.ArmorCategory>, List<_irzuusaf.ArmorCategory>>
  multiclassArmorTraining(List<_irzuusaf.ArmorCategory>? value) =>
      _is.ColumnValue(table.multiclassArmorTraining, value);

  _is.ColumnValue<List<String>, List<String>> multiclassWeaponTraining(
    List<String>? value,
  ) => _is.ColumnValue(table.multiclassWeaponTraining, value);

  _is.ColumnValue<List<String>, List<String>> multiclassToolTrainingKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.multiclassToolTrainingKeys, value);

  _is.ColumnValue<String, String> imageURL(String? value) =>
      _is.ColumnValue(table.imageURL, value);
}

class ClassDataTable extends _is.Table<int?> {
  ClassDataTable({super.tableRelation}) : super(tableName: 'class_data') {
    updateTable = ClassDataUpdateTable(this);
    spellSelectionFilter =
        _is.ColumnSerializable<_iv73j5oi.SpellSelectionFilterData>(
          'spellSelectionFilter',
          this,
        );
    referenceKey = _is.ColumnString('referenceKey', this);
    name = _is.ColumnString('name', this);
    description = _is.ColumnString('description', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    hitDieValue = _is.ColumnInt('hitDieValue', this);
    primaryAbilities = _is.ColumnSerializable<List<_iw3bk51e.Ability>>(
      'primaryAbilities',
      this,
    );
    savingThrowProficiencies = _is.ColumnSerializable<List<_iw3bk51e.Ability>>(
      'savingThrowProficiencies',
      this,
    );
    armorTraining = _is.ColumnSerializable<List<_irzuusaf.ArmorCategory>>(
      'armorTraining',
      this,
    );
    weaponTraining = _is.ColumnSerializable<List<String>>(
      'weaponTraining',
      this,
    );
    toolTrainingKeys = _is.ColumnSerializable<List<String>>(
      'toolTrainingKeys',
      this,
    );
    availableSkills = _is.ColumnSerializable<List<_iqrhamom.Skill>>(
      'availableSkills',
      this,
    );
    skillCount = _is.ColumnInt('skillCount', this);
    subclassChoiceLevel = _is.ColumnInt('subclassChoiceLevel', this);
    subclassChoiceFeatureId = _is.ColumnInt('subclassChoiceFeatureId', this);
    spellcastingProgression = _is.ColumnEnum(
      'spellcastingProgression',
      this,
      _is.EnumSerialization.byName,
    );
    spellSelectionMode = _is.ColumnEnum(
      'spellSelectionMode',
      this,
      _is.EnumSerialization.byName,
    );
    spellcastingAbilityValue = _is.ColumnEnum(
      'spellcastingAbilityValue',
      this,
      _is.EnumSerialization.byName,
    );
    multiclassPrerequisites = _is.ColumnSerializable<Map<String, int>>(
      'multiclassPrerequisites',
      this,
    );
    multiclassArmorTraining =
        _is.ColumnSerializable<List<_irzuusaf.ArmorCategory>>(
          'multiclassArmorTraining',
          this,
        );
    multiclassWeaponTraining = _is.ColumnSerializable<List<String>>(
      'multiclassWeaponTraining',
      this,
    );
    multiclassToolTrainingKeys = _is.ColumnSerializable<List<String>>(
      'multiclassToolTrainingKeys',
      this,
    );
    imageURL = _is.ColumnString('imageURL', this);
  }

  late final ClassDataUpdateTable updateTable;

  late final _is.ColumnSerializable<_iv73j5oi.SpellSelectionFilterData>
  spellSelectionFilter;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnInt hitDieValue;

  late final _is.ColumnSerializable<List<_iw3bk51e.Ability>> primaryAbilities;

  late final _is.ColumnSerializable<List<_iw3bk51e.Ability>>
  savingThrowProficiencies;

  late final _is.ColumnSerializable<List<_irzuusaf.ArmorCategory>>
  armorTraining;

  late final _is.ColumnSerializable<List<String>> weaponTraining;

  late final _is.ColumnSerializable<List<String>> toolTrainingKeys;

  late final _is.ColumnSerializable<List<_iqrhamom.Skill>> availableSkills;

  late final _is.ColumnInt skillCount;

  late final _is.ColumnInt subclassChoiceLevel;

  late final _is.ColumnInt subclassChoiceFeatureId;

  late final _is.ColumnEnum<_if4imcqg.SpellcastingProgression>
  spellcastingProgression;

  late final _is.ColumnEnum<_iax70tek.ClassSpellSelectionMode>
  spellSelectionMode;

  late final _is.ColumnEnum<_iw3bk51e.Ability> spellcastingAbilityValue;

  late final _is.ColumnSerializable<Map<String, int>> multiclassPrerequisites;

  late final _is.ColumnSerializable<List<_irzuusaf.ArmorCategory>>
  multiclassArmorTraining;

  late final _is.ColumnSerializable<List<String>> multiclassWeaponTraining;

  late final _is.ColumnSerializable<List<String>> multiclassToolTrainingKeys;

  late final _is.ColumnString imageURL;

  @override
  List<_is.Column> get columns => [
    id,
    spellSelectionFilter,
    referenceKey,
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
    toolTrainingKeys,
    availableSkills,
    skillCount,
    subclassChoiceLevel,
    subclassChoiceFeatureId,
    spellcastingProgression,
    spellSelectionMode,
    spellcastingAbilityValue,
    multiclassPrerequisites,
    multiclassArmorTraining,
    multiclassWeaponTraining,
    multiclassToolTrainingKeys,
    imageURL,
  ];
}

class ClassDataInclude extends _is.IncludeObject {
  ClassDataInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ClassData.t;
}

class ClassDataIncludeList extends _is.IncludeList {
  ClassDataIncludeList._({
    _is.WhereExpressionBuilder<ClassDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClassData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ClassData.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClassDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClassDataTable>? orderBy,
    _is.OrderByListBuilder<ClassDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ClassData>(
      where: where?.call(ClassData.t),
      orderBy: orderBy?.call(ClassData.t),
      orderByList: orderByList?.call(ClassData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClassDataTable>? where,
    int? offset,
    _is.OrderByBuilder<ClassDataTable>? orderBy,
    _is.OrderByListBuilder<ClassDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ClassData>(
      where: where?.call(ClassData.t),
      orderBy: orderBy?.call(ClassData.t),
      orderByList: orderByList?.call(ClassData.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ClassData] by its [id] or null if no such row exists.
  Future<ClassData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ClassData>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ClassData]s in the list and returns the inserted rows.
  ///
  /// The returned [ClassData]s will have their `id` fields set.
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
  Future<List<ClassData>> insert(
    _is.DatabaseSession session,
    List<ClassData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ClassData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ClassData] and returns the inserted row.
  ///
  /// The returned [ClassData] will have its `id` field set.
  Future<ClassData> insertRow(
    _is.DatabaseSession session,
    ClassData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClassData>(row, transaction: transaction);
  }

  /// Upserts all [ClassData]s in the list and returns the resulting rows.
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
  /// The returned [ClassData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassData>> upsert(
    _is.DatabaseSession session,
    List<ClassData> rows, {
    required _is.ColumnSelections<ClassDataTable> conflictColumns,
    _is.ColumnSelections<ClassDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ClassDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ClassData>(
      rows,
      conflictColumns: conflictColumns(ClassData.t),
      updateColumns: updateColumns?.call(ClassData.t),
      updateWhere: updateWhere?.call(ClassData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ClassData] and returns the resulting row.
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
  /// The returned [ClassData] will have its `id` field set.
  Future<ClassData?> upsertRow(
    _is.DatabaseSession session,
    ClassData row, {
    required _is.ColumnSelections<ClassDataTable> conflictColumns,
    _is.ColumnSelections<ClassDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ClassDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ClassData>(
      row,
      conflictColumns: conflictColumns(ClassData.t),
      updateColumns: updateColumns?.call(ClassData.t),
      updateWhere: updateWhere?.call(ClassData.t),
      transaction: transaction,
    );
  }

  /// Updates all [ClassData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassData>> update(
    _is.DatabaseSession session,
    List<ClassData> rows, {
    _is.ColumnSelections<ClassDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ClassData>(
      rows,
      columns: columns?.call(ClassData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ClassData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClassData> updateRow(
    _is.DatabaseSession session,
    ClassData row, {
    _is.ColumnSelections<ClassDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClassData>(
      row,
      columns: columns?.call(ClassData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClassData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ClassData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ClassDataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ClassData>(
      id,
      columnValues: columnValues(ClassData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ClassData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ClassDataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ClassDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClassDataTable>? orderBy,
    _is.OrderByListBuilder<ClassDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ClassData>(
      columnValues: columnValues(ClassData.t.updateTable),
      where: where(ClassData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassData.t),
      orderByList: orderByList?.call(ClassData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ClassData]s in the list and returns the deleted rows.
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
  Future<List<ClassData>> delete(
    _is.DatabaseSession session,
    List<ClassData> rows, {
    _is.OrderByBuilder<ClassDataTable>? orderBy,
    _is.OrderByListBuilder<ClassDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ClassData>(
      rows,
      orderBy: orderBy?.call(ClassData.t),
      orderByList: orderByList?.call(ClassData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ClassData].
  Future<ClassData> deleteRow(
    _is.DatabaseSession session,
    ClassData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClassData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClassDataTable> where,
    _is.OrderByBuilder<ClassDataTable>? orderBy,
    _is.OrderByListBuilder<ClassDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ClassData>(
      where: where(ClassData.t),
      orderBy: orderBy?.call(ClassData.t),
      orderByList: orderByList?.call(ClassData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClassDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ClassData>(
      where: where?.call(ClassData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ClassData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClassDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ClassData>(
      where: where(ClassData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
