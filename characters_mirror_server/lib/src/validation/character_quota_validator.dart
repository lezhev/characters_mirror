import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

import 'validation_exception.dart';
import 'validation_limits.dart';

abstract final class CharacterQuotaValidator {
  static Future<void> validateCanCreateCharacter(
    Session session, {
    required int userId,
  }) async {
    final count = await CharacterRecord.db.count(
      session,
      where: (t) => t.userId.equals(userId),
      limit: ValidationLimits.largeCollection,
    );
    if (count >= ValidationLimits.largeCollection) {
      throw InputValidationException(
        'characters',
        'largeCollection size $count reached '
            '${ValidationLimits.largeCollection}.',
      );
    }
  }
}
