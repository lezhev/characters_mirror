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
import '../general/class_data.dart' as _i2;

abstract class ClassFeatureData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ClassFeatureData._({
    this.id,
    required this.parentClassId,
    this.parentClass,
    required this.level,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.abilityBonuses,
    this.proficiencies,
    this.specialAbilities,
    this.variantOptions,
    this.resourceName,
    this.resourceAmount,
    this.resourceRegain,
    this.spellSlots,
  }) : _charactersClassfeaturesCharactersId = null;

  factory ClassFeatureData({
    int? id,
    required int parentClassId,
    _i2.ClassData? parentClass,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? proficiencies,
    List<String>? specialAbilities,
    List<String>? variantOptions,
    String? resourceName,
    int? resourceAmount,
    String? resourceRegain,
    Map<int, int>? spellSlots,
  }) = _ClassFeatureDataImpl;

  factory ClassFeatureData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassFeatureDataImplicit._(
      id: jsonSerialization['id'] as int?,
      parentClassId: jsonSerialization['parentClassId'] as int,
      parentClass: jsonSerialization['parentClass'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['parentClass'] as Map<String, dynamic>)),
      level: jsonSerialization['level'] as int,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      abilityBonuses:
          (jsonSerialization['abilityBonuses'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      proficiencies: (jsonSerialization['proficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      specialAbilities: (jsonSerialization['specialAbilities'] as List?)
          ?.map((e) => e as String)
          .toList(),
      variantOptions: (jsonSerialization['variantOptions'] as List?)
          ?.map((e) => e as String)
          .toList(),
      resourceName: jsonSerialization['resourceName'] as String?,
      resourceAmount: jsonSerialization['resourceAmount'] as int?,
      resourceRegain: jsonSerialization['resourceRegain'] as String?,
      spellSlots: (jsonSerialization['spellSlots'] as List?)
          ?.fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      $_charactersClassfeaturesCharactersId:
          jsonSerialization['_charactersClassfeaturesCharactersId'] as int?,
    );
  }

  static final t = ClassFeatureDataTable();

  static const db = ClassFeatureDataRepository._();

  @override
  int? id;

  int parentClassId;

  _i2.ClassData? parentClass;

  int level;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  Map<String, int>? abilityBonuses;

  List<String>? proficiencies;

  List<String>? specialAbilities;

  List<String>? variantOptions;

  String? resourceName;

  int? resourceAmount;

  String? resourceRegain;

  Map<int, int>? spellSlots;

  final int? _charactersClassfeaturesCharactersId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassFeatureData copyWith({
    int? id,
    int? parentClassId,
    _i2.ClassData? parentClass,
    int? level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? proficiencies,
    List<String>? specialAbilities,
    List<String>? variantOptions,
    String? resourceName,
    int? resourceAmount,
    String? resourceRegain,
    Map<int, int>? spellSlots,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJson(),
      'level': level,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (proficiencies != null) 'proficiencies': proficiencies?.toJson(),
      if (specialAbilities != null)
        'specialAbilities': specialAbilities?.toJson(),
      if (variantOptions != null) 'variantOptions': variantOptions?.toJson(),
      if (resourceName != null) 'resourceName': resourceName,
      if (resourceAmount != null) 'resourceAmount': resourceAmount,
      if (resourceRegain != null) 'resourceRegain': resourceRegain,
      if (spellSlots != null) 'spellSlots': spellSlots?.toJson(),
      if (_charactersClassfeaturesCharactersId != null)
        '_charactersClassfeaturesCharactersId':
            _charactersClassfeaturesCharactersId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJsonForProtocol(),
      'level': level,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (proficiencies != null) 'proficiencies': proficiencies?.toJson(),
      if (specialAbilities != null)
        'specialAbilities': specialAbilities?.toJson(),
      if (variantOptions != null) 'variantOptions': variantOptions?.toJson(),
      if (resourceName != null) 'resourceName': resourceName,
      if (resourceAmount != null) 'resourceAmount': resourceAmount,
      if (resourceRegain != null) 'resourceRegain': resourceRegain,
      if (spellSlots != null) 'spellSlots': spellSlots?.toJson(),
    };
  }

  static ClassFeatureDataInclude include({_i2.ClassDataInclude? parentClass}) {
    return ClassFeatureDataInclude._(parentClass: parentClass);
  }

  static ClassFeatureDataIncludeList includeList({
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    ClassFeatureDataInclude? include,
  }) {
    return ClassFeatureDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ClassFeatureData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassFeatureDataImpl extends ClassFeatureData {
  _ClassFeatureDataImpl({
    int? id,
    required int parentClassId,
    _i2.ClassData? parentClass,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? proficiencies,
    List<String>? specialAbilities,
    List<String>? variantOptions,
    String? resourceName,
    int? resourceAmount,
    String? resourceRegain,
    Map<int, int>? spellSlots,
  }) : super._(
          id: id,
          parentClassId: parentClassId,
          parentClass: parentClass,
          level: level,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          abilityBonuses: abilityBonuses,
          proficiencies: proficiencies,
          specialAbilities: specialAbilities,
          variantOptions: variantOptions,
          resourceName: resourceName,
          resourceAmount: resourceAmount,
          resourceRegain: resourceRegain,
          spellSlots: spellSlots,
        );

  /// Returns a shallow copy of this [ClassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassFeatureData copyWith({
    Object? id = _Undefined,
    int? parentClassId,
    Object? parentClass = _Undefined,
    int? level,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? abilityBonuses = _Undefined,
    Object? proficiencies = _Undefined,
    Object? specialAbilities = _Undefined,
    Object? variantOptions = _Undefined,
    Object? resourceName = _Undefined,
    Object? resourceAmount = _Undefined,
    Object? resourceRegain = _Undefined,
    Object? spellSlots = _Undefined,
  }) {
    return ClassFeatureDataImplicit._(
      id: id is int? ? id : this.id,
      parentClassId: parentClassId ?? this.parentClassId,
      parentClass: parentClass is _i2.ClassData?
          ? parentClass
          : this.parentClass?.copyWith(),
      level: level ?? this.level,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      abilityBonuses: abilityBonuses is Map<String, int>?
          ? abilityBonuses
          : this.abilityBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      proficiencies: proficiencies is List<String>?
          ? proficiencies
          : this.proficiencies?.map((e0) => e0).toList(),
      specialAbilities: specialAbilities is List<String>?
          ? specialAbilities
          : this.specialAbilities?.map((e0) => e0).toList(),
      variantOptions: variantOptions is List<String>?
          ? variantOptions
          : this.variantOptions?.map((e0) => e0).toList(),
      resourceName: resourceName is String? ? resourceName : this.resourceName,
      resourceAmount:
          resourceAmount is int? ? resourceAmount : this.resourceAmount,
      resourceRegain:
          resourceRegain is String? ? resourceRegain : this.resourceRegain,
      spellSlots: spellSlots is Map<int, int>?
          ? spellSlots
          : this.spellSlots?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      $_charactersClassfeaturesCharactersId:
          this._charactersClassfeaturesCharactersId,
    );
  }
}

class ClassFeatureDataImplicit extends _ClassFeatureDataImpl {
  ClassFeatureDataImplicit._({
    int? id,
    required int parentClassId,
    _i2.ClassData? parentClass,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? proficiencies,
    List<String>? specialAbilities,
    List<String>? variantOptions,
    String? resourceName,
    int? resourceAmount,
    String? resourceRegain,
    Map<int, int>? spellSlots,
    int? $_charactersClassfeaturesCharactersId,
  })  : _charactersClassfeaturesCharactersId =
            $_charactersClassfeaturesCharactersId,
        super(
          id: id,
          parentClassId: parentClassId,
          parentClass: parentClass,
          level: level,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          abilityBonuses: abilityBonuses,
          proficiencies: proficiencies,
          specialAbilities: specialAbilities,
          variantOptions: variantOptions,
          resourceName: resourceName,
          resourceAmount: resourceAmount,
          resourceRegain: resourceRegain,
          spellSlots: spellSlots,
        );

  factory ClassFeatureDataImplicit(
    ClassFeatureData classFeatureData, {
    int? $_charactersClassfeaturesCharactersId,
  }) {
    return ClassFeatureDataImplicit._(
      id: classFeatureData.id,
      parentClassId: classFeatureData.parentClassId,
      parentClass: classFeatureData.parentClass,
      level: classFeatureData.level,
      source: classFeatureData.source,
      version: classFeatureData.version,
      createdAt: classFeatureData.createdAt,
      updatedAt: classFeatureData.updatedAt,
      abilityBonuses: classFeatureData.abilityBonuses,
      proficiencies: classFeatureData.proficiencies,
      specialAbilities: classFeatureData.specialAbilities,
      variantOptions: classFeatureData.variantOptions,
      resourceName: classFeatureData.resourceName,
      resourceAmount: classFeatureData.resourceAmount,
      resourceRegain: classFeatureData.resourceRegain,
      spellSlots: classFeatureData.spellSlots,
      $_charactersClassfeaturesCharactersId:
          $_charactersClassfeaturesCharactersId,
    );
  }

  @override
  final int? _charactersClassfeaturesCharactersId;
}

class ClassFeatureDataTable extends _i1.Table<int?> {
  ClassFeatureDataTable({super.tableRelation})
      : super(tableName: 'class_feature_data') {
    parentClassId = _i1.ColumnInt(
      'parentClassId',
      this,
    );
    level = _i1.ColumnInt(
      'level',
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
    abilityBonuses = _i1.ColumnSerializable(
      'abilityBonuses',
      this,
    );
    proficiencies = _i1.ColumnSerializable(
      'proficiencies',
      this,
    );
    specialAbilities = _i1.ColumnSerializable(
      'specialAbilities',
      this,
    );
    variantOptions = _i1.ColumnSerializable(
      'variantOptions',
      this,
    );
    resourceName = _i1.ColumnString(
      'resourceName',
      this,
    );
    resourceAmount = _i1.ColumnInt(
      'resourceAmount',
      this,
    );
    resourceRegain = _i1.ColumnString(
      'resourceRegain',
      this,
    );
    spellSlots = _i1.ColumnSerializable(
      'spellSlots',
      this,
    );
    $_charactersClassfeaturesCharactersId = _i1.ColumnInt(
      '_charactersClassfeaturesCharactersId',
      this,
    );
  }

  late final _i1.ColumnInt parentClassId;

  _i2.ClassDataTable? _parentClass;

  late final _i1.ColumnInt level;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnSerializable abilityBonuses;

  late final _i1.ColumnSerializable proficiencies;

  late final _i1.ColumnSerializable specialAbilities;

  late final _i1.ColumnSerializable variantOptions;

  late final _i1.ColumnString resourceName;

  late final _i1.ColumnInt resourceAmount;

  late final _i1.ColumnString resourceRegain;

  late final _i1.ColumnSerializable spellSlots;

  late final _i1.ColumnInt $_charactersClassfeaturesCharactersId;

  _i2.ClassDataTable get parentClass {
    if (_parentClass != null) return _parentClass!;
    _parentClass = _i1.createRelationTable(
      relationFieldName: 'parentClass',
      field: ClassFeatureData.t.parentClassId,
      foreignField: _i2.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _parentClass!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        parentClassId,
        level,
        source,
        version,
        createdAt,
        updatedAt,
        abilityBonuses,
        proficiencies,
        specialAbilities,
        variantOptions,
        resourceName,
        resourceAmount,
        resourceRegain,
        spellSlots,
        $_charactersClassfeaturesCharactersId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        parentClassId,
        level,
        source,
        version,
        createdAt,
        updatedAt,
        abilityBonuses,
        proficiencies,
        specialAbilities,
        variantOptions,
        resourceName,
        resourceAmount,
        resourceRegain,
        spellSlots,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'parentClass') {
      return parentClass;
    }
    return null;
  }
}

class ClassFeatureDataInclude extends _i1.IncludeObject {
  ClassFeatureDataInclude._({_i2.ClassDataInclude? parentClass}) {
    _parentClass = parentClass;
  }

  _i2.ClassDataInclude? _parentClass;

  @override
  Map<String, _i1.Include?> get includes => {'parentClass': _parentClass};

  @override
  _i1.Table<int?> get table => ClassFeatureData.t;
}

class ClassFeatureDataIncludeList extends _i1.IncludeList {
  ClassFeatureDataIncludeList._({
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClassFeatureData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ClassFeatureData.t;
}

class ClassFeatureDataRepository {
  const ClassFeatureDataRepository._();

  final attachRow = const ClassFeatureDataAttachRowRepository._();

  /// Returns a list of [ClassFeatureData]s matching the given query parameters.
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
  Future<List<ClassFeatureData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassFeatureDataInclude? include,
  }) async {
    return session.db.find<ClassFeatureData>(
      where: where?.call(ClassFeatureData.t),
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderByList: orderByList?.call(ClassFeatureData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ClassFeatureData] matching the given query parameters.
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
  Future<ClassFeatureData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    _i1.Transaction? transaction,
    ClassFeatureDataInclude? include,
  }) async {
    return session.db.findFirstRow<ClassFeatureData>(
      where: where?.call(ClassFeatureData.t),
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderByList: orderByList?.call(ClassFeatureData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ClassFeatureData] by its [id] or null if no such row exists.
  Future<ClassFeatureData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ClassFeatureDataInclude? include,
  }) async {
    return session.db.findById<ClassFeatureData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ClassFeatureData]s in the list and returns the inserted rows.
  ///
  /// The returned [ClassFeatureData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ClassFeatureData>> insert(
    _i1.Session session,
    List<ClassFeatureData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ClassFeatureData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ClassFeatureData] and returns the inserted row.
  ///
  /// The returned [ClassFeatureData] will have its `id` field set.
  Future<ClassFeatureData> insertRow(
    _i1.Session session,
    ClassFeatureData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClassFeatureData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ClassFeatureData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ClassFeatureData>> update(
    _i1.Session session,
    List<ClassFeatureData> rows, {
    _i1.ColumnSelections<ClassFeatureDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ClassFeatureData>(
      rows,
      columns: columns?.call(ClassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClassFeatureData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClassFeatureData> updateRow(
    _i1.Session session,
    ClassFeatureData row, {
    _i1.ColumnSelections<ClassFeatureDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClassFeatureData>(
      row,
      columns: columns?.call(ClassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ClassFeatureData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ClassFeatureData>> delete(
    _i1.Session session,
    List<ClassFeatureData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ClassFeatureData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ClassFeatureData].
  Future<ClassFeatureData> deleteRow(
    _i1.Session session,
    ClassFeatureData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClassFeatureData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ClassFeatureData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClassFeatureDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ClassFeatureData>(
      where: where(ClassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ClassFeatureData>(
      where: where?.call(ClassFeatureData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ClassFeatureDataAttachRowRepository {
  const ClassFeatureDataAttachRowRepository._();

  /// Creates a relation between the given [ClassFeatureData] and [ClassData]
  /// by setting the [ClassFeatureData]'s foreign key `parentClassId` to refer to the [ClassData].
  Future<void> parentClass(
    _i1.Session session,
    ClassFeatureData classFeatureData,
    _i2.ClassData parentClass, {
    _i1.Transaction? transaction,
  }) async {
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }
    if (parentClass.id == null) {
      throw ArgumentError.notNull('parentClass.id');
    }

    var $classFeatureData =
        classFeatureData.copyWith(parentClassId: parentClass.id);
    await session.db.updateRow<ClassFeatureData>(
      $classFeatureData,
      columns: [ClassFeatureData.t.parentClassId],
      transaction: transaction,
    );
  }
}
