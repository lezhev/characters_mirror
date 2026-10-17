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
import '../../../data/general/class/class_data.dart' as _i7s9vfyh;
import '../../../data/general/spell_selection_filter_data.dart' as _iv73j5oi;
import '../../../enums/ability.dart' as _iw3bk51e;
import '../../../enums/class_spell_selection_mode.dart' as _iax70tek;
import '../../../enums/spellcasting_progression.dart' as _if4imcqg;

abstract class SubclassData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SubclassData._({
    this.id,
    this.spellSelectionFilter,
    this.referenceKey,
    this.name,
    this.description,
    this.shortDescription,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.subclassName,
    required this.parentClassId,
    this.parentClass,
    this.levelRequired,
    this.spellcastingStartLevel,
    this.spellcastingProgression,
    this.spellSelectionMode,
    this.spellcastingAbilityValue,
  });

  factory SubclassData({
    int? id,
    _iv73j5oi.SpellSelectionFilterData? spellSelectionFilter,
    String? referenceKey,
    String? name,
    String? description,
    String? shortDescription,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? subclassName,
    required int parentClassId,
    _i7s9vfyh.ClassData? parentClass,
    int? levelRequired,
    int? spellcastingStartLevel,
    _if4imcqg.SpellcastingProgression? spellcastingProgression,
    _iax70tek.ClassSpellSelectionMode? spellSelectionMode,
    _iw3bk51e.Ability? spellcastingAbilityValue,
  }) = _SubclassDataImpl;

  factory SubclassData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubclassData(
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
      shortDescription: jsonSerialization['shortDescription'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      subclassName: jsonSerialization['subclassName'] as String?,
      parentClassId: jsonSerialization['parentClassId'] as int,
      parentClass: jsonSerialization['parentClass'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i7s9vfyh.ClassData>(
              jsonSerialization['parentClass'],
            ),
      levelRequired: jsonSerialization['levelRequired'] as int?,
      spellcastingStartLevel:
          jsonSerialization['spellcastingStartLevel'] as int?,
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
    );
  }

  static final t = SubclassDataTable();

  static const db = SubclassDataRepository._();

  @override
  int? id;

  _iv73j5oi.SpellSelectionFilterData? spellSelectionFilter;

  String? referenceKey;

  String? name;

  String? description;

  String? shortDescription;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  String? subclassName;

  int parentClassId;

  _i7s9vfyh.ClassData? parentClass;

  int? levelRequired;

  int? spellcastingStartLevel;

  _if4imcqg.SpellcastingProgression? spellcastingProgression;

  _iax70tek.ClassSpellSelectionMode? spellSelectionMode;

  _iw3bk51e.Ability? spellcastingAbilityValue;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubclassData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SubclassData copyWith({
    int? id,
    _iv73j5oi.SpellSelectionFilterData? spellSelectionFilter,
    String? referenceKey,
    String? name,
    String? description,
    String? shortDescription,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? subclassName,
    int? parentClassId,
    _i7s9vfyh.ClassData? parentClass,
    int? levelRequired,
    int? spellcastingStartLevel,
    _if4imcqg.SpellcastingProgression? spellcastingProgression,
    _iax70tek.ClassSpellSelectionMode? spellSelectionMode,
    _iw3bk51e.Ability? spellcastingAbilityValue,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubclassData',
      if (id != null) 'id': id,
      if (spellSelectionFilter != null)
        'spellSelectionFilter': spellSelectionFilter?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (shortDescription != null) 'shortDescription': shortDescription,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (subclassName != null) 'subclassName': subclassName,
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJson(),
      if (levelRequired != null) 'levelRequired': levelRequired,
      if (spellcastingStartLevel != null)
        'spellcastingStartLevel': spellcastingStartLevel,
      if (spellcastingProgression != null)
        'spellcastingProgression': spellcastingProgression?.toJson(),
      if (spellSelectionMode != null)
        'spellSelectionMode': spellSelectionMode?.toJson(),
      if (spellcastingAbilityValue != null)
        'spellcastingAbilityValue': spellcastingAbilityValue?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubclassData',
      if (id != null) 'id': id,
      if (spellSelectionFilter != null)
        'spellSelectionFilter': spellSelectionFilter?.toJsonForProtocol(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (shortDescription != null) 'shortDescription': shortDescription,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (subclassName != null) 'subclassName': subclassName,
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJsonForProtocol(),
      if (levelRequired != null) 'levelRequired': levelRequired,
      if (spellcastingStartLevel != null)
        'spellcastingStartLevel': spellcastingStartLevel,
      if (spellcastingProgression != null)
        'spellcastingProgression': spellcastingProgression?.toJson(),
      if (spellSelectionMode != null)
        'spellSelectionMode': spellSelectionMode?.toJson(),
      if (spellcastingAbilityValue != null)
        'spellcastingAbilityValue': spellcastingAbilityValue?.toJson(),
    };
  }

  static SubclassDataInclude include({
    _i7s9vfyh.ClassDataInclude? parentClass,
  }) {
    return SubclassDataInclude._(parentClass: parentClass);
  }

  static SubclassDataIncludeList includeList({
    _is.WhereExpressionBuilder<SubclassDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SubclassDataTable>? orderBy,
    _is.OrderByListBuilder<SubclassDataTable>? orderByList,
    SubclassDataInclude? include,
  }) {
    return SubclassDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubclassData.t),
      orderByList: orderByList?.call(SubclassData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubclassDataImpl extends SubclassData {
  _SubclassDataImpl({
    int? id,
    _iv73j5oi.SpellSelectionFilterData? spellSelectionFilter,
    String? referenceKey,
    String? name,
    String? description,
    String? shortDescription,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? subclassName,
    required int parentClassId,
    _i7s9vfyh.ClassData? parentClass,
    int? levelRequired,
    int? spellcastingStartLevel,
    _if4imcqg.SpellcastingProgression? spellcastingProgression,
    _iax70tek.ClassSpellSelectionMode? spellSelectionMode,
    _iw3bk51e.Ability? spellcastingAbilityValue,
  }) : super._(
         id: id,
         spellSelectionFilter: spellSelectionFilter,
         referenceKey: referenceKey,
         name: name,
         description: description,
         shortDescription: shortDescription,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
         subclassName: subclassName,
         parentClassId: parentClassId,
         parentClass: parentClass,
         levelRequired: levelRequired,
         spellcastingStartLevel: spellcastingStartLevel,
         spellcastingProgression: spellcastingProgression,
         spellSelectionMode: spellSelectionMode,
         spellcastingAbilityValue: spellcastingAbilityValue,
       );

  /// Returns a shallow copy of this [SubclassData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SubclassData copyWith({
    Object? id = _Undefined,
    Object? spellSelectionFilter = _Undefined,
    Object? referenceKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? shortDescription = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? subclassName = _Undefined,
    int? parentClassId,
    Object? parentClass = _Undefined,
    Object? levelRequired = _Undefined,
    Object? spellcastingStartLevel = _Undefined,
    Object? spellcastingProgression = _Undefined,
    Object? spellSelectionMode = _Undefined,
    Object? spellcastingAbilityValue = _Undefined,
  }) {
    return SubclassData(
      id: id is int? ? id : this.id,
      spellSelectionFilter:
          spellSelectionFilter is _iv73j5oi.SpellSelectionFilterData?
          ? spellSelectionFilter
          : this.spellSelectionFilter?.copyWith(),
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      shortDescription: shortDescription is String?
          ? shortDescription
          : this.shortDescription,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      subclassName: subclassName is String? ? subclassName : this.subclassName,
      parentClassId: parentClassId ?? this.parentClassId,
      parentClass: parentClass is _i7s9vfyh.ClassData?
          ? parentClass
          : this.parentClass?.copyWith(),
      levelRequired: levelRequired is int? ? levelRequired : this.levelRequired,
      spellcastingStartLevel: spellcastingStartLevel is int?
          ? spellcastingStartLevel
          : this.spellcastingStartLevel,
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
    );
  }
}

class SubclassDataUpdateTable extends _is.UpdateTable<SubclassDataTable> {
  SubclassDataUpdateTable(super.table);

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

  _is.ColumnValue<String, String> shortDescription(String? value) =>
      _is.ColumnValue(table.shortDescription, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);

  _is.ColumnValue<String, String> subclassName(String? value) =>
      _is.ColumnValue(table.subclassName, value);

  _is.ColumnValue<int, int> parentClassId(int value) =>
      _is.ColumnValue(table.parentClassId, value);

  _is.ColumnValue<int, int> levelRequired(int? value) =>
      _is.ColumnValue(table.levelRequired, value);

  _is.ColumnValue<int, int> spellcastingStartLevel(int? value) =>
      _is.ColumnValue(table.spellcastingStartLevel, value);

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
}

class SubclassDataTable extends _is.Table<int?> {
  SubclassDataTable({super.tableRelation}) : super(tableName: 'subclass_data') {
    updateTable = SubclassDataUpdateTable(this);
    spellSelectionFilter =
        _is.ColumnSerializable<_iv73j5oi.SpellSelectionFilterData>(
          'spellSelectionFilter',
          this,
        );
    referenceKey = _is.ColumnString('referenceKey', this);
    name = _is.ColumnString('name', this);
    description = _is.ColumnString('description', this);
    shortDescription = _is.ColumnString('shortDescription', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    subclassName = _is.ColumnString('subclassName', this);
    parentClassId = _is.ColumnInt('parentClassId', this);
    levelRequired = _is.ColumnInt('levelRequired', this);
    spellcastingStartLevel = _is.ColumnInt('spellcastingStartLevel', this);
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
  }

  late final SubclassDataUpdateTable updateTable;

  late final _is.ColumnSerializable<_iv73j5oi.SpellSelectionFilterData>
  spellSelectionFilter;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnString shortDescription;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnString subclassName;

  late final _is.ColumnInt parentClassId;

  _i7s9vfyh.ClassDataTable? _parentClass;

  late final _is.ColumnInt levelRequired;

  late final _is.ColumnInt spellcastingStartLevel;

  late final _is.ColumnEnum<_if4imcqg.SpellcastingProgression>
  spellcastingProgression;

  late final _is.ColumnEnum<_iax70tek.ClassSpellSelectionMode>
  spellSelectionMode;

  late final _is.ColumnEnum<_iw3bk51e.Ability> spellcastingAbilityValue;

  _i7s9vfyh.ClassDataTable get parentClass {
    if (_parentClass != null) return _parentClass!;
    _parentClass = _is.createRelationTable(
      relationFieldName: 'parentClass',
      field: SubclassData.t.parentClassId,
      foreignField: _i7s9vfyh.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7s9vfyh.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _parentClass!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    spellSelectionFilter,
    referenceKey,
    name,
    description,
    shortDescription,
    source,
    version,
    createdAt,
    updatedAt,
    subclassName,
    parentClassId,
    levelRequired,
    spellcastingStartLevel,
    spellcastingProgression,
    spellSelectionMode,
    spellcastingAbilityValue,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'parentClass') {
      return parentClass;
    }
    return null;
  }
}

class SubclassDataInclude extends _is.IncludeObject {
  SubclassDataInclude._({_i7s9vfyh.ClassDataInclude? parentClass}) {
    _parentClass = parentClass;
  }

  _i7s9vfyh.ClassDataInclude? _parentClass;

  @override
  Map<String, _is.Include?> get includes => {'parentClass': _parentClass};

  @override
  _is.Table<int?> get table => SubclassData.t;
}

class SubclassDataIncludeList extends _is.IncludeList {
  SubclassDataIncludeList._({
    _is.WhereExpressionBuilder<SubclassDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubclassData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SubclassData.t;
}

class SubclassDataRepository {
  const SubclassDataRepository._();

  final attachRow = const SubclassDataAttachRowRepository._();

  /// Returns a list of [SubclassData]s matching the given query parameters.
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
  Future<List<SubclassData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SubclassDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SubclassDataTable>? orderBy,
    _is.OrderByListBuilder<SubclassDataTable>? orderByList,
    _is.Transaction? transaction,
    SubclassDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SubclassData>(
      where: where?.call(SubclassData.t),
      orderBy: orderBy?.call(SubclassData.t),
      orderByList: orderByList?.call(SubclassData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SubclassData] matching the given query parameters.
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
  Future<SubclassData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SubclassDataTable>? where,
    int? offset,
    _is.OrderByBuilder<SubclassDataTable>? orderBy,
    _is.OrderByListBuilder<SubclassDataTable>? orderByList,
    _is.Transaction? transaction,
    SubclassDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SubclassData>(
      where: where?.call(SubclassData.t),
      orderBy: orderBy?.call(SubclassData.t),
      orderByList: orderByList?.call(SubclassData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SubclassData] by its [id] or null if no such row exists.
  Future<SubclassData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    SubclassDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SubclassData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SubclassData]s in the list and returns the inserted rows.
  ///
  /// The returned [SubclassData]s will have their `id` fields set.
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
  Future<List<SubclassData>> insert(
    _is.DatabaseSession session,
    List<SubclassData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SubclassData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SubclassData] and returns the inserted row.
  ///
  /// The returned [SubclassData] will have its `id` field set.
  Future<SubclassData> insertRow(
    _is.DatabaseSession session,
    SubclassData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubclassData>(row, transaction: transaction);
  }

  /// Upserts all [SubclassData]s in the list and returns the resulting rows.
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
  /// The returned [SubclassData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SubclassData>> upsert(
    _is.DatabaseSession session,
    List<SubclassData> rows, {
    required _is.ColumnSelections<SubclassDataTable> conflictColumns,
    _is.ColumnSelections<SubclassDataTable>? updateColumns,
    _is.WhereExpressionBuilder<SubclassDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SubclassData>(
      rows,
      conflictColumns: conflictColumns(SubclassData.t),
      updateColumns: updateColumns?.call(SubclassData.t),
      updateWhere: updateWhere?.call(SubclassData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SubclassData] and returns the resulting row.
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
  /// The returned [SubclassData] will have its `id` field set.
  Future<SubclassData?> upsertRow(
    _is.DatabaseSession session,
    SubclassData row, {
    required _is.ColumnSelections<SubclassDataTable> conflictColumns,
    _is.ColumnSelections<SubclassDataTable>? updateColumns,
    _is.WhereExpressionBuilder<SubclassDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SubclassData>(
      row,
      conflictColumns: conflictColumns(SubclassData.t),
      updateColumns: updateColumns?.call(SubclassData.t),
      updateWhere: updateWhere?.call(SubclassData.t),
      transaction: transaction,
    );
  }

  /// Updates all [SubclassData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SubclassData>> update(
    _is.DatabaseSession session,
    List<SubclassData> rows, {
    _is.ColumnSelections<SubclassDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SubclassData>(
      rows,
      columns: columns?.call(SubclassData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SubclassData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubclassData> updateRow(
    _is.DatabaseSession session,
    SubclassData row, {
    _is.ColumnSelections<SubclassDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubclassData>(
      row,
      columns: columns?.call(SubclassData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubclassData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubclassData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SubclassDataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SubclassData>(
      id,
      columnValues: columnValues(SubclassData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubclassData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SubclassData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SubclassDataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SubclassDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SubclassDataTable>? orderBy,
    _is.OrderByListBuilder<SubclassDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SubclassData>(
      columnValues: columnValues(SubclassData.t.updateTable),
      where: where(SubclassData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubclassData.t),
      orderByList: orderByList?.call(SubclassData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SubclassData]s in the list and returns the deleted rows.
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
  Future<List<SubclassData>> delete(
    _is.DatabaseSession session,
    List<SubclassData> rows, {
    _is.OrderByBuilder<SubclassDataTable>? orderBy,
    _is.OrderByListBuilder<SubclassDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SubclassData>(
      rows,
      orderBy: orderBy?.call(SubclassData.t),
      orderByList: orderByList?.call(SubclassData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SubclassData].
  Future<SubclassData> deleteRow(
    _is.DatabaseSession session,
    SubclassData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubclassData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SubclassData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SubclassDataTable> where,
    _is.OrderByBuilder<SubclassDataTable>? orderBy,
    _is.OrderByListBuilder<SubclassDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SubclassData>(
      where: where(SubclassData.t),
      orderBy: orderBy?.call(SubclassData.t),
      orderByList: orderByList?.call(SubclassData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SubclassDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SubclassData>(
      where: where?.call(SubclassData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SubclassData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SubclassDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SubclassData>(
      where: where(SubclassData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SubclassDataAttachRowRepository {
  const SubclassDataAttachRowRepository._();

  /// Creates a relation between the given [SubclassData] and [ClassData]
  /// by setting the [SubclassData]'s foreign key `parentClassId` to refer to the [ClassData].
  Future<void> parentClass(
    _is.DatabaseSession session,
    SubclassData subclassData,
    _i7s9vfyh.ClassData parentClass, {
    _is.Transaction? transaction,
  }) async {
    if (subclassData.id == null) {
      throw ArgumentError.notNull('subclassData.id');
    }
    if (parentClass.id == null) {
      throw ArgumentError.notNull('parentClass.id');
    }

    var $subclassData = subclassData.copyWith(parentClassId: parentClass.id);
    await session.db.updateRow<SubclassData>(
      $subclassData,
      columns: [SubclassData.t.parentClassId],
      transaction: transaction,
    );
  }
}
