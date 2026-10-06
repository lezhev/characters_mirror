import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LevelUpClassHeader extends StatelessWidget {
  const LevelUpClassHeader(
      {super.key,
      required this.classData,
      required this.oldLevel,
      required this.newLevel});

  final ClassData? classData;
  final int? oldLevel;
  final int? newLevel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageName = classData?.imageURL?.trim();
    return SheetOutlineCard(
      key: const ValueKey('level-up-class-card'),
      padding: const EdgeInsets.all(10),
      borderRadius: 8,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          if (imageName != null && imageName.isNotEmpty) ...[
            Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.colorScheme.outline)),
                child: SvgPicture.asset('assets/svg/classes/$imageName.svg',
                    colorFilter: ColorFilter.mode(
                        theme.colorScheme.primary, BlendMode.srcIn),
                    excludeFromSemantics: true)),
            const SizedBox(width: 12),
          ],
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(classData?.name ?? 'Класс',
                    style: theme.textTheme.titleMedium),
                Text('$oldLevel → $newLevel',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(color: theme.colorScheme.primary)),
              ])),
        ]),
        const SizedBox(height: 8),
        OutlinedButton(
            onPressed: null,
            style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
                side: BorderSide(color: theme.colorScheme.outlineVariant)),
            child: Row(children: [
              const Icon(Icons.add, size: 18),
              const SizedBox(width: 8),
              const Expanded(
                  child: Text('Добавить уровень другого класса',
                      maxLines: 1, overflow: TextOverflow.ellipsis)),
              const Icon(Icons.chevron_right, size: 18),
            ])),
      ]),
    );
  }
}
