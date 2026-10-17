import 'package:flutter/material.dart';
import '../../application/dm_library_controller.dart';
import 'dm_raw_json_section.dart';

class DmTechnicalSection extends StatefulWidget {
  const DmTechnicalSection({super.key, required this.detail});
  final DmCreatureDetail detail;
  @override
  State<DmTechnicalSection> createState() => _DmTechnicalSectionState();
}

class _DmTechnicalSectionState extends State<DmTechnicalSection> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) => ExpansionTile(
        key: const PageStorageKey('dm-technical'),
        title: const Text('Технические сведения'),
        shape: const Border(),
        collapsedShape: const Border(),
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        onExpansionChanged: (value) =>
            WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && value != _expanded) setState(() => _expanded = value);
        }),
        children: _expanded
            ? [
                Text(
                    'Источник: ${widget.detail.record.sourceType} · dnd5e ${widget.detail.record.sourceVersion ?? '—'}'),
                const Text(
                    'Расчёт базовых параметров D&D 2014. Эффекты, модули Foundry и произвольные формулы не исполняются.'),
                if (widget.detail.creature.hpInitial !=
                    widget.detail.creature.hpMax)
                  Text(
                      'HP в экспорте: ${widget.detail.creature.hpInitial ?? '—'}'),
                const SizedBox(height: 12),
                Text('Диагностика импорта',
                    style: Theme.of(context).textTheme.titleSmall),
                if (widget.detail.creature.diagnostics.isEmpty)
                  const Text('Предупреждений нет.'),
                for (final diagnostic in widget.detail.creature.diagnostics)
                  SelectableText(diagnostic,
                      key: PageStorageKey('diagnostic:$diagnostic')),
                DmRawJsonSection(
                    rawJson: widget.detail.record.normalizedJson,
                    title: 'Нормализованные данные'),
                DmRawJsonSection(rawJson: widget.detail.record.rawJson),
              ]
            : const [],
      );
}
