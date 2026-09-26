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
import '../../enums/tool_category.dart' as _i2;

abstract class ToolData implements _i1.SerializableModel {
  ToolData._({
    this.id,
    required this.referenceKey,
    required this.name,
    this.category,
  });

  factory ToolData({
    int? id,
    required String referenceKey,
    required String name,
    _i2.ToolCategory? category,
  }) = _ToolDataImpl;

  factory ToolData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ToolData(
      id: jsonSerialization['id'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String,
      name: jsonSerialization['name'] as String,
      category: jsonSerialization['category'] == null
          ? null
          : _i2.ToolCategory.fromJson((jsonSerialization['category'] as int)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String referenceKey;

  String name;

  _i2.ToolCategory? category;

  /// Returns a shallow copy of this [ToolData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ToolData copyWith({
    int? id,
    String? referenceKey,
    String? name,
    _i2.ToolCategory? category,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'referenceKey': referenceKey,
      'name': name,
      if (category != null) 'category': category?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ToolDataImpl extends ToolData {
  _ToolDataImpl({
    int? id,
    required String referenceKey,
    required String name,
    _i2.ToolCategory? category,
  }) : super._(
          id: id,
          referenceKey: referenceKey,
          name: name,
          category: category,
        );

  /// Returns a shallow copy of this [ToolData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ToolData copyWith({
    Object? id = _Undefined,
    String? referenceKey,
    String? name,
    Object? category = _Undefined,
  }) {
    return ToolData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey ?? this.referenceKey,
      name: name ?? this.name,
      category: category is _i2.ToolCategory? ? category : this.category,
    );
  }
}
