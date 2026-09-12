import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';
import 'package:characters_mirror_flutter/features/auth/presentation/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as auth;

void main() {
  group('reachableServerpodPublicUrlForServerUrl', () {
    test('rewrites localhost public URLs for native clients', () {
      final url = reachableServerpodPublicUrlForServerUrl(
        'http://localhost:8083/serverpod_cloud_storage?method=file&path=serverpod%2Fuser_images%2F1-1.jpg',
        serverpodServerUrl: 'http://10.0.2.2:8083/',
        isWeb: false,
      );

      expect(
        url,
        'http://10.0.2.2:8083/serverpod_cloud_storage?method=file&path=serverpod%2Fuser_images%2F1-1.jpg',
      );
    });

    test('keeps URLs unchanged on web', () {
      final url = reachableServerpodPublicUrlForServerUrl(
        'http://localhost:8083/serverpod_cloud_storage?method=file',
        serverpodServerUrl: 'http://10.0.2.2:8083/',
        isWeb: true,
      );

      expect(
        url,
        'http://localhost:8083/serverpod_cloud_storage?method=file',
      );
    });

    test('keeps non-localhost URLs unchanged', () {
      final url = reachableServerpodPublicUrlForServerUrl(
        'https://cdn.example.dev/serverpod/user_images/1-1.jpg',
        serverpodServerUrl: 'http://10.0.2.2:8083/',
        isWeb: false,
      );

      expect(url, 'https://cdn.example.dev/serverpod/user_images/1-1.jpg');
    });
  });

  testWidgets('UserAvatar falls back when the network image fails',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: UserAvatar(
          user: auth.UserInfo(
            userIdentifier: 'hero@test.dev',
            userName: 'Hero',
            email: 'hero@test.dev',
            created: DateTime(2026),
            imageUrl: 'http://localhost:1/missing.jpg',
            scopeNames: const [],
            blocked: false,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('H'), findsOneWidget);
  });
}
