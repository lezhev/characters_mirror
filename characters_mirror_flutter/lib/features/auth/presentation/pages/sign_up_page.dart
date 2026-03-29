import 'package:characters_mirror_flutter/features/auth/application/auth_provider.dart';
import 'package:characters_mirror_flutter/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _showValidation = false;
  String? _feedbackMessage;
  bool _isError = false;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() => _showValidation = true);

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _feedbackMessage = null;
    });

    final result = await ref.read(authProvider.notifier).register(
          _userNameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text,
        );

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
      _feedbackMessage = result.message;
      _isError = !result.success;
    });

    if (result.success) {
      context.go('/characters');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Новый аккаунт без лишних ритуалов',
      subtitle:
          'Создайте профиль, сразу попадите в приложение и продолжайте работу с персонажами без ручной активации почты.',
      child: AuthCard(
        title: 'Регистрация',
        description:
            'Укажите имя, email и пароль. После успешного создания аккаунта мы авторизуем вас автоматически.',
        footer: Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: _isLoading ? null : () => context.go('/sign-in'),
            child: const Text('Уже есть аккаунт? Войти'),
          ),
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: _showValidation
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_feedbackMessage != null) ...[
                AuthInlineMessage(
                  message: _feedbackMessage!,
                  isError: _isError,
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _userNameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Имя пользователя',
                  hintText: 'Melifaro',
                ),
                validator: (value) {
                  if ((value ?? '').trim().isEmpty) {
                    return 'Введите имя пользователя.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'wizard@toril.dev',
                ),
                validator: (value) {
                  final email = value?.trim() ?? '';
                  if (email.isEmpty) {
                    return 'Введите email.';
                  }
                  if (!EmailValidator.validate(email)) {
                    return 'Введите корректный email.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Пароль',
                  hintText: 'Не менее 8 символов',
                ),
                validator: (value) {
                  final password = value ?? '';
                  if (password.isEmpty) {
                    return 'Введите пароль.';
                  }
                  if (password.length < 8) {
                    return 'Пароль должен быть не короче 8 символов.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
                decoration: const InputDecoration(
                  labelText: 'Подтвердите пароль',
                  hintText: 'Повторите пароль',
                ),
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Повторите пароль.';
                  }
                  if (value != _passwordController.text) {
                    return 'Пароли не совпадают.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Создать аккаунт'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
