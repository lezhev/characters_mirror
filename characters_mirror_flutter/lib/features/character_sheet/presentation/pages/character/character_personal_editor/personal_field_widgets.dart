part of '../character_personal_editor.dart';

class _ShortFieldSpec extends _PersonalFieldSpec {
  const _ShortFieldSpec({
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.textInputAction,
    required this.onSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final VoidCallback onSubmitted;
}

class _AlignmentFieldSpec extends _PersonalFieldSpec {
  const _AlignmentFieldSpec({
    required this.focusNode,
    required this.alignment,
    required this.onChanged,
  });

  final FocusNode focusNode;
  final CharacterAlignment? alignment;
  final ValueChanged<CharacterAlignment?> onChanged;
}

class _ShortTextField extends StatelessWidget {
  const _ShortTextField({
    required this.spec,
    required this.onChanged,
  });

  final _ShortFieldSpec spec;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: spec.controller,
      focusNode: spec.focusNode,
      minLines: 1,
      maxLines: 1,
      textInputAction: spec.textInputAction,
      onChanged: onChanged,
      onSubmitted: (_) => spec.onSubmitted(),
      decoration: InputDecoration(
        labelText: spec.label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class _AlignmentPickerField extends StatelessWidget {
  const _AlignmentPickerField({
    required this.spec,
  });

  final _AlignmentFieldSpec spec;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final alignment = spec.alignment;
    final label =
        alignment == null ? 'Не выбрано' : characterAlignmentLabel(alignment);
    final swatchColor = alignment == null
        ? colorScheme.outlineVariant
        : _alignmentColors(context, alignment).background;

    return Tooltip(
      message: 'Выбрать мировоззрение',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          focusNode: spec.focusNode,
          borderRadius: BorderRadius.circular(4),
          onTap: () => _openDialog(context),
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Мировоззрение',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(12, 14, 10, 14),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 32,
                  decoration: BoxDecoration(
                    color: swatchColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: alignment == null
                              ? colorScheme.onSurfaceVariant
                              : colorScheme.onSurface,
                        ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.grid_view_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openDialog(BuildContext context) async {
    spec.focusNode.requestFocus();

    final value = await showDialog<CharacterAlignment>(
      context: context,
      builder: (dialogContext) {
        return _AlignmentPickerDialog(selectedAlignment: spec.alignment);
      },
    );

    if (value != null) {
      spec.onChanged(value);
    }
  }
}
