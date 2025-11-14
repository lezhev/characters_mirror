import 'dart:async';
import 'dart:io';

import 'package:characters_mirror_flutter/app/auth/src/auth_provider.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (!_validateFields(email, password)) return;

    setState(() => isLoading = true);

    try {
      final success =
          await ref.read(authProvider.notifier).signIn(email, password);

      if (!mounted) return;
      _handleSignInResult(success);
    } catch (error, stackTrace) {
      debugPrint('Sign in error: $error');
      debugPrint('Stack trace: $stackTrace');

      if (!mounted) return;
      _handleSignInError(error);
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  bool _validateFields(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Заполните все поля');
      return false;
    }

    if (!EmailValidator.validate(email)) {
      _showSnackBar('Введите корректный email');
      return false;
    }

    return true;
  }

  void _handleSignInResult(bool success) {
    if (success) {
      context.go('/characters');
    } else {
      _showSnackBar('Неверные email или пароль');
    }
  }

  void _handleSignInError(dynamic error) {
    final errorMessage = _getServerpodErrorMessage(error);
    _showSnackBar(errorMessage);
  }

  String _getServerpodErrorMessage(dynamic error) {
    // Serverpod обычно выбрасывает стандартные исключения
    // или возвращает специфичные коды ошибок

    if (error is SocketException || error is TimeoutException) {
      return 'Проверьте подключение к интернету';
    } else if (error is FormatException) {
      return 'Ошибка формата данных';
    } else if (error is PlatformException) {
      return 'Ошибка платформы: ${error.message}';
    } else if (error is HttpException) {
      return 'Ошибка сети: ${error.message}';
    }

    // Общая обработка ошибок Serverpod
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('network') || errorString.contains('connection')) {
      return 'Ошибка подключения к серверу';
    } else if (errorString.contains('timeout')) {
      return 'Превышено время ожидания ответа от сервера';
    } else if (errorString.contains('invalid credentials') ||
        errorString.contains('wrong password') ||
        errorString.contains('user not found')) {
      return 'Неверные email или пароль';
    } else if (errorString.contains('email not verified')) {
      return 'Email не подтвержден. Проверьте вашу почту';
    } else if (errorString.contains('too many attempts')) {
      return 'Слишком много попыток. Попробуйте позже';
    } else if (errorString.contains('account locked') ||
        errorString.contains('suspended')) {
      return 'Аккаунт временно заблокирован';
    }

    return 'Произошла ошибка при входе';
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _getSnackBarColor(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Color _getSnackBarColor(String message) {
    final lowerMessage = message.toLowerCase();
    if (lowerMessage.contains('ошибка') ||
        lowerMessage.contains('неверный') ||
        lowerMessage.contains('заблокирован')) {
      return Colors.red;
    } else if (lowerMessage.contains('проверьте') ||
        lowerMessage.contains('подключение')) {
      return Colors.orange;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageSizeLimiter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email')),
                TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Пароль'),
                    obscureText: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : _signIn,
                  child: const Text('Войти'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
