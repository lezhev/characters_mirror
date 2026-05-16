import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart'
    as protocol;
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/features/auth/auth.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/characters/application/characters_list_state.dart';
import 'package:characters_mirror_flutter/features/characters/characters.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_progression.dart';
import 'package:characters_mirror_flutter/core/router/app_router.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as auth;

void main() {
  group('Auth flow', () {
    testWidgets('default route redirects signed out user to sign in',
        (tester) async {
      final service = FakeAuthService();

      await tester.pumpWidget(_TestRouterApp(service: service));
      await tester.pumpAndSettle();

      expect(find.text('Вход'), findsOneWidget);
      expect(find.text('Список персонажей'), findsNothing);
    });

    testWidgets('signed out user is redirected to sign in', (tester) async {
      final service = FakeAuthService();

      await tester.pumpWidget(_TestRouterApp(service: service));
      await tester.pumpAndSettle();

      expect(find.text('Вход'), findsOneWidget);
      expect(find.text('Создать аккаунт'), findsNothing);
    });

    testWidgets('default route redirects signed in user to characters list',
        (tester) async {
      final service = FakeAuthService.signedIn(_user(email: 'hero@test.dev'));

      await tester.pumpWidget(_TestRouterApp(service: service));
      await tester.pumpAndSettle();

      expect(find.text('Список персонажей'), findsOneWidget);
      expect(find.text('Вход'), findsNothing);
    });

    testWidgets('sign in shows remember me enabled by default', (tester) async {
      final service = FakeAuthService();

      await tester.pumpWidget(_TestRouterApp(service: service));
      await tester.pumpAndSettle();

      expect(find.text('Запомнить меня'), findsOneWidget);
      expect(
        tester.widget<CheckboxListTile>(find.byType(CheckboxListTile)).value,
        isTrue,
      );
    });

    testWidgets('sign in passes remember me choice', (tester) async {
      final service = FakeAuthService();

      await tester.pumpWidget(_TestRouterApp(service: service));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'user@example.com',
      );
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'password123',
      );
      await tester.tap(find.text('Запомнить меня'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Войти'));
      await tester.pumpAndSettle();

      expect(service.lastSignInRememberMe, isFalse);
      expect(find.text('Список персонажей'), findsOneWidget);
    });

    testWidgets('sign up shows remember me enabled by default', (tester) async {
      final service = FakeAuthService();
      final container = ProviderContainer(
        overrides: [authServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);
      _setLargeSurface(tester);

      await _pumpRouterAppWithContainer(tester, container);

      final router = container.read(routerProvider);
      router.go('/sign-up');
      await tester.pumpAndSettle();

      expect(find.text('Запомнить меня'), findsOneWidget);
      expect(
        tester.widget<CheckboxListTile>(find.byType(CheckboxListTile)).value,
        isTrue,
      );
    });

    testWidgets('sign up validates username and password confirmation',
        (tester) async {
      final service = FakeAuthService();
      _setLargeSurface(tester);

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
      await tester.ensureVisible(find.text('Создать аккаунт'));
      await tester.tap(find.text('Создать аккаунт'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('Введите имя пользователя.'), findsOneWidget);
      expect(find.text('Пароли не совпадают.'), findsOneWidget);
      expect(service.registerCallCount, 0);
    });

    testWidgets('sign up passes remember me choice', (tester) async {
      final service = FakeAuthService();
      final container = ProviderContainer(
        overrides: [authServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);
      _setLargeSurface(tester);

      await _pumpRouterAppWithContainer(tester, container);

      final router = container.read(routerProvider);
      router.go('/sign-up');
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'Melifaro',
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
        'password123',
      );
      await tester.tap(find.text('Запомнить меня'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Создать аккаунт'));
      await tester.tap(find.text('Создать аккаунт'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(service.lastRegisterRememberMe, isFalse);
      expect(find.text('Список персонажей'), findsOneWidget);
    });

    testWidgets('logout returns user to sign in screen', (tester) async {
      final service = FakeAuthService.signedIn(_user(email: 'hero@test.dev'));

      await tester.pumpWidget(_TestRouterApp(service: service));
      await tester.pumpAndSettle();

      expect(find.text('Список персонажей'), findsOneWidget);

      await tester.tap(_accountMenuButtonFinder());
      await tester.pumpAndSettle();

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

      await tester.tap(_accountMenuButtonFinder());
      await tester.pumpAndSettle();

      expect(find.text('Админ'), findsOneWidget);
      expect(find.text('admin@test.dev'), findsOneWidget);
    });
  });

  group('Creation flow app bar', () {
    testWidgets('shows current step title and highlights active circle',
        (tester) async {
      _setLargeSurface(tester);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            theme: darkTheme,
            routerConfig: GoRouter(
              initialLocation: Step.introduction.routePath,
              routes: [
                GoRoute(
                  path: Step.introduction.routePath,
                  builder: (_, __) => const Scaffold(
                    appBar: CreationAppBar(
                      title: 'Создание персонажа',
                    ),
                  ),
                ),
              ],
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

  group('Character sheet draft flow', () {
    testWidgets('finish on summary saves character and opens sheet page',
        (tester) async {
      final service = FakeAuthService.signedIn(_user(email: 'hero@test.dev'));
      final repository = FakeCharacterRepository(
        onSave: (character) async => character.copyWith(id: 42),
        initialCharacters: {
          42: protocol.CharacterData(
            id: 42,
            name: 'Тестовый герой',
          ),
        },
      );
      final container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWithValue(service),
          characterRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);
      _setLargeSurface(tester);

      container.read(characterCreationProvider.notifier).setName(
            'Тестовый герой',
          );

      await _pumpRouterAppWithContainer(tester, container);

      final router = container.read(routerProvider);
      router.go('/create/summary');
      await tester.pumpAndSettle();

      expect(find.text('Сводка персонажа'), findsOneWidget);

      await tester.ensureVisible(find.text('Завершить'));
      await tester.tap(find.text('Завершить'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(repository.saveCallCount, 1);
      expect(find.text('Тестовый герой'), findsOneWidget);
      expect(find.text('Атаки'), findsOneWidget);
    });

    testWidgets('finish action cannot trigger duplicate save requests',
        (tester) async {
      final service = FakeAuthService.signedIn(_user(email: 'hero@test.dev'));
      final saveCompleter = Completer<protocol.CharacterData>();
      final repository = FakeCharacterRepository(
        onSave: (_) => saveCompleter.future,
        initialCharacters: {
          42: protocol.CharacterData(
            id: 42,
            name: 'Тестовый герой',
          ),
        },
      );
      final container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWithValue(service),
          characterRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);
      _setLargeSurface(tester);

      container.read(characterCreationProvider.notifier).setName(
            'Тестовый герой',
          );

      await _pumpRouterAppWithContainer(tester, container);

      final router = container.read(routerProvider);
      router.go('/create/summary');
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Завершить'));
      await tester.tap(find.text('Завершить'), warnIfMissed: false);
      await tester.tap(find.text('Завершить'), warnIfMissed: false);
      await tester.pump();

      expect(repository.saveCallCount, 1);
      expect(find.text('Сводка персонажа'), findsOneWidget);

      saveCompleter.complete(
        protocol.CharacterData(
          id: 42,
          name: 'Тестовый герой',
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Тестовый герой'), findsOneWidget);
      expect(find.text('Атаки'), findsOneWidget);
    });

    testWidgets('save failure keeps user on summary and shows snackbar',
        (tester) async {
      final service = FakeAuthService.signedIn(_user(email: 'hero@test.dev'));
      final repository = FakeCharacterRepository(
        onSave: (_) async =>
            throw const protocol.ServerpodClientException('Failed to fetch', 0),
      );
      final container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWithValue(service),
          characterRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);
      _setLargeSurface(tester);

      container.read(characterCreationProvider.notifier).setName(
            'Тестовый герой',
          );

      await _pumpRouterAppWithContainer(tester, container);

      final router = container.read(routerProvider);
      router.go('/create/summary');
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Завершить'));
      await tester.tap(find.text('Завершить'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('Сводка персонажа'), findsOneWidget);
      expect(
        find.text('Не удалось подключиться к серверу. Проверьте соединение.'),
        findsOneWidget,
      );
    });

    testWidgets('sheet page loads character by id', (tester) async {
      final service = FakeAuthService.signedIn(_user(email: 'hero@test.dev'));
      final repository = FakeCharacterRepository(
        initialCharacters: {
          42: protocol.CharacterData(
            id: 42,
            name: 'Тестовый герой',
          ),
        },
      );
      final container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWithValue(service),
          characterRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);
      _setLargeSurface(tester);

      await _pumpRouterAppWithContainer(tester, container);

      final router = container.read(routerProvider);
      router.go('/characters/sheet/42');
      await tester.pumpAndSettle();

      expect(repository.getCharacterCallCount, 1);
      expect(find.text('Тестовый герой'), findsOneWidget);
      expect(find.text('Атаки'), findsOneWidget);
    });

    testWidgets('invalid sheet id shows fallback page', (tester) async {
      final service = FakeAuthService.signedIn(_user(email: 'hero@test.dev'));
      final repository = FakeCharacterRepository();
      final container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWithValue(service),
          characterRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);
      _setLargeSurface(tester);

      await _pumpRouterAppWithContainer(tester, container);

      final router = container.read(routerProvider);
      router.go('/characters/sheet/bad-id');
      await tester.pumpAndSettle();

      expect(
          find.text('Некорректный идентификатор персонажа.'), findsOneWidget);
    });

    testWidgets('placeholder tile opens character sheet for id 1',
        (tester) async {
      final service = FakeAuthService.signedIn(_user(email: 'hero@test.dev'));
      final repository = FakeCharacterRepository(
        initialCharacters: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
          ),
        },
      );
      final container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWithValue(service),
          characterRepositoryProvider.overrideWithValue(repository),
          charactersListControllerProvider.overrideWith(
            (ref) => CharactersListController(repository),
          ),
        ],
      );
      addTearDown(container.dispose);
      _setLargeSurface(tester);

      await _pumpRouterAppWithContainer(tester, container);

      expect(find.text('Список персонажей'), findsOneWidget);

      await tester.tap(find.text('Тестовый герой').first);
      await tester.pumpAndSettle();

      expect(repository.getCharacterCallCount, 1);
      expect(find.text('Тестовый герой'), findsOneWidget);
      expect(find.text('Атаки'), findsOneWidget);
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

Future<void> _pumpRouterAppWithContainer(
  WidgetTester tester,
  ProviderContainer container,
) async {
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const _RouterHost(),
    ),
  );
  await tester.pumpAndSettle();
}

void _setLargeSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(1440, 1600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Finder _accountMenuButtonFinder() {
  return find.byWidgetPredicate(
    (widget) => widget.runtimeType.toString().startsWith('PopupMenuButton'),
    description: 'account popup menu button',
  );
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
  int signInCallCount = 0;
  int signOutCallCount = 0;
  bool? lastRegisterRememberMe;
  bool? lastSignInRememberMe;

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
    registerCallCount += 1;
    lastRegisterRememberMe = rememberMe;
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
    signInCallCount += 1;
    lastSignInRememberMe = rememberMe;
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

class FakeCharacterRepository extends CharacterRepository {
  FakeCharacterRepository({
    Map<int, protocol.CharacterData>? initialCharacters,
    this.onSave,
    this.onGetCharacter,
  }) : _charactersById = Map<int, protocol.CharacterData>.from(
          initialCharacters ?? const {},
        );

  final Map<int, protocol.CharacterData> _charactersById;
  final Future<protocol.CharacterData> Function(
      protocol.CharacterData character)? onSave;
  final Future<protocol.CharacterData> Function(int id)? onGetCharacter;
  int saveCallCount = 0;
  int getCharacterCallCount = 0;
  int _nextId = 100;

  @override
  Future<List<protocol.CharacterData>> getAll() async {
    return _charactersById.values.toList();
  }

  @override
  Future<protocol.CharacterData?> getById(int id) async {
    return _charactersById[id];
  }

  @override
  Future<protocol.CharacterData> saveCharacter(
    protocol.CharacterData character,
  ) async {
    saveCallCount += 1;

    if (onSave != null) {
      final saved = await onSave!(character);
      if (saved.id != null) {
        _charactersById[saved.id!] = saved;
      }
      return saved;
    }

    final id = character.id ?? _nextId++;
    final saved = character.copyWith(id: id);
    _charactersById[id] = saved;
    return saved;
  }

  @override
  Future<protocol.CharacterData> getCharacter(int characterId) async {
    getCharacterCallCount += 1;

    if (onGetCharacter != null) {
      return onGetCharacter!(characterId);
    }

    final character = _charactersById[characterId];
    if (character == null) {
      throw Exception('Character not found');
    }
    return character;
  }

  @override
  Future<protocol.CharacterData> upsert(protocol.CharacterData entity) {
    return saveCharacter(entity);
  }

  @override
  Future<void> delete(int id) async {
    _charactersById.remove(id);
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
