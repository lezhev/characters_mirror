import 'package:characters_mirror_flutter/features/auth/auth.dart';
import 'package:characters_mirror_flutter/features/character_creation/character_creation.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_transition.dart';
import 'package:characters_mirror_flutter/core/router/default_route_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/character_sheet.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character_sheet_settings_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/invalid_caracter_sheet_page.dart';
import 'package:characters_mirror_flutter/features/characters/characters.dart';
import 'package:characters_mirror_flutter/features/settings/settings.dart';
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
      GoRoute(
        path: '/characters/sheet/:id/settings',
        builder: (_, state) {
          final rawId = state.pathParameters['id'];
          final characterId = rawId == null ? null : int.tryParse(rawId);
          if (characterId == null) {
            return const InvalidCharacterSheetPage();
          }
          return CharacterSheetSettingsPage(characterId: characterId);
        },
      ),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
      GoRoute(
        path: '/create',
        pageBuilder: (_, state) => _creationStepPage(
          state,
          const ClassStep(),
        ),
      ),
      GoRoute(
        path: '/create/race',
        pageBuilder: (_, state) => _creationStepPage(
          state,
          const RaceStep(),
        ),
      ),
      GoRoute(
        path: '/create/classStep',
        pageBuilder: (_, state) => _creationStepPage(
          state,
          const ClassStep(),
        ),
      ),
      GoRoute(
        path: '/create/background',
        pageBuilder: (_, state) => _creationStepPage(
          state,
          const BackgroundStep(),
        ),
      ),
      GoRoute(
        path: '/create/attributes',
        pageBuilder: (_, state) => _creationStepPage(
          state,
          const AttributesStep(),
        ),
      ),
      GoRoute(
        path: '/create/spells',
        pageBuilder: (_, state) => _creationStepPage(
          state,
          const SpellsStep(),
        ),
      ),
      GoRoute(
        path: '/create/personal',
        pageBuilder: (_, state) => _creationStepPage(
          state,
          const PersonalStep(),
        ),
      ),
      GoRoute(
        path: '/create/summary',
        pageBuilder: (_, state) => _creationStepPage(
          state,
          const SummaryStep(),
        ),
      ),
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

CustomTransitionPage<void> _creationStepPage(
  GoRouterState state,
  Widget child,
) {
  const duration = Duration(milliseconds: 280);
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        CreationStepTransitionScope(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    ),
  );
}
