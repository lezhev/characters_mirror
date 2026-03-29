import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as auth;
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

final sessionManagerProvider = Provider<SessionManager>((ref) {
  return sessionManager;
});

final serverpodClientProvider = Provider<Client>((ref) {
  return client;
});

final authServiceProvider = Provider<AuthService>((ref) {
  final service = ServerpodAuthService(
    client: ref.watch(serverpodClientProvider),
    sessionManager: ref.watch(sessionManagerProvider),
  );
  ref.onDispose(service.dispose);
  return service;
});

final authProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref.watch(authServiceProvider));
});

enum AuthStatus {
  checking,
  signedOut,
  signedIn,
}

class AuthState {
  const AuthState._({
    required this.status,
    this.user,
  });

  const AuthState.checking() : this._(status: AuthStatus.checking);

  const AuthState.signedOut() : this._(status: AuthStatus.signedOut);

  const AuthState.signedIn(auth.UserInfo user)
      : this._(
          status: AuthStatus.signedIn,
          user: user,
        );

  final AuthStatus status;
  final auth.UserInfo? user;

  bool get isChecking => status == AuthStatus.checking;
  bool get isSignedIn => status == AuthStatus.signedIn && user != null;
  bool get isSignedOut => status == AuthStatus.signedOut;
  bool hasScope(String scope) => user?.scopeNames.contains(scope) ?? false;
}

class AuthActionResult {
  const AuthActionResult({
    required this.success,
    required this.message,
    this.code,
  });

  final bool success;
  final String message;
  final String? code;

  static const cancelled = AuthActionResult(
    success: false,
    message: 'Действие не выполнено.',
    code: 'cancelled',
  );
}

abstract class AuthService extends ChangeNotifier {
  auth.UserInfo? get currentUser;
  bool get isSignedIn;

  Future<AuthActionResult> signIn(String email, String password);
  Future<AuthActionResult> register(
    String userName,
    String email,
    String password,
  );
  Future<AuthActionResult> signOut();
}

class ServerpodAuthService extends AuthService {
  ServerpodAuthService({
    required Client client,
    required SessionManager sessionManager,
  })  : _client = client,
        _sessionManager = sessionManager {
    _sessionManager.addListener(_relaySessionUpdates);
  }

  final Client _client;
  final SessionManager _sessionManager;

  @override
  auth.UserInfo? get currentUser => _sessionManager.signedInUser;

  @override
  bool get isSignedIn => _sessionManager.isSignedIn;

  @override
  Future<AuthActionResult> signIn(String email, String password) async {
    try {
      final response = await _client.modules.auth.email.authenticate(
        email.trim().toLowerCase(),
        password,
      );

      if (!response.success ||
          response.userInfo == null ||
          response.keyId == null ||
          response.key == null) {
        return AuthActionResult(
          success: false,
          code: response.failReason?.name ?? 'invalid_credentials',
          message: _mapFailReason(response.failReason),
        );
      }

      await _sessionManager.registerSignedInUser(
        response.userInfo!,
        response.keyId!,
        response.key!,
      );

      return const AuthActionResult(
        success: true,
        code: 'ok',
        message: 'Вход выполнен.',
      );
    } catch (error) {
      return AuthActionResult(
        success: false,
        code: 'server_error',
        message: _mapExceptionToMessage(error),
      );
    }
  }

  @override
  Future<AuthActionResult> register(
    String userName,
    String email,
    String password,
  ) async {
    try {
      final result = await _client.appAuth.register(
        userName.trim(),
        email.trim().toLowerCase(),
        password,
      );

      if (!result.success) {
        return AuthActionResult(
          success: false,
          code: result.code,
          message: result.message,
        );
      }

      final signInResult = await signIn(email, password);
      if (!signInResult.success) {
        return AuthActionResult(
          success: false,
          code: signInResult.code ?? 'auto_sign_in_failed',
          message: 'Аккаунт создан, но войти автоматически не удалось.',
        );
      }

      return AuthActionResult(
        success: true,
        code: result.code,
        message: result.message,
      );
    } catch (error) {
      return AuthActionResult(
        success: false,
        code: 'server_error',
        message: _mapExceptionToMessage(error),
      );
    }
  }

  @override
  Future<AuthActionResult> signOut() async {
    try {
      final success = await _sessionManager.signOutDevice();
      if (!success) {
        return const AuthActionResult(
          success: false,
          code: 'sign_out_failed',
          message: 'Не удалось выйти из аккаунта.',
        );
      }

      return const AuthActionResult(
        success: true,
        code: 'ok',
        message: 'Вы вышли из аккаунта.',
      );
    } catch (error) {
      return AuthActionResult(
        success: false,
        code: 'server_error',
        message: _mapExceptionToMessage(error),
      );
    }
  }

  void _relaySessionUpdates() {
    notifyListeners();
  }

  @override
  void dispose() {
    _sessionManager.removeListener(_relaySessionUpdates);
    super.dispose();
  }
}

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._service) : super(const AuthState.checking()) {
    _service.addListener(_syncFromService);
    _syncFromService();
  }

  final AuthService _service;

  Future<AuthActionResult> signIn(String email, String password) async {
    final result = await _service.signIn(email, password);
    _syncFromService();
    return result;
  }

  Future<AuthActionResult> register(
    String userName,
    String email,
    String password,
  ) async {
    final result = await _service.register(userName, email, password);
    _syncFromService();
    return result;
  }

  Future<AuthActionResult> signOut() async {
    final result = await _service.signOut();
    _syncFromService();
    return result;
  }

  void _syncFromService() {
    final user = _service.currentUser;
    if (user == null) {
      state = const AuthState.signedOut();
      return;
    }

    state = AuthState.signedIn(user);
  }

  @override
  void dispose() {
    _service.removeListener(_syncFromService);
    super.dispose();
  }
}

String _mapFailReason(auth.AuthenticationFailReason? failReason) {
  switch (failReason) {
    case auth.AuthenticationFailReason.invalidCredentials:
      return 'Неверные email или пароль.';
    case auth.AuthenticationFailReason.tooManyFailedAttempts:
      return 'Слишком много попыток входа. Попробуйте позже.';
    case auth.AuthenticationFailReason.blocked:
      return 'Аккаунт заблокирован.';
    case auth.AuthenticationFailReason.userCreationDenied:
      return 'Создание пользователя отклонено сервером.';
    case auth.AuthenticationFailReason.internalError:
      return 'Сервер временно недоступен.';
    case null:
      return 'Не удалось выполнить вход.';
  }
}

String _mapExceptionToMessage(Object error) {
  final message = error.toString().toLowerCase();

  if (message.contains('socket') ||
      message.contains('network') ||
      message.contains('connection')) {
    return 'Нет соединения с сервером. Проверьте сеть.';
  }

  if (message.contains('timeout')) {
    return 'Сервер не ответил вовремя. Попробуйте ещё раз.';
  }

  return 'Произошла ошибка. Попробуйте ещё раз.';
}

String displayNameForUser(auth.UserInfo? user) {
  final userName = user?.userName?.trim();
  if (userName != null && userName.isNotEmpty) {
    return userName;
  }

  final email = user?.email?.trim();
  if (email != null && email.isNotEmpty) {
    return email;
  }

  return 'Игрок';
}

String initialsForUser(auth.UserInfo? user) {
  final source = displayNameForUser(user).trim();
  if (source.isEmpty) {
    return 'I';
  }

  final parts = source.split(RegExp(r'\s+'));
  if (parts.length == 1) {
    return parts.first.substring(0, 1).toUpperCase();
  }

  final first = parts.first.substring(0, 1);
  final second = parts.last.substring(0, 1);
  return '$first$second'.toUpperCase();
}
