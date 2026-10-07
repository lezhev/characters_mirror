import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/cached_spell_key_compatibility.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('legacy reference cache remains readable without assigning an identity',
      () async {
    final cache = OfflineCacheDatabase.openInMemory();
    addTearDown(cache.close);
    final old = <String, dynamic>{'id': 7, 'name': 'Legacy spell'};
    await cache.putReferenceList('spell', 'all', [old], (value) => value);
    final spells =
        await cache.getReferenceList('spell', 'all', SpellData.fromJson);
    expect(spells!.single.referenceKey, isEmpty);
    expect(spells.single.name, 'Legacy spell');
    expect(old.containsKey('referenceKey'), isFalse);
  });

  test('nested legacy spells decode while canonical keys and text stay intact',
      () async {
    final cache = OfflineCacheDatabase.openInMemory();
    addTearDown(cache.close);
    final old = <String, dynamic>{
      'spellSelections': [
        {
          'spellId': 7,
          'spell': {'id': 7, 'referenceKey': null, 'name': 'Legacy'}
        },
        {
          'spell': {'referenceKey': 'canonical_key', 'description': r'One\nTwo'}
        },
      ],
    };
    await cache.putReference('character', 'fixture', old, (value) => value);
    final character = await cache.getReference(
        'character', 'fixture', CharacterData.fromJson);
    expect(character!.spellSelections!.first.spell!.referenceKey, isEmpty);
    expect(
        character.spellSelections!.last.spell!.referenceKey, 'canonical_key');
    expect(character.spellSelections!.last.spell!.description, r'One\nTwo');
    expect((old['spellSelections'] as List).first['spell']['referenceKey'],
        isNull);
  });

  test('other reference keys are not converted to spell sentinels', () {
    final data = {'className': 'ClassData', 'referenceKey': null};
    expect(compatibleCachedSpellKeys(data), data);
  });
}
