import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/helpers/sheet_autosave.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> showInitiativeSettingsSheet({
  required BuildContext context,
  required CharacterData character,
  required Future<void> Function(int bonus) onSave,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => InitiativeSettingsSheet(
      character: character,
      onSave: onSave,
    ),
  );
}

Future<void> showArmorClassSettingsSheet({
  required BuildContext context,
  required CharacterData character,
  required Future<void> Function(int bonus) onSave,
  Future<void> Function()? onUnequipArmor,
  Future<void> Function()? onUnequipShield,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => ArmorClassSettingsSheet(
      character: character,
      onSave: onSave,
      onUnequipArmor: onUnequipArmor,
      onUnequipShield: onUnequipShield,
    ),
  );
}

Future<void> showMovementSpeedSettingsSheet({
  required BuildContext context,
  required CharacterData character,
  required Future<void> Function(MovementSpeedsDraft draft) onSave,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => MovementSpeedSettingsSheet(
      character: character,
      onSave: onSave,
    ),
  );
}

class InitiativeSettingsSheet extends StatefulWidget {
  const InitiativeSettingsSheet({
    required this.character,
    required this.onSave,
    super.key,
  });

  final CharacterData character;
  final Future<void> Function(int bonus) onSave;

  @override
  State<InitiativeSettingsSheet> createState() =>
      _InitiativeSettingsSheetState();
}

class _InitiativeSettingsSheetState extends State<InitiativeSettingsSheet> {
  late final TextEditingController _controller;
  late final DebouncedAutosave<int> _autosave;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final bonus = widget.character.customInitiativeBonus ?? 0;
    _controller = TextEditingController(text: '$bonus');
    _autosave = DebouncedAutosave<int>(
      delay: characterSheetAutosaveDelay,
      lastSaved: bonus,
      equals: (left, right) => left == right,
      save: widget.onSave,
      onSavingChanged: (value) => setState(() => _isSaving = value),
      onError: (error, stackTrace) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(humanReadableError(error))),
          );
        }
      },
    );
    _controller.addListener(_scheduleSave);
  }

  @override
  void dispose() {
    _controller.removeListener(_scheduleSave);
    _autosave.dispose(flushPending: true);
    _controller.dispose();
    super.dispose();
  }

  void _scheduleSave() {
    final value = _parseSignedInt(_controller.text);
    if (value == null) return;
    _autosave.schedule(value);
  }

  @override
  Widget build(BuildContext context) {
    final base = (widget.character.derived?.initiative ?? 0) -
        (widget.character.customInitiativeBonus ?? 0);
    return _SettingsSheetScaffold(
      title: 'Инициатива',
      isSaving: _isSaving,
      children: [
        _SignedNumberField(
          fieldKey: const ValueKey('initiative-bonus-field'),
          controller: _controller,
          label: 'Пользовательский бонус',
        ),
        const SizedBox(height: 12),
        Text('База: ${_signedLabel(base)}'),
        const SizedBox(height: 16),
        const Text(
          'Быстрый бросок инициативы: удерживайте карточку инициативы на листе персонажа.',
        ),
      ],
    );
  }
}

class ArmorClassSettingsSheet extends StatefulWidget {
  const ArmorClassSettingsSheet({
    required this.character,
    required this.onSave,
    this.onUnequipArmor,
    this.onUnequipShield,
    super.key,
  });

  final CharacterData character;
  final Future<void> Function(int bonus) onSave;
  final Future<void> Function()? onUnequipArmor;
  final Future<void> Function()? onUnequipShield;

  @override
  State<ArmorClassSettingsSheet> createState() =>
      _ArmorClassSettingsSheetState();
}

class _ArmorClassSettingsSheetState extends State<ArmorClassSettingsSheet> {
  late final TextEditingController _controller;
  late final DebouncedAutosave<int> _autosave;
  bool _isSaving = false;
  CharacterEquipmentSelectionData? _equippedArmor;
  CharacterEquipmentSelectionData? _equippedShield;

  @override
  void initState() {
    super.initState();
    final bonus = widget.character.customArmorClassBonus ?? 0;
    _equippedArmor = widget.character.equippedArmor;
    _equippedShield = widget.character.equippedShield;
    _controller = TextEditingController(text: '$bonus');
    _autosave = DebouncedAutosave<int>(
      delay: characterSheetAutosaveDelay,
      lastSaved: bonus,
      equals: (left, right) => left == right,
      save: widget.onSave,
      onSavingChanged: (value) => setState(() => _isSaving = value),
      onError: (error, stackTrace) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(humanReadableError(error))),
          );
        }
      },
    );
    _controller.addListener(_scheduleSave);
  }

  @override
  void didUpdateWidget(ArmorClassSettingsSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.character.equippedArmor != widget.character.equippedArmor) {
      _equippedArmor = widget.character.equippedArmor;
    }
    if (oldWidget.character.equippedShield != widget.character.equippedShield) {
      _equippedShield = widget.character.equippedShield;
    }
  }

  Future<void> _removeArmor() async {
    try {
      await widget.onUnequipArmor?.call();
      if (mounted) setState(() => _equippedArmor = null);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(humanReadableError(error))),
        );
      }
    }
  }

  Future<void> _removeShield() async {
    try {
      await widget.onUnequipShield?.call();
      if (mounted) setState(() => _equippedShield = null);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(humanReadableError(error))),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_scheduleSave);
    _autosave.dispose(flushPending: true);
    _controller.dispose();
    super.dispose();
  }

  void _scheduleSave() {
    final value = _parseSignedInt(_controller.text);
    if (value == null) return;
    _autosave.schedule(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentBonus = _parseSignedInt(_controller.text) ??
        widget.character.customArmorClassBonus ??
        0;
    final base = (widget.character.derived?.armorClass ?? 10) -
        (widget.character.customArmorClassBonus ?? 0);
    return _SettingsSheetScaffold(
      title: 'Класс доспеха',
      isSaving: _isSaving,
      children: [
        _SignedNumberField(
          fieldKey: const ValueKey('armor-class-bonus-field'),
          controller: _controller,
          label: 'Бонус к КД',
        ),
        const SizedBox(height: 12),
        Text('Итоговая КД: ${base + currentBonus}'),
        if (_equippedArmor != null || _equippedShield != null) ...[
          const SizedBox(height: 20),
          const Text('Экипировано'),
          if (_equippedArmor case final armor?)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(armor.name),
              subtitle: const Text('Доспех'),
              trailing: IconButton(
                tooltip: 'Снять доспех',
                onPressed: widget.onUnequipArmor == null ? null : _removeArmor,
                icon: const Icon(Icons.remove_circle_outline),
              ),
            ),
          if (_equippedShield case final shield?)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(shield.name),
              subtitle: const Text('Щит'),
              trailing: IconButton(
                tooltip: 'Снять щит',
                onPressed:
                    widget.onUnequipShield == null ? null : _removeShield,
                icon: const Icon(Icons.remove_circle_outline),
              ),
            ),
        ],
      ],
    );
  }
}

class MovementSpeedSettingsSheet extends StatefulWidget {
  const MovementSpeedSettingsSheet({
    required this.character,
    required this.onSave,
    super.key,
  });

  final CharacterData character;
  final Future<void> Function(MovementSpeedsDraft draft) onSave;

  @override
  State<MovementSpeedSettingsSheet> createState() =>
      _MovementSpeedSettingsSheetState();
}

class _MovementSpeedSettingsSheetState
    extends State<MovementSpeedSettingsSheet> {
  late final TextEditingController _walkingController;
  late final TextEditingController _swimmingController;
  late final TextEditingController _climbingController;
  late final TextEditingController _flyingController;
  late final DebouncedAutosave<MovementSpeedsDraft> _autosave;
  late CharacterSpeedKind _displayedSpeedKind;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final speeds = effectiveMovementSpeeds(widget.character);
    _displayedSpeedKind =
        widget.character.displayedSpeedKind ?? CharacterSpeedKind.walking;
    _walkingController =
        TextEditingController(text: '${speeds[CharacterSpeedKind.walking]}');
    _swimmingController =
        TextEditingController(text: '${speeds[CharacterSpeedKind.swimming]}');
    _climbingController =
        TextEditingController(text: '${speeds[CharacterSpeedKind.climbing]}');
    _flyingController =
        TextEditingController(text: '${speeds[CharacterSpeedKind.flying]}');
    _autosave = DebouncedAutosave<MovementSpeedsDraft>(
      delay: characterSheetAutosaveDelay,
      lastSaved: _draft,
      equals: (left, right) => left == right,
      save: widget.onSave,
      onSavingChanged: (value) => setState(() => _isSaving = value),
      onError: (error, stackTrace) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(humanReadableError(error))),
          );
        }
      },
    );
    for (final controller in _controllers) {
      controller.addListener(_scheduleSave);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.removeListener(_scheduleSave);
    }
    _autosave.dispose(flushPending: true);
    _walkingController.dispose();
    _swimmingController.dispose();
    _climbingController.dispose();
    _flyingController.dispose();
    super.dispose();
  }

  Iterable<TextEditingController> get _controllers => [
        _walkingController,
        _swimmingController,
        _climbingController,
        _flyingController,
      ];

  MovementSpeedsDraft get _draft {
    return MovementSpeedsDraft(
      walkingSpeed: _parseUnsignedInt(_walkingController.text) ?? 0,
      swimmingSpeed: _parseUnsignedInt(_swimmingController.text) ?? 0,
      climbingSpeed: _parseUnsignedInt(_climbingController.text) ?? 0,
      flyingSpeed: _parseUnsignedInt(_flyingController.text) ?? 0,
      displayedSpeedKind: _displayedSpeedKind,
    );
  }

  void _scheduleSave() {
    _autosave.schedule(_draft);
    setState(() {});
  }

  void _selectDisplayedSpeed(CharacterSpeedKind? value) {
    if (value == null) return;
    setState(() {
      _displayedSpeedKind = value;
    });
    _scheduleSave();
  }

  @override
  Widget build(BuildContext context) {
    return _SettingsSheetScaffold(
      title: 'Скорость',
      isSaving: _isSaving,
      children: [
        RadioGroup<CharacterSpeedKind>(
          groupValue: _displayedSpeedKind,
          onChanged: _selectDisplayedSpeed,
          child: Column(
            children: [
              _SpeedField(
                fieldKey: const ValueKey('walking-speed-field'),
                controller: _walkingController,
                label: 'Ходьба',
                kind: CharacterSpeedKind.walking,
              ),
              _SpeedField(
                fieldKey: const ValueKey('swimming-speed-field'),
                controller: _swimmingController,
                label: 'Плаванье',
                kind: CharacterSpeedKind.swimming,
              ),
              _SpeedField(
                fieldKey: const ValueKey('climbing-speed-field'),
                controller: _climbingController,
                label: 'Лазанье',
                kind: CharacterSpeedKind.climbing,
              ),
              _SpeedField(
                fieldKey: const ValueKey('flying-speed-field'),
                controller: _flyingController,
                label: 'Полёт',
                kind: CharacterSpeedKind.flying,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MovementSpeedsDraft {
  const MovementSpeedsDraft({
    required this.walkingSpeed,
    required this.swimmingSpeed,
    required this.climbingSpeed,
    required this.flyingSpeed,
    required this.displayedSpeedKind,
  });

  final int walkingSpeed;
  final int swimmingSpeed;
  final int climbingSpeed;
  final int flyingSpeed;
  final CharacterSpeedKind displayedSpeedKind;

  @override
  bool operator ==(Object other) {
    return other is MovementSpeedsDraft &&
        walkingSpeed == other.walkingSpeed &&
        swimmingSpeed == other.swimmingSpeed &&
        climbingSpeed == other.climbingSpeed &&
        flyingSpeed == other.flyingSpeed &&
        displayedSpeedKind == other.displayedSpeedKind;
  }

  @override
  int get hashCode => Object.hash(
        walkingSpeed,
        swimmingSpeed,
        climbingSpeed,
        flyingSpeed,
        displayedSpeedKind,
      );
}

class _SettingsSheetScaffold extends StatelessWidget {
  const _SettingsSheetScaffold({
    required this.title,
    required this.children,
    required this.isSaving,
  });

  final String title;
  final List<Widget> children;
  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: 16 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  if (isSaving)
                    const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class _SignedNumberField extends StatelessWidget {
  const _SignedNumberField({
    required this.controller,
    required this.label,
    required this.fieldKey,
  });

  final TextEditingController controller;
  final String label;
  final Key fieldKey;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: fieldKey,
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(signed: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
      ],
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class _SpeedField extends StatelessWidget {
  const _SpeedField({
    required this.controller,
    required this.label,
    required this.fieldKey,
    required this.kind,
  });

  final TextEditingController controller;
  final String label;
  final Key fieldKey;
  final CharacterSpeedKind kind;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Radio<CharacterSpeedKind>(
            value: kind,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              key: fieldKey,
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

int? _parseSignedInt(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    return 0;
  }
  if (trimmed == '-') {
    return null;
  }
  return int.tryParse(trimmed);
}

int? _parseUnsignedInt(String value) {
  final parsed = int.tryParse(value.trim());
  if (parsed == null) {
    return value.trim().isEmpty ? 0 : null;
  }
  return parsed < 0 ? 0 : parsed;
}

String _signedLabel(int value) {
  return value >= 0 ? '+$value' : '$value';
}
