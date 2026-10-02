import 'package:characters_mirror_flutter/features/auth/application/auth_provider.dart';
import 'package:characters_mirror_flutter/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _showValidation = false;
  bool _rememberMe = true;
  bool _passwordVisible = false;
  String? _feedbackMessage;
  bool _isError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

    final result = await ref.read(authProvider.notifier).signIn(
          _emailController.text.trim(),
          _passwordController.text,
          rememberMe: _rememberMe,
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
    final authState = ref.watch(authProvider);

    if (authState.isChecking) {
      return const _AuthLoadingView();
    }

    return AuthScaffold(
      title: 'Вход',
      footer: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton(
            onPressed: _isLoading ? null : _submit,
            child: _isLoading
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Войти'),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: _isLoading ? null : () => context.push('/sign-up'),
              child: const Text('Нет аккаунта? Создать'),
            ),
          ),
        ],
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
              obscureText: !_passwordVisible,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              decoration: const InputDecoration(
                labelText: 'Пароль',
                hintText: 'Введите пароль',
              ).copyWith(
                suffixIcon: IconButton(
                  tooltip:
                      _passwordVisible ? 'Скрыть пароль' : 'Показать пароль',
                  onPressed: () => setState(
                    () => _passwordVisible = !_passwordVisible,
                  ),
                  icon: Icon(
                    _passwordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                ),
              ),
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return 'Введите пароль.';
                }
                return null;
              },
            ),
            CheckboxListTile(
              value: _rememberMe,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Запомнить меня'),
              onChanged: _isLoading
                  ? null
                  : (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() => _rememberMe = value);
                    },
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthLoadingView extends StatelessWidget {
  const _AuthLoadingView();

  @override
  Widget build(BuildContext context) {
    return const AuthScaffold(
      title: 'Вход',
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
