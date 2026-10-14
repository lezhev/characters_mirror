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

abstract class DmCreatureRecord implements _i1.SerializableModel {
  DmCreatureRecord._({
    this.id,
    required this.userId,
    required this.name,
    required this.sourceType,
    this.sourceVersion,
    this.challengeRating,
    required this.rawJson,
    required this.normalizedJson,
    required this.importHash,
    required this.schemaVersion,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DmCreatureRecord({
    int? id,
    required int userId,
    required String name,
    required String sourceType,
    String? sourceVersion,
    String? challengeRating,
    required String rawJson,
    required String normalizedJson,
    required String importHash,
    required int schemaVersion,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DmCreatureRecordImpl;

  factory DmCreatureRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return DmCreatureRecord(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      sourceType: jsonSerialization['sourceType'] as String,
      sourceVersion: jsonSerialization['sourceVersion'] as String?,
      challengeRating: jsonSerialization['challengeRating'] as String?,
      rawJson: jsonSerialization['rawJson'] as String,
      normalizedJson: jsonSerialization['normalizedJson'] as String,
      importHash: jsonSerialization['importHash'] as String,
      schemaVersion: jsonSerialization['schemaVersion'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String name;

  String sourceType;

  String? sourceVersion;

  String? challengeRating;

  String rawJson;

  String normalizedJson;

  String importHash;

  int schemaVersion;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DmCreatureRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DmCreatureRecord copyWith({
    int? id,
    int? userId,
    String? name,
    String? sourceType,
    String? sourceVersion,
    String? challengeRating,
    String? rawJson,
    String? normalizedJson,
    String? importHash,
    int? schemaVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'sourceType': sourceType,
      if (sourceVersion != null) 'sourceVersion': sourceVersion,
      if (challengeRating != null) 'challengeRating': challengeRating,
      'rawJson': rawJson,
      'normalizedJson': normalizedJson,
      'importHash': importHash,
      'schemaVersion': schemaVersion,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DmCreatureRecordImpl extends DmCreatureRecord {
  _DmCreatureRecordImpl({
    int? id,
    required int userId,
    required String name,
    required String sourceType,
    String? sourceVersion,
    String? challengeRating,
    required String rawJson,
    required String normalizedJson,
    required String importHash,
    required int schemaVersion,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          name: name,
          sourceType: sourceType,
          sourceVersion: sourceVersion,
          challengeRating: challengeRating,
          rawJson: rawJson,
          normalizedJson: normalizedJson,
          importHash: importHash,
          schemaVersion: schemaVersion,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [DmCreatureRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DmCreatureRecord copyWith({
    Object? id = _Undefined,
    int? userId,
    String? name,
    String? sourceType,
    Object? sourceVersion = _Undefined,
    Object? challengeRating = _Undefined,
    String? rawJson,
    String? normalizedJson,
    String? importHash,
    int? schemaVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DmCreatureRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      sourceType: sourceType ?? this.sourceType,
      sourceVersion:
          sourceVersion is String? ? sourceVersion : this.sourceVersion,
      challengeRating:
          challengeRating is String? ? challengeRating : this.challengeRating,
      rawJson: rawJson ?? this.rawJson,
      normalizedJson: normalizedJson ?? this.normalizedJson,
      importHash: importHash ?? this.importHash,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
