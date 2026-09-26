import 'package:characters_mirror_flutter/features/auth/application/auth_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as auth;

void main() {
  test('AuthState identifies the admin scope without an admin page', () {
    final adminState = AuthState.signedIn(
      auth.UserInfo(
        id: 1,
        userIdentifier: 'admin',
        created: DateTime.utc(2026),
        scopeNames: ['admin'],
        blocked: false,
      ),
    );
    final regularState = AuthState.signedIn(
      auth.UserInfo(
        id: 2,
        userIdentifier: 'user',
        created: DateTime.utc(2026),
        scopeNames: ['user'],
        blocked: false,
      ),
    );

    expect(adminState.hasScope('admin'), isTrue);
    expect(regularState.hasScope('admin'), isFalse);
    expect(const AuthState.signedOut().hasScope('admin'), isFalse);
  });
}
