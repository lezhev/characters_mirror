import 'package:characters_mirror_flutter/app/admin/admin_page.dart';
import 'package:characters_mirror_flutter/app/pages/characters_list/characters_list.dart';
import 'package:characters_mirror_flutter/app/auth/pages/sign_in_page.dart';
import 'package:characters_mirror_flutter/app/auth/src/auth_provider.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/background_choice.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/class_step/class_step.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/creation_attributes/attributes_step.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/introduction.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/personal.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/race_step/race_step.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/summary.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
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
        GoRoute(
            path: '/characters', builder: (_, __) => const CharactersList()),
        GoRoute(path: '/admin', builder: (_, __) => const AdminPage()),

        /// Character creation flow ///
        GoRoute(
          path: '/create',
          builder: (_, __) => const IntroductionStep(),
        ),
        GoRoute(
          path: '/create/race',
          builder: (_, __) => const RaceStep(),
        ),
        GoRoute(
          path: '/create/classStep',
          builder: (_, __) => const ClassStep(),
        ),
        GoRoute(
          path: '/create/background',
          builder: (_, __) => const BackgroundStep(),
        ),
        GoRoute(
          path: '/create/attributes',
          builder: (_, __) => const AttributesStep(),
        ),
        GoRoute(
          path: '/create/personal',
          builder: (_, __) => const PersonalStep(),
        ),
        GoRoute(
          path: '/create/summary',
          builder: (_, __) => const SummaryStep(),
        ),
      ],
    );
  },
);
