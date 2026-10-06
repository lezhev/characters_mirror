import 'package:flutter/material.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_search_field.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_app_bar.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/spell_card.dart';

class LevelUpPickerOption {
  const LevelUpPickerOption(
      {required this.key,
      required this.name,
      this.description,
      this.enabled = true,
      this.reason,
      this.spellLevel,
      this.spell});
  final String key;
  final String name;
  final String? description;
  final bool enabled;
  final String? reason;
  final int? spellLevel;
  final SpellData? spell;
}

class LevelUpPicker extends StatefulWidget {
  const LevelUpPicker(
      {super.key,
      required this.title,
      required this.options,
      required this.maximum,
      this.minimum = 0,
      this.selected = const [],
      this.allowDuplicates = false});
  final String title;
  final List<LevelUpPickerOption> options;
  final int maximum;
  final int minimum;
  final List<String> selected;
  final bool allowDuplicates;
  @override
  State<LevelUpPicker> createState() => _LevelUpPickerState();
}

class _LevelUpPickerState extends State<LevelUpPicker> {
  late final List<String> _selected = [...widget.selected];
  String _query = '';
  int? _spellLevel;
  @override
  Widget build(BuildContext context) {
    final levels = widget.options
        .map((o) => o.spellLevel ?? o.spell?.level)
        .whereType<int>()
        .toSet()
        .toList()
      ..sort();
    final options = widget.options
        .where((o) =>
            o.name.toLowerCase().contains(_query.toLowerCase()) &&
            (_spellLevel == null ||
                (o.spellLevel ?? o.spell?.level) == _spellLevel))
        .toList();
    return Scaffold(
      appBar: PageSizeAppBar(
        title: Text(widget.title),
        maxWidth: 680,
      ),
      body: Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(12),
                    child: AppSearchField(
                        onChanged: (value) => setState(() => _query = value))),
                if (levels.length > 1)
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        ChoiceChip(
                            label: const Text('Все уровни'),
                            selected: _spellLevel == null,
                            onSelected: (_) =>
                                setState(() => _spellLevel = null)),
                        for (final level in levels)
                          Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: ChoiceChip(
                                  label: Text(level == 0
                                      ? 'Заговоры'
                                      : '$level уровень'),
                                  selected: _spellLevel == level,
                                  onSelected: (_) =>
                                      setState(() => _spellLevel = level))),
                      ])),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                        'Выбрано ${_selected.length} / ${widget.maximum}')),
                Expanded(
                    child: options.isEmpty
                        ? const Center(child: Text('Нет доступных вариантов'))
                        : ListView.builder(
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final option = options[index];
                              final count = _selected
                                  .where((key) => key == option.key)
                                  .length;
                              final enabled = option.enabled &&
                                  (count > 0 ||
                                      widget.maximum == 1 ||
                                      _selected.length < widget.maximum);
                              void toggle() => setState(() {
                                    if (count > 0) {
                                      _selected.remove(option.key);
                                    } else {
                                      if (widget.maximum == 1) {
                                        _selected.clear();
                                      }
                                      _selected.add(option.key);
                                    }
                                  });
                              if (option.spell != null) {
                                return SpellCard(
                                    spell: option.spell!,
                                    selectionMode: true,
                                    selected: count > 0,
                                    onSelectionChanged:
                                        enabled ? (_) => toggle() : null);
                              }
                              return ListTile(
                                title: Text(option.name),
                                subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (option.description?.isNotEmpty ==
                                          true)
                                        Text(option.description!),
                                      if (option.reason != null)
                                        Text(option.reason!),
                                    ]),
                                leading: Icon(count > 0
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked),
                                onTap: !enabled ? null : toggle,
                                trailing: widget.allowDuplicates
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            Text('$count'),
                                            IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: option.enabled &&
                                                        _selected.length <
                                                            widget.maximum
                                                    ? () => setState(() =>
                                                        _selected
                                                            .add(option.key))
                                                    : null),
                                          ])
                                    : null,
                              );
                            })),
              ]))),
      bottomNavigationBar: SafeArea(
        child: PageSizeLimiter(
          maxWidth: 680,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: FilledButton(
              onPressed: _selected.length >= widget.minimum &&
                      _selected.length <= widget.maximum
                  ? () => Navigator.of(context).pop(List<String>.of(_selected))
                  : null,
              child: const Text('Готово'),
            ),
          ),
        ),
      ),
    );
  }
}
