import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CharacterMirrorLogo extends StatelessWidget {
  const CharacterMirrorLogo({
    required this.size,
    super.key,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: SvgPicture.asset(
        'assets/svg/logo/Logo.svg',
        semanticsLabel: 'Characters Mirror',
      ),
    );
  }
}
