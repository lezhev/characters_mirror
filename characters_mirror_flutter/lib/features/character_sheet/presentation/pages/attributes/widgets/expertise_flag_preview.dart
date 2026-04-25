import 'dart:math' as math;

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';

enum ExpertiseFlagVariant {
  doubleRing,
  starHalo,
  orbit,
  diamondEcho,
  sunburst,
  compassEcho,
}

class ExpertiseFlagPreview extends StatelessWidget {
  static const double size = 36;

  const ExpertiseFlagPreview({
    required this.variant,
    super.key,
  });

  final ExpertiseFlagVariant variant;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accent = colorScheme.primary;
    final muted = colorScheme.outline.withValues(alpha: 0.8);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...switch (variant) {
            ExpertiseFlagVariant.doubleRing => [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: muted,
                      width: 1.2,
                    ),
                  ),
                ),
              ],
            ExpertiseFlagVariant.starHalo => [
                Container(
                  width: 34,
                  height: 34,
                  decoration: ShapeDecoration(
                    shape: StarBorder.polygon(
                      sides: 8,
                      pointRounding: 0.2,
                    ),
                    color: Colors.transparent,
                  ),
                  foregroundDecoration: ShapeDecoration(
                    shape: StarBorder.polygon(
                      sides: 8,
                      pointRounding: 0.2,
                    ),
                    color: Colors.transparent,
                  ),
                  child: CustomPaint(
                    painter: _ShapeBorderPainter(
                      shape: StarBorder.polygon(
                        sides: 8,
                        pointRounding: 0.2,
                      ),
                      color: muted,
                    ),
                  ),
                ),
              ],
            ExpertiseFlagVariant.orbit => [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: muted,
                      width: 1.1,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accent,
                    ),
                  ),
                ),
              ],
            ExpertiseFlagVariant.diamondEcho => [
                Transform.rotate(
                  angle: math.pi / 4,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: muted,
                        width: 1.1,
                      ),
                    ),
                  ),
                ),
              ],
            ExpertiseFlagVariant.sunburst => [
                for (final angle in List.generate(8, (index) => index))
                  Transform.rotate(
                    angle: (math.pi / 4) * angle,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 1.4,
                        height: 7,
                        margin: const EdgeInsets.only(top: 1),
                        decoration: BoxDecoration(
                          color: muted,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
              ],
            ExpertiseFlagVariant.compassEcho => [
                for (final angle in List.generate(4, (index) => index))
                  Transform.rotate(
                    angle: (math.pi / 2) * angle,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: muted,
                            width: 1.1,
                          ),
                        ),
                        transform: Matrix4.rotationZ(math.pi / 4),
                      ),
                    ),
                  ),
              ],
          },
          _BaseDotFlag(
            active: true,
            accent: accent,
            inactiveBorder: muted,
          ),
        ],
      ),
    );
  }
}

class SkillProficiencyToggle extends StatelessWidget {
  static const double size = ExpertiseFlagPreview.size;

  const SkillProficiencyToggle({
    required this.level,
    required this.onTap,
    super.key,
    this.expertiseVariant = ExpertiseFlagVariant.starHalo,
  });

  final CharacterSkillProficiencyLevel level;
  final VoidCallback onTap;
  final ExpertiseFlagVariant expertiseVariant;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final active = level != CharacterSkillProficiencyLevel.none;
    final haloVisible = level == CharacterSkillProficiencyLevel.expertise;
    final accent = colorScheme.primary;
    final muted = colorScheme.outline.withValues(alpha: 0.8);

    return Semantics(
      button: true,
      label: switch (level) {
        CharacterSkillProficiencyLevel.none =>
          'Навык без владения. Нажмите, чтобы включить владение',
        CharacterSkillProficiencyLevel.proficient =>
          'Владение навыком включено. Нажмите, чтобы включить экспертизу',
        CharacterSkillProficiencyLevel.expertise =>
          'Экспертиза навыка включена. Нажмите, чтобы выключить владение',
      },
      child: InkResponse(
        onTap: onTap,
        radius: 24,
        child: SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              IgnorePointer(
                child: Opacity(
                  opacity: haloVisible ? 1 : 0,
                  child: _ExpertiseHalo(
                    variant: expertiseVariant,
                    color: accent,
                  ),
                ),
              ),
              _BaseDotFlag(
                active: active,
                accent: accent,
                inactiveBorder: muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpertiseHalo extends StatelessWidget {
  const _ExpertiseHalo({
    required this.variant,
    required this.color,
  });

  final ExpertiseFlagVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SkillProficiencyToggle.size,
      height: SkillProficiencyToggle.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...switch (variant) {
            ExpertiseFlagVariant.doubleRing => [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color,
                      width: 1.2,
                    ),
                  ),
                ),
              ],
            ExpertiseFlagVariant.starHalo => [
                SizedBox(
                  width: 34,
                  height: 34,
                  child: CustomPaint(
                    painter: _ShapeBorderPainter(
                      shape: StarBorder.polygon(
                        sides: 8,
                        pointRounding: 0.2,
                      ),
                      color: color,
                    ),
                  ),
                ),
              ],
            ExpertiseFlagVariant.orbit => [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color,
                      width: 1.1,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                ),
              ],
            ExpertiseFlagVariant.diamondEcho => [
                Transform.rotate(
                  angle: math.pi / 4,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: color,
                        width: 1.1,
                      ),
                    ),
                  ),
                ),
              ],
            ExpertiseFlagVariant.sunburst => [
                for (final angle in List.generate(8, (index) => index))
                  Transform.rotate(
                    angle: (math.pi / 4) * angle,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 1.4,
                        height: 7,
                        margin: const EdgeInsets.only(top: 1),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
              ],
            ExpertiseFlagVariant.compassEcho => [
                for (final angle in List.generate(4, (index) => index))
                  Transform.rotate(
                    angle: (math.pi / 2) * angle,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: color,
                            width: 1.1,
                          ),
                        ),
                        transform: Matrix4.rotationZ(math.pi / 4),
                      ),
                    ),
                  ),
              ],
          },
        ],
      ),
    );
  }
}

class _BaseDotFlag extends StatelessWidget {
  const _BaseDotFlag({
    required this.active,
    required this.accent,
    required this.inactiveBorder,
  });

  final bool active;
  final Color accent;
  final Color inactiveBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: active ? accent : inactiveBorder,
          width: active ? 1.5 : 1.2,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active ? accent : Colors.transparent,
        ),
      ),
    );
  }
}

class _ShapeBorderPainter extends CustomPainter {
  const _ShapeBorderPainter({
    required this.shape,
    required this.color,
  });

  final OutlinedBorder shape;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = shape.getOuterPath(Offset.zero & size);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ShapeBorderPainter oldDelegate) {
    return oldDelegate.shape != shape || oldDelegate.color != color;
  }
}
