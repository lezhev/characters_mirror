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
import '../../data/general/class/class_feature_data.dart' as _i2;
import '../../data/general/class/subclass_feature_data.dart' as _i3;
import '../../enums/feature_modifier_target.dart' as _i4;
import '../../enums/feature_modifier_operation.dart' as _i5;
import '../../data/general/feature_modifier_value_data.dart' as _i6;
import '../../data/general/feature_modifier_condition_data.dart' as _i7;

abstract class FeatureModifierData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FeatureModifierData._({
    this.id,
    required this.referenceKey,
    this.classFeatureId,
    this.classFeature,
    this.subclassFeatureId,
    this.subclassFeature,
    required this.target,
    required this.operation,
    required this.value,
    this.conditions,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory FeatureModifierData({
    int? id,
    required String referenceKey,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    required _i4.FeatureModifierTarget target,
    required _i5.FeatureModifierOperation operation,
    required _i6.FeatureModifierValueData value,
    List<_i7.FeatureModifierConditionData>? conditions,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FeatureModifierDataImpl;

  factory FeatureModifierData.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatureModifierData(
      id: jsonSerialization['id'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String,
      classFeatureId: jsonSerialization['classFeatureId'] as int?,
      classFeature: jsonSerialization['classFeature'] == null
          ? null
          : _i2.ClassFeatureData.fromJson(
              (jsonSerialization['classFeature'] as Map<String, dynamic>)),
      subclassFeatureId: jsonSerialization['subclassFeatureId'] as int?,
      subclassFeature: jsonSerialization['subclassFeature'] == null
          ? null
          : _i3.SubclassFeatureData.fromJson(
              (jsonSerialization['subclassFeature'] as Map<String, dynamic>)),
      target: _i4.FeatureModifierTarget.fromJson(
          (jsonSerialization['target'] as int)),
      operation: _i5.FeatureModifierOperation.fromJson(
          (jsonSerialization['operation'] as int)),
      value: _i6.FeatureModifierValueData.fromJson(
          (jsonSerialization['value'] as Map<String, dynamic>)),
      conditions: (jsonSerialization['conditions'] as List?)
          ?.map((e) => _i7.FeatureModifierConditionData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
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

  static final t = FeatureModifierDataTable();

  static const db = FeatureModifierDataRepository._();

  @override
  int? id;

  String referenceKey;

  int? classFeatureId;

  _i2.ClassFeatureData? classFeature;

  int? subclassFeatureId;

  _i3.SubclassFeatureData? subclassFeature;

  _i4.FeatureModifierTarget target;

  _i5.FeatureModifierOperation operation;

  _i6.FeatureModifierValueData value;

  List<_i7.FeatureModifierConditionData>? conditions;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureModifierData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureModifierData copyWith({
    int? id,
    String? referenceKey,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    _i4.FeatureModifierTarget? target,
    _i5.FeatureModifierOperation? operation,
    _i6.FeatureModifierValueData? value,
    List<_i7.FeatureModifierConditionData>? conditions,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'referenceKey': referenceKey,
      if (classFeatureId != null) 'classFeatureId': classFeatureId,
      if (classFeature != null) 'classFeature': classFeature?.toJson(),
      if (subclassFeatureId != null) 'subclassFeatureId': subclassFeatureId,
      if (subclassFeature != null) 'subclassFeature': subclassFeature?.toJson(),
      'target': target.toJson(),
      'operation': operation.toJson(),
      'value': value.toJson(),
      if (conditions != null)
        'conditions': conditions?.toJson(valueToJson: (v) => v.toJson()),
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
      'referenceKey': referenceKey,
      if (classFeatureId != null) 'classFeatureId': classFeatureId,
      if (classFeature != null)
        'classFeature': classFeature?.toJsonForProtocol(),
      if (subclassFeatureId != null) 'subclassFeatureId': subclassFeatureId,
      if (subclassFeature != null)
        'subclassFeature': subclassFeature?.toJsonForProtocol(),
      'target': target.toJson(),
      'operation': operation.toJson(),
      'value': value.toJsonForProtocol(),
      if (conditions != null)
        'conditions':
            conditions?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static FeatureModifierDataInclude include({
    _i2.ClassFeatureDataInclude? classFeature,
    _i3.SubclassFeatureDataInclude? subclassFeature,
  }) {
    return FeatureModifierDataInclude._(
      classFeature: classFeature,
      subclassFeature: subclassFeature,
    );
  }

  static FeatureModifierDataIncludeList includeList({
    _i1.WhereExpressionBuilder<FeatureModifierDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureModifierDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureModifierDataTable>? orderByList,
    FeatureModifierDataInclude? include,
  }) {
    return FeatureModifierDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureModifierData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FeatureModifierData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureModifierDataImpl extends FeatureModifierData {
  _FeatureModifierDataImpl({
    int? id,
    required String referenceKey,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    required _i4.FeatureModifierTarget target,
    required _i5.FeatureModifierOperation operation,
    required _i6.FeatureModifierValueData value,
    List<_i7.FeatureModifierConditionData>? conditions,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          referenceKey: referenceKey,
          classFeatureId: classFeatureId,
          classFeature: classFeature,
          subclassFeatureId: subclassFeatureId,
          subclassFeature: subclassFeature,
          target: target,
          operation: operation,
          value: value,
          conditions: conditions,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [FeatureModifierData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureModifierData copyWith({
    Object? id = _Undefined,
    String? referenceKey,
    Object? classFeatureId = _Undefined,
    Object? classFeature = _Undefined,
    Object? subclassFeatureId = _Undefined,
    Object? subclassFeature = _Undefined,
    _i4.FeatureModifierTarget? target,
    _i5.FeatureModifierOperation? operation,
    _i6.FeatureModifierValueData? value,
    Object? conditions = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return FeatureModifierData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey ?? this.referenceKey,
      classFeatureId:
          classFeatureId is int? ? classFeatureId : this.classFeatureId,
      classFeature: classFeature is _i2.ClassFeatureData?
          ? classFeature
          : this.classFeature?.copyWith(),
      subclassFeatureId: subclassFeatureId is int?
          ? subclassFeatureId
          : this.subclassFeatureId,
      subclassFeature: subclassFeature is _i3.SubclassFeatureData?
          ? subclassFeature
          : this.subclassFeature?.copyWith(),
      target: target ?? this.target,
      operation: operation ?? this.operation,
      value: value ?? this.value.copyWith(),
      conditions: conditions is List<_i7.FeatureModifierConditionData>?
          ? conditions
          : this.conditions?.map((e0) => e0.copyWith()).toList(),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class FeatureModifierDataTable extends _i1.Table<int?> {
  FeatureModifierDataTable({super.tableRelation})
      : super(tableName: 'feature_modifier_data') {
    referenceKey = _i1.ColumnString(
      'referenceKey',
      this,
    );
    classFeatureId = _i1.ColumnInt(
      'classFeatureId',
      this,
    );
    subclassFeatureId = _i1.ColumnInt(
      'subclassFeatureId',
      this,
    );
    target = _i1.ColumnEnum(
      'target',
      this,
      _i1.EnumSerialization.byIndex,
    );
    operation = _i1.ColumnEnum(
      'operation',
      this,
      _i1.EnumSerialization.byIndex,
    );
    value = _i1.ColumnSerializable(
      'value',
      this,
    );
    conditions = _i1.ColumnSerializable(
      'conditions',
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

  late final _i1.ColumnString referenceKey;

  late final _i1.ColumnInt classFeatureId;

  _i2.ClassFeatureDataTable? _classFeature;

  late final _i1.ColumnInt subclassFeatureId;

  _i3.SubclassFeatureDataTable? _subclassFeature;

  late final _i1.ColumnEnum<_i4.FeatureModifierTarget> target;

  late final _i1.ColumnEnum<_i5.FeatureModifierOperation> operation;

  late final _i1.ColumnSerializable value;

  late final _i1.ColumnSerializable conditions;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.ClassFeatureDataTable get classFeature {
    if (_classFeature != null) return _classFeature!;
    _classFeature = _i1.createRelationTable(
      relationFieldName: 'classFeature',
      field: FeatureModifierData.t.classFeatureId,
      foreignField: _i2.ClassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ClassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _classFeature!;
  }

  _i3.SubclassFeatureDataTable get subclassFeature {
    if (_subclassFeature != null) return _subclassFeature!;
    _subclassFeature = _i1.createRelationTable(
      relationFieldName: 'subclassFeature',
      field: FeatureModifierData.t.subclassFeatureId,
      foreignField: _i3.SubclassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SubclassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _subclassFeature!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        referenceKey,
        classFeatureId,
        subclassFeatureId,
        target,
        operation,
        value,
        conditions,
        source,
        version,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'classFeature') {
      return classFeature;
    }
    if (relationField == 'subclassFeature') {
      return subclassFeature;
    }
    return null;
  }
}

class FeatureModifierDataInclude extends _i1.IncludeObject {
  FeatureModifierDataInclude._({
    _i2.ClassFeatureDataInclude? classFeature,
    _i3.SubclassFeatureDataInclude? subclassFeature,
  }) {
    _classFeature = classFeature;
    _subclassFeature = subclassFeature;
  }

  _i2.ClassFeatureDataInclude? _classFeature;

  _i3.SubclassFeatureDataInclude? _subclassFeature;

  @override
  Map<String, _i1.Include?> get includes => {
        'classFeature': _classFeature,
        'subclassFeature': _subclassFeature,
      };

  @override
  _i1.Table<int?> get table => FeatureModifierData.t;
}

class FeatureModifierDataIncludeList extends _i1.IncludeList {
  FeatureModifierDataIncludeList._({
    _i1.WhereExpressionBuilder<FeatureModifierDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureModifierData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FeatureModifierData.t;
}

class FeatureModifierDataRepository {
  const FeatureModifierDataRepository._();

  final attachRow = const FeatureModifierDataAttachRowRepository._();

  final detachRow = const FeatureModifierDataDetachRowRepository._();

  /// Returns a list of [FeatureModifierData]s matching the given query parameters.
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
  Future<List<FeatureModifierData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureModifierDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureModifierDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureModifierDataTable>? orderByList,
    _i1.Transaction? transaction,
    FeatureModifierDataInclude? include,
  }) async {
    return session.db.find<FeatureModifierData>(
      where: where?.call(FeatureModifierData.t),
      orderBy: orderBy?.call(FeatureModifierData.t),
      orderByList: orderByList?.call(FeatureModifierData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [FeatureModifierData] matching the given query parameters.
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
  Future<FeatureModifierData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureModifierDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<FeatureModifierDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureModifierDataTable>? orderByList,
    _i1.Transaction? transaction,
    FeatureModifierDataInclude? include,
  }) async {
    return session.db.findFirstRow<FeatureModifierData>(
      where: where?.call(FeatureModifierData.t),
      orderBy: orderBy?.call(FeatureModifierData.t),
      orderByList: orderByList?.call(FeatureModifierData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [FeatureModifierData] by its [id] or null if no such row exists.
  Future<FeatureModifierData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    FeatureModifierDataInclude? include,
  }) async {
    return session.db.findById<FeatureModifierData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [FeatureModifierData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureModifierData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FeatureModifierData>> insert(
    _i1.Session session,
    List<FeatureModifierData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FeatureModifierData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FeatureModifierData] and returns the inserted row.
  ///
  /// The returned [FeatureModifierData] will have its `id` field set.
  Future<FeatureModifierData> insertRow(
    _i1.Session session,
    FeatureModifierData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureModifierData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FeatureModifierData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FeatureModifierData>> update(
    _i1.Session session,
    List<FeatureModifierData> rows, {
    _i1.ColumnSelections<FeatureModifierDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FeatureModifierData>(
      rows,
      columns: columns?.call(FeatureModifierData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureModifierData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureModifierData> updateRow(
    _i1.Session session,
    FeatureModifierData row, {
    _i1.ColumnSelections<FeatureModifierDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureModifierData>(
      row,
      columns: columns?.call(FeatureModifierData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [FeatureModifierData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FeatureModifierData>> delete(
    _i1.Session session,
    List<FeatureModifierData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FeatureModifierData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FeatureModifierData].
  Future<FeatureModifierData> deleteRow(
    _i1.Session session,
    FeatureModifierData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureModifierData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FeatureModifierData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FeatureModifierDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FeatureModifierData>(
      where: where(FeatureModifierData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureModifierDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FeatureModifierData>(
      where: where?.call(FeatureModifierData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class FeatureModifierDataAttachRowRepository {
  const FeatureModifierDataAttachRowRepository._();

  /// Creates a relation between the given [FeatureModifierData] and [ClassFeatureData]
  /// by setting the [FeatureModifierData]'s foreign key `classFeatureId` to refer to the [ClassFeatureData].
  Future<void> classFeature(
    _i1.Session session,
    FeatureModifierData featureModifierData,
    _i2.ClassFeatureData classFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (featureModifierData.id == null) {
      throw ArgumentError.notNull('featureModifierData.id');
    }
    if (classFeature.id == null) {
      throw ArgumentError.notNull('classFeature.id');
    }

    var $featureModifierData =
        featureModifierData.copyWith(classFeatureId: classFeature.id);
    await session.db.updateRow<FeatureModifierData>(
      $featureModifierData,
      columns: [FeatureModifierData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureModifierData] and [SubclassFeatureData]
  /// by setting the [FeatureModifierData]'s foreign key `subclassFeatureId` to refer to the [SubclassFeatureData].
  Future<void> subclassFeature(
    _i1.Session session,
    FeatureModifierData featureModifierData,
    _i3.SubclassFeatureData subclassFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (featureModifierData.id == null) {
      throw ArgumentError.notNull('featureModifierData.id');
    }
    if (subclassFeature.id == null) {
      throw ArgumentError.notNull('subclassFeature.id');
    }

    var $featureModifierData =
        featureModifierData.copyWith(subclassFeatureId: subclassFeature.id);
    await session.db.updateRow<FeatureModifierData>(
      $featureModifierData,
      columns: [FeatureModifierData.t.subclassFeatureId],
      transaction: transaction,
    );
  }
}

class FeatureModifierDataDetachRowRepository {
  const FeatureModifierDataDetachRowRepository._();

  /// Detaches the relation between this [FeatureModifierData] and the [ClassFeatureData] set in `classFeature`
  /// by setting the [FeatureModifierData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classFeature(
    _i1.Session session,
    FeatureModifierData featuremodifierdata, {
    _i1.Transaction? transaction,
  }) async {
    if (featuremodifierdata.id == null) {
      throw ArgumentError.notNull('featuremodifierdata.id');
    }

    var $featuremodifierdata =
        featuremodifierdata.copyWith(classFeatureId: null);
    await session.db.updateRow<FeatureModifierData>(
      $featuremodifierdata,
      columns: [FeatureModifierData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [FeatureModifierData] and the [SubclassFeatureData] set in `subclassFeature`
  /// by setting the [FeatureModifierData]'s foreign key `subclassFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subclassFeature(
    _i1.Session session,
    FeatureModifierData featuremodifierdata, {
    _i1.Transaction? transaction,
  }) async {
    if (featuremodifierdata.id == null) {
      throw ArgumentError.notNull('featuremodifierdata.id');
    }

    var $featuremodifierdata =
        featuremodifierdata.copyWith(subclassFeatureId: null);
    await session.db.updateRow<FeatureModifierData>(
      $featuremodifierdata,
      columns: [FeatureModifierData.t.subclassFeatureId],
      transaction: transaction,
    );
  }
}
