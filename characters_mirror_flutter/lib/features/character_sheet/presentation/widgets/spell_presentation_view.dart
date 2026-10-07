import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:flutter/material.dart';
import 'spell_highlight_view.dart';

/// Shared expanded content for details and the cast selection preview.
class SpellPresentationView extends StatelessWidget {
  const SpellPresentationView({required this.presentation, super.key});
  final SpellPresentation presentation;

  @override
  Widget build(BuildContext context) {
    final p = presentation;
    final theme = Theme.of(context).textTheme;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(p.identityLabel, style: theme.bodySmall),
          if (p.metadata.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(p.metadata.join(' · ')),
          ],
          if (p.components.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('Компоненты: ${p.components.join(', ')}'),
          ],
          if (p.highlights.isNotEmpty) ...[
            const SizedBox(height: 16),
            for (final h in p.highlights)
              Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: SpellHighlightView(highlight: h)),
          ],
          if (p.description != null) ...[
            const SizedBox(height: 16),
            Text(p.description!,
                style: theme.bodyMedium?.copyWith(height: 1.5)),
          ],
          if (p.higherLevel != null) ...[
            const SizedBox(height: 16),
            Text('На высоких уровнях', style: theme.titleSmall),
            const SizedBox(height: 6),
            Text(p.higherLevel!,
                style: theme.bodyMedium?.copyWith(height: 1.5)),
          ],
          if (p.materialDescription != null ||
              p.materialCost != null ||
              p.materialConsumed) ...[
            const SizedBox(height: 16),
            Text('Материалы', style: theme.titleSmall),
            if (p.materialDescription != null) ...[
              const SizedBox(height: 6),
              Text(p.materialDescription!),
            ],
            // Storage uses the minimum currency unit: copper pieces.
            if (p.materialCost != null) Text('Стоимость: ${p.materialCost} мм'),
            if (p.materialConsumed) const Text('Компонент расходуется'),
          ],
        ]);
  }
}
