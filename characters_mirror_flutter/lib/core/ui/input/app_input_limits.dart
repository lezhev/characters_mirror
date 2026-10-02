abstract final class AppInputLimits {
  // Keep these values in sync with characters_mirror_server's
  // ValidationLimits. The Flutter package must not depend on the server.
  static const shortText = 120;
  static const mediumText = 1000;
  static const longText = 20000;

  static const boundedIntMin = -100000;
  static const boundedIntMax = 100000;
  static const nonNegativeIntMax = 100000;
  static const hitPointActionMax = 10000;
  static const hitPointExpressionLength = 64;
}
