import 'package:characters_mirror_flutter/core/dice/dice_roller.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/compact_number_input.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../application/level_up_overview.dart';

enum _HpMethod { fixed, virtual, manual }

class LevelUpHp extends StatefulWidget {
  const LevelUpHp(
      {super.key,
      required this.die,
      required this.roll,
      required this.constitution,
      required this.oldMax,
      required this.newMax,
      required this.onRoll,
      this.perLevelBonus = 0,
      this.oldConstitution = 0,
      this.oldLevel = 1});
  final int die;
  final int? roll;
  final int constitution;
  final int oldConstitution;
  final int oldLevel;
  final int perLevelBonus;
  final int oldMax;
  final int newMax;
  final void Function(int?) onRoll;
  @override
  State<LevelUpHp> createState() => _LevelUpHpState();
}

class _LevelUpHpState extends State<LevelUpHp> {
  _HpMethod _method = _HpMethod.fixed;
  late final TextEditingController _manual =
      TextEditingController(text: '${widget.roll ?? ''}');
  @override
  void dispose() {
    _manual.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final roll = widget.roll;
    final retroactive =
        (widget.constitution - widget.oldConstitution) * widget.oldLevel;
    return SheetOutlineCard(
        borderRadius: 8,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Expanded(
                child:
                    Text('Максимум хитов', style: theme.textTheme.titleMedium)),
            const SizedBox(width: 8),
            Text('${widget.oldMax} → ${widget.newMax}',
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: theme.colorScheme.primary)),
          ]),
          const SizedBox(height: 4),
          Text(
              'Увеличьте максимум хитов на 1к${widget.die} + модификатор Телосложения.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 8),
          Row(children: [
            for (final (method, label) in [
              (_HpMethod.fixed, 'Среднее'),
              (_HpMethod.virtual, 'Бросить к${widget.die}'),
              (_HpMethod.manual, 'Ввести вручную')
            ]) ...[
              if (method != _HpMethod.fixed) const SizedBox(width: 6),
              Expanded(
                  flex: method == _HpMethod.manual ? 13 : 10,
                  child: _HpMethodButton(
                      label: label,
                      selected: _method == method,
                      onTap: () {
                        setState(() => _method = method);
                        if (method == _HpMethod.fixed) {
                          widget.onRoll(widget.die ~/ 2 + 1);
                        }
                        if (method == _HpMethod.virtual) {
                          widget.onRoll(null);
                        }
                        if (method == _HpMethod.manual) {
                          final v = int.tryParse(_manual.text);
                          widget.onRoll(v != null && v >= 1 && v <= widget.die
                              ? v
                              : null);
                        }
                      })),
            ],
          ]),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
                child: SizedBox(
                    height: CompactNumberInput.extent,
                    child: Material(
                        key: const ValueKey('level-up-hp-result'),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: theme.colorScheme.outlineVariant)),
                        color: theme.colorScheme.surfaceContainerLow,
                        child: InkWell(
                          onTap: _method == _HpMethod.virtual ? _roll : null,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Row(children: [
                              Expanded(
                                  child: Text(
                                      roll == null
                                          ? (_method == _HpMethod.virtual
                                              ? 'Бросить к${widget.die}'
                                              : 'Выберите результат кости хитов')
                                          : levelUpHpCalculation(
                                              roll,
                                              widget.constitution,
                                              widget.perLevelBonus),
                                      style: theme.textTheme.bodySmall)),
                              if (_method == _HpMethod.virtual && roll != null)
                                IconButton(
                                    tooltip: 'Перебросить к${widget.die}',
                                    onPressed: _roll,
                                    icon: SvgPicture.asset(
                                        'assets/svg/dice.svg',
                                        width: 24,
                                        height: 24,
                                        colorFilter: ColorFilter.mode(
                                            theme.colorScheme.primary,
                                            BlendMode.srcIn))),
                            ]),
                          ),
                        )))),
            if (_method == _HpMethod.manual) ...[
              const SizedBox(width: 10),
              CompactNumberInput(
                  fieldKey: const ValueKey('level-up-hp-roll'),
                  controller: _manual,
                  semanticLabel:
                      'Результат к${widget.die}, от 1 до ${widget.die}, без модификаторов',
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (text) {
                    final value = int.tryParse(text);
                    widget.onRoll(
                        value != null && value >= 1 && value <= widget.die
                            ? value
                            : null);
                  }),
            ],
          ]),
          if (retroactive != 0)
            Text(
                'Изменение Телосложения на прошлых уровнях: ${signedLevelUpValue(retroactive)}'),
        ]));
  }

  void _roll() => widget.onRoll(DiceRoller().roll('d${widget.die}').total);
}

class _HpMethodButton extends StatelessWidget {
  const _HpMethodButton(
      {required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
        selected: selected,
        button: true,
        child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor:
                    selected ? theme.colorScheme.primaryContainer : null,
                side: BorderSide(
                    color: selected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outlineVariant)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: 12,
                  height: 12,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: selected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outline)),
                  child: selected
                      ? DecoratedBox(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.colorScheme.primary))
                      : null),
              const SizedBox(width: 6),
              Flexible(
                  child: Text(label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall)),
            ])));
  }
}
