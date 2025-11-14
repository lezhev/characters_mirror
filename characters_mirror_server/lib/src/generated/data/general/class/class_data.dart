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
import '../../../data/items/weapon_data.dart' as _i2;
import '../../../data/items/item_data.dart' as _i3;

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
    this.hitDie,
    this.savingThrows,
    this.proficienciesArmor,
    this.proficienciesWeapons,
    this.proficienciesTools,
    this.skills,
    this.skillCount,
    this.spellcasting,
    this.spellcastingAbility,
    this.startingEquipment,
    this.imageURL,
  }) : _charactersClassesCharactersId = null;

  factory ClassData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? hitDie,
    List<String>? savingThrows,
    List<int>? proficienciesArmor,
    List<_i2.WeaponData>? proficienciesWeapons,
    List<_i3.ItemData>? proficienciesTools,
    List<String>? skills,
    int? skillCount,
    bool? spellcasting,
    String? spellcastingAbility,
    List<_i3.ItemData>? startingEquipment,
    String? imageURL,
  }) = _ClassDataImpl;

  factory ClassData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassDataImplicit._(
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
      hitDie: jsonSerialization['hitDie'] as String?,
      savingThrows: (jsonSerialization['savingThrows'] as List?)
          ?.map((e) => e as String)
          .toList(),
      proficienciesArmor: (jsonSerialization['proficienciesArmor'] as List?)
          ?.map((e) => e as int)
          .toList(),
      proficienciesWeapons: (jsonSerialization['proficienciesWeapons'] as List?)
          ?.map((e) => _i2.WeaponData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      proficienciesTools: (jsonSerialization['proficienciesTools'] as List?)
          ?.map((e) => _i3.ItemData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      skills: (jsonSerialization['skills'] as List?)
          ?.map((e) => e as String)
          .toList(),
      skillCount: jsonSerialization['skillCount'] as int?,
      spellcasting: jsonSerialization['spellcasting'] as bool?,
      spellcastingAbility: jsonSerialization['spellcastingAbility'] as String?,
      startingEquipment: (jsonSerialization['startingEquipment'] as List?)
          ?.map((e) => _i3.ItemData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      imageURL: jsonSerialization['imageURL'] as String?,
      $_charactersClassesCharactersId:
          jsonSerialization['_charactersClassesCharactersId'] as int?,
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

  String? hitDie;

  List<String>? savingThrows;

  List<int>? proficienciesArmor;

  List<_i2.WeaponData>? proficienciesWeapons;

  List<_i3.ItemData>? proficienciesTools;

  List<String>? skills;

  int? skillCount;

  bool? spellcasting;

  String? spellcastingAbility;

  List<_i3.ItemData>? startingEquipment;

  String? imageURL;

  final int? _charactersClassesCharactersId;

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
    String? hitDie,
    List<String>? savingThrows,
    List<int>? proficienciesArmor,
    List<_i2.WeaponData>? proficienciesWeapons,
    List<_i3.ItemData>? proficienciesTools,
    List<String>? skills,
    int? skillCount,
    bool? spellcasting,
    String? spellcastingAbility,
    List<_i3.ItemData>? startingEquipment,
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
      if (hitDie != null) 'hitDie': hitDie,
      if (savingThrows != null) 'savingThrows': savingThrows?.toJson(),
      if (proficienciesArmor != null)
        'proficienciesArmor': proficienciesArmor?.toJson(),
      if (proficienciesWeapons != null)
        'proficienciesWeapons':
            proficienciesWeapons?.toJson(valueToJson: (v) => v.toJson()),
      if (proficienciesTools != null)
        'proficienciesTools':
            proficienciesTools?.toJson(valueToJson: (v) => v.toJson()),
      if (skills != null) 'skills': skills?.toJson(),
      if (skillCount != null) 'skillCount': skillCount,
      if (spellcasting != null) 'spellcasting': spellcasting,
      if (spellcastingAbility != null)
        'spellcastingAbility': spellcastingAbility,
      if (startingEquipment != null)
        'startingEquipment':
            startingEquipment?.toJson(valueToJson: (v) => v.toJson()),
      if (imageURL != null) 'imageURL': imageURL,
      if (_charactersClassesCharactersId != null)
        '_charactersClassesCharactersId': _charactersClassesCharactersId,
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
      if (hitDie != null) 'hitDie': hitDie,
      if (savingThrows != null) 'savingThrows': savingThrows?.toJson(),
      if (proficienciesArmor != null)
        'proficienciesArmor': proficienciesArmor?.toJson(),
      if (proficienciesWeapons != null)
        'proficienciesWeapons': proficienciesWeapons?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (proficienciesTools != null)
        'proficienciesTools': proficienciesTools?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (skills != null) 'skills': skills?.toJson(),
      if (skillCount != null) 'skillCount': skillCount,
      if (spellcasting != null) 'spellcasting': spellcasting,
      if (spellcastingAbility != null)
        'spellcastingAbility': spellcastingAbility,
      if (startingEquipment != null)
        'startingEquipment': startingEquipment?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (imageURL != null) 'imageURL': imageURL,
    };
  }

  static ClassDataInclude include({
    _i2.WeaponDataIncludeList? proficienciesWeapons,
    _i3.ItemDataIncludeList? proficienciesTools,
    _i3.ItemDataIncludeList? startingEquipment,
  }) {
    return ClassDataInclude._(
      proficienciesWeapons: proficienciesWeapons,
      proficienciesTools: proficienciesTools,
      startingEquipment: startingEquipment,
    );
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
    String? hitDie,
    List<String>? savingThrows,
    List<int>? proficienciesArmor,
    List<_i2.WeaponData>? proficienciesWeapons,
    List<_i3.ItemData>? proficienciesTools,
    List<String>? skills,
    int? skillCount,
    bool? spellcasting,
    String? spellcastingAbility,
    List<_i3.ItemData>? startingEquipment,
    String? imageURL,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          hitDie: hitDie,
          savingThrows: savingThrows,
          proficienciesArmor: proficienciesArmor,
          proficienciesWeapons: proficienciesWeapons,
          proficienciesTools: proficienciesTools,
          skills: skills,
          skillCount: skillCount,
          spellcasting: spellcasting,
          spellcastingAbility: spellcastingAbility,
          startingEquipment: startingEquipment,
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
    Object? hitDie = _Undefined,
    Object? savingThrows = _Undefined,
    Object? proficienciesArmor = _Undefined,
    Object? proficienciesWeapons = _Undefined,
    Object? proficienciesTools = _Undefined,
    Object? skills = _Undefined,
    Object? skillCount = _Undefined,
    Object? spellcasting = _Undefined,
    Object? spellcastingAbility = _Undefined,
    Object? startingEquipment = _Undefined,
    Object? imageURL = _Undefined,
  }) {
    return ClassDataImplicit._(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      hitDie: hitDie is String? ? hitDie : this.hitDie,
      savingThrows: savingThrows is List<String>?
          ? savingThrows
          : this.savingThrows?.map((e0) => e0).toList(),
      proficienciesArmor: proficienciesArmor is List<int>?
          ? proficienciesArmor
          : this.proficienciesArmor?.map((e0) => e0).toList(),
      proficienciesWeapons: proficienciesWeapons is List<_i2.WeaponData>?
          ? proficienciesWeapons
          : this.proficienciesWeapons?.map((e0) => e0.copyWith()).toList(),
      proficienciesTools: proficienciesTools is List<_i3.ItemData>?
          ? proficienciesTools
          : this.proficienciesTools?.map((e0) => e0.copyWith()).toList(),
      skills: skills is List<String>?
          ? skills
          : this.skills?.map((e0) => e0).toList(),
      skillCount: skillCount is int? ? skillCount : this.skillCount,
      spellcasting: spellcasting is bool? ? spellcasting : this.spellcasting,
      spellcastingAbility: spellcastingAbility is String?
          ? spellcastingAbility
          : this.spellcastingAbility,
      startingEquipment: startingEquipment is List<_i3.ItemData>?
          ? startingEquipment
          : this.startingEquipment?.map((e0) => e0.copyWith()).toList(),
      imageURL: imageURL is String? ? imageURL : this.imageURL,
      $_charactersClassesCharactersId: this._charactersClassesCharactersId,
    );
  }
}

class ClassDataImplicit extends _ClassDataImpl {
  ClassDataImplicit._({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? hitDie,
    List<String>? savingThrows,
    List<int>? proficienciesArmor,
    List<_i2.WeaponData>? proficienciesWeapons,
    List<_i3.ItemData>? proficienciesTools,
    List<String>? skills,
    int? skillCount,
    bool? spellcasting,
    String? spellcastingAbility,
    List<_i3.ItemData>? startingEquipment,
    String? imageURL,
    int? $_charactersClassesCharactersId,
  })  : _charactersClassesCharactersId = $_charactersClassesCharactersId,
        super(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          hitDie: hitDie,
          savingThrows: savingThrows,
          proficienciesArmor: proficienciesArmor,
          proficienciesWeapons: proficienciesWeapons,
          proficienciesTools: proficienciesTools,
          skills: skills,
          skillCount: skillCount,
          spellcasting: spellcasting,
          spellcastingAbility: spellcastingAbility,
          startingEquipment: startingEquipment,
          imageURL: imageURL,
        );

  factory ClassDataImplicit(
    ClassData classData, {
    int? $_charactersClassesCharactersId,
  }) {
    return ClassDataImplicit._(
      id: classData.id,
      name: classData.name,
      description: classData.description,
      source: classData.source,
      version: classData.version,
      createdAt: classData.createdAt,
      updatedAt: classData.updatedAt,
      hitDie: classData.hitDie,
      savingThrows: classData.savingThrows,
      proficienciesArmor: classData.proficienciesArmor,
      proficienciesWeapons: classData.proficienciesWeapons,
      proficienciesTools: classData.proficienciesTools,
      skills: classData.skills,
      skillCount: classData.skillCount,
      spellcasting: classData.spellcasting,
      spellcastingAbility: classData.spellcastingAbility,
      startingEquipment: classData.startingEquipment,
      imageURL: classData.imageURL,
      $_charactersClassesCharactersId: $_charactersClassesCharactersId,
    );
  }

  @override
  final int? _charactersClassesCharactersId;
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
    hitDie = _i1.ColumnString(
      'hitDie',
      this,
    );
    savingThrows = _i1.ColumnSerializable(
      'savingThrows',
      this,
    );
    proficienciesArmor = _i1.ColumnSerializable(
      'proficienciesArmor',
      this,
    );
    skills = _i1.ColumnSerializable(
      'skills',
      this,
    );
    skillCount = _i1.ColumnInt(
      'skillCount',
      this,
    );
    spellcasting = _i1.ColumnBool(
      'spellcasting',
      this,
    );
    spellcastingAbility = _i1.ColumnString(
      'spellcastingAbility',
      this,
    );
    imageURL = _i1.ColumnString(
      'imageURL',
      this,
    );
    $_charactersClassesCharactersId = _i1.ColumnInt(
      '_charactersClassesCharactersId',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnString hitDie;

  late final _i1.ColumnSerializable savingThrows;

  late final _i1.ColumnSerializable proficienciesArmor;

  _i2.WeaponDataTable? ___proficienciesWeapons;

  _i1.ManyRelation<_i2.WeaponDataTable>? _proficienciesWeapons;

  _i3.ItemDataTable? ___proficienciesTools;

  _i1.ManyRelation<_i3.ItemDataTable>? _proficienciesTools;

  late final _i1.ColumnSerializable skills;

  late final _i1.ColumnInt skillCount;

  late final _i1.ColumnBool spellcasting;

  late final _i1.ColumnString spellcastingAbility;

  _i3.ItemDataTable? ___startingEquipment;

  _i1.ManyRelation<_i3.ItemDataTable>? _startingEquipment;

  late final _i1.ColumnString imageURL;

  late final _i1.ColumnInt $_charactersClassesCharactersId;

  _i2.WeaponDataTable get __proficienciesWeapons {
    if (___proficienciesWeapons != null) return ___proficienciesWeapons!;
    ___proficienciesWeapons = _i1.createRelationTable(
      relationFieldName: '__proficienciesWeapons',
      field: ClassData.t.id,
      foreignField: _i2.WeaponData.t.$_classDataProficienciesweaponsClassDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.WeaponDataTable(tableRelation: foreignTableRelation),
    );
    return ___proficienciesWeapons!;
  }

  _i3.ItemDataTable get __proficienciesTools {
    if (___proficienciesTools != null) return ___proficienciesTools!;
    ___proficienciesTools = _i1.createRelationTable(
      relationFieldName: '__proficienciesTools',
      field: ClassData.t.id,
      foreignField: _i3.ItemData.t.$_classDataProficienciestoolsClassDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ItemDataTable(tableRelation: foreignTableRelation),
    );
    return ___proficienciesTools!;
  }

  _i3.ItemDataTable get __startingEquipment {
    if (___startingEquipment != null) return ___startingEquipment!;
    ___startingEquipment = _i1.createRelationTable(
      relationFieldName: '__startingEquipment',
      field: ClassData.t.id,
      foreignField: _i3.ItemData.t.$_classDataStartingequipmentClassDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ItemDataTable(tableRelation: foreignTableRelation),
    );
    return ___startingEquipment!;
  }

  _i1.ManyRelation<_i2.WeaponDataTable> get proficienciesWeapons {
    if (_proficienciesWeapons != null) return _proficienciesWeapons!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'proficienciesWeapons',
      field: ClassData.t.id,
      foreignField: _i2.WeaponData.t.$_classDataProficienciesweaponsClassDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.WeaponDataTable(tableRelation: foreignTableRelation),
    );
    _proficienciesWeapons = _i1.ManyRelation<_i2.WeaponDataTable>(
      tableWithRelations: relationTable,
      table: _i2.WeaponDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _proficienciesWeapons!;
  }

  _i1.ManyRelation<_i3.ItemDataTable> get proficienciesTools {
    if (_proficienciesTools != null) return _proficienciesTools!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'proficienciesTools',
      field: ClassData.t.id,
      foreignField: _i3.ItemData.t.$_classDataProficienciestoolsClassDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ItemDataTable(tableRelation: foreignTableRelation),
    );
    _proficienciesTools = _i1.ManyRelation<_i3.ItemDataTable>(
      tableWithRelations: relationTable,
      table: _i3.ItemDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _proficienciesTools!;
  }

  _i1.ManyRelation<_i3.ItemDataTable> get startingEquipment {
    if (_startingEquipment != null) return _startingEquipment!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'startingEquipment',
      field: ClassData.t.id,
      foreignField: _i3.ItemData.t.$_classDataStartingequipmentClassDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ItemDataTable(tableRelation: foreignTableRelation),
    );
    _startingEquipment = _i1.ManyRelation<_i3.ItemDataTable>(
      tableWithRelations: relationTable,
      table: _i3.ItemDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _startingEquipment!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        hitDie,
        savingThrows,
        proficienciesArmor,
        skills,
        skillCount,
        spellcasting,
        spellcastingAbility,
        imageURL,
        $_charactersClassesCharactersId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        hitDie,
        savingThrows,
        proficienciesArmor,
        skills,
        skillCount,
        spellcasting,
        spellcastingAbility,
        imageURL,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'proficienciesWeapons') {
      return __proficienciesWeapons;
    }
    if (relationField == 'proficienciesTools') {
      return __proficienciesTools;
    }
    if (relationField == 'startingEquipment') {
      return __startingEquipment;
    }
    return null;
  }
}

class ClassDataInclude extends _i1.IncludeObject {
  ClassDataInclude._({
    _i2.WeaponDataIncludeList? proficienciesWeapons,
    _i3.ItemDataIncludeList? proficienciesTools,
    _i3.ItemDataIncludeList? startingEquipment,
  }) {
    _proficienciesWeapons = proficienciesWeapons;
    _proficienciesTools = proficienciesTools;
    _startingEquipment = startingEquipment;
  }

  _i2.WeaponDataIncludeList? _proficienciesWeapons;

  _i3.ItemDataIncludeList? _proficienciesTools;

  _i3.ItemDataIncludeList? _startingEquipment;

  @override
  Map<String, _i1.Include?> get includes => {
        'proficienciesWeapons': _proficienciesWeapons,
        'proficienciesTools': _proficienciesTools,
        'startingEquipment': _startingEquipment,
      };

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

  final attach = const ClassDataAttachRepository._();

  final attachRow = const ClassDataAttachRowRepository._();

  final detach = const ClassDataDetachRepository._();

  final detachRow = const ClassDataDetachRowRepository._();

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
    ClassDataInclude? include,
  }) async {
    return session.db.find<ClassData>(
      where: where?.call(ClassData.t),
      orderBy: orderBy?.call(ClassData.t),
      orderByList: orderByList?.call(ClassData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    ClassDataInclude? include,
  }) async {
    return session.db.findFirstRow<ClassData>(
      where: where?.call(ClassData.t),
      orderBy: orderBy?.call(ClassData.t),
      orderByList: orderByList?.call(ClassData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ClassData] by its [id] or null if no such row exists.
  Future<ClassData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ClassDataInclude? include,
  }) async {
    return session.db.findById<ClassData>(
      id,
      transaction: transaction,
      include: include,
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

class ClassDataAttachRepository {
  const ClassDataAttachRepository._();

  /// Creates a relation between this [ClassData] and the given [WeaponData]s
  /// by setting each [WeaponData]'s foreign key `_classDataProficienciesweaponsClassDataId` to refer to this [ClassData].
  Future<void> proficienciesWeapons(
    _i1.Session session,
    ClassData classData,
    List<_i2.WeaponData> weaponData, {
    _i1.Transaction? transaction,
  }) async {
    if (weaponData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('weaponData.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $weaponData = weaponData
        .map((e) => _i2.WeaponDataImplicit(
              e,
              $_classDataProficienciesweaponsClassDataId: classData.id,
            ))
        .toList();
    await session.db.update<_i2.WeaponData>(
      $weaponData,
      columns: [_i2.WeaponData.t.$_classDataProficienciesweaponsClassDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassData] and the given [ItemData]s
  /// by setting each [ItemData]'s foreign key `_classDataProficienciestoolsClassDataId` to refer to this [ClassData].
  Future<void> proficienciesTools(
    _i1.Session session,
    ClassData classData,
    List<_i3.ItemData> itemData, {
    _i1.Transaction? transaction,
  }) async {
    if (itemData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('itemData.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $itemData = itemData
        .map((e) => _i3.ItemDataImplicit(
              e,
              $_classDataProficienciestoolsClassDataId: classData.id,
            ))
        .toList();
    await session.db.update<_i3.ItemData>(
      $itemData,
      columns: [_i3.ItemData.t.$_classDataProficienciestoolsClassDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassData] and the given [ItemData]s
  /// by setting each [ItemData]'s foreign key `_classDataStartingequipmentClassDataId` to refer to this [ClassData].
  Future<void> startingEquipment(
    _i1.Session session,
    ClassData classData,
    List<_i3.ItemData> itemData, {
    _i1.Transaction? transaction,
  }) async {
    if (itemData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('itemData.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $itemData = itemData
        .map((e) => _i3.ItemDataImplicit(
              e,
              $_classDataStartingequipmentClassDataId: classData.id,
            ))
        .toList();
    await session.db.update<_i3.ItemData>(
      $itemData,
      columns: [_i3.ItemData.t.$_classDataStartingequipmentClassDataId],
      transaction: transaction,
    );
  }
}

class ClassDataAttachRowRepository {
  const ClassDataAttachRowRepository._();

  /// Creates a relation between this [ClassData] and the given [WeaponData]
  /// by setting the [WeaponData]'s foreign key `_classDataProficienciesweaponsClassDataId` to refer to this [ClassData].
  Future<void> proficienciesWeapons(
    _i1.Session session,
    ClassData classData,
    _i2.WeaponData weaponData, {
    _i1.Transaction? transaction,
  }) async {
    if (weaponData.id == null) {
      throw ArgumentError.notNull('weaponData.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $weaponData = _i2.WeaponDataImplicit(
      weaponData,
      $_classDataProficienciesweaponsClassDataId: classData.id,
    );
    await session.db.updateRow<_i2.WeaponData>(
      $weaponData,
      columns: [_i2.WeaponData.t.$_classDataProficienciesweaponsClassDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassData] and the given [ItemData]
  /// by setting the [ItemData]'s foreign key `_classDataProficienciestoolsClassDataId` to refer to this [ClassData].
  Future<void> proficienciesTools(
    _i1.Session session,
    ClassData classData,
    _i3.ItemData itemData, {
    _i1.Transaction? transaction,
  }) async {
    if (itemData.id == null) {
      throw ArgumentError.notNull('itemData.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $itemData = _i3.ItemDataImplicit(
      itemData,
      $_classDataProficienciestoolsClassDataId: classData.id,
    );
    await session.db.updateRow<_i3.ItemData>(
      $itemData,
      columns: [_i3.ItemData.t.$_classDataProficienciestoolsClassDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassData] and the given [ItemData]
  /// by setting the [ItemData]'s foreign key `_classDataStartingequipmentClassDataId` to refer to this [ClassData].
  Future<void> startingEquipment(
    _i1.Session session,
    ClassData classData,
    _i3.ItemData itemData, {
    _i1.Transaction? transaction,
  }) async {
    if (itemData.id == null) {
      throw ArgumentError.notNull('itemData.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $itemData = _i3.ItemDataImplicit(
      itemData,
      $_classDataStartingequipmentClassDataId: classData.id,
    );
    await session.db.updateRow<_i3.ItemData>(
      $itemData,
      columns: [_i3.ItemData.t.$_classDataStartingequipmentClassDataId],
      transaction: transaction,
    );
  }
}

class ClassDataDetachRepository {
  const ClassDataDetachRepository._();

  /// Detaches the relation between this [ClassData] and the given [WeaponData]
  /// by setting the [WeaponData]'s foreign key `_classDataProficienciesweaponsClassDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> proficienciesWeapons(
    _i1.Session session,
    List<_i2.WeaponData> weaponData, {
    _i1.Transaction? transaction,
  }) async {
    if (weaponData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('weaponData.id');
    }

    var $weaponData = weaponData
        .map((e) => _i2.WeaponDataImplicit(
              e,
              $_classDataProficienciesweaponsClassDataId: null,
            ))
        .toList();
    await session.db.update<_i2.WeaponData>(
      $weaponData,
      columns: [_i2.WeaponData.t.$_classDataProficienciesweaponsClassDataId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassData] and the given [ItemData]
  /// by setting the [ItemData]'s foreign key `_classDataProficienciestoolsClassDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> proficienciesTools(
    _i1.Session session,
    List<_i3.ItemData> itemData, {
    _i1.Transaction? transaction,
  }) async {
    if (itemData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('itemData.id');
    }

    var $itemData = itemData
        .map((e) => _i3.ItemDataImplicit(
              e,
              $_classDataProficienciestoolsClassDataId: null,
            ))
        .toList();
    await session.db.update<_i3.ItemData>(
      $itemData,
      columns: [_i3.ItemData.t.$_classDataProficienciestoolsClassDataId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassData] and the given [ItemData]
  /// by setting the [ItemData]'s foreign key `_classDataStartingequipmentClassDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> startingEquipment(
    _i1.Session session,
    List<_i3.ItemData> itemData, {
    _i1.Transaction? transaction,
  }) async {
    if (itemData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('itemData.id');
    }

    var $itemData = itemData
        .map((e) => _i3.ItemDataImplicit(
              e,
              $_classDataStartingequipmentClassDataId: null,
            ))
        .toList();
    await session.db.update<_i3.ItemData>(
      $itemData,
      columns: [_i3.ItemData.t.$_classDataStartingequipmentClassDataId],
      transaction: transaction,
    );
  }
}

class ClassDataDetachRowRepository {
  const ClassDataDetachRowRepository._();

  /// Detaches the relation between this [ClassData] and the given [WeaponData]
  /// by setting the [WeaponData]'s foreign key `_classDataProficienciesweaponsClassDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> proficienciesWeapons(
    _i1.Session session,
    _i2.WeaponData weaponData, {
    _i1.Transaction? transaction,
  }) async {
    if (weaponData.id == null) {
      throw ArgumentError.notNull('weaponData.id');
    }

    var $weaponData = _i2.WeaponDataImplicit(
      weaponData,
      $_classDataProficienciesweaponsClassDataId: null,
    );
    await session.db.updateRow<_i2.WeaponData>(
      $weaponData,
      columns: [_i2.WeaponData.t.$_classDataProficienciesweaponsClassDataId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassData] and the given [ItemData]
  /// by setting the [ItemData]'s foreign key `_classDataProficienciestoolsClassDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> proficienciesTools(
    _i1.Session session,
    _i3.ItemData itemData, {
    _i1.Transaction? transaction,
  }) async {
    if (itemData.id == null) {
      throw ArgumentError.notNull('itemData.id');
    }

    var $itemData = _i3.ItemDataImplicit(
      itemData,
      $_classDataProficienciestoolsClassDataId: null,
    );
    await session.db.updateRow<_i3.ItemData>(
      $itemData,
      columns: [_i3.ItemData.t.$_classDataProficienciestoolsClassDataId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassData] and the given [ItemData]
  /// by setting the [ItemData]'s foreign key `_classDataStartingequipmentClassDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> startingEquipment(
    _i1.Session session,
    _i3.ItemData itemData, {
    _i1.Transaction? transaction,
  }) async {
    if (itemData.id == null) {
      throw ArgumentError.notNull('itemData.id');
    }

    var $itemData = _i3.ItemDataImplicit(
      itemData,
      $_classDataStartingequipmentClassDataId: null,
    );
    await session.db.updateRow<_i3.ItemData>(
      $itemData,
      columns: [_i3.ItemData.t.$_classDataStartingequipmentClassDataId],
      transaction: transaction,
    );
  }
}
