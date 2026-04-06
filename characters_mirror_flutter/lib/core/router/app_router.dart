import 'package:characters_mirror_flutter/features/admin/admin.dart';
import 'package:characters_mirror_flutter/features/auth/auth.dart';
import 'package:characters_mirror_flutter/features/character_creation/character_creation.dart';
import 'package:characters_mirror_flutter/core/router/default_route_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/character_sheet.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/invalid_caracter_sheet_page.dart';
import 'package:characters_mirror_flutter/features/characters/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final location = state.matchedLocation;
      const publicRoutes = {'/sign-in', '/sign-up'};

      if (authState.isChecking) {
        return null;
      }

      if (location == '/') {
        return authState.isSignedOut ? '/sign-in' : '/characters';
      }

      if (authState.isSignedOut && !publicRoutes.contains(location)) {
        return '/sign-in';
      }

      if (authState.isSignedIn && publicRoutes.contains(location)) {
        return '/characters';
      }

      if (location == '/admin' && !authState.hasScope('admin')) {
        return '/characters';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => const DefaultRoutePage()),
      GoRoute(path: '/sign-in', builder: (_, __) => const SignInPage()),
      GoRoute(path: '/sign-up', builder: (_, __) => const SignUpPage()),
      GoRoute(path: '/characters', builder: (_, __) => const CharactersList()),
      GoRoute(
        path: '/characters/sheet/:id',
        builder: (_, state) {
          final rawId = state.pathParameters['id'];
          final characterId = rawId == null ? null : int.tryParse(rawId);
          if (characterId == null) {
            return const InvalidCharacterSheetPage();
          }
          return CharacterSheet(characterId: characterId);
        },
      ),
      GoRoute(path: '/admin', builder: (_, __) => const AdminPage()),
      GoRoute(path: '/create', builder: (_, __) => const IntroductionStep()),
      GoRoute(path: '/create/race', builder: (_, __) => const RaceStep()),
      GoRoute(path: '/create/classStep', builder: (_, __) => const ClassStep()),
      GoRoute(
        path: '/create/background',
        builder: (_, __) => const BackgroundStep(),
      ),
      GoRoute(
        path: '/create/attributes',
        builder: (_, __) => const AttributesStep(),
      ),
      GoRoute(
          path: '/create/personal', builder: (_, __) => const PersonalStep()),
      GoRoute(path: '/create/summary', builder: (_, __) => const SummaryStep()),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Text('Route error: ${state.error}'),
        ),
      );
    },
  );
});
