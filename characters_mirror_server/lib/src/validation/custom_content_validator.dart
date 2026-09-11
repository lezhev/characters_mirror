import 'package:characters_mirror_server/src/generated/protocol.dart';

import 'rules.dart';

abstract final class CustomContentValidator {
  static void validateNotes(String field, List<CharacterNoteData>? notes) {
    Rules.mediumCollection(field, notes);
    if (notes == null) return;

    for (var index = 0; index < notes.length; index++) {
      final note = notes[index];
      final prefix = '$field[$index]';
      Rules.shortText('$prefix.id', note.id);
      Rules.longText('$prefix.text', note.text);
    }
  }

  static void validateFeatureOverrides(
    String field,
    List<CharacterFeatureOverrideData>? overrides,
  ) {
    Rules.mediumCollection(field, overrides);
    if (overrides == null) return;

    for (var index = 0; index < overrides.length; index++) {
      final override = overrides[index];
      final prefix = '$field[$index]';
      Rules.shortText('$prefix.id', override.id);
      Rules.nonNegativeInt('$prefix.sourceId', override.sourceId);
      Rules.shortText('$prefix.name', override.name);
      Rules.longText('$prefix.description', override.description);
      Rules.smallCollection('$prefix.tags', override.tags);
    }
  }

  static void validateResourceStates(
    String field,
    List<CharacterResourceStateData>? states,
  ) {
    Rules.mediumCollection(field, states);
    if (states == null) return;

    for (var index = 0; index < states.length; index++) {
      final state = states[index];
      final prefix = '$field[$index]';
      Rules.nonNegativeInt('$prefix.sourceId', state.sourceId);
      Rules.shortText('$prefix.resourceKey', state.resourceKey);
      Rules.nonNegativeInt('$prefix.current', state.current);
    }
  }
}
