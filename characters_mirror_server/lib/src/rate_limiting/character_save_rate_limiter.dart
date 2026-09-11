class CharacterSaveRateLimitException implements Exception {
  CharacterSaveRateLimitException(this.key);

  final String key;

  @override
  String toString() => 'Character save rate limit exceeded for $key.';
}

class CharacterSaveRateLimiter {
  CharacterSaveRateLimiter({
    DateTime Function()? now,
    this.capacity = 5,
    this.refillPerMinute = 20,
  }) : _now = now ?? DateTime.now;

  static CharacterSaveRateLimiter instance = CharacterSaveRateLimiter();

  final DateTime Function() _now;
  final int capacity;
  final int refillPerMinute;
  final Map<String, _Bucket> _buckets = {};

  void consume({
    required int userId,
    required int? characterId,
  }) {
    final key = bucketKey(userId: userId, characterId: characterId);
    final now = _now().toUtc();
    final bucket = _buckets.putIfAbsent(
      key,
      () => _Bucket(tokens: capacity.toDouble(), updatedAt: now),
    );
    _refill(bucket, now);

    if (bucket.tokens < 1) {
      throw CharacterSaveRateLimitException(key);
    }
    bucket.tokens -= 1;
  }

  static String bucketKey({
    required int userId,
    required int? characterId,
  }) {
    return 'character-save:$userId:${characterId ?? 'new'}';
  }

  static void resetForTests() {
    instance = CharacterSaveRateLimiter();
  }

  void _refill(_Bucket bucket, DateTime now) {
    final elapsed = now.difference(bucket.updatedAt);
    if (elapsed.isNegative || elapsed == Duration.zero) {
      bucket.updatedAt = now;
      return;
    }

    final refill = elapsed.inMicroseconds *
        refillPerMinute /
        Duration.microsecondsPerMinute;
    bucket.tokens = (bucket.tokens + refill).clamp(0, capacity).toDouble();
    bucket.updatedAt = now;
  }
}

class _Bucket {
  _Bucket({
    required this.tokens,
    required this.updatedAt,
  });

  double tokens;
  DateTime updatedAt;
}
