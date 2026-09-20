import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

const _portraitSize = 1024;

Future<Uint8List> processCharacterPortrait(
  Uint8List source,
) {
  return compute(
    _processCharacterPortrait,
    source,
  );
}

Uint8List _processCharacterPortrait(
  Uint8List source,
) {
  final decoded = img.decodeImage(source);

  if (decoded == null) {
    throw const FormatException(
      'Unsupported portrait image format.',
    );
  }

  final resized = img.copyResizeCropSquare(
    decoded,
    size: _portraitSize,
    interpolation: img.Interpolation.cubic,
  );

  return img.encodeWebP(resized);
}
