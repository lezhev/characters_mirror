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
import '../../data/general/feature_resource_definition_data.dart' as _i2;

abstract class FeatureResourceProgressionValueData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FeatureResourceProgressionValueData._({
    this.id,
    this.resourceDefinitionId,
    this.resourceDefinition,
    required this.level,
    required this.value,
  });

  factory FeatureResourceProgressionValueData({
    int? id,
    int? resourceDefinitionId,
    _i2.FeatureResourceDefinitionData? resourceDefinition,
    required int level,
    required int value,
  }) = _FeatureResourceProgressionValueDataImpl;

  factory FeatureResourceProgressionValueData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return FeatureResourceProgressionValueData(
      id: jsonSerialization['id'] as int?,
      resourceDefinitionId: jsonSerialization['resourceDefinitionId'] as int?,
      resourceDefinition: jsonSerialization['resourceDefinition'] == null
          ? null
          : _i2.FeatureResourceDefinitionData.fromJson(
              (jsonSerialization['resourceDefinition']
                  as Map<String, dynamic>)),
      level: jsonSerialization['level'] as int,
      value: jsonSerialization['value'] as int,
    );
  }

  static final t = FeatureResourceProgressionValueDataTable();

  static const db = FeatureResourceProgressionValueDataRepository._();

  @override
  int? id;

  int? resourceDefinitionId;

  _i2.FeatureResourceDefinitionData? resourceDefinition;

  int level;

  int value;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureResourceProgressionValueData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureResourceProgressionValueData copyWith({
    int? id,
    int? resourceDefinitionId,
    _i2.FeatureResourceDefinitionData? resourceDefinition,
    int? level,
    int? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (resourceDefinitionId != null)
        'resourceDefinitionId': resourceDefinitionId,
      if (resourceDefinition != null)
        'resourceDefinition': resourceDefinition?.toJson(),
      'level': level,
      'value': value,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (resourceDefinitionId != null)
        'resourceDefinitionId': resourceDefinitionId,
      if (resourceDefinition != null)
        'resourceDefinition': resourceDefinition?.toJsonForProtocol(),
      'level': level,
      'value': value,
    };
  }

  static FeatureResourceProgressionValueDataInclude include(
      {_i2.FeatureResourceDefinitionDataInclude? resourceDefinition}) {
    return FeatureResourceProgressionValueDataInclude._(
        resourceDefinition: resourceDefinition);
  }

  static FeatureResourceProgressionValueDataIncludeList includeList({
    _i1.WhereExpressionBuilder<FeatureResourceProgressionValueDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureResourceProgressionValueDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureResourceProgressionValueDataTable>?
        orderByList,
    FeatureResourceProgressionValueDataInclude? include,
  }) {
    return FeatureResourceProgressionValueDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureResourceProgressionValueData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FeatureResourceProgressionValueData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureResourceProgressionValueDataImpl
    extends FeatureResourceProgressionValueData {
  _FeatureResourceProgressionValueDataImpl({
    int? id,
    int? resourceDefinitionId,
    _i2.FeatureResourceDefinitionData? resourceDefinition,
    required int level,
    required int value,
  }) : super._(
          id: id,
          resourceDefinitionId: resourceDefinitionId,
          resourceDefinition: resourceDefinition,
          level: level,
          value: value,
        );

  /// Returns a shallow copy of this [FeatureResourceProgressionValueData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureResourceProgressionValueData copyWith({
    Object? id = _Undefined,
    Object? resourceDefinitionId = _Undefined,
    Object? resourceDefinition = _Undefined,
    int? level,
    int? value,
  }) {
    return FeatureResourceProgressionValueData(
      id: id is int? ? id : this.id,
      resourceDefinitionId: resourceDefinitionId is int?
          ? resourceDefinitionId
          : this.resourceDefinitionId,
      resourceDefinition:
          resourceDefinition is _i2.FeatureResourceDefinitionData?
              ? resourceDefinition
              : this.resourceDefinition?.copyWith(),
      level: level ?? this.level,
      value: value ?? this.value,
    );
  }
}

class FeatureResourceProgressionValueDataTable extends _i1.Table<int?> {
  FeatureResourceProgressionValueDataTable({super.tableRelation})
      : super(tableName: 'feature_resource_progression_value_data') {
    resourceDefinitionId = _i1.ColumnInt(
      'resourceDefinitionId',
      this,
    );
    level = _i1.ColumnInt(
      'level',
      this,
    );
    value = _i1.ColumnInt(
      'value',
      this,
    );
  }

  late final _i1.ColumnInt resourceDefinitionId;

  _i2.FeatureResourceDefinitionDataTable? _resourceDefinition;

  late final _i1.ColumnInt level;

  late final _i1.ColumnInt value;

  _i2.FeatureResourceDefinitionDataTable get resourceDefinition {
    if (_resourceDefinition != null) return _resourceDefinition!;
    _resourceDefinition = _i1.createRelationTable(
      relationFieldName: 'resourceDefinition',
      field: FeatureResourceProgressionValueData.t.resourceDefinitionId,
      foreignField: _i2.FeatureResourceDefinitionData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.FeatureResourceDefinitionDataTable(
              tableRelation: foreignTableRelation),
    );
    return _resourceDefinition!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        resourceDefinitionId,
        level,
        value,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'resourceDefinition') {
      return resourceDefinition;
    }
    return null;
  }
}

class FeatureResourceProgressionValueDataInclude extends _i1.IncludeObject {
  FeatureResourceProgressionValueDataInclude._(
      {_i2.FeatureResourceDefinitionDataInclude? resourceDefinition}) {
    _resourceDefinition = resourceDefinition;
  }

  _i2.FeatureResourceDefinitionDataInclude? _resourceDefinition;

  @override
  Map<String, _i1.Include?> get includes =>
      {'resourceDefinition': _resourceDefinition};

  @override
  _i1.Table<int?> get table => FeatureResourceProgressionValueData.t;
}

class FeatureResourceProgressionValueDataIncludeList extends _i1.IncludeList {
  FeatureResourceProgressionValueDataIncludeList._({
    _i1.WhereExpressionBuilder<FeatureResourceProgressionValueDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureResourceProgressionValueData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FeatureResourceProgressionValueData.t;
}

class FeatureResourceProgressionValueDataRepository {
  const FeatureResourceProgressionValueDataRepository._();

  final attachRow =
      const FeatureResourceProgressionValueDataAttachRowRepository._();

  final detachRow =
      const FeatureResourceProgressionValueDataDetachRowRepository._();

  /// Returns a list of [FeatureResourceProgressionValueData]s matching the given query parameters.
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
  Future<List<FeatureResourceProgressionValueData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureResourceProgressionValueDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureResourceProgressionValueDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureResourceProgressionValueDataTable>?
        orderByList,
    _i1.Transaction? transaction,
    FeatureResourceProgressionValueDataInclude? include,
  }) async {
    return session.db.find<FeatureResourceProgressionValueData>(
      where: where?.call(FeatureResourceProgressionValueData.t),
      orderBy: orderBy?.call(FeatureResourceProgressionValueData.t),
      orderByList: orderByList?.call(FeatureResourceProgressionValueData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [FeatureResourceProgressionValueData] matching the given query parameters.
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
  Future<FeatureResourceProgressionValueData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureResourceProgressionValueDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<FeatureResourceProgressionValueDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureResourceProgressionValueDataTable>?
        orderByList,
    _i1.Transaction? transaction,
    FeatureResourceProgressionValueDataInclude? include,
  }) async {
    return session.db.findFirstRow<FeatureResourceProgressionValueData>(
      where: where?.call(FeatureResourceProgressionValueData.t),
      orderBy: orderBy?.call(FeatureResourceProgressionValueData.t),
      orderByList: orderByList?.call(FeatureResourceProgressionValueData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [FeatureResourceProgressionValueData] by its [id] or null if no such row exists.
  Future<FeatureResourceProgressionValueData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    FeatureResourceProgressionValueDataInclude? include,
  }) async {
    return session.db.findById<FeatureResourceProgressionValueData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [FeatureResourceProgressionValueData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureResourceProgressionValueData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FeatureResourceProgressionValueData>> insert(
    _i1.Session session,
    List<FeatureResourceProgressionValueData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FeatureResourceProgressionValueData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FeatureResourceProgressionValueData] and returns the inserted row.
  ///
  /// The returned [FeatureResourceProgressionValueData] will have its `id` field set.
  Future<FeatureResourceProgressionValueData> insertRow(
    _i1.Session session,
    FeatureResourceProgressionValueData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureResourceProgressionValueData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FeatureResourceProgressionValueData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FeatureResourceProgressionValueData>> update(
    _i1.Session session,
    List<FeatureResourceProgressionValueData> rows, {
    _i1.ColumnSelections<FeatureResourceProgressionValueDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FeatureResourceProgressionValueData>(
      rows,
      columns: columns?.call(FeatureResourceProgressionValueData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureResourceProgressionValueData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureResourceProgressionValueData> updateRow(
    _i1.Session session,
    FeatureResourceProgressionValueData row, {
    _i1.ColumnSelections<FeatureResourceProgressionValueDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureResourceProgressionValueData>(
      row,
      columns: columns?.call(FeatureResourceProgressionValueData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [FeatureResourceProgressionValueData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FeatureResourceProgressionValueData>> delete(
    _i1.Session session,
    List<FeatureResourceProgressionValueData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FeatureResourceProgressionValueData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FeatureResourceProgressionValueData].
  Future<FeatureResourceProgressionValueData> deleteRow(
    _i1.Session session,
    FeatureResourceProgressionValueData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureResourceProgressionValueData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FeatureResourceProgressionValueData>> deleteWhere(
    _i1.Session session, {
    required _i1
        .WhereExpressionBuilder<FeatureResourceProgressionValueDataTable>
        where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FeatureResourceProgressionValueData>(
      where: where(FeatureResourceProgressionValueData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureResourceProgressionValueDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FeatureResourceProgressionValueData>(
      where: where?.call(FeatureResourceProgressionValueData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class FeatureResourceProgressionValueDataAttachRowRepository {
  const FeatureResourceProgressionValueDataAttachRowRepository._();

  /// Creates a relation between the given [FeatureResourceProgressionValueData] and [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceProgressionValueData]'s foreign key `resourceDefinitionId` to refer to the [FeatureResourceDefinitionData].
  Future<void> resourceDefinition(
    _i1.Session session,
    FeatureResourceProgressionValueData featureResourceProgressionValueData,
    _i2.FeatureResourceDefinitionData resourceDefinition, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceProgressionValueData.id == null) {
      throw ArgumentError.notNull('featureResourceProgressionValueData.id');
    }
    if (resourceDefinition.id == null) {
      throw ArgumentError.notNull('resourceDefinition.id');
    }

    var $featureResourceProgressionValueData =
        featureResourceProgressionValueData.copyWith(
            resourceDefinitionId: resourceDefinition.id);
    await session.db.updateRow<FeatureResourceProgressionValueData>(
      $featureResourceProgressionValueData,
      columns: [FeatureResourceProgressionValueData.t.resourceDefinitionId],
      transaction: transaction,
    );
  }
}

class FeatureResourceProgressionValueDataDetachRowRepository {
  const FeatureResourceProgressionValueDataDetachRowRepository._();

  /// Detaches the relation between this [FeatureResourceProgressionValueData] and the [FeatureResourceDefinitionData] set in `resourceDefinition`
  /// by setting the [FeatureResourceProgressionValueData]'s foreign key `resourceDefinitionId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resourceDefinition(
    _i1.Session session,
    FeatureResourceProgressionValueData featureresourceprogressionvaluedata, {
    _i1.Transaction? transaction,
  }) async {
    if (featureresourceprogressionvaluedata.id == null) {
      throw ArgumentError.notNull('featureresourceprogressionvaluedata.id');
    }

    var $featureresourceprogressionvaluedata =
        featureresourceprogressionvaluedata.copyWith(
            resourceDefinitionId: null);
    await session.db.updateRow<FeatureResourceProgressionValueData>(
      $featureresourceprogressionvaluedata,
      columns: [FeatureResourceProgressionValueData.t.resourceDefinitionId],
      transaction: transaction,
    );
  }
}
