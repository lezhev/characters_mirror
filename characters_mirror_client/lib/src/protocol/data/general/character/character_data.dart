/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../../data/general/race/race_data.dart' as _i2;
import '../../../data/general/subrace_data.dart' as _i3;
import '../../../data/general/class/class_data.dart' as _i4;
import '../../../data/general/class/subclass_data.dart' as _i5;
import '../../../data/general/class/class_feature_data.dart' as _i6;
import '../../../data/general/class/class_option_data.dart' as _i7;
import '../../../data/background_data.dart' as _i8;
import '../../../data/spell_data.dart' as _i9;
import '../../../data/items/item_data.dart' as _i10;
import '../../../data/items/magic_item_data.dart' as _i11;
import '../../../data/items/armor_data.dart' as _i12;
import '../../../data/items/weapon_data.dart' as _i13;

abstract class CharacterData implements _i1.SerializableModel {
  CharacterData._({
    this.id,
    this.name,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.experience,
    this.attributes,
    this.raceId,
    this.race,
    this.subraceId,
    this.subrace,
    this.classes,
    this.subclassId,
    this.subclass,
    this.classFeatures,
    this.variantOptions,
    this.backgroundId,
    this.background,
    this.alignment,
    this.armorClass,
    this.speed,
    this.coins,
    this.skillProficiencies,
    this.skillExpertises,
    this.maxHp,
    this.temporaryHp,
    this.currentHp,
    this.preparedSpells,
    this.writtenSpells,
    this.items,
    this.magicItems,
    this.armor,
    this.weapons,
  });

  factory CharacterData({
    int? id,
    String? name,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? experience,
    Map<String, int>? attributes,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    List<_i4.ClassData>? classes,
    int? subclassId,
    _i5.SubclassData? subclass,
    List<_i6.ClassFeatureData>? classFeatures,
    List<_i7.ClassOptionData>? variantOptions,
    int? backgroundId,
    _i8.BackgroundData? background,
    String? alignment,
    int? armorClass,
    int? speed,
    int? coins,
    List<String>? skillProficiencies,
    List<String>? skillExpertises,
    int? maxHp,
    int? temporaryHp,
    int? currentHp,
    List<_i9.SpellData>? preparedSpells,
    List<_i9.SpellData>? writtenSpells,
    List<_i10.ItemData>? items,
    List<_i11.MagicItemData>? magicItems,
    List<_i12.ArmorData>? armor,
    List<_i13.WeaponData>? weapons,
  }) = _CharacterDataImpl;

  factory CharacterData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      experience: jsonSerialization['experience'] as int?,
      attributes:
          (jsonSerialization['attributes'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      raceId: jsonSerialization['raceId'] as int?,
      race: jsonSerialization['race'] == null
          ? null
          : _i2.RaceData.fromJson(
              (jsonSerialization['race'] as Map<String, dynamic>)),
      subraceId: jsonSerialization['subraceId'] as int?,
      subrace: jsonSerialization['subrace'] == null
          ? null
          : _i3.SubraceData.fromJson(
              (jsonSerialization['subrace'] as Map<String, dynamic>)),
      classes: (jsonSerialization['classes'] as List?)
          ?.map((e) => _i4.ClassData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      subclassId: jsonSerialization['subclassId'] as int?,
      subclass: jsonSerialization['subclass'] == null
          ? null
          : _i5.SubclassData.fromJson(
              (jsonSerialization['subclass'] as Map<String, dynamic>)),
      classFeatures: (jsonSerialization['classFeatures'] as List?)
          ?.map(
              (e) => _i6.ClassFeatureData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      variantOptions: (jsonSerialization['variantOptions'] as List?)
          ?.map(
              (e) => _i7.ClassOptionData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      backgroundId: jsonSerialization['backgroundId'] as int?,
      background: jsonSerialization['background'] == null
          ? null
          : _i8.BackgroundData.fromJson(
              (jsonSerialization['background'] as Map<String, dynamic>)),
      alignment: jsonSerialization['alignment'] as String?,
      armorClass: jsonSerialization['armorClass'] as int?,
      speed: jsonSerialization['speed'] as int?,
      coins: jsonSerialization['coins'] as int?,
      skillProficiencies: (jsonSerialization['skillProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      skillExpertises: (jsonSerialization['skillExpertises'] as List?)
          ?.map((e) => e as String)
          .toList(),
      maxHp: jsonSerialization['maxHp'] as int?,
      temporaryHp: jsonSerialization['temporaryHp'] as int?,
      currentHp: jsonSerialization['currentHp'] as int?,
      preparedSpells: (jsonSerialization['preparedSpells'] as List?)
          ?.map((e) => _i9.SpellData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      writtenSpells: (jsonSerialization['writtenSpells'] as List?)
          ?.map((e) => _i9.SpellData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      items: (jsonSerialization['items'] as List?)
          ?.map((e) => _i10.ItemData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      magicItems: (jsonSerialization['magicItems'] as List?)
          ?.map((e) => _i11.MagicItemData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      armor: (jsonSerialization['armor'] as List?)
          ?.map((e) => _i12.ArmorData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      weapons: (jsonSerialization['weapons'] as List?)
          ?.map((e) => _i13.WeaponData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? name;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? experience;

  Map<String, int>? attributes;

  int? raceId;

  _i2.RaceData? race;

  int? subraceId;

  _i3.SubraceData? subrace;

  List<_i4.ClassData>? classes;

  int? subclassId;

  _i5.SubclassData? subclass;

  List<_i6.ClassFeatureData>? classFeatures;

  List<_i7.ClassOptionData>? variantOptions;

  int? backgroundId;

  _i8.BackgroundData? background;

  String? alignment;

  int? armorClass;

  int? speed;

  int? coins;

  List<String>? skillProficiencies;

  List<String>? skillExpertises;

  int? maxHp;

  int? temporaryHp;

  int? currentHp;

  List<_i9.SpellData>? preparedSpells;

  List<_i9.SpellData>? writtenSpells;

  List<_i10.ItemData>? items;

  List<_i11.MagicItemData>? magicItems;

  List<_i12.ArmorData>? armor;

  List<_i13.WeaponData>? weapons;

  /// Returns a shallow copy of this [CharacterData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterData copyWith({
    int? id,
    String? name,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? experience,
    Map<String, int>? attributes,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    List<_i4.ClassData>? classes,
    int? subclassId,
    _i5.SubclassData? subclass,
    List<_i6.ClassFeatureData>? classFeatures,
    List<_i7.ClassOptionData>? variantOptions,
    int? backgroundId,
    _i8.BackgroundData? background,
    String? alignment,
    int? armorClass,
    int? speed,
    int? coins,
    List<String>? skillProficiencies,
    List<String>? skillExpertises,
    int? maxHp,
    int? temporaryHp,
    int? currentHp,
    List<_i9.SpellData>? preparedSpells,
    List<_i9.SpellData>? writtenSpells,
    List<_i10.ItemData>? items,
    List<_i11.MagicItemData>? magicItems,
    List<_i12.ArmorData>? armor,
    List<_i13.WeaponData>? weapons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (experience != null) 'experience': experience,
      if (attributes != null) 'attributes': attributes?.toJson(),
      if (raceId != null) 'raceId': raceId,
      if (race != null) 'race': race?.toJson(),
      if (subraceId != null) 'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJson(),
      if (classes != null)
        'classes': classes?.toJson(valueToJson: (v) => v.toJson()),
      if (subclassId != null) 'subclassId': subclassId,
      if (subclass != null) 'subclass': subclass?.toJson(),
      if (classFeatures != null)
        'classFeatures': classFeatures?.toJson(valueToJson: (v) => v.toJson()),
      if (variantOptions != null)
        'variantOptions':
            variantOptions?.toJson(valueToJson: (v) => v.toJson()),
      if (backgroundId != null) 'backgroundId': backgroundId,
      if (background != null) 'background': background?.toJson(),
      if (alignment != null) 'alignment': alignment,
      if (armorClass != null) 'armorClass': armorClass,
      if (speed != null) 'speed': speed,
      if (coins != null) 'coins': coins,
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (skillExpertises != null) 'skillExpertises': skillExpertises?.toJson(),
      if (maxHp != null) 'maxHp': maxHp,
      if (temporaryHp != null) 'temporaryHp': temporaryHp,
      if (currentHp != null) 'currentHp': currentHp,
      if (preparedSpells != null)
        'preparedSpells':
            preparedSpells?.toJson(valueToJson: (v) => v.toJson()),
      if (writtenSpells != null)
        'writtenSpells': writtenSpells?.toJson(valueToJson: (v) => v.toJson()),
      if (items != null) 'items': items?.toJson(valueToJson: (v) => v.toJson()),
      if (magicItems != null)
        'magicItems': magicItems?.toJson(valueToJson: (v) => v.toJson()),
      if (armor != null) 'armor': armor?.toJson(valueToJson: (v) => v.toJson()),
      if (weapons != null)
        'weapons': weapons?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterDataImpl extends CharacterData {
  _CharacterDataImpl({
    int? id,
    String? name,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? experience,
    Map<String, int>? attributes,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    List<_i4.ClassData>? classes,
    int? subclassId,
    _i5.SubclassData? subclass,
    List<_i6.ClassFeatureData>? classFeatures,
    List<_i7.ClassOptionData>? variantOptions,
    int? backgroundId,
    _i8.BackgroundData? background,
    String? alignment,
    int? armorClass,
    int? speed,
    int? coins,
    List<String>? skillProficiencies,
    List<String>? skillExpertises,
    int? maxHp,
    int? temporaryHp,
    int? currentHp,
    List<_i9.SpellData>? preparedSpells,
    List<_i9.SpellData>? writtenSpells,
    List<_i10.ItemData>? items,
    List<_i11.MagicItemData>? magicItems,
    List<_i12.ArmorData>? armor,
    List<_i13.WeaponData>? weapons,
  }) : super._(
          id: id,
          name: name,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          experience: experience,
          attributes: attributes,
          raceId: raceId,
          race: race,
          subraceId: subraceId,
          subrace: subrace,
          classes: classes,
          subclassId: subclassId,
          subclass: subclass,
          classFeatures: classFeatures,
          variantOptions: variantOptions,
          backgroundId: backgroundId,
          background: background,
          alignment: alignment,
          armorClass: armorClass,
          speed: speed,
          coins: coins,
          skillProficiencies: skillProficiencies,
          skillExpertises: skillExpertises,
          maxHp: maxHp,
          temporaryHp: temporaryHp,
          currentHp: currentHp,
          preparedSpells: preparedSpells,
          writtenSpells: writtenSpells,
          items: items,
          magicItems: magicItems,
          armor: armor,
          weapons: weapons,
        );

  /// Returns a shallow copy of this [CharacterData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? experience = _Undefined,
    Object? attributes = _Undefined,
    Object? raceId = _Undefined,
    Object? race = _Undefined,
    Object? subraceId = _Undefined,
    Object? subrace = _Undefined,
    Object? classes = _Undefined,
    Object? subclassId = _Undefined,
    Object? subclass = _Undefined,
    Object? classFeatures = _Undefined,
    Object? variantOptions = _Undefined,
    Object? backgroundId = _Undefined,
    Object? background = _Undefined,
    Object? alignment = _Undefined,
    Object? armorClass = _Undefined,
    Object? speed = _Undefined,
    Object? coins = _Undefined,
    Object? skillProficiencies = _Undefined,
    Object? skillExpertises = _Undefined,
    Object? maxHp = _Undefined,
    Object? temporaryHp = _Undefined,
    Object? currentHp = _Undefined,
    Object? preparedSpells = _Undefined,
    Object? writtenSpells = _Undefined,
    Object? items = _Undefined,
    Object? magicItems = _Undefined,
    Object? armor = _Undefined,
    Object? weapons = _Undefined,
  }) {
    return CharacterData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      experience: experience is int? ? experience : this.experience,
      attributes: attributes is Map<String, int>?
          ? attributes
          : this.attributes?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      raceId: raceId is int? ? raceId : this.raceId,
      race: race is _i2.RaceData? ? race : this.race?.copyWith(),
      subraceId: subraceId is int? ? subraceId : this.subraceId,
      subrace: subrace is _i3.SubraceData? ? subrace : this.subrace?.copyWith(),
      classes: classes is List<_i4.ClassData>?
          ? classes
          : this.classes?.map((e0) => e0.copyWith()).toList(),
      subclassId: subclassId is int? ? subclassId : this.subclassId,
      subclass:
          subclass is _i5.SubclassData? ? subclass : this.subclass?.copyWith(),
      classFeatures: classFeatures is List<_i6.ClassFeatureData>?
          ? classFeatures
          : this.classFeatures?.map((e0) => e0.copyWith()).toList(),
      variantOptions: variantOptions is List<_i7.ClassOptionData>?
          ? variantOptions
          : this.variantOptions?.map((e0) => e0.copyWith()).toList(),
      backgroundId: backgroundId is int? ? backgroundId : this.backgroundId,
      background: background is _i8.BackgroundData?
          ? background
          : this.background?.copyWith(),
      alignment: alignment is String? ? alignment : this.alignment,
      armorClass: armorClass is int? ? armorClass : this.armorClass,
      speed: speed is int? ? speed : this.speed,
      coins: coins is int? ? coins : this.coins,
      skillProficiencies: skillProficiencies is List<String>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      skillExpertises: skillExpertises is List<String>?
          ? skillExpertises
          : this.skillExpertises?.map((e0) => e0).toList(),
      maxHp: maxHp is int? ? maxHp : this.maxHp,
      temporaryHp: temporaryHp is int? ? temporaryHp : this.temporaryHp,
      currentHp: currentHp is int? ? currentHp : this.currentHp,
      preparedSpells: preparedSpells is List<_i9.SpellData>?
          ? preparedSpells
          : this.preparedSpells?.map((e0) => e0.copyWith()).toList(),
      writtenSpells: writtenSpells is List<_i9.SpellData>?
          ? writtenSpells
          : this.writtenSpells?.map((e0) => e0.copyWith()).toList(),
      items: items is List<_i10.ItemData>?
          ? items
          : this.items?.map((e0) => e0.copyWith()).toList(),
      magicItems: magicItems is List<_i11.MagicItemData>?
          ? magicItems
          : this.magicItems?.map((e0) => e0.copyWith()).toList(),
      armor: armor is List<_i12.ArmorData>?
          ? armor
          : this.armor?.map((e0) => e0.copyWith()).toList(),
      weapons: weapons is List<_i13.WeaponData>?
          ? weapons
          : this.weapons?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
