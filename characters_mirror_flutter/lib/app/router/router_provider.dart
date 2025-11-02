import 'package:characters_mirror_flutter/app/pages/admin_page.dart';
import 'package:characters_mirror_flutter/app/pages/characters_list/characters_list.dart';
import 'package:characters_mirror_flutter/auth/pages/sign_in_page.dart';
import 'package:characters_mirror_flutter/auth/src/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final user = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/characters',
    redirect: (context, state) {
      if (user == null && state.matchedLocation != '/sign-in') {
        return '/sign-in';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/sign-in', builder: (_, __) => const SignInPage()),
      GoRoute(path: '/characters', builder: (_, __) => const CharactersList()),
      GoRoute(path: '/admin', builder: (_, __) => const AdminPage()),
    ],
  );
});
