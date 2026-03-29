import 'package:characters_mirror_flutter/app/auth/pages/sign_up_page.dart';
import 'package:characters_mirror_flutter/app/auth/src/auth_provider.dart';
import 'package:characters_mirror_flutter/app/pages/characters_list/characters_list.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_progression.dart';
import 'package:characters_mirror_flutter/app/router/router_provider.dart';
import 'package:characters_mirror_flutter/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as auth;

void main() {
  group('Auth flow', () {
    testWidgets('signed out user is redirected to sign in', (tester) async {
      final service = FakeAuthService();

      await tester.pumpWidget(_TestRouterApp(service: service));
      await tester.pumpAndSettle();

      expect(find.text('Вход'), findsOneWidget);
      expect(find.text('Создать аккаунт'), findsNothing);
    });

    testWidgets('sign up validates username and password confirmation',
        (tester) async {
      final service = FakeAuthService();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [authServiceProvider.overrideWithValue(service)],
          child: MaterialApp(
            theme: darkTheme,
            home: const SignUpPage(),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextFormField).at(1),
        'user@example.com',
      );
      await tester.enterText(
        find.byType(TextFormField).at(2),
        'password123',
      );
      await tester.enterText(
        find.byType(TextFormField).at(3),
        'different',
      );
      await tester.tap(find.text('Создать аккаунт'));
      await tester.pumpAndSettle();

      expect(find.text('Введите имя пользователя.'), findsOneWidget);
      expect(find.text('Пароли не совпадают.'), findsOneWidget);
      expect(service.registerCallCount, 0);
    });

    testWidgets('logout returns user to sign in screen', (tester) async {
      final service = FakeAuthService.signedIn(_user(email: 'hero@test.dev'));

      await tester.pumpWidget(_TestRouterApp(service: service));
      await tester.pumpAndSettle();

      expect(find.text('Characters List'), findsOneWidget);

      await tester.tap(find.text('Выйти'));
      await tester.pumpAndSettle();

      expect(find.text('Вход'), findsOneWidget);
      expect(service.signOutCallCount, 1);
    });

    testWidgets('admin button is visible for admin users', (tester) async {
      final service = FakeAuthService.signedIn(
        _user(
          email: 'admin@test.dev',
          scopes: const ['admin'],
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [authServiceProvider.overrideWithValue(service)],
          child: MaterialApp(
            theme: darkTheme,
            home: const CharactersList(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Админ'), findsOneWidget);
      expect(find.text('admin@test.dev'), findsOneWidget);
    });
  });

  group('Creation flow app bar', () {
    testWidgets('shows current step title and highlights active circle',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: darkTheme,
            home: const Scaffold(
              appBar: CreationAppBar(
                title: 'Создание персонажа',
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Создание персонажа'), findsOneWidget);
      expect(find.text('Вступление'), findsOneWidget);
      expect(find.byType(CreationProgression), findsOneWidget);
      expect(find.text('1'), findsOneWidget);

      final activeCircle = tester.getSize(find.byType(CircleAvatar).at(0));
      final inactiveCircle = tester.getSize(find.byType(CircleAvatar).at(1));

      expect(activeCircle.width, greaterThan(inactiveCircle.width));
      expect(activeCircle.height, greaterThan(inactiveCircle.height));
    });
  });
}

class _TestRouterApp extends StatelessWidget {
  const _TestRouterApp({required this.service});

  final FakeAuthService service;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [authServiceProvider.overrideWithValue(service)],
      child: const _RouterHost(),
    );
  }
}

class _RouterHost extends ConsumerWidget {
  const _RouterHost();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: darkTheme,
      routerConfig: router,
    );
  }
}

class FakeAuthService extends AuthService {
  FakeAuthService({auth.UserInfo? initialUser}) : _user = initialUser;

  FakeAuthService.signedIn(auth.UserInfo user) : _user = user;

  auth.UserInfo? _user;
  int registerCallCount = 0;
  int signOutCallCount = 0;

  @override
  auth.UserInfo? get currentUser => _user;

  @override
  bool get isSignedIn => _user != null;

  @override
  Future<AuthActionResult> register(
    String userName,
    String email,
    String password,
  ) async {
    registerCallCount += 1;
    _user = _user ??
        auth.UserInfo(
          userIdentifier: email,
          userName: userName,
          email: email,
          created: DateTime(2026),
          scopeNames: const [],
          blocked: false,
        );
    notifyListeners();
    return const AuthActionResult(
      success: true,
      code: 'ok',
      message: 'Аккаунт успешно создан.',
    );
  }

  @override
  Future<AuthActionResult> signIn(String email, String password) async {
    _user = auth.UserInfo(
      userIdentifier: email,
      userName: 'Hero',
      email: email,
      created: DateTime(2026),
      scopeNames: const [],
      blocked: false,
    );
    notifyListeners();
    return const AuthActionResult(
      success: true,
      code: 'ok',
      message: 'Вход выполнен.',
    );
  }

  @override
  Future<AuthActionResult> signOut() async {
    signOutCallCount += 1;
    _user = null;
    notifyListeners();
    return const AuthActionResult(
      success: true,
      code: 'ok',
      message: 'Вы вышли из аккаунта.',
    );
  }
}

auth.UserInfo _user({
  required String email,
  List<String> scopes = const [],
}) {
  return auth.UserInfo(
    userIdentifier: email,
    userName: 'Admin Hero',
    email: email,
    created: DateTime(2026),
    scopeNames: scopes,
    blocked: false,
  );
}
