part of '../smooth_switcher.dart';

class _SmoothSwitcherEditDialog extends StatefulWidget {
  const _SmoothSwitcherEditDialog({
    required this.editConfig,
    this.initialTitle,
    this.initialText,
  });

  final SmoothSwitcherEditConfig editConfig;
  final String? initialTitle;
  final String? initialText;

  @override
  State<_SmoothSwitcherEditDialog> createState() =>
      _SmoothSwitcherEditDialogState();
}

class _SmoothSwitcherEditDialogState extends State<_SmoothSwitcherEditDialog> {
  late String _titleValue;
  late String _textValue;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleValue = widget.initialTitle ?? '';
    _textValue = widget.initialText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final editConfig = widget.editConfig;

    return AlertDialog(
      title: Text(editConfig.dialogTitle),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _titleValue,
                decoration: InputDecoration(
                  labelText: editConfig.titleFieldLabel,
                ),
                onChanged: (value) {
                  _titleValue = value;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _textValue,
                decoration: InputDecoration(
                  labelText: editConfig.textFieldLabel,
                ),
                minLines: editConfig.textMinLines,
                maxLines: editConfig.textMaxLines,
                onChanged: (value) {
                  _textValue = value;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        if (editConfig.onReset != null)
          TextButton(
            onPressed: _isSaving ? null : _handleReset,
            child: Text(editConfig.resetLabel),
          ),
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        FilledButton(
          onPressed: _isSaving ? null : _handleSave,
          child: const Text('Сохранить'),
        ),
      ],
    );
  }

  Future<void> _handleReset() async {
    final onReset = widget.editConfig.onReset;
    if (onReset == null) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await onReset();
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _handleSave() async {
    setState(() {
      _isSaving = true;
    });

    try {
      await widget.editConfig.onSave(
        title: _normalizedText(_titleValue),
        text: _normalizedText(_textValue),
      );
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}

class _SmoothSwitcherAbilityDialog extends StatefulWidget {
  const _SmoothSwitcherAbilityDialog({
    required this.abilityConfig,
    this.initialTitle,
    this.initialText,
  });

  final _SmoothSwitcherAbilityConfig abilityConfig;
  final String? initialTitle;
  final String? initialText;

  @override
  State<_SmoothSwitcherAbilityDialog> createState() =>
      _SmoothSwitcherAbilityDialogState();
}

class _SmoothSwitcherAbilityDialogState
    extends State<_SmoothSwitcherAbilityDialog> {
  late String _titleValue;
  late String _textValue;
  late List<FeatureTag> _selectedTags;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleValue = widget.initialTitle ?? '';
    _textValue = widget.initialText ?? '';
    _selectedTags = _normalizedFeatureTags(
          widget.abilityConfig.tags,
          preserveEmpty: true,
        ) ??
        <FeatureTag>[];
  }

  @override
  Widget build(BuildContext context) {
    final abilityConfig = widget.abilityConfig;

    return AlertDialog(
      title: Text(abilityConfig.dialogTitle),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _titleValue,
                decoration: InputDecoration(
                  labelText: abilityConfig.titleFieldLabel,
                ),
                onChanged: (value) {
                  _titleValue = value;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _textValue,
                decoration: InputDecoration(
                  labelText: abilityConfig.textFieldLabel,
                ),
                minLines: abilityConfig.textMinLines,
                maxLines: abilityConfig.textMaxLines,
                onChanged: (value) {
                  _textValue = value;
                },
              ),
              const SizedBox(height: 16),
              Text(
                abilityConfig.tagsLabel,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final tag in FeatureTag.values)
                    FilterChip(
                      label: Text(featureTagRuLabel(tag)),
                      selected: _selectedTags.contains(tag),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedTags = [..._selectedTags, tag];
                          } else {
                            _selectedTags = _selectedTags
                                .where((item) => item != tag)
                                .toList();
                          }
                          _selectedTags = _normalizedFeatureTags(
                                _selectedTags,
                                preserveEmpty: true,
                              ) ??
                              <FeatureTag>[];
                        });
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        if (abilityConfig.onReset != null)
          TextButton(
            onPressed: _isSaving ? null : _handleReset,
            child: Text(abilityConfig.resetLabel),
          ),
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        FilledButton(
          onPressed: _isSaving ? null : _handleSave,
          child: const Text('Сохранить'),
        ),
      ],
    );
  }

  Future<void> _handleReset() async {
    final onReset = widget.abilityConfig.onReset;
    if (onReset == null) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await onReset();
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _handleSave() async {
    setState(() {
      _isSaving = true;
    });

    try {
      await widget.abilityConfig.onSave(
        title: _normalizedText(_titleValue),
        text: _normalizedText(_textValue),
        tags: _normalizedFeatureTags(_selectedTags, preserveEmpty: true),
      );
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}
