import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RaceTileView extends ConsumerWidget {
  const RaceTileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();

    // state.when(
    //   data: (races) => GridView.builder(
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       mainAxisSpacing: 16,
    //       crossAxisSpacing: 16,
    //       crossAxisCount: races.length < 3 ? races.length : 3,
    //       mainAxisExtent: 96,
    //     ),
    //     itemCount: races.length,
    //     itemBuilder: (context, index) {
    //       final race = races[index];
    //       return RaceTile(race: race);
    //     },
    //   ),
    //   loading: () => const Center(child: CircularProgressIndicator()),
    //   error: (err, _) => Center(child: Text('Ошибка: $err')),
    // );
  }
}

class RaceTile extends StatelessWidget {
  final RaceData race;

  const RaceTile({super.key, required this.race});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        splashColor: colorScheme.surfaceContainerHighest
          ..withValues(alpha: 0.92),
        highlightColor: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: colorScheme.inversePrimary..withValues(alpha: 0.1),
                blurRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: colorScheme.outline,
              width: 1,
            ),
          ),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage('images/races/${race.imageURL}.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
