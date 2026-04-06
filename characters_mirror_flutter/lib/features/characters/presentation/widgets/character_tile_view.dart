import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/characters/presentation/widgets/character_tile/character_grid.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CharacterTileView extends StatelessWidget {
  const CharacterTileView({
    required this.characters,
    required this.onCharacterTap,
    required this.onDeleteIntent,
    required this.onDeleteMenuDismissed,
    required this.onDeleteConfirm,
    required this.armedDeleteCharacterId,
    required this.deletingCharacterId,
    required this.onCreateCharacter,
    super.key,
  });

  final List<CharacterData> characters;
  final ValueChanged<int> onCharacterTap;
  final ValueChanged<int> onDeleteIntent;
  final VoidCallback onDeleteMenuDismissed;
  final ValueChanged<int> onDeleteConfirm;
  final int? armedDeleteCharacterId;
  final int? deletingCharacterId;
  final VoidCallback onCreateCharacter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(16),
        CharacterGrid(
          characters: characters,
          armedDeleteCharacterId: armedDeleteCharacterId,
          deletingCharacterId: deletingCharacterId,
          onCreateCharacter: onCreateCharacter,
          onCharacterTap: onCharacterTap,
          onDeleteIntent: onDeleteIntent,
          onDeleteMenuDismissed: onDeleteMenuDismissed,
          onDeleteConfirm: onDeleteConfirm,
        ),
      ],
    );
  }
}
