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
import '../../../data/general/race_data.dart' as _i2;
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

abstract class CharacterData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = CharacterDataTable();

  static const db = CharacterDataRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (experience != null) 'experience': experience,
      if (attributes != null) 'attributes': attributes?.toJson(),
      if (raceId != null) 'raceId': raceId,
      if (race != null) 'race': race?.toJsonForProtocol(),
      if (subraceId != null) 'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJsonForProtocol(),
      if (classes != null)
        'classes': classes?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (subclassId != null) 'subclassId': subclassId,
      if (subclass != null) 'subclass': subclass?.toJsonForProtocol(),
      if (classFeatures != null)
        'classFeatures':
            classFeatures?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (variantOptions != null)
        'variantOptions':
            variantOptions?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (backgroundId != null) 'backgroundId': backgroundId,
      if (background != null) 'background': background?.toJsonForProtocol(),
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
            preparedSpells?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (writtenSpells != null)
        'writtenSpells':
            writtenSpells?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (items != null)
        'items': items?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (magicItems != null)
        'magicItems':
            magicItems?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (armor != null)
        'armor': armor?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (weapons != null)
        'weapons': weapons?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static CharacterDataInclude include({
    _i2.RaceDataInclude? race,
    _i3.SubraceDataInclude? subrace,
    _i4.ClassDataIncludeList? classes,
    _i5.SubclassDataInclude? subclass,
    _i6.ClassFeatureDataIncludeList? classFeatures,
    _i7.ClassOptionDataIncludeList? variantOptions,
    _i8.BackgroundDataInclude? background,
    _i9.SpellDataIncludeList? preparedSpells,
    _i9.SpellDataIncludeList? writtenSpells,
    _i10.ItemDataIncludeList? items,
    _i11.MagicItemDataIncludeList? magicItems,
    _i12.ArmorDataIncludeList? armor,
    _i13.WeaponDataIncludeList? weapons,
  }) {
    return CharacterDataInclude._(
      race: race,
      subrace: subrace,
      classes: classes,
      subclass: subclass,
      classFeatures: classFeatures,
      variantOptions: variantOptions,
      background: background,
      preparedSpells: preparedSpells,
      writtenSpells: writtenSpells,
      items: items,
      magicItems: magicItems,
      armor: armor,
      weapons: weapons,
    );
  }

  static CharacterDataIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterDataTable>? orderByList,
    CharacterDataInclude? include,
  }) {
    return CharacterDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CharacterData.t),
      include: include,
    );
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

class CharacterDataTable extends _i1.Table<int?> {
  CharacterDataTable({super.tableRelation}) : super(tableName: 'characters') {
    name = _i1.ColumnString(
      'name',
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
    experience = _i1.ColumnInt(
      'experience',
      this,
    );
    attributes = _i1.ColumnSerializable(
      'attributes',
      this,
    );
    raceId = _i1.ColumnInt(
      'raceId',
      this,
    );
    subraceId = _i1.ColumnInt(
      'subraceId',
      this,
    );
    subclassId = _i1.ColumnInt(
      'subclassId',
      this,
    );
    backgroundId = _i1.ColumnInt(
      'backgroundId',
      this,
    );
    alignment = _i1.ColumnString(
      'alignment',
      this,
    );
    armorClass = _i1.ColumnInt(
      'armorClass',
      this,
    );
    speed = _i1.ColumnInt(
      'speed',
      this,
    );
    coins = _i1.ColumnInt(
      'coins',
      this,
    );
    skillProficiencies = _i1.ColumnSerializable(
      'skillProficiencies',
      this,
    );
    skillExpertises = _i1.ColumnSerializable(
      'skillExpertises',
      this,
    );
    maxHp = _i1.ColumnInt(
      'maxHp',
      this,
    );
    temporaryHp = _i1.ColumnInt(
      'temporaryHp',
      this,
    );
    currentHp = _i1.ColumnInt(
      'currentHp',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt experience;

  late final _i1.ColumnSerializable attributes;

  late final _i1.ColumnInt raceId;

  _i2.RaceDataTable? _race;

  late final _i1.ColumnInt subraceId;

  _i3.SubraceDataTable? _subrace;

  _i4.ClassDataTable? ___classes;

  _i1.ManyRelation<_i4.ClassDataTable>? _classes;

  late final _i1.ColumnInt subclassId;

  _i5.SubclassDataTable? _subclass;

  _i6.ClassFeatureDataTable? ___classFeatures;

  _i1.ManyRelation<_i6.ClassFeatureDataTable>? _classFeatures;

  _i7.ClassOptionDataTable? ___variantOptions;

  _i1.ManyRelation<_i7.ClassOptionDataTable>? _variantOptions;

  late final _i1.ColumnInt backgroundId;

  _i8.BackgroundDataTable? _background;

  late final _i1.ColumnString alignment;

  late final _i1.ColumnInt armorClass;

  late final _i1.ColumnInt speed;

  late final _i1.ColumnInt coins;

  late final _i1.ColumnSerializable skillProficiencies;

  late final _i1.ColumnSerializable skillExpertises;

  late final _i1.ColumnInt maxHp;

  late final _i1.ColumnInt temporaryHp;

  late final _i1.ColumnInt currentHp;

  _i9.SpellDataTable? ___preparedSpells;

  _i1.ManyRelation<_i9.SpellDataTable>? _preparedSpells;

  _i9.SpellDataTable? ___writtenSpells;

  _i1.ManyRelation<_i9.SpellDataTable>? _writtenSpells;

  _i10.ItemDataTable? ___items;

  _i1.ManyRelation<_i10.ItemDataTable>? _items;

  _i11.MagicItemDataTable? ___magicItems;

  _i1.ManyRelation<_i11.MagicItemDataTable>? _magicItems;

  _i12.ArmorDataTable? ___armor;

  _i1.ManyRelation<_i12.ArmorDataTable>? _armor;

  _i13.WeaponDataTable? ___weapons;

  _i1.ManyRelation<_i13.WeaponDataTable>? _weapons;

  _i2.RaceDataTable get race {
    if (_race != null) return _race!;
    _race = _i1.createRelationTable(
      relationFieldName: 'race',
      field: CharacterData.t.raceId,
      foreignField: _i2.RaceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RaceDataTable(tableRelation: foreignTableRelation),
    );
    return _race!;
  }

  _i3.SubraceDataTable get subrace {
    if (_subrace != null) return _subrace!;
    _subrace = _i1.createRelationTable(
      relationFieldName: 'subrace',
      field: CharacterData.t.subraceId,
      foreignField: _i3.SubraceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SubraceDataTable(tableRelation: foreignTableRelation),
    );
    return _subrace!;
  }

  _i4.ClassDataTable get __classes {
    if (___classes != null) return ___classes!;
    ___classes = _i1.createRelationTable(
      relationFieldName: '__classes',
      field: CharacterData.t.id,
      foreignField: _i4.ClassData.t.$_charactersClassesCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return ___classes!;
  }

  _i5.SubclassDataTable get subclass {
    if (_subclass != null) return _subclass!;
    _subclass = _i1.createRelationTable(
      relationFieldName: 'subclass',
      field: CharacterData.t.subclassId,
      foreignField: _i5.SubclassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.SubclassDataTable(tableRelation: foreignTableRelation),
    );
    return _subclass!;
  }

  _i6.ClassFeatureDataTable get __classFeatures {
    if (___classFeatures != null) return ___classFeatures!;
    ___classFeatures = _i1.createRelationTable(
      relationFieldName: '__classFeatures',
      field: CharacterData.t.id,
      foreignField:
          _i6.ClassFeatureData.t.$_charactersClassfeaturesCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.ClassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return ___classFeatures!;
  }

  _i7.ClassOptionDataTable get __variantOptions {
    if (___variantOptions != null) return ___variantOptions!;
    ___variantOptions = _i1.createRelationTable(
      relationFieldName: '__variantOptions',
      field: CharacterData.t.id,
      foreignField:
          _i7.ClassOptionData.t.$_charactersVariantoptionsCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7.ClassOptionDataTable(tableRelation: foreignTableRelation),
    );
    return ___variantOptions!;
  }

  _i8.BackgroundDataTable get background {
    if (_background != null) return _background!;
    _background = _i1.createRelationTable(
      relationFieldName: 'background',
      field: CharacterData.t.backgroundId,
      foreignField: _i8.BackgroundData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.BackgroundDataTable(tableRelation: foreignTableRelation),
    );
    return _background!;
  }

  _i9.SpellDataTable get __preparedSpells {
    if (___preparedSpells != null) return ___preparedSpells!;
    ___preparedSpells = _i1.createRelationTable(
      relationFieldName: '__preparedSpells',
      field: CharacterData.t.id,
      foreignField: _i9.SpellData.t.$_charactersPreparedspellsCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i9.SpellDataTable(tableRelation: foreignTableRelation),
    );
    return ___preparedSpells!;
  }

  _i9.SpellDataTable get __writtenSpells {
    if (___writtenSpells != null) return ___writtenSpells!;
    ___writtenSpells = _i1.createRelationTable(
      relationFieldName: '__writtenSpells',
      field: CharacterData.t.id,
      foreignField: _i9.SpellData.t.$_charactersWrittenspellsCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i9.SpellDataTable(tableRelation: foreignTableRelation),
    );
    return ___writtenSpells!;
  }

  _i10.ItemDataTable get __items {
    if (___items != null) return ___items!;
    ___items = _i1.createRelationTable(
      relationFieldName: '__items',
      field: CharacterData.t.id,
      foreignField: _i10.ItemData.t.$_charactersItemsCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i10.ItemDataTable(tableRelation: foreignTableRelation),
    );
    return ___items!;
  }

  _i11.MagicItemDataTable get __magicItems {
    if (___magicItems != null) return ___magicItems!;
    ___magicItems = _i1.createRelationTable(
      relationFieldName: '__magicItems',
      field: CharacterData.t.id,
      foreignField: _i11.MagicItemData.t.$_charactersMagicitemsCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i11.MagicItemDataTable(tableRelation: foreignTableRelation),
    );
    return ___magicItems!;
  }

  _i12.ArmorDataTable get __armor {
    if (___armor != null) return ___armor!;
    ___armor = _i1.createRelationTable(
      relationFieldName: '__armor',
      field: CharacterData.t.id,
      foreignField: _i12.ArmorData.t.$_charactersArmorCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i12.ArmorDataTable(tableRelation: foreignTableRelation),
    );
    return ___armor!;
  }

  _i13.WeaponDataTable get __weapons {
    if (___weapons != null) return ___weapons!;
    ___weapons = _i1.createRelationTable(
      relationFieldName: '__weapons',
      field: CharacterData.t.id,
      foreignField: _i13.WeaponData.t.$_charactersWeaponsCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i13.WeaponDataTable(tableRelation: foreignTableRelation),
    );
    return ___weapons!;
  }

  _i1.ManyRelation<_i4.ClassDataTable> get classes {
    if (_classes != null) return _classes!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'classes',
      field: CharacterData.t.id,
      foreignField: _i4.ClassData.t.$_charactersClassesCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ClassDataTable(tableRelation: foreignTableRelation),
    );
    _classes = _i1.ManyRelation<_i4.ClassDataTable>(
      tableWithRelations: relationTable,
      table: _i4.ClassDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _classes!;
  }

  _i1.ManyRelation<_i6.ClassFeatureDataTable> get classFeatures {
    if (_classFeatures != null) return _classFeatures!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'classFeatures',
      field: CharacterData.t.id,
      foreignField:
          _i6.ClassFeatureData.t.$_charactersClassfeaturesCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.ClassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    _classFeatures = _i1.ManyRelation<_i6.ClassFeatureDataTable>(
      tableWithRelations: relationTable,
      table: _i6.ClassFeatureDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _classFeatures!;
  }

  _i1.ManyRelation<_i7.ClassOptionDataTable> get variantOptions {
    if (_variantOptions != null) return _variantOptions!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'variantOptions',
      field: CharacterData.t.id,
      foreignField:
          _i7.ClassOptionData.t.$_charactersVariantoptionsCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7.ClassOptionDataTable(tableRelation: foreignTableRelation),
    );
    _variantOptions = _i1.ManyRelation<_i7.ClassOptionDataTable>(
      tableWithRelations: relationTable,
      table: _i7.ClassOptionDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _variantOptions!;
  }

  _i1.ManyRelation<_i9.SpellDataTable> get preparedSpells {
    if (_preparedSpells != null) return _preparedSpells!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'preparedSpells',
      field: CharacterData.t.id,
      foreignField: _i9.SpellData.t.$_charactersPreparedspellsCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i9.SpellDataTable(tableRelation: foreignTableRelation),
    );
    _preparedSpells = _i1.ManyRelation<_i9.SpellDataTable>(
      tableWithRelations: relationTable,
      table: _i9.SpellDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _preparedSpells!;
  }

  _i1.ManyRelation<_i9.SpellDataTable> get writtenSpells {
    if (_writtenSpells != null) return _writtenSpells!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'writtenSpells',
      field: CharacterData.t.id,
      foreignField: _i9.SpellData.t.$_charactersWrittenspellsCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i9.SpellDataTable(tableRelation: foreignTableRelation),
    );
    _writtenSpells = _i1.ManyRelation<_i9.SpellDataTable>(
      tableWithRelations: relationTable,
      table: _i9.SpellDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _writtenSpells!;
  }

  _i1.ManyRelation<_i10.ItemDataTable> get items {
    if (_items != null) return _items!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'items',
      field: CharacterData.t.id,
      foreignField: _i10.ItemData.t.$_charactersItemsCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i10.ItemDataTable(tableRelation: foreignTableRelation),
    );
    _items = _i1.ManyRelation<_i10.ItemDataTable>(
      tableWithRelations: relationTable,
      table: _i10.ItemDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _items!;
  }

  _i1.ManyRelation<_i11.MagicItemDataTable> get magicItems {
    if (_magicItems != null) return _magicItems!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'magicItems',
      field: CharacterData.t.id,
      foreignField: _i11.MagicItemData.t.$_charactersMagicitemsCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i11.MagicItemDataTable(tableRelation: foreignTableRelation),
    );
    _magicItems = _i1.ManyRelation<_i11.MagicItemDataTable>(
      tableWithRelations: relationTable,
      table: _i11.MagicItemDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _magicItems!;
  }

  _i1.ManyRelation<_i12.ArmorDataTable> get armor {
    if (_armor != null) return _armor!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'armor',
      field: CharacterData.t.id,
      foreignField: _i12.ArmorData.t.$_charactersArmorCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i12.ArmorDataTable(tableRelation: foreignTableRelation),
    );
    _armor = _i1.ManyRelation<_i12.ArmorDataTable>(
      tableWithRelations: relationTable,
      table: _i12.ArmorDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _armor!;
  }

  _i1.ManyRelation<_i13.WeaponDataTable> get weapons {
    if (_weapons != null) return _weapons!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'weapons',
      field: CharacterData.t.id,
      foreignField: _i13.WeaponData.t.$_charactersWeaponsCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i13.WeaponDataTable(tableRelation: foreignTableRelation),
    );
    _weapons = _i1.ManyRelation<_i13.WeaponDataTable>(
      tableWithRelations: relationTable,
      table: _i13.WeaponDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _weapons!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        version,
        createdAt,
        updatedAt,
        experience,
        attributes,
        raceId,
        subraceId,
        subclassId,
        backgroundId,
        alignment,
        armorClass,
        speed,
        coins,
        skillProficiencies,
        skillExpertises,
        maxHp,
        temporaryHp,
        currentHp,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'race') {
      return race;
    }
    if (relationField == 'subrace') {
      return subrace;
    }
    if (relationField == 'classes') {
      return __classes;
    }
    if (relationField == 'subclass') {
      return subclass;
    }
    if (relationField == 'classFeatures') {
      return __classFeatures;
    }
    if (relationField == 'variantOptions') {
      return __variantOptions;
    }
    if (relationField == 'background') {
      return background;
    }
    if (relationField == 'preparedSpells') {
      return __preparedSpells;
    }
    if (relationField == 'writtenSpells') {
      return __writtenSpells;
    }
    if (relationField == 'items') {
      return __items;
    }
    if (relationField == 'magicItems') {
      return __magicItems;
    }
    if (relationField == 'armor') {
      return __armor;
    }
    if (relationField == 'weapons') {
      return __weapons;
    }
    return null;
  }
}

class CharacterDataInclude extends _i1.IncludeObject {
  CharacterDataInclude._({
    _i2.RaceDataInclude? race,
    _i3.SubraceDataInclude? subrace,
    _i4.ClassDataIncludeList? classes,
    _i5.SubclassDataInclude? subclass,
    _i6.ClassFeatureDataIncludeList? classFeatures,
    _i7.ClassOptionDataIncludeList? variantOptions,
    _i8.BackgroundDataInclude? background,
    _i9.SpellDataIncludeList? preparedSpells,
    _i9.SpellDataIncludeList? writtenSpells,
    _i10.ItemDataIncludeList? items,
    _i11.MagicItemDataIncludeList? magicItems,
    _i12.ArmorDataIncludeList? armor,
    _i13.WeaponDataIncludeList? weapons,
  }) {
    _race = race;
    _subrace = subrace;
    _classes = classes;
    _subclass = subclass;
    _classFeatures = classFeatures;
    _variantOptions = variantOptions;
    _background = background;
    _preparedSpells = preparedSpells;
    _writtenSpells = writtenSpells;
    _items = items;
    _magicItems = magicItems;
    _armor = armor;
    _weapons = weapons;
  }

  _i2.RaceDataInclude? _race;

  _i3.SubraceDataInclude? _subrace;

  _i4.ClassDataIncludeList? _classes;

  _i5.SubclassDataInclude? _subclass;

  _i6.ClassFeatureDataIncludeList? _classFeatures;

  _i7.ClassOptionDataIncludeList? _variantOptions;

  _i8.BackgroundDataInclude? _background;

  _i9.SpellDataIncludeList? _preparedSpells;

  _i9.SpellDataIncludeList? _writtenSpells;

  _i10.ItemDataIncludeList? _items;

  _i11.MagicItemDataIncludeList? _magicItems;

  _i12.ArmorDataIncludeList? _armor;

  _i13.WeaponDataIncludeList? _weapons;

  @override
  Map<String, _i1.Include?> get includes => {
        'race': _race,
        'subrace': _subrace,
        'classes': _classes,
        'subclass': _subclass,
        'classFeatures': _classFeatures,
        'variantOptions': _variantOptions,
        'background': _background,
        'preparedSpells': _preparedSpells,
        'writtenSpells': _writtenSpells,
        'items': _items,
        'magicItems': _magicItems,
        'armor': _armor,
        'weapons': _weapons,
      };

  @override
  _i1.Table<int?> get table => CharacterData.t;
}

class CharacterDataIncludeList extends _i1.IncludeList {
  CharacterDataIncludeList._({
    _i1.WhereExpressionBuilder<CharacterDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterData.t;
}

class CharacterDataRepository {
  const CharacterDataRepository._();

  final attach = const CharacterDataAttachRepository._();

  final attachRow = const CharacterDataAttachRowRepository._();

  final detach = const CharacterDataDetachRepository._();

  final detachRow = const CharacterDataDetachRowRepository._();

  /// Returns a list of [CharacterData]s matching the given query parameters.
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
  Future<List<CharacterData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterDataTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterDataInclude? include,
  }) async {
    return session.db.find<CharacterData>(
      where: where?.call(CharacterData.t),
      orderBy: orderBy?.call(CharacterData.t),
      orderByList: orderByList?.call(CharacterData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CharacterData] matching the given query parameters.
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
  Future<CharacterData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<CharacterDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterDataTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterDataInclude? include,
  }) async {
    return session.db.findFirstRow<CharacterData>(
      where: where?.call(CharacterData.t),
      orderBy: orderBy?.call(CharacterData.t),
      orderByList: orderByList?.call(CharacterData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CharacterData] by its [id] or null if no such row exists.
  Future<CharacterData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CharacterDataInclude? include,
  }) async {
    return session.db.findById<CharacterData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CharacterData]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterData>> insert(
    _i1.Session session,
    List<CharacterData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterData] and returns the inserted row.
  ///
  /// The returned [CharacterData] will have its `id` field set.
  Future<CharacterData> insertRow(
    _i1.Session session,
    CharacterData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterData>> update(
    _i1.Session session,
    List<CharacterData> rows, {
    _i1.ColumnSelections<CharacterDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterData>(
      rows,
      columns: columns?.call(CharacterData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterData> updateRow(
    _i1.Session session,
    CharacterData row, {
    _i1.ColumnSelections<CharacterDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterData>(
      row,
      columns: columns?.call(CharacterData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterData>> delete(
    _i1.Session session,
    List<CharacterData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterData].
  Future<CharacterData> deleteRow(
    _i1.Session session,
    CharacterData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CharacterDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterData>(
      where: where(CharacterData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterData>(
      where: where?.call(CharacterData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CharacterDataAttachRepository {
  const CharacterDataAttachRepository._();

  /// Creates a relation between this [CharacterData] and the given [ClassData]s
  /// by setting each [ClassData]'s foreign key `_charactersClassesCharactersId` to refer to this [CharacterData].
  Future<void> classes(
    _i1.Session session,
    CharacterData characterData,
    List<_i4.ClassData> classData, {
    _i1.Transaction? transaction,
  }) async {
    if (classData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('classData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $classData = classData
        .map((e) => _i4.ClassDataImplicit(
              e,
              $_charactersClassesCharactersId: characterData.id,
            ))
        .toList();
    await session.db.update<_i4.ClassData>(
      $classData,
      columns: [_i4.ClassData.t.$_charactersClassesCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [ClassFeatureData]s
  /// by setting each [ClassFeatureData]'s foreign key `_charactersClassfeaturesCharactersId` to refer to this [CharacterData].
  Future<void> classFeatures(
    _i1.Session session,
    CharacterData characterData,
    List<_i6.ClassFeatureData> classFeatureData, {
    _i1.Transaction? transaction,
  }) async {
    if (classFeatureData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('classFeatureData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $classFeatureData = classFeatureData
        .map((e) => _i6.ClassFeatureDataImplicit(
              e,
              $_charactersClassfeaturesCharactersId: characterData.id,
            ))
        .toList();
    await session.db.update<_i6.ClassFeatureData>(
      $classFeatureData,
      columns: [_i6.ClassFeatureData.t.$_charactersClassfeaturesCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [ClassOptionData]s
  /// by setting each [ClassOptionData]'s foreign key `_charactersVariantoptionsCharactersId` to refer to this [CharacterData].
  Future<void> variantOptions(
    _i1.Session session,
    CharacterData characterData,
    List<_i7.ClassOptionData> classOptionData, {
    _i1.Transaction? transaction,
  }) async {
    if (classOptionData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('classOptionData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $classOptionData = classOptionData
        .map((e) => _i7.ClassOptionDataImplicit(
              e,
              $_charactersVariantoptionsCharactersId: characterData.id,
            ))
        .toList();
    await session.db.update<_i7.ClassOptionData>(
      $classOptionData,
      columns: [_i7.ClassOptionData.t.$_charactersVariantoptionsCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [SpellData]s
  /// by setting each [SpellData]'s foreign key `_charactersPreparedspellsCharactersId` to refer to this [CharacterData].
  Future<void> preparedSpells(
    _i1.Session session,
    CharacterData characterData,
    List<_i9.SpellData> spellData, {
    _i1.Transaction? transaction,
  }) async {
    if (spellData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('spellData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $spellData = spellData
        .map((e) => _i9.SpellDataImplicit(
              e,
              $_charactersPreparedspellsCharactersId: characterData.id,
            ))
        .toList();
    await session.db.update<_i9.SpellData>(
      $spellData,
      columns: [_i9.SpellData.t.$_charactersPreparedspellsCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [SpellData]s
  /// by setting each [SpellData]'s foreign key `_charactersWrittenspellsCharactersId` to refer to this [CharacterData].
  Future<void> writtenSpells(
    _i1.Session session,
    CharacterData characterData,
    List<_i9.SpellData> spellData, {
    _i1.Transaction? transaction,
  }) async {
    if (spellData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('spellData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $spellData = spellData
        .map((e) => _i9.SpellDataImplicit(
              e,
              $_charactersWrittenspellsCharactersId: characterData.id,
            ))
        .toList();
    await session.db.update<_i9.SpellData>(
      $spellData,
      columns: [_i9.SpellData.t.$_charactersWrittenspellsCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [ItemData]s
  /// by setting each [ItemData]'s foreign key `_charactersItemsCharactersId` to refer to this [CharacterData].
  Future<void> items(
    _i1.Session session,
    CharacterData characterData,
    List<_i10.ItemData> itemData, {
    _i1.Transaction? transaction,
  }) async {
    if (itemData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('itemData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $itemData = itemData
        .map((e) => _i10.ItemDataImplicit(
              e,
              $_charactersItemsCharactersId: characterData.id,
            ))
        .toList();
    await session.db.update<_i10.ItemData>(
      $itemData,
      columns: [_i10.ItemData.t.$_charactersItemsCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [MagicItemData]s
  /// by setting each [MagicItemData]'s foreign key `_charactersMagicitemsCharactersId` to refer to this [CharacterData].
  Future<void> magicItems(
    _i1.Session session,
    CharacterData characterData,
    List<_i11.MagicItemData> magicItemData, {
    _i1.Transaction? transaction,
  }) async {
    if (magicItemData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('magicItemData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $magicItemData = magicItemData
        .map((e) => _i11.MagicItemDataImplicit(
              e,
              $_charactersMagicitemsCharactersId: characterData.id,
            ))
        .toList();
    await session.db.update<_i11.MagicItemData>(
      $magicItemData,
      columns: [_i11.MagicItemData.t.$_charactersMagicitemsCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [ArmorData]s
  /// by setting each [ArmorData]'s foreign key `_charactersArmorCharactersId` to refer to this [CharacterData].
  Future<void> armor(
    _i1.Session session,
    CharacterData characterData,
    List<_i12.ArmorData> armorData, {
    _i1.Transaction? transaction,
  }) async {
    if (armorData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('armorData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $armorData = armorData
        .map((e) => _i12.ArmorDataImplicit(
              e,
              $_charactersArmorCharactersId: characterData.id,
            ))
        .toList();
    await session.db.update<_i12.ArmorData>(
      $armorData,
      columns: [_i12.ArmorData.t.$_charactersArmorCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [WeaponData]s
  /// by setting each [WeaponData]'s foreign key `_charactersWeaponsCharactersId` to refer to this [CharacterData].
  Future<void> weapons(
    _i1.Session session,
    CharacterData characterData,
    List<_i13.WeaponData> weaponData, {
    _i1.Transaction? transaction,
  }) async {
    if (weaponData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('weaponData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $weaponData = weaponData
        .map((e) => _i13.WeaponDataImplicit(
              e,
              $_charactersWeaponsCharactersId: characterData.id,
            ))
        .toList();
    await session.db.update<_i13.WeaponData>(
      $weaponData,
      columns: [_i13.WeaponData.t.$_charactersWeaponsCharactersId],
      transaction: transaction,
    );
  }
}

class CharacterDataAttachRowRepository {
  const CharacterDataAttachRowRepository._();

  /// Creates a relation between the given [CharacterData] and [RaceData]
  /// by setting the [CharacterData]'s foreign key `raceId` to refer to the [RaceData].
  Future<void> race(
    _i1.Session session,
    CharacterData characterData,
    _i2.RaceData race, {
    _i1.Transaction? transaction,
  }) async {
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }
    if (race.id == null) {
      throw ArgumentError.notNull('race.id');
    }

    var $characterData = characterData.copyWith(raceId: race.id);
    await session.db.updateRow<CharacterData>(
      $characterData,
      columns: [CharacterData.t.raceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterData] and [SubraceData]
  /// by setting the [CharacterData]'s foreign key `subraceId` to refer to the [SubraceData].
  Future<void> subrace(
    _i1.Session session,
    CharacterData characterData,
    _i3.SubraceData subrace, {
    _i1.Transaction? transaction,
  }) async {
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }
    if (subrace.id == null) {
      throw ArgumentError.notNull('subrace.id');
    }

    var $characterData = characterData.copyWith(subraceId: subrace.id);
    await session.db.updateRow<CharacterData>(
      $characterData,
      columns: [CharacterData.t.subraceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterData] and [SubclassData]
  /// by setting the [CharacterData]'s foreign key `subclassId` to refer to the [SubclassData].
  Future<void> subclass(
    _i1.Session session,
    CharacterData characterData,
    _i5.SubclassData subclass, {
    _i1.Transaction? transaction,
  }) async {
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }
    if (subclass.id == null) {
      throw ArgumentError.notNull('subclass.id');
    }

    var $characterData = characterData.copyWith(subclassId: subclass.id);
    await session.db.updateRow<CharacterData>(
      $characterData,
      columns: [CharacterData.t.subclassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterData] and [BackgroundData]
  /// by setting the [CharacterData]'s foreign key `backgroundId` to refer to the [BackgroundData].
  Future<void> background(
    _i1.Session session,
    CharacterData characterData,
    _i8.BackgroundData background, {
    _i1.Transaction? transaction,
  }) async {
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }
    if (background.id == null) {
      throw ArgumentError.notNull('background.id');
    }

    var $characterData = characterData.copyWith(backgroundId: background.id);
    await session.db.updateRow<CharacterData>(
      $characterData,
      columns: [CharacterData.t.backgroundId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [ClassData]
  /// by setting the [ClassData]'s foreign key `_charactersClassesCharactersId` to refer to this [CharacterData].
  Future<void> classes(
    _i1.Session session,
    CharacterData characterData,
    _i4.ClassData classData, {
    _i1.Transaction? transaction,
  }) async {
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $classData = _i4.ClassDataImplicit(
      classData,
      $_charactersClassesCharactersId: characterData.id,
    );
    await session.db.updateRow<_i4.ClassData>(
      $classData,
      columns: [_i4.ClassData.t.$_charactersClassesCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [ClassFeatureData]
  /// by setting the [ClassFeatureData]'s foreign key `_charactersClassfeaturesCharactersId` to refer to this [CharacterData].
  Future<void> classFeatures(
    _i1.Session session,
    CharacterData characterData,
    _i6.ClassFeatureData classFeatureData, {
    _i1.Transaction? transaction,
  }) async {
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $classFeatureData = _i6.ClassFeatureDataImplicit(
      classFeatureData,
      $_charactersClassfeaturesCharactersId: characterData.id,
    );
    await session.db.updateRow<_i6.ClassFeatureData>(
      $classFeatureData,
      columns: [_i6.ClassFeatureData.t.$_charactersClassfeaturesCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [ClassOptionData]
  /// by setting the [ClassOptionData]'s foreign key `_charactersVariantoptionsCharactersId` to refer to this [CharacterData].
  Future<void> variantOptions(
    _i1.Session session,
    CharacterData characterData,
    _i7.ClassOptionData classOptionData, {
    _i1.Transaction? transaction,
  }) async {
    if (classOptionData.id == null) {
      throw ArgumentError.notNull('classOptionData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $classOptionData = _i7.ClassOptionDataImplicit(
      classOptionData,
      $_charactersVariantoptionsCharactersId: characterData.id,
    );
    await session.db.updateRow<_i7.ClassOptionData>(
      $classOptionData,
      columns: [_i7.ClassOptionData.t.$_charactersVariantoptionsCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [SpellData]
  /// by setting the [SpellData]'s foreign key `_charactersPreparedspellsCharactersId` to refer to this [CharacterData].
  Future<void> preparedSpells(
    _i1.Session session,
    CharacterData characterData,
    _i9.SpellData spellData, {
    _i1.Transaction? transaction,
  }) async {
    if (spellData.id == null) {
      throw ArgumentError.notNull('spellData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $spellData = _i9.SpellDataImplicit(
      spellData,
      $_charactersPreparedspellsCharactersId: characterData.id,
    );
    await session.db.updateRow<_i9.SpellData>(
      $spellData,
      columns: [_i9.SpellData.t.$_charactersPreparedspellsCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [SpellData]
  /// by setting the [SpellData]'s foreign key `_charactersWrittenspellsCharactersId` to refer to this [CharacterData].
  Future<void> writtenSpells(
    _i1.Session session,
    CharacterData characterData,
    _i9.SpellData spellData, {
    _i1.Transaction? transaction,
  }) async {
    if (spellData.id == null) {
      throw ArgumentError.notNull('spellData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $spellData = _i9.SpellDataImplicit(
      spellData,
      $_charactersWrittenspellsCharactersId: characterData.id,
    );
    await session.db.updateRow<_i9.SpellData>(
      $spellData,
      columns: [_i9.SpellData.t.$_charactersWrittenspellsCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [ItemData]
  /// by setting the [ItemData]'s foreign key `_charactersItemsCharactersId` to refer to this [CharacterData].
  Future<void> items(
    _i1.Session session,
    CharacterData characterData,
    _i10.ItemData itemData, {
    _i1.Transaction? transaction,
  }) async {
    if (itemData.id == null) {
      throw ArgumentError.notNull('itemData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $itemData = _i10.ItemDataImplicit(
      itemData,
      $_charactersItemsCharactersId: characterData.id,
    );
    await session.db.updateRow<_i10.ItemData>(
      $itemData,
      columns: [_i10.ItemData.t.$_charactersItemsCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [MagicItemData]
  /// by setting the [MagicItemData]'s foreign key `_charactersMagicitemsCharactersId` to refer to this [CharacterData].
  Future<void> magicItems(
    _i1.Session session,
    CharacterData characterData,
    _i11.MagicItemData magicItemData, {
    _i1.Transaction? transaction,
  }) async {
    if (magicItemData.id == null) {
      throw ArgumentError.notNull('magicItemData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $magicItemData = _i11.MagicItemDataImplicit(
      magicItemData,
      $_charactersMagicitemsCharactersId: characterData.id,
    );
    await session.db.updateRow<_i11.MagicItemData>(
      $magicItemData,
      columns: [_i11.MagicItemData.t.$_charactersMagicitemsCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [ArmorData]
  /// by setting the [ArmorData]'s foreign key `_charactersArmorCharactersId` to refer to this [CharacterData].
  Future<void> armor(
    _i1.Session session,
    CharacterData characterData,
    _i12.ArmorData armorData, {
    _i1.Transaction? transaction,
  }) async {
    if (armorData.id == null) {
      throw ArgumentError.notNull('armorData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $armorData = _i12.ArmorDataImplicit(
      armorData,
      $_charactersArmorCharactersId: characterData.id,
    );
    await session.db.updateRow<_i12.ArmorData>(
      $armorData,
      columns: [_i12.ArmorData.t.$_charactersArmorCharactersId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CharacterData] and the given [WeaponData]
  /// by setting the [WeaponData]'s foreign key `_charactersWeaponsCharactersId` to refer to this [CharacterData].
  Future<void> weapons(
    _i1.Session session,
    CharacterData characterData,
    _i13.WeaponData weaponData, {
    _i1.Transaction? transaction,
  }) async {
    if (weaponData.id == null) {
      throw ArgumentError.notNull('weaponData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $weaponData = _i13.WeaponDataImplicit(
      weaponData,
      $_charactersWeaponsCharactersId: characterData.id,
    );
    await session.db.updateRow<_i13.WeaponData>(
      $weaponData,
      columns: [_i13.WeaponData.t.$_charactersWeaponsCharactersId],
      transaction: transaction,
    );
  }
}

class CharacterDataDetachRepository {
  const CharacterDataDetachRepository._();

  /// Detaches the relation between this [CharacterData] and the given [ClassData]
  /// by setting the [ClassData]'s foreign key `_charactersClassesCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classes(
    _i1.Session session,
    List<_i4.ClassData> classData, {
    _i1.Transaction? transaction,
  }) async {
    if (classData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('classData.id');
    }

    var $classData = classData
        .map((e) => _i4.ClassDataImplicit(
              e,
              $_charactersClassesCharactersId: null,
            ))
        .toList();
    await session.db.update<_i4.ClassData>(
      $classData,
      columns: [_i4.ClassData.t.$_charactersClassesCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [ClassFeatureData]
  /// by setting the [ClassFeatureData]'s foreign key `_charactersClassfeaturesCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classFeatures(
    _i1.Session session,
    List<_i6.ClassFeatureData> classFeatureData, {
    _i1.Transaction? transaction,
  }) async {
    if (classFeatureData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $classFeatureData = classFeatureData
        .map((e) => _i6.ClassFeatureDataImplicit(
              e,
              $_charactersClassfeaturesCharactersId: null,
            ))
        .toList();
    await session.db.update<_i6.ClassFeatureData>(
      $classFeatureData,
      columns: [_i6.ClassFeatureData.t.$_charactersClassfeaturesCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [ClassOptionData]
  /// by setting the [ClassOptionData]'s foreign key `_charactersVariantoptionsCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> variantOptions(
    _i1.Session session,
    List<_i7.ClassOptionData> classOptionData, {
    _i1.Transaction? transaction,
  }) async {
    if (classOptionData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('classOptionData.id');
    }

    var $classOptionData = classOptionData
        .map((e) => _i7.ClassOptionDataImplicit(
              e,
              $_charactersVariantoptionsCharactersId: null,
            ))
        .toList();
    await session.db.update<_i7.ClassOptionData>(
      $classOptionData,
      columns: [_i7.ClassOptionData.t.$_charactersVariantoptionsCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [SpellData]
  /// by setting the [SpellData]'s foreign key `_charactersPreparedspellsCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> preparedSpells(
    _i1.Session session,
    List<_i9.SpellData> spellData, {
    _i1.Transaction? transaction,
  }) async {
    if (spellData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('spellData.id');
    }

    var $spellData = spellData
        .map((e) => _i9.SpellDataImplicit(
              e,
              $_charactersPreparedspellsCharactersId: null,
            ))
        .toList();
    await session.db.update<_i9.SpellData>(
      $spellData,
      columns: [_i9.SpellData.t.$_charactersPreparedspellsCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [SpellData]
  /// by setting the [SpellData]'s foreign key `_charactersWrittenspellsCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> writtenSpells(
    _i1.Session session,
    List<_i9.SpellData> spellData, {
    _i1.Transaction? transaction,
  }) async {
    if (spellData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('spellData.id');
    }

    var $spellData = spellData
        .map((e) => _i9.SpellDataImplicit(
              e,
              $_charactersWrittenspellsCharactersId: null,
            ))
        .toList();
    await session.db.update<_i9.SpellData>(
      $spellData,
      columns: [_i9.SpellData.t.$_charactersWrittenspellsCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [ItemData]
  /// by setting the [ItemData]'s foreign key `_charactersItemsCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> items(
    _i1.Session session,
    List<_i10.ItemData> itemData, {
    _i1.Transaction? transaction,
  }) async {
    if (itemData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('itemData.id');
    }

    var $itemData = itemData
        .map((e) => _i10.ItemDataImplicit(
              e,
              $_charactersItemsCharactersId: null,
            ))
        .toList();
    await session.db.update<_i10.ItemData>(
      $itemData,
      columns: [_i10.ItemData.t.$_charactersItemsCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [MagicItemData]
  /// by setting the [MagicItemData]'s foreign key `_charactersMagicitemsCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> magicItems(
    _i1.Session session,
    List<_i11.MagicItemData> magicItemData, {
    _i1.Transaction? transaction,
  }) async {
    if (magicItemData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('magicItemData.id');
    }

    var $magicItemData = magicItemData
        .map((e) => _i11.MagicItemDataImplicit(
              e,
              $_charactersMagicitemsCharactersId: null,
            ))
        .toList();
    await session.db.update<_i11.MagicItemData>(
      $magicItemData,
      columns: [_i11.MagicItemData.t.$_charactersMagicitemsCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [ArmorData]
  /// by setting the [ArmorData]'s foreign key `_charactersArmorCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> armor(
    _i1.Session session,
    List<_i12.ArmorData> armorData, {
    _i1.Transaction? transaction,
  }) async {
    if (armorData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('armorData.id');
    }

    var $armorData = armorData
        .map((e) => _i12.ArmorDataImplicit(
              e,
              $_charactersArmorCharactersId: null,
            ))
        .toList();
    await session.db.update<_i12.ArmorData>(
      $armorData,
      columns: [_i12.ArmorData.t.$_charactersArmorCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [WeaponData]
  /// by setting the [WeaponData]'s foreign key `_charactersWeaponsCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> weapons(
    _i1.Session session,
    List<_i13.WeaponData> weaponData, {
    _i1.Transaction? transaction,
  }) async {
    if (weaponData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('weaponData.id');
    }

    var $weaponData = weaponData
        .map((e) => _i13.WeaponDataImplicit(
              e,
              $_charactersWeaponsCharactersId: null,
            ))
        .toList();
    await session.db.update<_i13.WeaponData>(
      $weaponData,
      columns: [_i13.WeaponData.t.$_charactersWeaponsCharactersId],
      transaction: transaction,
    );
  }
}

class CharacterDataDetachRowRepository {
  const CharacterDataDetachRowRepository._();

  /// Detaches the relation between this [CharacterData] and the [RaceData] set in `race`
  /// by setting the [CharacterData]'s foreign key `raceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> race(
    _i1.Session session,
    CharacterData characterdata, {
    _i1.Transaction? transaction,
  }) async {
    if (characterdata.id == null) {
      throw ArgumentError.notNull('characterdata.id');
    }

    var $characterdata = characterdata.copyWith(raceId: null);
    await session.db.updateRow<CharacterData>(
      $characterdata,
      columns: [CharacterData.t.raceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the [SubraceData] set in `subrace`
  /// by setting the [CharacterData]'s foreign key `subraceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subrace(
    _i1.Session session,
    CharacterData characterdata, {
    _i1.Transaction? transaction,
  }) async {
    if (characterdata.id == null) {
      throw ArgumentError.notNull('characterdata.id');
    }

    var $characterdata = characterdata.copyWith(subraceId: null);
    await session.db.updateRow<CharacterData>(
      $characterdata,
      columns: [CharacterData.t.subraceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the [SubclassData] set in `subclass`
  /// by setting the [CharacterData]'s foreign key `subclassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subclass(
    _i1.Session session,
    CharacterData characterdata, {
    _i1.Transaction? transaction,
  }) async {
    if (characterdata.id == null) {
      throw ArgumentError.notNull('characterdata.id');
    }

    var $characterdata = characterdata.copyWith(subclassId: null);
    await session.db.updateRow<CharacterData>(
      $characterdata,
      columns: [CharacterData.t.subclassId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the [BackgroundData] set in `background`
  /// by setting the [CharacterData]'s foreign key `backgroundId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> background(
    _i1.Session session,
    CharacterData characterdata, {
    _i1.Transaction? transaction,
  }) async {
    if (characterdata.id == null) {
      throw ArgumentError.notNull('characterdata.id');
    }

    var $characterdata = characterdata.copyWith(backgroundId: null);
    await session.db.updateRow<CharacterData>(
      $characterdata,
      columns: [CharacterData.t.backgroundId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [ClassData]
  /// by setting the [ClassData]'s foreign key `_charactersClassesCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classes(
    _i1.Session session,
    _i4.ClassData classData, {
    _i1.Transaction? transaction,
  }) async {
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $classData = _i4.ClassDataImplicit(
      classData,
      $_charactersClassesCharactersId: null,
    );
    await session.db.updateRow<_i4.ClassData>(
      $classData,
      columns: [_i4.ClassData.t.$_charactersClassesCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [ClassFeatureData]
  /// by setting the [ClassFeatureData]'s foreign key `_charactersClassfeaturesCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classFeatures(
    _i1.Session session,
    _i6.ClassFeatureData classFeatureData, {
    _i1.Transaction? transaction,
  }) async {
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $classFeatureData = _i6.ClassFeatureDataImplicit(
      classFeatureData,
      $_charactersClassfeaturesCharactersId: null,
    );
    await session.db.updateRow<_i6.ClassFeatureData>(
      $classFeatureData,
      columns: [_i6.ClassFeatureData.t.$_charactersClassfeaturesCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [ClassOptionData]
  /// by setting the [ClassOptionData]'s foreign key `_charactersVariantoptionsCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> variantOptions(
    _i1.Session session,
    _i7.ClassOptionData classOptionData, {
    _i1.Transaction? transaction,
  }) async {
    if (classOptionData.id == null) {
      throw ArgumentError.notNull('classOptionData.id');
    }

    var $classOptionData = _i7.ClassOptionDataImplicit(
      classOptionData,
      $_charactersVariantoptionsCharactersId: null,
    );
    await session.db.updateRow<_i7.ClassOptionData>(
      $classOptionData,
      columns: [_i7.ClassOptionData.t.$_charactersVariantoptionsCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [SpellData]
  /// by setting the [SpellData]'s foreign key `_charactersPreparedspellsCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> preparedSpells(
    _i1.Session session,
    _i9.SpellData spellData, {
    _i1.Transaction? transaction,
  }) async {
    if (spellData.id == null) {
      throw ArgumentError.notNull('spellData.id');
    }

    var $spellData = _i9.SpellDataImplicit(
      spellData,
      $_charactersPreparedspellsCharactersId: null,
    );
    await session.db.updateRow<_i9.SpellData>(
      $spellData,
      columns: [_i9.SpellData.t.$_charactersPreparedspellsCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [SpellData]
  /// by setting the [SpellData]'s foreign key `_charactersWrittenspellsCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> writtenSpells(
    _i1.Session session,
    _i9.SpellData spellData, {
    _i1.Transaction? transaction,
  }) async {
    if (spellData.id == null) {
      throw ArgumentError.notNull('spellData.id');
    }

    var $spellData = _i9.SpellDataImplicit(
      spellData,
      $_charactersWrittenspellsCharactersId: null,
    );
    await session.db.updateRow<_i9.SpellData>(
      $spellData,
      columns: [_i9.SpellData.t.$_charactersWrittenspellsCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [ItemData]
  /// by setting the [ItemData]'s foreign key `_charactersItemsCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> items(
    _i1.Session session,
    _i10.ItemData itemData, {
    _i1.Transaction? transaction,
  }) async {
    if (itemData.id == null) {
      throw ArgumentError.notNull('itemData.id');
    }

    var $itemData = _i10.ItemDataImplicit(
      itemData,
      $_charactersItemsCharactersId: null,
    );
    await session.db.updateRow<_i10.ItemData>(
      $itemData,
      columns: [_i10.ItemData.t.$_charactersItemsCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [MagicItemData]
  /// by setting the [MagicItemData]'s foreign key `_charactersMagicitemsCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> magicItems(
    _i1.Session session,
    _i11.MagicItemData magicItemData, {
    _i1.Transaction? transaction,
  }) async {
    if (magicItemData.id == null) {
      throw ArgumentError.notNull('magicItemData.id');
    }

    var $magicItemData = _i11.MagicItemDataImplicit(
      magicItemData,
      $_charactersMagicitemsCharactersId: null,
    );
    await session.db.updateRow<_i11.MagicItemData>(
      $magicItemData,
      columns: [_i11.MagicItemData.t.$_charactersMagicitemsCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [ArmorData]
  /// by setting the [ArmorData]'s foreign key `_charactersArmorCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> armor(
    _i1.Session session,
    _i12.ArmorData armorData, {
    _i1.Transaction? transaction,
  }) async {
    if (armorData.id == null) {
      throw ArgumentError.notNull('armorData.id');
    }

    var $armorData = _i12.ArmorDataImplicit(
      armorData,
      $_charactersArmorCharactersId: null,
    );
    await session.db.updateRow<_i12.ArmorData>(
      $armorData,
      columns: [_i12.ArmorData.t.$_charactersArmorCharactersId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterData] and the given [WeaponData]
  /// by setting the [WeaponData]'s foreign key `_charactersWeaponsCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> weapons(
    _i1.Session session,
    _i13.WeaponData weaponData, {
    _i1.Transaction? transaction,
  }) async {
    if (weaponData.id == null) {
      throw ArgumentError.notNull('weaponData.id');
    }

    var $weaponData = _i13.WeaponDataImplicit(
      weaponData,
      $_charactersWeaponsCharactersId: null,
    );
    await session.db.updateRow<_i13.WeaponData>(
      $weaponData,
      columns: [_i13.WeaponData.t.$_charactersWeaponsCharactersId],
      transaction: transaction,
    );
  }
}
