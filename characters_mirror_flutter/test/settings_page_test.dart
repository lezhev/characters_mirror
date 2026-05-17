import 'package:characters_mirror_client/characters_mirror_client.dart'
    as protocol;
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/auth/auth.dart';
import 'package:characters_mirror_flutter/features/characters/application/characters_list_state.dart';
import 'package:characters_mirror_flutter/features/characters/characters.dart';
import 'package:characters_mirror_flutter/features/settings/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as auth;
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

void main() {
  group('Settings navigation', () {
    testWidgets('signed in user opens settings from profile menu',
        (tester) async {
      _setLargeSurface(tester);
      final authService = _FakeAuthService.signedIn(_user());
      final storage = _FakeStorage();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWithValue(authService),
            userSettingsRepositoryProvider.overrideWithValue(
              UserSettingsRepository(storage: storage),
            ),
            charactersListControllerProvider.overrideWith(
              (ref) => CharactersListController(_FakeCharacterRepository()),
            ),
            serverConnectionStatusProvider.overrideWith(
              (ref) async => ServerConnectionStatus.online,
            ),
          ],
          child: _SettingsRouterHarness(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(_accountMenuButtonFinder());
      await tester.pumpAndSettle();

      expect(find.text('Настройки'), findsOneWidget);

      await tester.tap(find.text('Настройки'));
      await tester.pumpAndSettle();

      expect(find.text('Внешний вид'), findsOneWidget);
      expect(find.text('Как в системе'), findsOneWidget);
      expect(find.text('Режим работы'), findsOneWidget);
      expect(find.text('Онлайн'), findsOneWidget);
    });
  });

  group('Settings page', () {
    testWidgets('changing theme updates active brightness and persists value',
        (tester) async {
      final storage = _FakeStorage()..values[userSettingsThemeModeKey] = 'dark';

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userSettingsRepositoryProvider.overrideWithValue(
              UserSettingsRepository(storage: storage),
            ),
            serverConnectionStatusProvider.overrideWith(
              (ref) async => ServerConnectionStatus.online,
            ),
          ],
          child: const _SettingsThemeHarness(),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        Theme.of(tester.element(find.byType(SettingsPage))).brightness,
        Brightness.dark,
      );

      await tester.tap(find.text('Светлая'));
      await tester.pumpAndSettle();

      expect(storage.values[userSettingsThemeModeKey], 'light');
      expect(
        Theme.of(tester.element(find.byType(SettingsPage))).brightness,
        Brightness.light,
      );

      await tester.tap(find.text('Тёмная'));
      await tester.pumpAndSettle();

      expect(storage.values[userSettingsThemeModeKey], 'dark');
      expect(
        Theme.of(tester.element(find.byType(SettingsPage))).brightness,
        Brightness.dark,
      );
    });

    testWidgets('shows offline status when ping fails', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userSettingsRepositoryProvider.overrideWithValue(
              UserSettingsRepository(storage: _FakeStorage()),
            ),
            serverConnectionStatusProvider.overrideWith(
              (ref) async => ServerConnectionStatus.offline,
            ),
          ],
          child: const _SettingsThemeHarness(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Оффлайн'), findsOneWidget);
      expect(
        find.textContaining('Сервер недоступен.'),
        findsOneWidget,
      );
    });

    testWidgets('android keep screen awake toggle persists value',
        (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      try {
        final storage = _FakeStorage();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              userSettingsRepositoryProvider.overrideWithValue(
                UserSettingsRepository(storage: storage),
              ),
              serverConnectionStatusProvider.overrideWith(
                (ref) async => ServerConnectionStatus.online,
              ),
            ],
            child: const _SettingsThemeHarness(),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Экран'), findsOneWidget);
        expect(find.text('Не гасить экран'), findsOneWidget);

        await tester.tap(find.byType(SwitchListTile));
        await tester.pumpAndSettle();

        expect(storage.values[userSettingsKeepScreenAwakeKey], 1);
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });

    testWidgets('keep screen awake toggle is hidden outside android',
        (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      try {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              userSettingsRepositoryProvider.overrideWithValue(
                UserSettingsRepository(storage: _FakeStorage()),
              ),
              serverConnectionStatusProvider.overrideWith(
                (ref) async => ServerConnectionStatus.online,
              ),
            ],
            child: const _SettingsThemeHarness(),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Не гасить экран'), findsNothing);
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });
  });
}

class _SettingsRouterHarness extends StatelessWidget {
  _SettingsRouterHarness();

  late final GoRouter _router = GoRouter(
    initialLocation: '/characters',
    routes: [
      GoRoute(
        path: '/characters',
        builder: (_, __) => const CharactersList(),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => const SettingsPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: _router,
    );
  }
}

class _SettingsThemeHarness extends ConsumerWidget {
  const _SettingsThemeHarness();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(userSettingsControllerProvider);

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: settings.maybeWhen(
        data: (value) => value.themeMode,
        orElse: () => ThemeMode.system,
      ),
      home: const SettingsPage(),
    );
  }
}

class _FakeCharacterRepository extends CharacterRepository {
  @override
  Future<List<protocol.CharacterData>> getAll() async {
    return const [];
  }

  @override
  Future<void> delete(int id) async {}
}

class _FakeAuthService extends AuthService {
  _FakeAuthService.signedIn(auth.UserInfo user) : _user = user;

  auth.UserInfo? _user;

  @override
  auth.UserInfo? get currentUser => _user;

  @override
  bool get isSignedIn => _user != null;

  @override
  Future<AuthActionResult> register(
    String userName,
    String email,
    String password, {
    required bool rememberMe,
  }) async {
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
  Future<AuthActionResult> signIn(
    String email,
    String password, {
    required bool rememberMe,
  }) async {
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
    _user = null;
    notifyListeners();
    return const AuthActionResult(
      success: true,
      code: 'ok',
      message: 'Вы вышли из аккаунта.',
    );
  }
}

class _FakeStorage implements Storage {
  final Map<String, Object> values = {};

  @override
  Future<int?> getInt(String key) async {
    return values[key] as int?;
  }

  @override
  Future<String?> getString(String key) async {
    return values[key] as String?;
  }

  @override
  Future<void> remove(String key) async {
    values.remove(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    values[key] = value;
  }

  @override
  Future<void> setString(String key, String value) async {
    values[key] = value;
  }
}

auth.UserInfo _user() {
  return auth.UserInfo(
    userIdentifier: 'hero@test.dev',
    userName: 'Hero',
    email: 'hero@test.dev',
    created: DateTime(2026),
    scopeNames: const [],
    blocked: false,
  );
}

Finder _accountMenuButtonFinder() {
  return find.byWidgetPredicate(
    (widget) => widget.runtimeType.toString().startsWith('PopupMenuButton'),
    description: 'account popup menu button',
  );
}

void _setLargeSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(1440, 1600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}
