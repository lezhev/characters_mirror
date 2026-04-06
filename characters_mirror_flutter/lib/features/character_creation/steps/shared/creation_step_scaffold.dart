import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_nav_bar.dart';
import 'package:flutter/material.dart' hide Step;

class CreationStepScaffold extends StatelessWidget {
  const CreationStepScaffold({
    required this.body,
    required this.onBack,
    required this.onStepTap,
    required this.onPressedNext,
    required this.route,
    super.key,
    this.title = 'Создание персонажа',
    this.scrollableBody = true,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  });

  final Widget body;
  final VoidCallback onBack;
  final Future<void> Function(Step target)? onStepTap;
  final VoidCallback onPressedNext;
  final String route;
  final String title;
  final bool scrollableBody;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(CreationAppBar.height),
        child: CreationAppBar(
          title: title,
          onBack: onBack,
          onStepTap: onStepTap,
        ),
      ),
      body: PageSizeLimiter(
        child: Padding(
          padding: contentPadding,
          child: scrollableBody
              ? SingleChildScrollView(child: body)
              : body,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: CreationNavBar(
            onPressedNext: onPressedNext,
            route: route,
          ),
        ),
      ),
    );
  }
}
