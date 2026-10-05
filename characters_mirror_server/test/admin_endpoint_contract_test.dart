import 'package:characters_mirror_server/src/endpoints/admin_endpoint.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import 'package:test/test.dart';

void main() {
  group('AdminEndpoint role-management contract', () {
    test('requires login and the admin scope', () {
      final endpoint = AdminEndpoint();

      expect(endpoint.requireLogin, isTrue);
      expect(endpoint.requiredScopes, contains(const Scope('admin')));
    });

    test('exposes user listing and role mutation methods', () {
      final endpoint = AdminEndpoint();

      final Future<List<auth.UserInfo>> Function(Session) getAllUsers =
          endpoint.getAllUsers;
      final Future<void> Function(Session, int, bool) setAdminRole =
          endpoint.setAdminRole;
      final Future<int> Function(Session, String) importChoiceOptions =
          endpoint.importChoiceOptions;
      final Future<int> Function(Session, String) importFeatureModifiers =
          endpoint.importFeatureModifiers;

      expect(getAllUsers, isA<Function>());
      expect(setAdminRole, isA<Function>());
      expect(importChoiceOptions, isA<Function>());
      expect(importFeatureModifiers, isA<Function>());
    });
  });
}
