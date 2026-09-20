import 'dart:math';

String createCharacterSyncItemId() {
  final random = Random.secure();
  final parts = [
    for (final length in const [8, 4, 4, 4, 12]) _randomHex(random, length),
  ];
  return parts.join('-');
}

String _randomHex(Random random, int length) {
  final buffer = StringBuffer();
  for (var index = 0; index < length; index++) {
    buffer.write(random.nextInt(16).toRadixString(16));
  }
  return buffer.toString();
}
