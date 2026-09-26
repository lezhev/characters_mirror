abstract final class ValidationLimits {
  static const payloadBytes = 512 * 1024;

  static const shortText = 120;
  static const mediumText = 1000;
  static const longText = 20000;

  static const smallCollection = 20;
  static const mediumCollection = 100;
  static const largeCollection = 500;
  static const proficiencyOverrideEntries = 64;

  static const boundedIntMin = -100000;
  static const boundedIntMax = 100000;
  static const nonNegativeIntMax = 100000;
}
