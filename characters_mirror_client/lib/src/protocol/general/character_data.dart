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
import '../general/race_data.dart' as _i2;
import '../general/subrace_data.dart' as _i3;
import '../general/class_data.dart' as _i4;
import '../general/subclass_data.dart' as _i5;
import '../general/class_feature_data.dart' as _i6;
import '../background_data.dart' as _i7;
import '../spell_data.dart' as _i8;
import '../items/item_data.dart' as _i9;
import '../items/magic_item_data.dart' as _i10;
import '../items/armor_data.dart' as _i11;
import '../items/weapon_data.dart' as _i12;

abstract class CharacterData implements _i1.SerializableModel {
  CharacterData._({
    this.id,
    this.name,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.experience,
    this.attributes,
    required this.raceId,
    this.race,
    required this.subraceId,
    this.subrace,
    this.classes,
    this.subclasses,
    this.classFeatures,
    required this.backgroundId,
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
    required this.preparedSpellsId,
    this.preparedSpells,
    required this.writtenSpellsId,
    this.writtenSpells,
    required this.itemsId,
    this.items,
    required this.magicItemsId,
    this.magicItems,
    required this.armorId,
    this.armor,
    required this.weaponsId,
    this.weapons,
  });

  factory CharacterData({
    int? id,
    String? name,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? experience,
    Map<String, int>? attributes,
    required int raceId,
    _i2.RaceData? race,
    required int subraceId,
    _i3.SubraceData? subrace,
    List<_i4.ClassData>? classes,
    List<_i5.SubclassData>? subclasses,
    List<_i6.ClassFeatureData>? classFeatures,
    required int backgroundId,
    _i7.BackgroundData? background,
    String? alignment,
    int? armorClass,
    int? speed,
    int? coins,
    List<String>? skillProficiencies,
    List<String>? skillExpertises,
    int? maxHp,
    int? temporaryHp,
    int? currentHp,
    required int preparedSpellsId,
    _i8.SpellData? preparedSpells,
    required int writtenSpellsId,
    _i8.SpellData? writtenSpells,
    required int itemsId,
    _i9.ItemData? items,
    required int magicItemsId,
    _i10.MagicItemData? magicItems,
    required int armorId,
    _i11.ArmorData? armor,
    required int weaponsId,
    _i12.WeaponData? weapons,
  }) = _CharacterDataImpl;

  factory CharacterData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      source: jsonSerialization['source'] as String?,
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
      raceId: jsonSerialization['raceId'] as int,
      race: jsonSerialization['race'] == null
          ? null
          : _i2.RaceData.fromJson(
              (jsonSerialization['race'] as Map<String, dynamic>)),
      subraceId: jsonSerialization['subraceId'] as int,
      subrace: jsonSerialization['subrace'] == null
          ? null
          : _i3.SubraceData.fromJson(
              (jsonSerialization['subrace'] as Map<String, dynamic>)),
      classes: (jsonSerialization['classes'] as List?)
          ?.map((e) => _i4.ClassData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      subclasses: (jsonSerialization['subclasses'] as List?)
          ?.map((e) => _i5.SubclassData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      classFeatures: (jsonSerialization['classFeatures'] as List?)
          ?.map(
              (e) => _i6.ClassFeatureData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      backgroundId: jsonSerialization['backgroundId'] as int,
      background: jsonSerialization['background'] == null
          ? null
          : _i7.BackgroundData.fromJson(
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
      preparedSpellsId: jsonSerialization['preparedSpellsId'] as int,
      preparedSpells: jsonSerialization['preparedSpells'] == null
          ? null
          : _i8.SpellData.fromJson(
              (jsonSerialization['preparedSpells'] as Map<String, dynamic>)),
      writtenSpellsId: jsonSerialization['writtenSpellsId'] as int,
      writtenSpells: jsonSerialization['writtenSpells'] == null
          ? null
          : _i8.SpellData.fromJson(
              (jsonSerialization['writtenSpells'] as Map<String, dynamic>)),
      itemsId: jsonSerialization['itemsId'] as int,
      items: jsonSerialization['items'] == null
          ? null
          : _i9.ItemData.fromJson(
              (jsonSerialization['items'] as Map<String, dynamic>)),
      magicItemsId: jsonSerialization['magicItemsId'] as int,
      magicItems: jsonSerialization['magicItems'] == null
          ? null
          : _i10.MagicItemData.fromJson(
              (jsonSerialization['magicItems'] as Map<String, dynamic>)),
      armorId: jsonSerialization['armorId'] as int,
      armor: jsonSerialization['armor'] == null
          ? null
          : _i11.ArmorData.fromJson(
              (jsonSerialization['armor'] as Map<String, dynamic>)),
      weaponsId: jsonSerialization['weaponsId'] as int,
      weapons: jsonSerialization['weapons'] == null
          ? null
          : _i12.WeaponData.fromJson(
              (jsonSerialization['weapons'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? name;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? experience;

  Map<String, int>? attributes;

  int raceId;

  _i2.RaceData? race;

  int subraceId;

  _i3.SubraceData? subrace;

  List<_i4.ClassData>? classes;

  List<_i5.SubclassData>? subclasses;

  List<_i6.ClassFeatureData>? classFeatures;

  int backgroundId;

  _i7.BackgroundData? background;

  String? alignment;

  int? armorClass;

  int? speed;

  int? coins;

  List<String>? skillProficiencies;

  List<String>? skillExpertises;

  int? maxHp;

  int? temporaryHp;

  int? currentHp;

  int preparedSpellsId;

  _i8.SpellData? preparedSpells;

  int writtenSpellsId;

  _i8.SpellData? writtenSpells;

  int itemsId;

  _i9.ItemData? items;

  int magicItemsId;

  _i10.MagicItemData? magicItems;

  int armorId;

  _i11.ArmorData? armor;

  int weaponsId;

  _i12.WeaponData? weapons;

  /// Returns a shallow copy of this [CharacterData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterData copyWith({
    int? id,
    String? name,
    String? source,
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
    List<_i5.SubclassData>? subclasses,
    List<_i6.ClassFeatureData>? classFeatures,
    int? backgroundId,
    _i7.BackgroundData? background,
    String? alignment,
    int? armorClass,
    int? speed,
    int? coins,
    List<String>? skillProficiencies,
    List<String>? skillExpertises,
    int? maxHp,
    int? temporaryHp,
    int? currentHp,
    int? preparedSpellsId,
    _i8.SpellData? preparedSpells,
    int? writtenSpellsId,
    _i8.SpellData? writtenSpells,
    int? itemsId,
    _i9.ItemData? items,
    int? magicItemsId,
    _i10.MagicItemData? magicItems,
    int? armorId,
    _i11.ArmorData? armor,
    int? weaponsId,
    _i12.WeaponData? weapons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (experience != null) 'experience': experience,
      if (attributes != null) 'attributes': attributes?.toJson(),
      'raceId': raceId,
      if (race != null) 'race': race?.toJson(),
      'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJson(),
      if (classes != null)
        'classes': classes?.toJson(valueToJson: (v) => v.toJson()),
      if (subclasses != null)
        'subclasses': subclasses?.toJson(valueToJson: (v) => v.toJson()),
      if (classFeatures != null)
        'classFeatures': classFeatures?.toJson(valueToJson: (v) => v.toJson()),
      'backgroundId': backgroundId,
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
      'preparedSpellsId': preparedSpellsId,
      if (preparedSpells != null) 'preparedSpells': preparedSpells?.toJson(),
      'writtenSpellsId': writtenSpellsId,
      if (writtenSpells != null) 'writtenSpells': writtenSpells?.toJson(),
      'itemsId': itemsId,
      if (items != null) 'items': items?.toJson(),
      'magicItemsId': magicItemsId,
      if (magicItems != null) 'magicItems': magicItems?.toJson(),
      'armorId': armorId,
      if (armor != null) 'armor': armor?.toJson(),
      'weaponsId': weaponsId,
      if (weapons != null) 'weapons': weapons?.toJson(),
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
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? experience,
    Map<String, int>? attributes,
    required int raceId,
    _i2.RaceData? race,
    required int subraceId,
    _i3.SubraceData? subrace,
    List<_i4.ClassData>? classes,
    List<_i5.SubclassData>? subclasses,
    List<_i6.ClassFeatureData>? classFeatures,
    required int backgroundId,
    _i7.BackgroundData? background,
    String? alignment,
    int? armorClass,
    int? speed,
    int? coins,
    List<String>? skillProficiencies,
    List<String>? skillExpertises,
    int? maxHp,
    int? temporaryHp,
    int? currentHp,
    required int preparedSpellsId,
    _i8.SpellData? preparedSpells,
    required int writtenSpellsId,
    _i8.SpellData? writtenSpells,
    required int itemsId,
    _i9.ItemData? items,
    required int magicItemsId,
    _i10.MagicItemData? magicItems,
    required int armorId,
    _i11.ArmorData? armor,
    required int weaponsId,
    _i12.WeaponData? weapons,
  }) : super._(
          id: id,
          name: name,
          source: source,
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
          subclasses: subclasses,
          classFeatures: classFeatures,
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
          preparedSpellsId: preparedSpellsId,
          preparedSpells: preparedSpells,
          writtenSpellsId: writtenSpellsId,
          writtenSpells: writtenSpells,
          itemsId: itemsId,
          items: items,
          magicItemsId: magicItemsId,
          magicItems: magicItems,
          armorId: armorId,
          armor: armor,
          weaponsId: weaponsId,
          weapons: weapons,
        );

  /// Returns a shallow copy of this [CharacterData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? experience = _Undefined,
    Object? attributes = _Undefined,
    int? raceId,
    Object? race = _Undefined,
    int? subraceId,
    Object? subrace = _Undefined,
    Object? classes = _Undefined,
    Object? subclasses = _Undefined,
    Object? classFeatures = _Undefined,
    int? backgroundId,
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
    int? preparedSpellsId,
    Object? preparedSpells = _Undefined,
    int? writtenSpellsId,
    Object? writtenSpells = _Undefined,
    int? itemsId,
    Object? items = _Undefined,
    int? magicItemsId,
    Object? magicItems = _Undefined,
    int? armorId,
    Object? armor = _Undefined,
    int? weaponsId,
    Object? weapons = _Undefined,
  }) {
    return CharacterData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      source: source is String? ? source : this.source,
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
      raceId: raceId ?? this.raceId,
      race: race is _i2.RaceData? ? race : this.race?.copyWith(),
      subraceId: subraceId ?? this.subraceId,
      subrace: subrace is _i3.SubraceData? ? subrace : this.subrace?.copyWith(),
      classes: classes is List<_i4.ClassData>?
          ? classes
          : this.classes?.map((e0) => e0.copyWith()).toList(),
      subclasses: subclasses is List<_i5.SubclassData>?
          ? subclasses
          : this.subclasses?.map((e0) => e0.copyWith()).toList(),
      classFeatures: classFeatures is List<_i6.ClassFeatureData>?
          ? classFeatures
          : this.classFeatures?.map((e0) => e0.copyWith()).toList(),
      backgroundId: backgroundId ?? this.backgroundId,
      background: background is _i7.BackgroundData?
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
      preparedSpellsId: preparedSpellsId ?? this.preparedSpellsId,
      preparedSpells: preparedSpells is _i8.SpellData?
          ? preparedSpells
          : this.preparedSpells?.copyWith(),
      writtenSpellsId: writtenSpellsId ?? this.writtenSpellsId,
      writtenSpells: writtenSpells is _i8.SpellData?
          ? writtenSpells
          : this.writtenSpells?.copyWith(),
      itemsId: itemsId ?? this.itemsId,
      items: items is _i9.ItemData? ? items : this.items?.copyWith(),
      magicItemsId: magicItemsId ?? this.magicItemsId,
      magicItems: magicItems is _i10.MagicItemData?
          ? magicItems
          : this.magicItems?.copyWith(),
      armorId: armorId ?? this.armorId,
      armor: armor is _i11.ArmorData? ? armor : this.armor?.copyWith(),
      weaponsId: weaponsId ?? this.weaponsId,
      weapons: weapons is _i12.WeaponData? ? weapons : this.weapons?.copyWith(),
    );
  }
}
