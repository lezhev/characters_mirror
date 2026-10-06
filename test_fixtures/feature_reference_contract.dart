Map<String, Object?> featureReferenceProjection(Map<String, dynamic> derived) {
  List<String> strings(String key) =>
      (derived[key] as List? ?? []).map((value) => '$value').toSet().toList()
        ..sort();
  final skills = [
    for (final state in derived['skillProficiencyLevels'] as List? ?? [])
      if (state['level'] != 'none') '${state['skill']}:${state['level']}',
  ]..sort();
  final resources = <String, int>{
    for (final feature in derived['activeFeatures'] as List? ?? [])
      for (final resource in feature['resources'] as List? ?? [])
        resource['key'] as String: resource['max'] as int,
  };
  return {
    'skills': skills,
    'languages': strings('languages'),
    'tools': strings('toolProficiencyKeys'),
    'toolExpertise': strings('toolExpertiseKeys'),
    'armor': strings('armorTraining'),
    'weapons': strings('weaponTraining'),
    'spells': strings('grantedSpellKeys'),
    'prepared': strings('alwaysPreparedSpellKeys'),
    'slots': derived['spellSlots'] == null
        ? null
        : {
            for (final slot in derived['spellSlots'] as List)
              '${slot['k']}': slot['v'],
          },
    'resources': resources,
  };
}

const selectedFeatureReferenceContract = <String, Object?>{
  'skills': ['history:expertise', 'stealth:proficient'],
  'languages': ['common', 'elvish'],
  'tools': ['fixture_choice_tool', 'fixture_disguise', 'fixture_poison'],
  'toolExpertise': ['fixture_poison'],
  'armor': ['heavy'],
  'weapons': ['martialMelee', 'martialRanged'],
  'spells': [
    'fixture_choice',
    'fixture_fixed',
    'fixture_null',
    'fixture_prepared',
  ],
  'prepared': ['fixture_prepared'],
  'slots': {'1': 2},
  'resources': {'fixture_pool': 5, 'fixture_choice_pool': 1},
};

const unselectedFeatureReferenceContract = <String, Object?>{
  'skills': ['history:expertise', 'stealth:proficient'],
  'languages': ['common', 'elvish'],
  'tools': ['fixture_disguise', 'fixture_poison'],
  'toolExpertise': ['fixture_poison'],
  'armor': ['heavy'],
  'weapons': ['martialMelee', 'martialRanged'],
  'spells': ['fixture_fixed', 'fixture_null'],
  'prepared': [],
  'slots': {'1': 2},
  'resources': {'fixture_pool': 2},
};
