import 'package:flutter/material.dart';

class SpellSlotRecoveryDialog extends StatefulWidget {
  const SpellSlotRecoveryDialog(
      {required this.title,
      required this.options,
      this.budget,
      this.single = false,
      super.key});
  final String title;
  final Map<int, int> options;
  final int? budget;
  final bool single;
  @override
  State<SpellSlotRecoveryDialog> createState() =>
      _SpellSlotRecoveryDialogState();
}

class _SpellSlotRecoveryDialogState extends State<SpellSlotRecoveryDialog> {
  final _selected = <int, int>{};
  int get _count => _selected.values.fold(0, (sum, count) => sum + count);
  int get _cost =>
      _selected.entries.fold(0, (sum, entry) => sum + entry.key * entry.value);
  bool _canIncrease(int level) =>
      (_selected[level] ?? 0) < widget.options[level]! &&
      (widget.single ? _count < 1 : _cost + level <= (widget.budget ?? 0));
  void _adjust(int level, int delta) => setState(() {
        final next = (_selected[level] ?? 0) + delta;
        if (next == 0) {
          _selected.remove(level);
        } else {
          _selected[level] = next;
        }
      });

  @override
  Widget build(BuildContext context) {
    final levels = widget.options.keys.toList()..sort();
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
          width: 360,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Выбрано: ${widget.single ? _count : _cost} / ${widget.single ? 1 : widget.budget}'),
                const SizedBox(height: 12),
                Flexible(
                    child: SingleChildScrollView(
                        child: Column(children: [
                  for (final level in levels)
                    Row(children: [
                      Expanded(
                          child: Text(
                              '$level-й уровень (потрачено: ${widget.options[level]})')),
                      IconButton(
                          key: ValueKey('recovery-decrease-$level'),
                          onPressed: (_selected[level] ?? 0) > 0
                              ? () => _adjust(level, -1)
                              : null,
                          icon: const Icon(Icons.remove)),
                      Text('${_selected[level] ?? 0}'),
                      IconButton(
                          key: ValueKey('recovery-increase-$level'),
                          onPressed: _canIncrease(level)
                              ? () => _adjust(level, 1)
                              : null,
                          icon: const Icon(Icons.add)),
                    ]),
                ]))),
              ])),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена')),
        FilledButton(
            key: const ValueKey('confirm-spell-slot-recovery'),
            onPressed: _count > 0
                ? () => Navigator.pop(context, Map<int, int>.from(_selected))
                : null,
            child: const Text('Восстановить')),
      ],
    );
  }
}
