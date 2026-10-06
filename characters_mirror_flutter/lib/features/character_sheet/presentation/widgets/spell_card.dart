import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';
import 'spell_details_dialog.dart';

class SpellCard extends StatelessWidget {
  const SpellCard({
    super.key,
    required this.spell,
    this.trailing,
    this.selectionMode = false,
    this.selected = false,
    this.onSelectionChanged,
  });

  final SpellData spell;
  final Widget? trailing;
  final bool selectionMode;
  final bool selected;
  final ValueChanged<bool>? onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: selectionMode
            ? (onSelectionChanged == null
                ? null
                : () => onSelectionChanged!(!selected))
            : () => showSpellDetailsDialog(context, spell),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 8, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (selectionMode) ...[
                Checkbox(
                    value: selected,
                    onChanged: onSelectionChanged == null
                        ? null
                        : (value) => onSelectionChanged!(value!)),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(spellName(spell), style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    SpellPrimaryMetadata(spell: spell),
                  ],
                ),
              ),
              if (selectionMode || trailing != null) ...[
                const SizedBox(width: 12),
                if (selectionMode)
                  IconButton(
                    tooltip: 'Информация о заклинании',
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => showSpellDetailsDialog(context, spell),
                  )
                else
                  trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
