import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

class AppAuthEndpoint extends Endpoint {
  Future<AuthActionResult> register(
    Session session,
    String userName,
    String email,
    String password,
  ) async {
    final normalizedUserName = userName.trim();
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedPassword = password.trim();

    if (normalizedUserName.isEmpty) {
      return _result(
        code: 'invalid_user_name',
        message: 'Укажите имя пользователя.',
      );
    }

    if (!_emailPattern.hasMatch(normalizedEmail)) {
      return _result(
        code: 'invalid_email',
        message: 'Введите корректный email.',
      );
    }

    final minPasswordLength = auth.AuthConfig.current.minPasswordLength;
    final maxPasswordLength = auth.AuthConfig.current.maxPasswordLength;
    if (normalizedPassword.length < minPasswordLength ||
        normalizedPassword.length > maxPasswordLength) {
      return _result(
        code: 'weak_password',
        message: 'Пароль должен содержать от $minPasswordLength до '
            '$maxPasswordLength символов.',
      );
    }

    final existingUser =
        await auth.Users.findUserByEmail(session, normalizedEmail);
    if (existingUser != null) {
      return _result(
        code: 'email_taken',
        message: 'Пользователь с таким email уже существует.',
      );
    }

    try {
      final user = await auth.Emails.createUser(
        session,
        normalizedUserName,
        normalizedEmail,
        normalizedPassword,
      );

      if (user == null) {
        session.log(
          'AppAuth register failed: createUser returned null for '
          '$normalizedEmail',
          level: LogLevel.error,
        );
        return _result(
          code: 'server_error',
          message: 'Не удалось создать аккаунт. Попробуйте позже.',
        );
      }

      return _result(
        success: true,
        code: 'ok',
        message: 'Аккаунт успешно создан.',
      );
    } catch (error) {
      session.log(
        'AppAuth register exception for $normalizedEmail: $error',
        level: LogLevel.error,
      );
      return _result(
        code: 'server_error',
        message: 'Не удалось создать аккаунт. Попробуйте позже.',
      );
    }
  }
}

final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

AuthActionResult _result({
  bool success = false,
  required String code,
  required String message,
}) {
  return AuthActionResult(
    success: success,
    code: code,
    message: message,
  );
}
