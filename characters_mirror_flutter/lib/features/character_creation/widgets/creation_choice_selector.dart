import 'package:characters_mirror_flutter/core/ui/widgets/expandable_section.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/smooth_switcher.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreationChoiceSelectorItem {
  const CreationChoiceSelectorItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.isSelected = false,
    this.isEnabled = true,
    this.count = 0,
    this.onTap,
    this.onInfoTap,
    this.onIncrement,
    this.onDecrement,
  });

  final String id;
  final String title;
  final String? subtitle;
  final bool isSelected;
  final bool isEnabled;
  final int count;
  final VoidCallback? onTap;
  final VoidCallback? onInfoTap;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
}

enum _CreationChoiceSelectorMode {
  single,
  multi,
  fixed,
  counter,
}

class CreationChoiceSelector extends StatefulWidget {
  const CreationChoiceSelector._({
    required this.items,
    required _CreationChoiceSelectorMode mode,
    required this.switchKey,
    super.key,
    this.title,
    this.description,
    this.selectionLimit,
    this.onClear,
    this.autoScrollOnExpand = true,
  }) : _mode = mode;

  factory CreationChoiceSelector.single({
    required String title,
    required List<CreationChoiceSelectorItem> items,
    required Object switchKey,
    Key? key,
    String? description,
    VoidCallback? onClear,
    bool autoScrollOnExpand = true,
  }) {
    return CreationChoiceSelector._(
      key: key,
      title: title,
      description: description,
      items: items,
      mode: _CreationChoiceSelectorMode.single,
      switchKey: switchKey,
      selectionLimit: 1,
      onClear: onClear,
      autoScrollOnExpand: autoScrollOnExpand,
    );
  }

  factory CreationChoiceSelector.multi({
    required String title,
    required List<CreationChoiceSelectorItem> items,
    required Object switchKey,
    required int selectionLimit,
    Key? key,
    String? description,
    VoidCallback? onClear,
    bool autoScrollOnExpand = true,
  }) {
    return CreationChoiceSelector._(
      key: key,
      title: title,
      description: description,
      items: items,
      mode: _CreationChoiceSelectorMode.multi,
      switchKey: switchKey,
      selectionLimit: selectionLimit,
      onClear: onClear,
      autoScrollOnExpand: autoScrollOnExpand,
    );
  }

  factory CreationChoiceSelector.fixed({
    required List<CreationChoiceSelectorItem> items,
    Key? key,
    Object? switchKey,
    String? title,
    String? description,
  }) {
    return CreationChoiceSelector._(
      key: key,
      title: title,
      description: description,
      items: items,
      mode: _CreationChoiceSelectorMode.fixed,
      switchKey: switchKey ?? title ?? 'fixed_choices',
    );
  }

  factory CreationChoiceSelector.counter({
    required String title,
    required List<CreationChoiceSelectorItem> items,
    required Object switchKey,
    required int selectionLimit,
    Key? key,
    String? description,
    VoidCallback? onClear,
  }) {
    return CreationChoiceSelector._(
      key: key,
      title: title,
      description: description,
      items: items,
      mode: _CreationChoiceSelectorMode.counter,
      switchKey: switchKey,
      selectionLimit: selectionLimit,
      onClear: onClear,
    );
  }

  final String? title;
  final String? description;
  final List<CreationChoiceSelectorItem> items;
  final _CreationChoiceSelectorMode _mode;
  final Object switchKey;
  final int? selectionLimit;
  final VoidCallback? onClear;
  final bool autoScrollOnExpand;

  @override
  State<CreationChoiceSelector> createState() => _CreationChoiceSelectorState();
}

class _CreationChoiceSelectorState extends State<CreationChoiceSelector> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return switch (widget._mode) {
      _CreationChoiceSelectorMode.fixed => _buildFixed(context),
      _CreationChoiceSelectorMode.counter => _buildCounter(context),
      _CreationChoiceSelectorMode.single ||
      _CreationChoiceSelectorMode.multi =>
        _buildExpandableCards(context),
    };
  }

  Widget _buildExpandableCards(BuildContext context) {
    return _SelectorSurface(
      title: widget.title,
      description: widget.description,
      onClear: widget.onClear,
      trailing: IconButton(
        onPressed: _toggleExpanded,
        icon: AnimatedRotation(
          turns: _isExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 200),
          child: const Icon(Icons.expand_more),
        ),
        tooltip: _isExpanded ? 'Скрыть варианты' : 'Показать варианты',
      ),
      onHeaderTap: _toggleExpanded,
      child: ExpandableSection(
        expand: _isExpanded,
        extraOffset: 64,
        autoScrollOnExpand: widget.autoScrollOnExpand,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SmoothSwitcher(
            switchKey: widget.switchKey,
            autoScrollOnTransition: widget.autoScrollOnExpand,
            child: Column(
              key: ValueKey<Object>(widget.switchKey),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var index = 0; index < widget.items.length; index++) ...[
                  _SelectorChoiceCard(
                    item: widget.items[index],
                    enabled: _isCardEnabled(widget.items[index]),
                  ),
                  if (index < widget.items.length - 1) const Gap(8),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFixed(BuildContext context) {
    final cards = Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final item in widget.items)
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 140),
            child: _SelectorChoiceCard(
              item: item,
              enabled: item.isEnabled && item.onTap != null,
            ),
          ),
      ],
    );

    if (widget.title == null && widget.description == null) {
      return cards;
    }

    return _SelectorSurface(
      title: widget.title,
      description: widget.description,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: cards,
      ),
    );
  }

  Widget _buildCounter(BuildContext context) {
    final totalCount = widget.items.fold<int>(
      0,
      (sum, item) => sum + item.count,
    );
    final selectionLimit = widget.selectionLimit ?? 1;

    return _SelectorSurface(
      title: widget.title,
      description: widget.description,
      onClear: widget.onClear,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            for (var index = 0; index < widget.items.length; index++) ...[
              _CounterChoiceCard(
                item: widget.items[index],
                canIncrement: totalCount < selectionLimit,
              ),
              if (index < widget.items.length - 1) const Gap(8),
            ],
          ],
        ),
      ),
    );
  }

  bool _isCardEnabled(CreationChoiceSelectorItem item) {
    if (!item.isEnabled || item.onTap == null) {
      return false;
    }

    if (widget._mode == _CreationChoiceSelectorMode.multi &&
        !item.isSelected &&
        widget.selectionLimit != null) {
      final selectedCount =
          widget.items.where((item) => item.isSelected).length;
      return selectedCount < widget.selectionLimit!;
    }

    return true;
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}

class _SelectorSurface extends StatelessWidget {
  const _SelectorSurface({
    required this.child,
    this.title,
    this.description,
    this.onClear,
    this.trailing,
    this.onHeaderTap,
  });

  final String? title;
  final String? description;
  final Widget child;
  final VoidCallback? onClear;
  final Widget? trailing;
  final VoidCallback? onHeaderTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasHeader = title != null ||
        (description ?? '').trim().isNotEmpty ||
        onClear != null ||
        trailing != null;

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
          if (hasHeader)
            InkWell(
              onTap: onHeaderTap,
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
                          if (title != null)
                            Text(title!, style: textTheme.titleMedium),
                          if ((description ?? '').trim().isNotEmpty) ...[
                            const Gap(6),
                            Text(description!, style: textTheme.bodyMedium),
                          ],
                        ],
                      ),
                    ),
                    if (onClear != null)
                      TextButton(
                        onPressed: onClear,
                        child: const Text('Сбросить'),
                      ),
                    if (trailing != null) trailing!,
                  ],
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }
}

class _SelectorChoiceCard extends StatelessWidget {
  const _SelectorChoiceCard({
    required this.item,
    required this.enabled,
  });

  final CreationChoiceSelectorItem item;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: ValueKey<String>('choice-card-${item.id}'),
        onTap: enabled ? item.onTap : null,
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
                          color: item.isEnabled
                              ? null
                              : colorScheme.onSurfaceVariant,
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
                if (item.onInfoTap != null) ...[
                  const Gap(8),
                  IconButton(
                    key: ValueKey<String>('choice-info-${item.id}'),
                    onPressed: item.onInfoTap,
                    icon: const Icon(Icons.info_outline),
                    tooltip: 'Информация',
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CounterChoiceCard extends StatelessWidget {
  const _CounterChoiceCard({
    required this.item,
    required this.canIncrement,
  });

  final CreationChoiceSelectorItem item;
  final bool canIncrement;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isSelected = item.count > 0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
          width: isSelected ? 1.5 : 1,
        ),
        color: isSelected
            ? colorScheme.primaryContainer.withValues(alpha: 0.35)
            : colorScheme.surfaceContainerLowest.withValues(alpha: 0.35),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              key: ValueKey<String>('choice-decrement-${item.id}'),
              onPressed: item.count > 0 ? item.onDecrement : null,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text('${item.count}', style: textTheme.titleSmall),
            IconButton(
              key: ValueKey<String>('choice-increment-${item.id}'),
              onPressed: canIncrement ? item.onIncrement : null,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
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
