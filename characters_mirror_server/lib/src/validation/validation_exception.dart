class InputValidationException implements Exception {
  InputValidationException(this.field, this.message);

  final String field;
  final String message;

  @override
  String toString() => 'Validation failed for $field: $message';
}
