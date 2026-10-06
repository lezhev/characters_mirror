/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class SelectedFeatureChoiceView
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SelectedFeatureChoiceView._({
    required this.groupKey,
    this.groupTitle,
    required this.optionKey,
    required this.name,
    this.shortDescription,
  });

  factory SelectedFeatureChoiceView({
    required String groupKey,
    String? groupTitle,
    required String optionKey,
    required String name,
    String? shortDescription,
  }) = _SelectedFeatureChoiceViewImpl;

  factory SelectedFeatureChoiceView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SelectedFeatureChoiceView(
      groupKey: jsonSerialization['groupKey'] as String,
      groupTitle: jsonSerialization['groupTitle'] as String?,
      optionKey: jsonSerialization['optionKey'] as String,
      name: jsonSerialization['name'] as String,
      shortDescription: jsonSerialization['shortDescription'] as String?,
    );
  }

  String groupKey;

  String? groupTitle;

  String optionKey;

  String name;

  String? shortDescription;

  /// Returns a shallow copy of this [SelectedFeatureChoiceView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SelectedFeatureChoiceView copyWith({
    String? groupKey,
    String? groupTitle,
    String? optionKey,
    String? name,
    String? shortDescription,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'groupKey': groupKey,
      if (groupTitle != null) 'groupTitle': groupTitle,
      'optionKey': optionKey,
      'name': name,
      if (shortDescription != null) 'shortDescription': shortDescription,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'groupKey': groupKey,
      if (groupTitle != null) 'groupTitle': groupTitle,
      'optionKey': optionKey,
      'name': name,
      if (shortDescription != null) 'shortDescription': shortDescription,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SelectedFeatureChoiceViewImpl extends SelectedFeatureChoiceView {
  _SelectedFeatureChoiceViewImpl({
    required String groupKey,
    String? groupTitle,
    required String optionKey,
    required String name,
    String? shortDescription,
  }) : super._(
          groupKey: groupKey,
          groupTitle: groupTitle,
          optionKey: optionKey,
          name: name,
          shortDescription: shortDescription,
        );

  /// Returns a shallow copy of this [SelectedFeatureChoiceView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SelectedFeatureChoiceView copyWith({
    String? groupKey,
    Object? groupTitle = _Undefined,
    String? optionKey,
    String? name,
    Object? shortDescription = _Undefined,
  }) {
    return SelectedFeatureChoiceView(
      groupKey: groupKey ?? this.groupKey,
      groupTitle: groupTitle is String? ? groupTitle : this.groupTitle,
      optionKey: optionKey ?? this.optionKey,
      name: name ?? this.name,
      shortDescription: shortDescription is String?
          ? shortDescription
          : this.shortDescription,
    );
  }
}
