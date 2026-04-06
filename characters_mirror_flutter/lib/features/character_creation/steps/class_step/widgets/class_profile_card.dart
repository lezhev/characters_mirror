import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:flutter/material.dart';

class ClassProfileCard extends StatelessWidget {
  const ClassProfileCard({
    required this.classData,
    super.key,
  });

  final ClassData classData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labels = <String>[
      if (_hitDieLabel(classData) != null)
        'Кость хитов: ${_hitDieLabel(classData)}',
      if (classData.primaryAbilities?.isNotEmpty ?? false)
        'Ключевые характеристики: ${_joinNames(classData.primaryAbilities!)}',
      if (classData.savingThrowProficiencies?.isNotEmpty ?? false)
        'Спасброски: ${_joinNames(classData.savingThrowProficiencies!)}',
      if (classData.availableSkills?.isNotEmpty ?? false)
        'Навыки на выбор (${classData.skillCount ?? 0}): ${_joinNames(classData.availableSkills!)}',
      if (_spellcastingAbilityLabel(classData) != null)
        'Базовая характеристика заклинаний: ${_spellcastingAbilityLabel(classData)}',
    ];

    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((classData.description ?? '').isNotEmpty) ...[
            Text(
              classData.description!,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
          ],
          for (final label in labels)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(label, style: theme.textTheme.bodyMedium),
            ),
        ],
      ),
    );
  }
}

String _joinNames(List<dynamic> values) =>
    values.map((value) => _formatName(_enumToken(value))).join(', ');

String? _hitDieLabel(ClassData classData) {
  if (classData.hitDieValue != null) {
    return 'd${classData.hitDieValue}';
  }
  return null;
}

String? _spellcastingAbilityLabel(ClassData classData) {
  if (classData.spellcastingAbilityValue != null) {
    return _formatName(_enumToken(classData.spellcastingAbilityValue));
  }
  return null;
}

String _enumToken(Object? value) {
  if (value == null) {
    return 'unknown';
  }
  final raw = value.toString();
  if (raw.trim().isEmpty) {
    return 'unknown';
  }
  final parts = raw.split('.');
  return parts.isEmpty ? raw : parts.last;
}

String _formatName(String value) {
  final normalized = value.replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'),
    (match) => '${match.group(1)} ${match.group(2)}',
  );
  return normalized.isEmpty
      ? normalized
      : normalized[0].toUpperCase() + normalized.substring(1);
}
