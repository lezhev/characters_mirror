import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/helpers/fight_page_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _physicalDamageTypes = [
  DamageType.bludgeoning,
  DamageType.piercing,
  DamageType.slashing,
];

final _otherDamageTypes = DamageType.values
    .where((type) => !_physicalDamageTypes.contains(type))
    .toList(growable: false);

Future<void> showDamageTypePickerDialog(
  BuildContext context, {
  required DamageType? selectedType,
  required ValueChanged<DamageType?> onSelected,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _DamageTypePickerDialog(
      selectedType: selectedType,
      onSelected: (value) {
        onSelected(value);
        Navigator.of(context).pop();
      },
    ),
  );
}

class _DamageTypePickerDialog extends StatelessWidget {
  const _DamageTypePickerDialog({
    required this.selectedType,
    required this.onSelected,
  });

  final DamageType? selectedType;
  final ValueChanged<DamageType?> onSelected;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(24, 16, 12, 0),
      title: Row(
        children: [
          const Expanded(child: Text('Тип урона')),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            tooltip: 'Закрыть',
          ),
        ],
      ),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final otherColumns = constraints.maxWidth < 480 ? 2 : 5;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildGrid(_physicalDamageTypes, 3),
                  const SizedBox(height: 12),
                  _buildGrid(_otherDamageTypes, otherColumns),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => onSelected(null),
                    child: const Text('Не указан'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<DamageType> types, int columns) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisExtent: 94,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: types.length,
      itemBuilder: (context, index) {
        final type = types[index];
        final colorScheme = Theme.of(context).colorScheme;
        final selected = type == selectedType;

        return Material(
          color: selected ? colorScheme.primaryContainer : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color:
                  selected ? colorScheme.primary : colorScheme.outlineVariant,
            ),
          ),
          child: InkWell(
            key: ValueKey('damage-type-${type.name}'),
            borderRadius: BorderRadius.circular(8),
            onTap: () => onSelected(type),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/damage_types/${type.name}.svg',
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    damageTypeLabel(type),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
