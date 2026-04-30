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
import '../data/spell_data.dart' as _i2;
import '../data/general/class/class_data.dart' as _i3;
import '../data/general/class/subclass_data.dart' as _i4;
import '../data/general/class/class_feature_data.dart' as _i5;
import '../data/general/class/subclass_feature_data.dart' as _i6;

abstract class ClassSpellGrantData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ClassSpellGrantData._({
    this.id,
    this.spellId,
    this.spell,
    this.spellReferenceKey,
    this.sourceClassId,
    this.sourceClass,
    this.sourceSubclassId,
    this.sourceSubclass,
    this.sourceFeatureId,
    this.sourceFeature,
    this.sourceSubclassFeatureId,
    this.sourceSubclassFeature,
    this.grantedAtLevel,
    this.alwaysPrepared,
    this.notes,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassSpellGrantData({
    int? id,
    int? spellId,
    _i2.SpellData? spell,
    String? spellReferenceKey,
    int? sourceClassId,
    _i3.ClassData? sourceClass,
    int? sourceSubclassId,
    _i4.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _i5.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _i6.SubclassFeatureData? sourceSubclassFeature,
    int? grantedAtLevel,
    bool? alwaysPrepared,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ClassSpellGrantDataImpl;

  factory ClassSpellGrantData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassSpellGrantData(
      id: jsonSerialization['id'] as int?,
      spellId: jsonSerialization['spellId'] as int?,
      spell: jsonSerialization['spell'] == null
          ? null
          : _i2.SpellData.fromJson(
              (jsonSerialization['spell'] as Map<String, dynamic>)),
      spellReferenceKey: jsonSerialization['spellReferenceKey'] as String?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _i3.ClassData.fromJson(
              (jsonSerialization['sourceClass'] as Map<String, dynamic>)),
      sourceSubclassId: jsonSerialization['sourceSubclassId'] as int?,
      sourceSubclass: jsonSerialization['sourceSubclass'] == null
          ? null
          : _i4.SubclassData.fromJson(
              (jsonSerialization['sourceSubclass'] as Map<String, dynamic>)),
      sourceFeatureId: jsonSerialization['sourceFeatureId'] as int?,
      sourceFeature: jsonSerialization['sourceFeature'] == null
          ? null
          : _i5.ClassFeatureData.fromJson(
              (jsonSerialization['sourceFeature'] as Map<String, dynamic>)),
      sourceSubclassFeatureId:
          jsonSerialization['sourceSubclassFeatureId'] as int?,
      sourceSubclassFeature: jsonSerialization['sourceSubclassFeature'] == null
          ? null
          : _i6.SubclassFeatureData.fromJson(
              (jsonSerialization['sourceSubclassFeature']
                  as Map<String, dynamic>)),
      grantedAtLevel: jsonSerialization['grantedAtLevel'] as int?,
      alwaysPrepared: jsonSerialization['alwaysPrepared'] as bool?,
      notes: jsonSerialization['notes'] as String?,
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

  static final t = ClassSpellGrantDataTable();

  static const db = ClassSpellGrantDataRepository._();

  @override
  int? id;

  int? spellId;

  _i2.SpellData? spell;

  String? spellReferenceKey;

  int? sourceClassId;

  _i3.ClassData? sourceClass;

  int? sourceSubclassId;

  _i4.SubclassData? sourceSubclass;

  int? sourceFeatureId;

  _i5.ClassFeatureData? sourceFeature;

  int? sourceSubclassFeatureId;

  _i6.SubclassFeatureData? sourceSubclassFeature;

  int? grantedAtLevel;

  bool? alwaysPrepared;

  String? notes;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClassSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassSpellGrantData copyWith({
    int? id,
    int? spellId,
    _i2.SpellData? spell,
    String? spellReferenceKey,
    int? sourceClassId,
    _i3.ClassData? sourceClass,
    int? sourceSubclassId,
    _i4.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _i5.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _i6.SubclassFeatureData? sourceSubclassFeature,
    int? grantedAtLevel,
    bool? alwaysPrepared,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (spellId != null) 'spellId': spellId,
      if (spell != null) 'spell': spell?.toJson(),
      if (spellReferenceKey != null) 'spellReferenceKey': spellReferenceKey,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJson(),
      if (sourceSubclassId != null) 'sourceSubclassId': sourceSubclassId,
      if (sourceSubclass != null) 'sourceSubclass': sourceSubclass?.toJson(),
      if (sourceFeatureId != null) 'sourceFeatureId': sourceFeatureId,
      if (sourceFeature != null) 'sourceFeature': sourceFeature?.toJson(),
      if (sourceSubclassFeatureId != null)
        'sourceSubclassFeatureId': sourceSubclassFeatureId,
      if (sourceSubclassFeature != null)
        'sourceSubclassFeature': sourceSubclassFeature?.toJson(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (alwaysPrepared != null) 'alwaysPrepared': alwaysPrepared,
      if (notes != null) 'notes': notes,
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
      if (spellId != null) 'spellId': spellId,
      if (spell != null) 'spell': spell?.toJsonForProtocol(),
      if (spellReferenceKey != null) 'spellReferenceKey': spellReferenceKey,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJsonForProtocol(),
      if (sourceSubclassId != null) 'sourceSubclassId': sourceSubclassId,
      if (sourceSubclass != null)
        'sourceSubclass': sourceSubclass?.toJsonForProtocol(),
      if (sourceFeatureId != null) 'sourceFeatureId': sourceFeatureId,
      if (sourceFeature != null)
        'sourceFeature': sourceFeature?.toJsonForProtocol(),
      if (sourceSubclassFeatureId != null)
        'sourceSubclassFeatureId': sourceSubclassFeatureId,
      if (sourceSubclassFeature != null)
        'sourceSubclassFeature': sourceSubclassFeature?.toJsonForProtocol(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (alwaysPrepared != null) 'alwaysPrepared': alwaysPrepared,
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static ClassSpellGrantDataInclude include({
    _i2.SpellDataInclude? spell,
    _i3.ClassDataInclude? sourceClass,
    _i4.SubclassDataInclude? sourceSubclass,
    _i5.ClassFeatureDataInclude? sourceFeature,
    _i6.SubclassFeatureDataInclude? sourceSubclassFeature,
  }) {
    return ClassSpellGrantDataInclude._(
      spell: spell,
      sourceClass: sourceClass,
      sourceSubclass: sourceSubclass,
      sourceFeature: sourceFeature,
      sourceSubclassFeature: sourceSubclassFeature,
    );
  }

  static ClassSpellGrantDataIncludeList includeList({
    _i1.WhereExpressionBuilder<ClassSpellGrantDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassSpellGrantDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassSpellGrantDataTable>? orderByList,
    ClassSpellGrantDataInclude? include,
  }) {
    return ClassSpellGrantDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassSpellGrantData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ClassSpellGrantData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassSpellGrantDataImpl extends ClassSpellGrantData {
  _ClassSpellGrantDataImpl({
    int? id,
    int? spellId,
    _i2.SpellData? spell,
    String? spellReferenceKey,
    int? sourceClassId,
    _i3.ClassData? sourceClass,
    int? sourceSubclassId,
    _i4.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _i5.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _i6.SubclassFeatureData? sourceSubclassFeature,
    int? grantedAtLevel,
    bool? alwaysPrepared,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          spellId: spellId,
          spell: spell,
          spellReferenceKey: spellReferenceKey,
          sourceClassId: sourceClassId,
          sourceClass: sourceClass,
          sourceSubclassId: sourceSubclassId,
          sourceSubclass: sourceSubclass,
          sourceFeatureId: sourceFeatureId,
          sourceFeature: sourceFeature,
          sourceSubclassFeatureId: sourceSubclassFeatureId,
          sourceSubclassFeature: sourceSubclassFeature,
          grantedAtLevel: grantedAtLevel,
          alwaysPrepared: alwaysPrepared,
          notes: notes,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ClassSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassSpellGrantData copyWith({
    Object? id = _Undefined,
    Object? spellId = _Undefined,
    Object? spell = _Undefined,
    Object? spellReferenceKey = _Undefined,
    Object? sourceClassId = _Undefined,
    Object? sourceClass = _Undefined,
    Object? sourceSubclassId = _Undefined,
    Object? sourceSubclass = _Undefined,
    Object? sourceFeatureId = _Undefined,
    Object? sourceFeature = _Undefined,
    Object? sourceSubclassFeatureId = _Undefined,
    Object? sourceSubclassFeature = _Undefined,
    Object? grantedAtLevel = _Undefined,
    Object? alwaysPrepared = _Undefined,
    Object? notes = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return ClassSpellGrantData(
      id: id is int? ? id : this.id,
      spellId: spellId is int? ? spellId : this.spellId,
      spell: spell is _i2.SpellData? ? spell : this.spell?.copyWith(),
      spellReferenceKey: spellReferenceKey is String?
          ? spellReferenceKey
          : this.spellReferenceKey,
      sourceClassId: sourceClassId is int? ? sourceClassId : this.sourceClassId,
      sourceClass: sourceClass is _i3.ClassData?
          ? sourceClass
          : this.sourceClass?.copyWith(),
      sourceSubclassId:
          sourceSubclassId is int? ? sourceSubclassId : this.sourceSubclassId,
      sourceSubclass: sourceSubclass is _i4.SubclassData?
          ? sourceSubclass
          : this.sourceSubclass?.copyWith(),
      sourceFeatureId:
          sourceFeatureId is int? ? sourceFeatureId : this.sourceFeatureId,
      sourceFeature: sourceFeature is _i5.ClassFeatureData?
          ? sourceFeature
          : this.sourceFeature?.copyWith(),
      sourceSubclassFeatureId: sourceSubclassFeatureId is int?
          ? sourceSubclassFeatureId
          : this.sourceSubclassFeatureId,
      sourceSubclassFeature: sourceSubclassFeature is _i6.SubclassFeatureData?
          ? sourceSubclassFeature
          : this.sourceSubclassFeature?.copyWith(),
      grantedAtLevel:
          grantedAtLevel is int? ? grantedAtLevel : this.grantedAtLevel,
      alwaysPrepared:
          alwaysPrepared is bool? ? alwaysPrepared : this.alwaysPrepared,
      notes: notes is String? ? notes : this.notes,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class ClassSpellGrantDataTable extends _i1.Table<int?> {
  ClassSpellGrantDataTable({super.tableRelation})
      : super(tableName: 'class_spell_grant_data') {
    spellId = _i1.ColumnInt(
      'spellId',
      this,
    );
    sourceClassId = _i1.ColumnInt(
      'sourceClassId',
      this,
    );
    sourceSubclassId = _i1.ColumnInt(
      'sourceSubclassId',
      this,
    );
    sourceFeatureId = _i1.ColumnInt(
      'sourceFeatureId',
      this,
    );
    sourceSubclassFeatureId = _i1.ColumnInt(
      'sourceSubclassFeatureId',
      this,
    );
    grantedAtLevel = _i1.ColumnInt(
      'grantedAtLevel',
      this,
    );
    alwaysPrepared = _i1.ColumnBool(
      'alwaysPrepared',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
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

  late final _i1.ColumnInt spellId;

  _i2.SpellDataTable? _spell;

  late final _i1.ColumnInt sourceClassId;

  _i3.ClassDataTable? _sourceClass;

  late final _i1.ColumnInt sourceSubclassId;

  _i4.SubclassDataTable? _sourceSubclass;

  late final _i1.ColumnInt sourceFeatureId;

  _i5.ClassFeatureDataTable? _sourceFeature;

  late final _i1.ColumnInt sourceSubclassFeatureId;

  _i6.SubclassFeatureDataTable? _sourceSubclassFeature;

  late final _i1.ColumnInt grantedAtLevel;

  late final _i1.ColumnBool alwaysPrepared;

  late final _i1.ColumnString notes;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.SpellDataTable get spell {
    if (_spell != null) return _spell!;
    _spell = _i1.createRelationTable(
      relationFieldName: 'spell',
      field: ClassSpellGrantData.t.spellId,
      foreignField: _i2.SpellData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SpellDataTable(tableRelation: foreignTableRelation),
    );
    return _spell!;
  }

  _i3.ClassDataTable get sourceClass {
    if (_sourceClass != null) return _sourceClass!;
    _sourceClass = _i1.createRelationTable(
      relationFieldName: 'sourceClass',
      field: ClassSpellGrantData.t.sourceClassId,
      foreignField: _i3.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceClass!;
  }

  _i4.SubclassDataTable get sourceSubclass {
    if (_sourceSubclass != null) return _sourceSubclass!;
    _sourceSubclass = _i1.createRelationTable(
      relationFieldName: 'sourceSubclass',
      field: ClassSpellGrantData.t.sourceSubclassId,
      foreignField: _i4.SubclassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SubclassDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceSubclass!;
  }

  _i5.ClassFeatureDataTable get sourceFeature {
    if (_sourceFeature != null) return _sourceFeature!;
    _sourceFeature = _i1.createRelationTable(
      relationFieldName: 'sourceFeature',
      field: ClassSpellGrantData.t.sourceFeatureId,
      foreignField: _i5.ClassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.ClassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceFeature!;
  }

  _i6.SubclassFeatureDataTable get sourceSubclassFeature {
    if (_sourceSubclassFeature != null) return _sourceSubclassFeature!;
    _sourceSubclassFeature = _i1.createRelationTable(
      relationFieldName: 'sourceSubclassFeature',
      field: ClassSpellGrantData.t.sourceSubclassFeatureId,
      foreignField: _i6.SubclassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.SubclassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceSubclassFeature!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        spellId,
        sourceClassId,
        sourceSubclassId,
        sourceFeatureId,
        sourceSubclassFeatureId,
        grantedAtLevel,
        alwaysPrepared,
        notes,
        source,
        version,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'spell') {
      return spell;
    }
    if (relationField == 'sourceClass') {
      return sourceClass;
    }
    if (relationField == 'sourceSubclass') {
      return sourceSubclass;
    }
    if (relationField == 'sourceFeature') {
      return sourceFeature;
    }
    if (relationField == 'sourceSubclassFeature') {
      return sourceSubclassFeature;
    }
    return null;
  }
}

class ClassSpellGrantDataInclude extends _i1.IncludeObject {
  ClassSpellGrantDataInclude._({
    _i2.SpellDataInclude? spell,
    _i3.ClassDataInclude? sourceClass,
    _i4.SubclassDataInclude? sourceSubclass,
    _i5.ClassFeatureDataInclude? sourceFeature,
    _i6.SubclassFeatureDataInclude? sourceSubclassFeature,
  }) {
    _spell = spell;
    _sourceClass = sourceClass;
    _sourceSubclass = sourceSubclass;
    _sourceFeature = sourceFeature;
    _sourceSubclassFeature = sourceSubclassFeature;
  }

  _i2.SpellDataInclude? _spell;

  _i3.ClassDataInclude? _sourceClass;

  _i4.SubclassDataInclude? _sourceSubclass;

  _i5.ClassFeatureDataInclude? _sourceFeature;

  _i6.SubclassFeatureDataInclude? _sourceSubclassFeature;

  @override
  Map<String, _i1.Include?> get includes => {
        'spell': _spell,
        'sourceClass': _sourceClass,
        'sourceSubclass': _sourceSubclass,
        'sourceFeature': _sourceFeature,
        'sourceSubclassFeature': _sourceSubclassFeature,
      };

  @override
  _i1.Table<int?> get table => ClassSpellGrantData.t;
}

class ClassSpellGrantDataIncludeList extends _i1.IncludeList {
  ClassSpellGrantDataIncludeList._({
    _i1.WhereExpressionBuilder<ClassSpellGrantDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClassSpellGrantData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ClassSpellGrantData.t;
}

class ClassSpellGrantDataRepository {
  const ClassSpellGrantDataRepository._();

  final attachRow = const ClassSpellGrantDataAttachRowRepository._();

  final detachRow = const ClassSpellGrantDataDetachRowRepository._();

  /// Returns a list of [ClassSpellGrantData]s matching the given query parameters.
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
  Future<List<ClassSpellGrantData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassSpellGrantDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassSpellGrantDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassSpellGrantDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassSpellGrantDataInclude? include,
  }) async {
    return session.db.find<ClassSpellGrantData>(
      where: where?.call(ClassSpellGrantData.t),
      orderBy: orderBy?.call(ClassSpellGrantData.t),
      orderByList: orderByList?.call(ClassSpellGrantData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ClassSpellGrantData] matching the given query parameters.
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
  Future<ClassSpellGrantData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassSpellGrantDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClassSpellGrantDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassSpellGrantDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassSpellGrantDataInclude? include,
  }) async {
    return session.db.findFirstRow<ClassSpellGrantData>(
      where: where?.call(ClassSpellGrantData.t),
      orderBy: orderBy?.call(ClassSpellGrantData.t),
      orderByList: orderByList?.call(ClassSpellGrantData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ClassSpellGrantData] by its [id] or null if no such row exists.
  Future<ClassSpellGrantData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ClassSpellGrantDataInclude? include,
  }) async {
    return session.db.findById<ClassSpellGrantData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ClassSpellGrantData]s in the list and returns the inserted rows.
  ///
  /// The returned [ClassSpellGrantData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ClassSpellGrantData>> insert(
    _i1.Session session,
    List<ClassSpellGrantData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ClassSpellGrantData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ClassSpellGrantData] and returns the inserted row.
  ///
  /// The returned [ClassSpellGrantData] will have its `id` field set.
  Future<ClassSpellGrantData> insertRow(
    _i1.Session session,
    ClassSpellGrantData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClassSpellGrantData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ClassSpellGrantData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ClassSpellGrantData>> update(
    _i1.Session session,
    List<ClassSpellGrantData> rows, {
    _i1.ColumnSelections<ClassSpellGrantDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ClassSpellGrantData>(
      rows,
      columns: columns?.call(ClassSpellGrantData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClassSpellGrantData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClassSpellGrantData> updateRow(
    _i1.Session session,
    ClassSpellGrantData row, {
    _i1.ColumnSelections<ClassSpellGrantDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClassSpellGrantData>(
      row,
      columns: columns?.call(ClassSpellGrantData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ClassSpellGrantData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ClassSpellGrantData>> delete(
    _i1.Session session,
    List<ClassSpellGrantData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ClassSpellGrantData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ClassSpellGrantData].
  Future<ClassSpellGrantData> deleteRow(
    _i1.Session session,
    ClassSpellGrantData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClassSpellGrantData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ClassSpellGrantData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClassSpellGrantDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ClassSpellGrantData>(
      where: where(ClassSpellGrantData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassSpellGrantDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ClassSpellGrantData>(
      where: where?.call(ClassSpellGrantData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ClassSpellGrantDataAttachRowRepository {
  const ClassSpellGrantDataAttachRowRepository._();

  /// Creates a relation between the given [ClassSpellGrantData] and [SpellData]
  /// by setting the [ClassSpellGrantData]'s foreign key `spellId` to refer to the [SpellData].
  Future<void> spell(
    _i1.Session session,
    ClassSpellGrantData classSpellGrantData,
    _i2.SpellData spell, {
    _i1.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (spell.id == null) {
      throw ArgumentError.notNull('spell.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(spellId: spell.id);
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.spellId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassSpellGrantData] and [ClassData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceClassId` to refer to the [ClassData].
  Future<void> sourceClass(
    _i1.Session session,
    ClassSpellGrantData classSpellGrantData,
    _i3.ClassData sourceClass, {
    _i1.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (sourceClass.id == null) {
      throw ArgumentError.notNull('sourceClass.id');
    }

    var $classSpellGrantData =
        classSpellGrantData.copyWith(sourceClassId: sourceClass.id);
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassSpellGrantData] and [SubclassData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceSubclassId` to refer to the [SubclassData].
  Future<void> sourceSubclass(
    _i1.Session session,
    ClassSpellGrantData classSpellGrantData,
    _i4.SubclassData sourceSubclass, {
    _i1.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (sourceSubclass.id == null) {
      throw ArgumentError.notNull('sourceSubclass.id');
    }

    var $classSpellGrantData =
        classSpellGrantData.copyWith(sourceSubclassId: sourceSubclass.id);
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.sourceSubclassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassSpellGrantData] and [ClassFeatureData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceFeatureId` to refer to the [ClassFeatureData].
  Future<void> sourceFeature(
    _i1.Session session,
    ClassSpellGrantData classSpellGrantData,
    _i5.ClassFeatureData sourceFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (sourceFeature.id == null) {
      throw ArgumentError.notNull('sourceFeature.id');
    }

    var $classSpellGrantData =
        classSpellGrantData.copyWith(sourceFeatureId: sourceFeature.id);
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ClassSpellGrantData] and [SubclassFeatureData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceSubclassFeatureId` to refer to the [SubclassFeatureData].
  Future<void> sourceSubclassFeature(
    _i1.Session session,
    ClassSpellGrantData classSpellGrantData,
    _i6.SubclassFeatureData sourceSubclassFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (sourceSubclassFeature.id == null) {
      throw ArgumentError.notNull('sourceSubclassFeature.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
        sourceSubclassFeatureId: sourceSubclassFeature.id);
    await session.db.updateRow<ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [ClassSpellGrantData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }
}

class ClassSpellGrantDataDetachRowRepository {
  const ClassSpellGrantDataDetachRowRepository._();

  /// Detaches the relation between this [ClassSpellGrantData] and the [SpellData] set in `spell`
  /// by setting the [ClassSpellGrantData]'s foreign key `spellId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> spell(
    _i1.Session session,
    ClassSpellGrantData classspellgrantdata, {
    _i1.Transaction? transaction,
  }) async {
    if (classspellgrantdata.id == null) {
      throw ArgumentError.notNull('classspellgrantdata.id');
    }

    var $classspellgrantdata = classspellgrantdata.copyWith(spellId: null);
    await session.db.updateRow<ClassSpellGrantData>(
      $classspellgrantdata,
      columns: [ClassSpellGrantData.t.spellId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassSpellGrantData] and the [ClassData] set in `sourceClass`
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceClassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceClass(
    _i1.Session session,
    ClassSpellGrantData classspellgrantdata, {
    _i1.Transaction? transaction,
  }) async {
    if (classspellgrantdata.id == null) {
      throw ArgumentError.notNull('classspellgrantdata.id');
    }

    var $classspellgrantdata =
        classspellgrantdata.copyWith(sourceClassId: null);
    await session.db.updateRow<ClassSpellGrantData>(
      $classspellgrantdata,
      columns: [ClassSpellGrantData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassSpellGrantData] and the [SubclassData] set in `sourceSubclass`
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceSubclassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceSubclass(
    _i1.Session session,
    ClassSpellGrantData classspellgrantdata, {
    _i1.Transaction? transaction,
  }) async {
    if (classspellgrantdata.id == null) {
      throw ArgumentError.notNull('classspellgrantdata.id');
    }

    var $classspellgrantdata =
        classspellgrantdata.copyWith(sourceSubclassId: null);
    await session.db.updateRow<ClassSpellGrantData>(
      $classspellgrantdata,
      columns: [ClassSpellGrantData.t.sourceSubclassId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassSpellGrantData] and the [ClassFeatureData] set in `sourceFeature`
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceFeature(
    _i1.Session session,
    ClassSpellGrantData classspellgrantdata, {
    _i1.Transaction? transaction,
  }) async {
    if (classspellgrantdata.id == null) {
      throw ArgumentError.notNull('classspellgrantdata.id');
    }

    var $classspellgrantdata =
        classspellgrantdata.copyWith(sourceFeatureId: null);
    await session.db.updateRow<ClassSpellGrantData>(
      $classspellgrantdata,
      columns: [ClassSpellGrantData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassSpellGrantData] and the [SubclassFeatureData] set in `sourceSubclassFeature`
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceSubclassFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceSubclassFeature(
    _i1.Session session,
    ClassSpellGrantData classspellgrantdata, {
    _i1.Transaction? transaction,
  }) async {
    if (classspellgrantdata.id == null) {
      throw ArgumentError.notNull('classspellgrantdata.id');
    }

    var $classspellgrantdata =
        classspellgrantdata.copyWith(sourceSubclassFeatureId: null);
    await session.db.updateRow<ClassSpellGrantData>(
      $classspellgrantdata,
      columns: [ClassSpellGrantData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }
}
