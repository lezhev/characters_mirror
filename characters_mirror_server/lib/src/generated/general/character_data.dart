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

abstract class CharacterData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = CharacterDataTable();

  static const db = CharacterDataRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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
      if (race != null) 'race': race?.toJsonForProtocol(),
      'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJsonForProtocol(),
      if (classes != null)
        'classes': classes?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (subclasses != null)
        'subclasses':
            subclasses?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (classFeatures != null)
        'classFeatures':
            classFeatures?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'backgroundId': backgroundId,
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
      'preparedSpellsId': preparedSpellsId,
      if (preparedSpells != null)
        'preparedSpells': preparedSpells?.toJsonForProtocol(),
      'writtenSpellsId': writtenSpellsId,
      if (writtenSpells != null)
        'writtenSpells': writtenSpells?.toJsonForProtocol(),
      'itemsId': itemsId,
      if (items != null) 'items': items?.toJsonForProtocol(),
      'magicItemsId': magicItemsId,
      if (magicItems != null) 'magicItems': magicItems?.toJsonForProtocol(),
      'armorId': armorId,
      if (armor != null) 'armor': armor?.toJsonForProtocol(),
      'weaponsId': weaponsId,
      if (weapons != null) 'weapons': weapons?.toJsonForProtocol(),
    };
  }

  static CharacterDataInclude include({
    _i2.RaceDataInclude? race,
    _i3.SubraceDataInclude? subrace,
    _i4.ClassDataIncludeList? classes,
    _i5.SubclassDataIncludeList? subclasses,
    _i6.ClassFeatureDataIncludeList? classFeatures,
    _i7.BackgroundDataInclude? background,
    _i8.SpellDataInclude? preparedSpells,
    _i8.SpellDataInclude? writtenSpells,
    _i9.ItemDataInclude? items,
    _i10.MagicItemDataInclude? magicItems,
    _i11.ArmorDataInclude? armor,
    _i12.WeaponDataInclude? weapons,
  }) {
    return CharacterDataInclude._(
      race: race,
      subrace: subrace,
      classes: classes,
      subclasses: subclasses,
      classFeatures: classFeatures,
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

class CharacterDataTable extends _i1.Table<int?> {
  CharacterDataTable({super.tableRelation}) : super(tableName: 'characters') {
    name = _i1.ColumnString(
      'name',
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
    preparedSpellsId = _i1.ColumnInt(
      'preparedSpellsId',
      this,
    );
    writtenSpellsId = _i1.ColumnInt(
      'writtenSpellsId',
      this,
    );
    itemsId = _i1.ColumnInt(
      'itemsId',
      this,
    );
    magicItemsId = _i1.ColumnInt(
      'magicItemsId',
      this,
    );
    armorId = _i1.ColumnInt(
      'armorId',
      this,
    );
    weaponsId = _i1.ColumnInt(
      'weaponsId',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString source;

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

  _i5.SubclassDataTable? ___subclasses;

  _i1.ManyRelation<_i5.SubclassDataTable>? _subclasses;

  _i6.ClassFeatureDataTable? ___classFeatures;

  _i1.ManyRelation<_i6.ClassFeatureDataTable>? _classFeatures;

  late final _i1.ColumnInt backgroundId;

  _i7.BackgroundDataTable? _background;

  late final _i1.ColumnString alignment;

  late final _i1.ColumnInt armorClass;

  late final _i1.ColumnInt speed;

  late final _i1.ColumnInt coins;

  late final _i1.ColumnSerializable skillProficiencies;

  late final _i1.ColumnSerializable skillExpertises;

  late final _i1.ColumnInt maxHp;

  late final _i1.ColumnInt temporaryHp;

  late final _i1.ColumnInt currentHp;

  late final _i1.ColumnInt preparedSpellsId;

  _i8.SpellDataTable? _preparedSpells;

  late final _i1.ColumnInt writtenSpellsId;

  _i8.SpellDataTable? _writtenSpells;

  late final _i1.ColumnInt itemsId;

  _i9.ItemDataTable? _items;

  late final _i1.ColumnInt magicItemsId;

  _i10.MagicItemDataTable? _magicItems;

  late final _i1.ColumnInt armorId;

  _i11.ArmorDataTable? _armor;

  late final _i1.ColumnInt weaponsId;

  _i12.WeaponDataTable? _weapons;

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

  _i5.SubclassDataTable get __subclasses {
    if (___subclasses != null) return ___subclasses!;
    ___subclasses = _i1.createRelationTable(
      relationFieldName: '__subclasses',
      field: CharacterData.t.id,
      foreignField: _i5.SubclassData.t.$_charactersSubclassesCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.SubclassDataTable(tableRelation: foreignTableRelation),
    );
    return ___subclasses!;
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

  _i7.BackgroundDataTable get background {
    if (_background != null) return _background!;
    _background = _i1.createRelationTable(
      relationFieldName: 'background',
      field: CharacterData.t.backgroundId,
      foreignField: _i7.BackgroundData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7.BackgroundDataTable(tableRelation: foreignTableRelation),
    );
    return _background!;
  }

  _i8.SpellDataTable get preparedSpells {
    if (_preparedSpells != null) return _preparedSpells!;
    _preparedSpells = _i1.createRelationTable(
      relationFieldName: 'preparedSpells',
      field: CharacterData.t.preparedSpellsId,
      foreignField: _i8.SpellData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.SpellDataTable(tableRelation: foreignTableRelation),
    );
    return _preparedSpells!;
  }

  _i8.SpellDataTable get writtenSpells {
    if (_writtenSpells != null) return _writtenSpells!;
    _writtenSpells = _i1.createRelationTable(
      relationFieldName: 'writtenSpells',
      field: CharacterData.t.writtenSpellsId,
      foreignField: _i8.SpellData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.SpellDataTable(tableRelation: foreignTableRelation),
    );
    return _writtenSpells!;
  }

  _i9.ItemDataTable get items {
    if (_items != null) return _items!;
    _items = _i1.createRelationTable(
      relationFieldName: 'items',
      field: CharacterData.t.itemsId,
      foreignField: _i9.ItemData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i9.ItemDataTable(tableRelation: foreignTableRelation),
    );
    return _items!;
  }

  _i10.MagicItemDataTable get magicItems {
    if (_magicItems != null) return _magicItems!;
    _magicItems = _i1.createRelationTable(
      relationFieldName: 'magicItems',
      field: CharacterData.t.magicItemsId,
      foreignField: _i10.MagicItemData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i10.MagicItemDataTable(tableRelation: foreignTableRelation),
    );
    return _magicItems!;
  }

  _i11.ArmorDataTable get armor {
    if (_armor != null) return _armor!;
    _armor = _i1.createRelationTable(
      relationFieldName: 'armor',
      field: CharacterData.t.armorId,
      foreignField: _i11.ArmorData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i11.ArmorDataTable(tableRelation: foreignTableRelation),
    );
    return _armor!;
  }

  _i12.WeaponDataTable get weapons {
    if (_weapons != null) return _weapons!;
    _weapons = _i1.createRelationTable(
      relationFieldName: 'weapons',
      field: CharacterData.t.weaponsId,
      foreignField: _i12.WeaponData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i12.WeaponDataTable(tableRelation: foreignTableRelation),
    );
    return _weapons!;
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

  _i1.ManyRelation<_i5.SubclassDataTable> get subclasses {
    if (_subclasses != null) return _subclasses!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'subclasses',
      field: CharacterData.t.id,
      foreignField: _i5.SubclassData.t.$_charactersSubclassesCharactersId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.SubclassDataTable(tableRelation: foreignTableRelation),
    );
    _subclasses = _i1.ManyRelation<_i5.SubclassDataTable>(
      tableWithRelations: relationTable,
      table: _i5.SubclassDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _subclasses!;
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

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        source,
        version,
        createdAt,
        updatedAt,
        experience,
        attributes,
        raceId,
        subraceId,
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
        preparedSpellsId,
        writtenSpellsId,
        itemsId,
        magicItemsId,
        armorId,
        weaponsId,
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
    if (relationField == 'subclasses') {
      return __subclasses;
    }
    if (relationField == 'classFeatures') {
      return __classFeatures;
    }
    if (relationField == 'background') {
      return background;
    }
    if (relationField == 'preparedSpells') {
      return preparedSpells;
    }
    if (relationField == 'writtenSpells') {
      return writtenSpells;
    }
    if (relationField == 'items') {
      return items;
    }
    if (relationField == 'magicItems') {
      return magicItems;
    }
    if (relationField == 'armor') {
      return armor;
    }
    if (relationField == 'weapons') {
      return weapons;
    }
    return null;
  }
}

class CharacterDataInclude extends _i1.IncludeObject {
  CharacterDataInclude._({
    _i2.RaceDataInclude? race,
    _i3.SubraceDataInclude? subrace,
    _i4.ClassDataIncludeList? classes,
    _i5.SubclassDataIncludeList? subclasses,
    _i6.ClassFeatureDataIncludeList? classFeatures,
    _i7.BackgroundDataInclude? background,
    _i8.SpellDataInclude? preparedSpells,
    _i8.SpellDataInclude? writtenSpells,
    _i9.ItemDataInclude? items,
    _i10.MagicItemDataInclude? magicItems,
    _i11.ArmorDataInclude? armor,
    _i12.WeaponDataInclude? weapons,
  }) {
    _race = race;
    _subrace = subrace;
    _classes = classes;
    _subclasses = subclasses;
    _classFeatures = classFeatures;
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

  _i5.SubclassDataIncludeList? _subclasses;

  _i6.ClassFeatureDataIncludeList? _classFeatures;

  _i7.BackgroundDataInclude? _background;

  _i8.SpellDataInclude? _preparedSpells;

  _i8.SpellDataInclude? _writtenSpells;

  _i9.ItemDataInclude? _items;

  _i10.MagicItemDataInclude? _magicItems;

  _i11.ArmorDataInclude? _armor;

  _i12.WeaponDataInclude? _weapons;

  @override
  Map<String, _i1.Include?> get includes => {
        'race': _race,
        'subrace': _subrace,
        'classes': _classes,
        'subclasses': _subclasses,
        'classFeatures': _classFeatures,
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

  /// Creates a relation between this [CharacterData] and the given [SubclassData]s
  /// by setting each [SubclassData]'s foreign key `_charactersSubclassesCharactersId` to refer to this [CharacterData].
  Future<void> subclasses(
    _i1.Session session,
    CharacterData characterData,
    List<_i5.SubclassData> subclassData, {
    _i1.Transaction? transaction,
  }) async {
    if (subclassData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('subclassData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $subclassData = subclassData
        .map((e) => _i5.SubclassDataImplicit(
              e,
              $_charactersSubclassesCharactersId: characterData.id,
            ))
        .toList();
    await session.db.update<_i5.SubclassData>(
      $subclassData,
      columns: [_i5.SubclassData.t.$_charactersSubclassesCharactersId],
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

  /// Creates a relation between the given [CharacterData] and [BackgroundData]
  /// by setting the [CharacterData]'s foreign key `backgroundId` to refer to the [BackgroundData].
  Future<void> background(
    _i1.Session session,
    CharacterData characterData,
    _i7.BackgroundData background, {
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

  /// Creates a relation between the given [CharacterData] and [SpellData]
  /// by setting the [CharacterData]'s foreign key `preparedSpellsId` to refer to the [SpellData].
  Future<void> preparedSpells(
    _i1.Session session,
    CharacterData characterData,
    _i8.SpellData preparedSpells, {
    _i1.Transaction? transaction,
  }) async {
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }
    if (preparedSpells.id == null) {
      throw ArgumentError.notNull('preparedSpells.id');
    }

    var $characterData =
        characterData.copyWith(preparedSpellsId: preparedSpells.id);
    await session.db.updateRow<CharacterData>(
      $characterData,
      columns: [CharacterData.t.preparedSpellsId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterData] and [SpellData]
  /// by setting the [CharacterData]'s foreign key `writtenSpellsId` to refer to the [SpellData].
  Future<void> writtenSpells(
    _i1.Session session,
    CharacterData characterData,
    _i8.SpellData writtenSpells, {
    _i1.Transaction? transaction,
  }) async {
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }
    if (writtenSpells.id == null) {
      throw ArgumentError.notNull('writtenSpells.id');
    }

    var $characterData =
        characterData.copyWith(writtenSpellsId: writtenSpells.id);
    await session.db.updateRow<CharacterData>(
      $characterData,
      columns: [CharacterData.t.writtenSpellsId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterData] and [ItemData]
  /// by setting the [CharacterData]'s foreign key `itemsId` to refer to the [ItemData].
  Future<void> items(
    _i1.Session session,
    CharacterData characterData,
    _i9.ItemData items, {
    _i1.Transaction? transaction,
  }) async {
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }
    if (items.id == null) {
      throw ArgumentError.notNull('items.id');
    }

    var $characterData = characterData.copyWith(itemsId: items.id);
    await session.db.updateRow<CharacterData>(
      $characterData,
      columns: [CharacterData.t.itemsId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterData] and [MagicItemData]
  /// by setting the [CharacterData]'s foreign key `magicItemsId` to refer to the [MagicItemData].
  Future<void> magicItems(
    _i1.Session session,
    CharacterData characterData,
    _i10.MagicItemData magicItems, {
    _i1.Transaction? transaction,
  }) async {
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }
    if (magicItems.id == null) {
      throw ArgumentError.notNull('magicItems.id');
    }

    var $characterData = characterData.copyWith(magicItemsId: magicItems.id);
    await session.db.updateRow<CharacterData>(
      $characterData,
      columns: [CharacterData.t.magicItemsId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterData] and [ArmorData]
  /// by setting the [CharacterData]'s foreign key `armorId` to refer to the [ArmorData].
  Future<void> armor(
    _i1.Session session,
    CharacterData characterData,
    _i11.ArmorData armor, {
    _i1.Transaction? transaction,
  }) async {
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }
    if (armor.id == null) {
      throw ArgumentError.notNull('armor.id');
    }

    var $characterData = characterData.copyWith(armorId: armor.id);
    await session.db.updateRow<CharacterData>(
      $characterData,
      columns: [CharacterData.t.armorId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterData] and [WeaponData]
  /// by setting the [CharacterData]'s foreign key `weaponsId` to refer to the [WeaponData].
  Future<void> weapons(
    _i1.Session session,
    CharacterData characterData,
    _i12.WeaponData weapons, {
    _i1.Transaction? transaction,
  }) async {
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }
    if (weapons.id == null) {
      throw ArgumentError.notNull('weapons.id');
    }

    var $characterData = characterData.copyWith(weaponsId: weapons.id);
    await session.db.updateRow<CharacterData>(
      $characterData,
      columns: [CharacterData.t.weaponsId],
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

  /// Creates a relation between this [CharacterData] and the given [SubclassData]
  /// by setting the [SubclassData]'s foreign key `_charactersSubclassesCharactersId` to refer to this [CharacterData].
  Future<void> subclasses(
    _i1.Session session,
    CharacterData characterData,
    _i5.SubclassData subclassData, {
    _i1.Transaction? transaction,
  }) async {
    if (subclassData.id == null) {
      throw ArgumentError.notNull('subclassData.id');
    }
    if (characterData.id == null) {
      throw ArgumentError.notNull('characterData.id');
    }

    var $subclassData = _i5.SubclassDataImplicit(
      subclassData,
      $_charactersSubclassesCharactersId: characterData.id,
    );
    await session.db.updateRow<_i5.SubclassData>(
      $subclassData,
      columns: [_i5.SubclassData.t.$_charactersSubclassesCharactersId],
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

  /// Detaches the relation between this [CharacterData] and the given [SubclassData]
  /// by setting the [SubclassData]'s foreign key `_charactersSubclassesCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subclasses(
    _i1.Session session,
    List<_i5.SubclassData> subclassData, {
    _i1.Transaction? transaction,
  }) async {
    if (subclassData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('subclassData.id');
    }

    var $subclassData = subclassData
        .map((e) => _i5.SubclassDataImplicit(
              e,
              $_charactersSubclassesCharactersId: null,
            ))
        .toList();
    await session.db.update<_i5.SubclassData>(
      $subclassData,
      columns: [_i5.SubclassData.t.$_charactersSubclassesCharactersId],
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
}

class CharacterDataDetachRowRepository {
  const CharacterDataDetachRowRepository._();

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

  /// Detaches the relation between this [CharacterData] and the given [SubclassData]
  /// by setting the [SubclassData]'s foreign key `_charactersSubclassesCharactersId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subclasses(
    _i1.Session session,
    _i5.SubclassData subclassData, {
    _i1.Transaction? transaction,
  }) async {
    if (subclassData.id == null) {
      throw ArgumentError.notNull('subclassData.id');
    }

    var $subclassData = _i5.SubclassDataImplicit(
      subclassData,
      $_charactersSubclassesCharactersId: null,
    );
    await session.db.updateRow<_i5.SubclassData>(
      $subclassData,
      columns: [_i5.SubclassData.t.$_charactersSubclassesCharactersId],
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
}
