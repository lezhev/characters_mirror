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

abstract class AuthActionResult implements _i1.SerializableModel {
  AuthActionResult._({
    required this.success,
    required this.code,
    required this.message,
  });

  factory AuthActionResult({
    required bool success,
    required String code,
    required String message,
  }) = _AuthActionResultImpl;

  factory AuthActionResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthActionResult(
      success: jsonSerialization['success'] as bool,
      code: jsonSerialization['code'] as String,
      message: jsonSerialization['message'] as String,
    );
  }

  bool success;

  String code;

  String message;

  /// Returns a shallow copy of this [AuthActionResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuthActionResult copyWith({
    bool? success,
    String? code,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'code': code,
      'message': message,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AuthActionResultImpl extends AuthActionResult {
  _AuthActionResultImpl({
    required bool success,
    required String code,
    required String message,
  }) : super._(
          success: success,
          code: code,
          message: message,
        );

  /// Returns a shallow copy of this [AuthActionResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuthActionResult copyWith({
    bool? success,
    String? code,
    String? message,
  }) {
    return AuthActionResult(
      success: success ?? this.success,
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}
