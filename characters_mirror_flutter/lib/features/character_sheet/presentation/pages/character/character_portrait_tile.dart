import 'dart:math' as math;

import 'package:characters_mirror_flutter/features/character_portrait/character_portrait.dart';
import 'package:characters_mirror_flutter/features/character_portrait/presentation/widgets/character_portrait_editor.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'package:flutter/material.dart';

class CharacterPortraitTile extends StatelessWidget {
  const CharacterPortraitTile({required this.characterId, super.key});

  final int characterId;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Изменить портрет',
      child: Tooltip(
        message: 'Изменить портрет',
        child: SheetOutlineCard(
          onTap: () => _showPortraitEditor(context, characterId),
          padding: EdgeInsets.zero,
          borderRadius: 12,
          child: CharacterPortrait(
            characterId: characterId,
            size: 112,
            borderRadius: 12,
          ),
        ),
      ),
    );
  }
}

Future<void> _showPortraitEditor(BuildContext context, int characterId) {
  final screenSize = MediaQuery.sizeOf(context);

  return showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        child: SizedBox(
          width: math.min(640, screenSize.width - 48),
          height: math.min(640, screenSize.height - 96),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CharacterPortraitEditor(
              characterId: characterId,
              onUploaded: () => Navigator.of(dialogContext).pop(),
            ),
          ),
        ),
      );
    },
  );
}
