import 'package:characters_mirror_flutter/app/admin/admin_page.dart';
import 'package:characters_mirror_flutter/app/auth/pages/sign_in_page.dart';
import 'package:characters_mirror_flutter/app/auth/pages/sign_up_page.dart';
import 'package:characters_mirror_flutter/app/auth/src/auth_provider.dart';
import 'package:characters_mirror_flutter/app/pages/characters_list/characters_list.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/attributes_step.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/background_step/background_step.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/class_step/class_step.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/introduction.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/personal.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/race_step/race_step.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/characters',
    redirect: (context, state) {
      final location = state.matchedLocation;
      const publicRoutes = {'/sign-in', '/sign-up'};

      if (authState.isChecking) {
        return null;
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
      GoRoute(path: '/sign-in', builder: (_, __) => const SignInPage()),
      GoRoute(path: '/sign-up', builder: (_, __) => const SignUpPage()),
      GoRoute(path: '/characters', builder: (_, __) => const CharactersList()),
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
