/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

abstract class DmCreatureSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DmCreatureSummary._({
    required this.id,
    required this.name,
    this.challengeRating,
    this.hpMax,
    required this.createdAt,
  });

  factory DmCreatureSummary({
    required int id,
    required String name,
    String? challengeRating,
    int? hpMax,
    required DateTime createdAt,
  }) = _DmCreatureSummaryImpl;

  factory DmCreatureSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return DmCreatureSummary(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      challengeRating: jsonSerialization['challengeRating'] as String?,
      hpMax: jsonSerialization['hpMax'] as int?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  int id;

  String name;

  String? challengeRating;

  int? hpMax;

  DateTime createdAt;

  /// Returns a shallow copy of this [DmCreatureSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DmCreatureSummary copyWith({
    int? id,
    String? name,
    String? challengeRating,
    int? hpMax,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DmCreatureSummary',
      'id': id,
      'name': name,
      if (challengeRating != null) 'challengeRating': challengeRating,
      if (hpMax != null) 'hpMax': hpMax,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DmCreatureSummary',
      'id': id,
      'name': name,
      if (challengeRating != null) 'challengeRating': challengeRating,
      if (hpMax != null) 'hpMax': hpMax,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DmCreatureSummaryImpl extends DmCreatureSummary {
  _DmCreatureSummaryImpl({
    required int id,
    required String name,
    String? challengeRating,
    int? hpMax,
    required DateTime createdAt,
  }) : super._(
         id: id,
         name: name,
         challengeRating: challengeRating,
         hpMax: hpMax,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [DmCreatureSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DmCreatureSummary copyWith({
    int? id,
    String? name,
    Object? challengeRating = _Undefined,
    Object? hpMax = _Undefined,
    DateTime? createdAt,
  }) {
    return DmCreatureSummary(
      id: id ?? this.id,
      name: name ?? this.name,
      challengeRating: challengeRating is String?
          ? challengeRating
          : this.challengeRating,
      hpMax: hpMax is int? ? hpMax : this.hpMax,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
