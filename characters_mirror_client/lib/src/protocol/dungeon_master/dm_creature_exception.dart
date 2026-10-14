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

abstract class DmCreatureException
    implements _i1.SerializableException, _i1.SerializableModel {
  DmCreatureException._({
    required this.code,
    required this.message,
  });

  factory DmCreatureException({
    required String code,
    required String message,
  }) = _DmCreatureExceptionImpl;

  factory DmCreatureException.fromJson(Map<String, dynamic> jsonSerialization) {
    return DmCreatureException(
      code: jsonSerialization['code'] as String,
      message: jsonSerialization['message'] as String,
    );
  }

  String code;

  String message;

  /// Returns a shallow copy of this [DmCreatureException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DmCreatureException copyWith({
    String? code,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DmCreatureExceptionImpl extends DmCreatureException {
  _DmCreatureExceptionImpl({
    required String code,
    required String message,
  }) : super._(
          code: code,
          message: message,
        );

  /// Returns a shallow copy of this [DmCreatureException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DmCreatureException copyWith({
    String? code,
    String? message,
  }) {
    return DmCreatureException(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}
