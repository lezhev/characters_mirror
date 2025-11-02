import 'package:characters_mirror_flutter/auth/src/auth_provider.dart';
import 'package:flutter/material.dart';
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
    setState(() => isLoading = true);
    final success = await ref
        .read(authProvider.notifier)
        .signIn(emailController.text, passwordController.text);
    setState(() => isLoading = false);

    if (success && mounted) {
      context.go('/characters');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Неверные данные')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Войти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
