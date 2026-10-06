import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';
import '../application/level_experience.dart';

class LevelExperienceSheet extends StatelessWidget {
  const LevelExperienceSheet(
      {super.key,
      required this.character,
      required this.onLevelUp,
      this.onLevelDown});
  final CharacterData character;
  final VoidCallback onLevelUp;
  final VoidCallback? onLevelDown;
  @override
  Widget build(BuildContext context) {
    final xp = LevelExperience(character);
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('${xp.level} уровень',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(xp.next == null
                      ? '${xp.experience} опыта'
                      : '${xp.experience} / ${xp.next} опыта'),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: xp.progress),
                  const SizedBox(height: 8),
                  Text(xp.next == null
                      ? 'Максимальный уровень'
                      : 'До следующего уровня: ${xp.remaining} опыта'),
                  const SizedBox(height: 16),
                  FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        foregroundColor: Theme.of(context).colorScheme.onError,
                      ),
                      onPressed: _canLevelDown ? onLevelDown : null,
                      child: const Text('Понизить уровень')),
                  const SizedBox(height: 8),
                  FilledButton(
                      onPressed: xp.level < 20 ? onLevelUp : null,
                      child: const Text('Повысить уровень')),
                ])));
  }

  bool get _canLevelDown =>
      character.classEntries?.any((entry) => (entry.level ?? 0) > 1) ?? false;
}
