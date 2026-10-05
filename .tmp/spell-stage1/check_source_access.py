from pathlib import Path
paths = [
'characters_mirror_server/lib/src/endpoints/models/general/class_endpoints/class_step_helpers.dart',
'characters_mirror_flutter/lib/features/character_creation/steps/class_step/state/class_state.dart',
'characters_mirror_flutter/lib/features/character_sheet/presentation/pages/spell_page/spell_helpers.dart',
'characters_mirror_server/lib/src/models/enums/character_spell_selection_kind.spy.yaml',
'characters_mirror_server/lib/src/models/views/class_spell_selection_group_view.spy.yaml',
'characters_mirror_server/lib/src/models/data/general/class/class_level_data.spy.yaml',
'characters_mirror_flutter/lib/features/character_creation/steps/spells_step/spells_step.dart',
'characters_mirror_flutter/lib/features/character_sheet/application/character_sheet_state/spell_operations.dart',
]
for name in paths:
    try:
        with Path(name).open('r+b'):
            pass
        print('Writable:', name)
    except OSError as e:
        print('Denied:', name, e.errno)
