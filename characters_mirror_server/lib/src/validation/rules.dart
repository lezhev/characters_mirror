import 'validation_exception.dart';
import 'validation_limits.dart';

abstract final class Rules {
  static void shortText(String field, String? value) {
    _text(field, value, ValidationLimits.shortText, 'shortText');
  }

  static void mediumText(String field, String? value) {
    _text(field, value, ValidationLimits.mediumText, 'mediumText');
  }

  static void longText(String field, String? value) {
    _text(field, value, ValidationLimits.longText, 'longText');
  }

  static void smallCollection(String field, Object? value) {
    _collection(
      field,
      value,
      ValidationLimits.smallCollection,
      'smallCollection',
    );
  }

  static void mediumCollection(String field, Object? value) {
    _collection(
      field,
      value,
      ValidationLimits.mediumCollection,
      'mediumCollection',
    );
  }

  static void largeCollection(String field, Object? value) {
    _collection(
      field,
      value,
      ValidationLimits.largeCollection,
      'largeCollection',
    );
  }

  static void proficiencyOverrideCollection(String field, Object? value) {
    _collection(
      field,
      value,
      ValidationLimits.proficiencyOverrideEntries,
      'proficiencyOverrideCollection',
    );
  }

  static void boundedInt(
    String field,
    int? value, {
    int min = ValidationLimits.boundedIntMin,
    int max = ValidationLimits.boundedIntMax,
  }) {
    if (value == null) return;
    if (value < min || value > max) {
      throw InputValidationException(
        field,
        'must be between $min and $max.',
      );
    }
  }

  static void nonNegativeInt(
    String field,
    int? value, {
    int max = ValidationLimits.nonNegativeIntMax,
  }) {
    if (value == null) return;
    if (value < 0 || value > max) {
      throw InputValidationException(
        field,
        'must be between 0 and $max.',
      );
    }
  }

  static void rangeInt(
    String field,
    int? value, {
    required int min,
    required int max,
  }) {
    if (value == null) return;
    if (value < min || value > max) {
      throw InputValidationException(
        field,
        'must be between $min and $max.',
      );
    }
  }

  static void _text(
    String field,
    String? value,
    int maxLength,
    String category,
  ) {
    if (value == null) return;
    final length = value.runes.length;
    if (length > maxLength) {
      throw InputValidationException(
        field,
        '$category length $length exceeds $maxLength.',
      );
    }
  }

  static void _collection(
    String field,
    Object? value,
    int maxLength,
    String category,
  ) {
    if (value == null) return;
    final length = switch (value) {
      Iterable<Object?> iterable => iterable.length,
      Map<Object?, Object?> map => map.length,
      _ => throw InputValidationException(
          field,
          'must be an Iterable or Map.',
        ),
    };
    if (length > maxLength) {
      throw InputValidationException(
        field,
        '$category size $length exceeds $maxLength.',
      );
    }
  }
}
