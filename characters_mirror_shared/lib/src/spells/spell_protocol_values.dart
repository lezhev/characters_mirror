/// Serverpod encodes non-string-key maps as [{k: key, v: value}].
/// Accept plain maps too, so domain callers need not depend on that encoding.
Map<int, T> spellProtocolIntMap<T>(dynamic value) {
  final entries = value is Map
      ? value.entries
      : value is List
          ? value.whereType<Map>().map((v) => MapEntry(v['k'], v['v']))
          : const <MapEntry<dynamic, dynamic>>[];
  return {
    for (final e in entries)
      if (int.tryParse('${e.key}') != null) int.parse('${e.key}'): e.value as T
  };
}

/// Enum-key maps also use entry lists, even when enums serialize by name.
Map<String, T> spellProtocolStringMap<T>(dynamic value) {
  final entries = value is Map
      ? value.entries
      : value is List
          ? value.whereType<Map>().map((v) => MapEntry(v['k'], v['v']))
          : const <MapEntry<dynamic, dynamic>>[];
  return {for (final entry in entries) '${entry.key}': entry.value as T};
}
