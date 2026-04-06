import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/characters/presentation/widgets/character_tile/character_tile.dart';
import 'package:flutter/material.dart';

class CharacterGrid extends StatelessWidget {
  const CharacterGrid({
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
    final itemCount = characters.length + 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        maxCrossAxisExtent: 470,
        mainAxisExtent: 104,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _CreateCharacterTile(onTap: onCreateCharacter);
        }

        final character = characters[index - 1];
        final characterId = character.id;

        return CharacterTile(
          character: character,
          isDeleteArmed: armedDeleteCharacterId == characterId,
          isDeleting: deletingCharacterId == characterId,
          onTap: characterId == null ? null : () => onCharacterTap(characterId),
          onDeleteIntent:
              characterId == null ? null : () => onDeleteIntent(characterId),
          onDeleteMenuDismissed: onDeleteMenuDismissed,
          onDeleteConfirm:
              characterId == null ? null : () => onDeleteConfirm(characterId),
        );
      },
    );
  }
}

class _CreateCharacterTile extends StatelessWidget {
  const _CreateCharacterTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: CharacterTileCard(
        onTap: onTap,
        child: Center(
          child: Icon(
            Icons.add,
            size: 30,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
