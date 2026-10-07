import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';
import 'spell_details_dialog.dart';
import 'spell_highlight_view.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';

class SpellCard extends StatelessWidget {
  const SpellCard({
    super.key,
    required this.spell,
    this.trailing,
    this.selectionMode = false,
    this.selected = false,
    this.onSelectionChanged,
    this.presentationContext = const SpellPresentationContext(),
  });

  final SpellData spell;
  final Widget? trailing;
  final bool selectionMode;
  final bool selected;
  final ValueChanged<bool>? onSelectionChanged;
  final SpellPresentationContext presentationContext;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final presentation = const SpellPresentationResolver()
        .resolve(spell.toJson(), context: presentationContext);
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Theme.of(context).colorScheme.outline)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: selectionMode
            ? (onSelectionChanged == null
                ? null
                : () => onSelectionChanged!(!selected))
            : () => showSpellDetailsDialog(context, spell,
                presentationContext: presentationContext),
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
                    Text(presentation.identityLabel,
                        style: textTheme.bodySmall),
                    if (presentation.metadata.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      SpellPrimaryMetadata(
                          spell: spell, showHiddenLabels: true),
                    ],
                    for (final highlight
                        in presentation.collapsedHighlights) ...[
                      const SizedBox(height: 6),
                      SpellHighlightView(
                          highlight: highlight, style: textTheme.bodySmall),
                    ],
                  ],
                ),
              ),
              if (selectionMode || trailing != null) ...[
                const SizedBox(width: 12),
                if (selectionMode)
                  IconButton(
                    tooltip: 'Информация о заклинании',
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => showSpellDetailsDialog(context, spell,
                        presentationContext: presentationContext),
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
