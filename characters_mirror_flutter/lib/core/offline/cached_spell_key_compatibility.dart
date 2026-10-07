/// Old cache payloads may predate required SpellData reference keys. An empty
/// sentinel keeps them readable without inventing a canonical identity.
Object? compatibleCachedSpellKeys(Object? value, {bool isSpell = false}) {
  if (value is List) {
    return [
      for (final item in value)
        compatibleCachedSpellKeys(item, isSpell: isSpell)
    ];
  }
  if (value is! Map<String, dynamic>) return value;
  return <String, dynamic>{
    for (final entry in value.entries)
      entry.key:
          compatibleCachedSpellKeys(entry.value, isSpell: entry.key == 'spell'),
    if ((isSpell || value['className'] == 'SpellData') &&
        value['referenceKey'] == null)
      'referenceKey': '',
  };
}
