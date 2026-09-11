part of '../character_personal_editor.dart';

class _AlignmentPickerDialog extends StatelessWidget {
  const _AlignmentPickerDialog({
    required this.selectedAlignment,
  });

  static const _gridValues = [
    CharacterAlignment.lawfulGood,
    CharacterAlignment.neutralGood,
    CharacterAlignment.chaoticGood,
    CharacterAlignment.lawfulNeutral,
    CharacterAlignment.trueNeutral,
    CharacterAlignment.chaoticNeutral,
    CharacterAlignment.lawfulEvil,
    CharacterAlignment.neutralEvil,
    CharacterAlignment.chaoticEvil,
  ];

  final CharacterAlignment? selectedAlignment;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(24, 16, 12, 0),
      title: Row(
        children: [
          const Expanded(child: Text('Мировоззрение')),
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
              final isNarrow = constraints.maxWidth < 360;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: isNarrow ? 1.25 : 1.55,
                    children: [
                      for (final value in _gridValues)
                        _AlignmentChoiceTile(
                          value: value,
                          selected: selectedAlignment == value,
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _AlignmentChoiceTile(
                    value: CharacterAlignment.unaligned,
                    selected: selectedAlignment == CharacterAlignment.unaligned,
                    wide: true,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AlignmentChoiceTile extends StatelessWidget {
  const _AlignmentChoiceTile({
    required this.value,
    required this.selected,
    this.wide = false,
  });

  final CharacterAlignment value;
  final bool selected;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final label = characterAlignmentLabel(value);
    final borderRadius = BorderRadius.circular(8);
    final colors = _alignmentColors(context, value);
    final backgroundColor = selected
        ? colors.background
        : Color.alphaBlend(
            colors.background.withValues(alpha: 0.22),
            colorScheme.surfaceContainerHighest,
          );
    final foregroundColor =
        selected ? colors.foreground : colorScheme.onSurface;

    return Tooltip(
      message: label,
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        child: Card(
          margin: EdgeInsets.zero,
          color: backgroundColor,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(
              color: selected ? colors.border : colorScheme.outline,
              width: selected ? 2 : 1,
            ),
          ),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(value),
            child: Stack(
              children: [
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    curve: Curves.easeOut,
                    decoration: BoxDecoration(
                      gradient: selected
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                colors.background,
                                Color.alphaBlend(
                                  colorScheme.surfaceTint
                                      .withValues(alpha: 0.16),
                                  colors.background,
                                ),
                              ],
                            )
                          : null,
                    ),
                  ),
                ),
                if (selected)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 18,
                      color: foregroundColor,
                    ),
                  ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: wide ? 12 : 6,
                      vertical: wide ? 10 : 6,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final compactLabelStyle = constraints.maxWidth < 96
                            ? Theme.of(context).textTheme.labelSmall
                            : Theme.of(context).textTheme.labelMedium;

                        return Text(
                          label,
                          maxLines: wide ? 1 : 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: compactLabelStyle?.copyWith(
                            color: foregroundColor,
                            height: 1.1,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_AlignmentTileColors _alignmentColors(
  BuildContext context,
  CharacterAlignment value,
) {
  final colorScheme = Theme.of(context).colorScheme;

  return switch (value) {
    CharacterAlignment.lawfulGood ||
    CharacterAlignment.neutralGood ||
    CharacterAlignment.chaoticGood =>
      _AlignmentTileColors(
        background: colorScheme.primaryContainer,
        foreground: colorScheme.onPrimaryContainer,
        border: colorScheme.primary,
      ),
    CharacterAlignment.lawfulNeutral ||
    CharacterAlignment.trueNeutral ||
    CharacterAlignment.chaoticNeutral =>
      _AlignmentTileColors(
        background: colorScheme.secondaryContainer,
        foreground: colorScheme.onSecondaryContainer,
        border: colorScheme.secondary,
      ),
    CharacterAlignment.lawfulEvil ||
    CharacterAlignment.neutralEvil ||
    CharacterAlignment.chaoticEvil =>
      _AlignmentTileColors(
        background: colorScheme.tertiaryContainer,
        foreground: colorScheme.onTertiaryContainer,
        border: colorScheme.tertiary,
      ),
    CharacterAlignment.unaligned => _AlignmentTileColors(
        background: colorScheme.surfaceContainerHighest,
        foreground: colorScheme.onSurface,
        border: colorScheme.outlineVariant,
      ),
  };
}

class _AlignmentTileColors {
  const _AlignmentTileColors({
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Color border;
}
