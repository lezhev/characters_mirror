import 'package:characters_mirror_flutter/core/ui/widgets/expandable_section.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/smooth_switcher.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreationChoiceCardItem {
  const CreationChoiceCardItem({
    required this.id,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.onInfoTap,
    this.subtitle,
  });

  final String id;
  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onInfoTap;
}

class CreationChoiceCardsSwitcher extends StatefulWidget {
  const CreationChoiceCardsSwitcher({
    required this.title,
    required this.items,
    required this.switchKey,
    super.key,
    this.description,
    this.onClear,
  });

  final String title;
  final String? description;
  final List<CreationChoiceCardItem> items;
  final Object switchKey;
  final VoidCallback? onClear;

  @override
  State<CreationChoiceCardsSwitcher> createState() =>
      _CreationChoiceCardsSwitcherState();
}

class _CreationChoiceCardsSwitcherState
    extends State<CreationChoiceCardsSwitcher> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: colorScheme.surfaceDim,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _toggleExpanded,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title, style: textTheme.titleMedium),
                        if ((widget.description ?? '').trim().isNotEmpty) ...[
                          const Gap(6),
                          Text(widget.description!,
                              style: textTheme.bodyMedium),
                        ],
                      ],
                    ),
                  ),
                  if (widget.onClear != null)
                    TextButton(
                      onPressed: widget.onClear,
                      child: const Text('Сбросить'),
                    ),
                  IconButton(
                    onPressed: _toggleExpanded,
                    icon: AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(Icons.expand_more),
                    ),
                    tooltip:
                        _isExpanded ? 'Скрыть варианты' : 'Показать варианты',
                  ),
                ],
              ),
            ),
          ),
          ExpandableSection(
            expand: _isExpanded,
            extraOffset: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SmoothSwitcher(
                switchKey: widget.switchKey,
                child: Column(
                  key: ValueKey<Object>(widget.switchKey),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var index = 0;
                        index < widget.items.length;
                        index++) ...[
                      _CreationChoiceCard(item: widget.items[index]),
                      if (index < widget.items.length - 1) const Gap(8),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}

class _CreationChoiceCard extends StatelessWidget {
  const _CreationChoiceCard({
    required this.item,
  });

  final CreationChoiceCardItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: ValueKey<String>('choice-card-${item.id}'),
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: item.isSelected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: item.isSelected ? 1.5 : 1,
            ),
            color: item.isSelected
                ? colorScheme.primaryContainer.withValues(alpha: 0.35)
                : colorScheme.surfaceContainerLowest.withValues(alpha: 0.35),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: item.isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                      if ((item.subtitle ?? '').trim().isNotEmpty) ...[
                        const Gap(4),
                        Text(
                          item.subtitle!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Gap(8),
                IconButton(
                  key: ValueKey<String>('choice-info-${item.id}'),
                  onPressed: item.onInfoTap,
                  icon: const Icon(Icons.info_outline),
                  tooltip: 'Информация',
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showChoiceOptionPlaceholderDialog({
  required BuildContext context,
  required String title,
  String? description,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(
        (description ?? '').trim().isNotEmpty
            ? description!
            : 'Описание будет добавлено позже.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Закрыть'),
        ),
      ],
    ),
  );
}
