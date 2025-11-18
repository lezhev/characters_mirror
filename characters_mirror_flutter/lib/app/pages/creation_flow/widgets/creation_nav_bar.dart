import 'package:characters_mirror_flutter/app/pages/characters_list/widgets/button.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreationNavBar extends ConsumerWidget {
  final String route;
  final VoidCallback onPressedNext;
  const CreationNavBar(
      {super.key, required this.route, required this.onPressedNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final state = ref.read(characterCreationProvider);
    final notifier = ref.read(characterCreationProvider.notifier);
    return Row(
      children: [
        SizedBox(width: width > 1000 ? (width - 1000) / 2 : 0),
        state.step == Step.introduction
            ? SizedBox.shrink()
            : Button.outlined(
                leading: Icon(Icons.arrow_back,
                    color: Theme.of(context).colorScheme.primary),
                onPressed: () => notifier.prevStep(context),
                title: 'Назад',
              ),
        Spacer(),
        route == 'character'
            ? Button.filled(
                leading: Icon(Icons.auto_awesome_outlined,
                    color: Theme.of(context).colorScheme.onPrimary),
                title: 'Завершить',
                width: 168,
                onPressed: () {},
              )
            : Button.filled(
                onPressed: onPressedNext,
                title: 'Далее',
                trailing: Icon(Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
        SizedBox(width: width > 1000 ? (width - 1000) / 2 : 0),
      ],
    );
  }
}
