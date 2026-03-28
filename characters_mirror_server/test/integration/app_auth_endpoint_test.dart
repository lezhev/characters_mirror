import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('AppAuthEndpoint.register', (sessionBuilder, endpoints) {
    test('creates a new user for valid credentials', () async {
      final result = await endpoints.appAuth.register(
        sessionBuilder,
        'Melifaro',
        'melifaro@example.com',
        'password123',
      );

      expect(result.success, isTrue);
      expect(result.code, 'ok');

      final session = sessionBuilder.build();
      try {
        final user =
            await auth.Users.findUserByEmail(session, 'melifaro@example.com');
        expect(user, isNotNull);
        expect(user?.userName, 'Melifaro');
      } finally {
        await session.close();
      }
    });

    test('rejects duplicate email', () async {
      await endpoints.appAuth.register(
        sessionBuilder,
        'First',
        'duplicate@example.com',
        'password123',
      );

      final result = await endpoints.appAuth.register(
        sessionBuilder,
        'Second',
        'duplicate@example.com',
        'password123',
      );

      expect(result.success, isFalse);
      expect(result.code, 'email_taken');
    });

    test('rejects invalid email', () async {
      final result = await endpoints.appAuth.register(
        sessionBuilder,
        'Wizard',
        'not-an-email',
        'password123',
      );

      expect(result.success, isFalse);
      expect(result.code, 'invalid_email');
    });

    test('rejects weak password', () async {
      final result = await endpoints.appAuth.register(
        sessionBuilder,
        'Wizard',
        'wizard@example.com',
        '12345',
      );

      expect(result.success, isFalse);
      expect(result.code, 'weak_password');
    });
  });
}
