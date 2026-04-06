import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_scaffold.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/jump_to_details_button.dart';
import 'package:flutter/material.dart' hide Step;

class CreationSelectionStepScaffold extends StatelessWidget {
  const CreationSelectionStepScaffold({
    required this.selection,
    required this.onBack,
    required this.onStepTap,
    required this.onPressedNext,
    required this.route,
    super.key,
    this.details,
    this.detailsKey,
    this.showJumpButton = false,
    this.onJumpToDetails,
  });

  final Widget selection;
  final Widget? details;
  final GlobalKey? detailsKey;
  final bool showJumpButton;
  final VoidCallback? onJumpToDetails;
  final VoidCallback onBack;
  final Future<void> Function(Step target)? onStepTap;
  final VoidCallback onPressedNext;
  final String route;

  @override
  Widget build(BuildContext context) {
    return CreationStepScaffold(
      route: route,
      onBack: onBack,
      onStepTap: onStepTap,
      onPressedNext: onPressedNext,
      body: Stack(
        children: [
          Column(
            children: [
              selection,
              if (details != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 88.0),
                  child: KeyedSubtree(
                    key: detailsKey,
                    child: details!,
                  ),
                ),
            ],
          ),
          if (showJumpButton && onJumpToDetails != null)
            JumpToDetailsButton(onPressed: onJumpToDetails!),
        ],
      ),
    );
  }
}
