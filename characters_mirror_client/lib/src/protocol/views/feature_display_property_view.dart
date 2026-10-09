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

abstract class FeatureDisplayPropertyView implements _i1.SerializableModel {
  FeatureDisplayPropertyView._({
    required this.key,
    required this.label,
    required this.value,
    this.formula,
    this.sortOrder,
  });

  factory FeatureDisplayPropertyView({
    required String key,
    required String label,
    required String value,
    String? formula,
    int? sortOrder,
  }) = _FeatureDisplayPropertyViewImpl;

  factory FeatureDisplayPropertyView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return FeatureDisplayPropertyView(
      key: jsonSerialization['key'] as String,
      label: jsonSerialization['label'] as String,
      value: jsonSerialization['value'] as String,
      formula: jsonSerialization['formula'] as String?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
    );
  }

  String key;

  String label;

  String value;

  String? formula;

  int? sortOrder;

  /// Returns a shallow copy of this [FeatureDisplayPropertyView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureDisplayPropertyView copyWith({
    String? key,
    String? label,
    String? value,
    String? formula,
    int? sortOrder,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'label': label,
      'value': value,
      if (formula != null) 'formula': formula,
      if (sortOrder != null) 'sortOrder': sortOrder,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureDisplayPropertyViewImpl extends FeatureDisplayPropertyView {
  _FeatureDisplayPropertyViewImpl({
    required String key,
    required String label,
    required String value,
    String? formula,
    int? sortOrder,
  }) : super._(
          key: key,
          label: label,
          value: value,
          formula: formula,
          sortOrder: sortOrder,
        );

  /// Returns a shallow copy of this [FeatureDisplayPropertyView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureDisplayPropertyView copyWith({
    String? key,
    String? label,
    String? value,
    Object? formula = _Undefined,
    Object? sortOrder = _Undefined,
  }) {
    return FeatureDisplayPropertyView(
      key: key ?? this.key,
      label: label ?? this.label,
      value: value ?? this.value,
      formula: formula is String? ? formula : this.formula,
      sortOrder: sortOrder is int? ? sortOrder : this.sortOrder,
    );
  }
}
