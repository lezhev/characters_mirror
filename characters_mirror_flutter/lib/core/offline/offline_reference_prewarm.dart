import 'dart:async';

import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';

class OfflineReferencePrewarmer {
  OfflineReferencePrewarmer({
    RaceRepository? raceRepository,
    ClassRepository? classRepository,
    BackgroundRepository? backgroundRepository,
    ItemRepository? itemRepository,
    WeaponRepository? weaponRepository,
    ArmorRepository? armorRepository,
    ToolDataRepository? toolDataRepository,
    MagicItemRepository? magicItemRepository,
    FeatRepository? featRepository,
    SpellRepository? spellRepository,
    SubclassRepository? subclassRepository,
    RaceFeatureRepository? raceFeatureRepository,
    RaceFeatureSpellGrantRepository? raceFeatureSpellGrantRepository,
    ClassFeatureRepository? classFeatureRepository,
    ClassLevelRepository? classLevelRepository,
    SubclassFeatureRepository? subclassFeatureRepository,
    ChoiceGroupRepository? choiceGroupRepository,
    ChoiceOptionRepository? choiceOptionRepository,
  })  : _raceRepository = raceRepository ?? RaceRepository(),
        _classRepository = classRepository ?? ClassRepository(),
        _backgroundRepository = backgroundRepository ?? BackgroundRepository(),
        _itemRepository = itemRepository ?? ItemRepository(),
        _weaponRepository = weaponRepository ?? WeaponRepository(),
        _armorRepository = armorRepository ?? ArmorRepository(),
        _toolDataRepository = toolDataRepository ?? ToolDataRepository(),
        _magicItemRepository = magicItemRepository ?? MagicItemRepository(),
        _featRepository = featRepository ?? FeatRepository(),
        _spellRepository = spellRepository ?? SpellRepository(),
        _subclassRepository = subclassRepository ?? SubclassRepository(),
        _raceFeatureRepository =
            raceFeatureRepository ?? RaceFeatureRepository(),
        _raceFeatureSpellGrantRepository = raceFeatureSpellGrantRepository ??
            RaceFeatureSpellGrantRepository(),
        _classFeatureRepository =
            classFeatureRepository ?? ClassFeatureRepository(),
        _classLevelRepository = classLevelRepository ?? ClassLevelRepository(),
        _subclassFeatureRepository =
            subclassFeatureRepository ?? SubclassFeatureRepository(),
        _choiceGroupRepository = choiceGroupRepository ?? ChoiceGroupRepository(),
        _choiceOptionRepository = choiceOptionRepository ?? ChoiceOptionRepository();

  final RaceRepository _raceRepository;
  final ClassRepository _classRepository;
  final BackgroundRepository _backgroundRepository;
  final ItemRepository _itemRepository;
  final WeaponRepository _weaponRepository;
  final ArmorRepository _armorRepository;
  final ToolDataRepository _toolDataRepository;
  final MagicItemRepository _magicItemRepository;
  final FeatRepository _featRepository;
  final SpellRepository _spellRepository;
  final SubclassRepository _subclassRepository;
  final RaceFeatureRepository _raceFeatureRepository;
  final RaceFeatureSpellGrantRepository _raceFeatureSpellGrantRepository;
  final ClassFeatureRepository _classFeatureRepository;
  final ClassLevelRepository _classLevelRepository;
  final SubclassFeatureRepository _subclassFeatureRepository;
  final ChoiceGroupRepository _choiceGroupRepository;
  final ChoiceOptionRepository _choiceOptionRepository;

  bool _isRunning = false;

  Future<void> prewarm() async {
    if (_isRunning) return;
    _isRunning = true;
    try {
      final races = await _raceRepository.getAll();
      final classes = await _classRepository.getAll();
      final backgrounds = await _backgroundRepository.getAll();
      final subclasses = await _subclassRepository.getAll();
      await Future.wait([
        _itemRepository.getAll(),
        _weaponRepository.getAll(),
        _armorRepository.getAll(),
        _toolDataRepository.getAll(),
        _magicItemRepository.getAll(),
        _featRepository.getAll(),
        _spellRepository.getAll(),
        _raceFeatureRepository.getAll(),
        _raceFeatureSpellGrantRepository.getAll(),
        _classFeatureRepository.getAll(),
        _classLevelRepository.getAll(),
        _subclassFeatureRepository.getAll(),
        _choiceGroupRepository.getAll(),
        _choiceOptionRepository.getAll(),
      ]);

      await Future.wait([
        for (final race in races)
          if (race.id != null) _raceRepository.getStepView(race.id!),
        for (final background in backgrounds)
          if (background.id != null)
            _backgroundRepository.getStepView(background.id!),
        for (final classData in classes)
          if (classData.id != null)
            _classRepository.getStepView(
              classData.id!,
              selectedLevel: 1,
              isStartingClass: true,
            ),
        for (final subclass in subclasses)
          if (subclass.id != null)
            _classRepository.getStepView(
              subclass.parentClassId,
              selectedLevel: 1,
              isStartingClass: true,
              selectedSubclassId: subclass.id,
            ),
      ]);
    } finally {
      _isRunning = false;
    }
  }
}
