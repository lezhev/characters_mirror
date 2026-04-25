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
    MagicItemRepository? magicItemRepository,
    FeatRepository? featRepository,
    SpellRepository? spellRepository,
    SubclassRepository? subclassRepository,
    RaceFeatureRepository? raceFeatureRepository,
    RaceChoiceSetRepository? raceChoiceSetRepository,
    RaceChoiceOptionRepository? raceChoiceOptionRepository,
    RaceFeatureSpellGrantRepository? raceFeatureSpellGrantRepository,
    ClassFeatureRepository? classFeatureRepository,
    ClassLevelRepository? classLevelRepository,
    ClassChoiceGroupRepository? classChoiceGroupRepository,
    ClassChoiceOptionRepository? classChoiceOptionRepository,
    SubclassFeatureRepository? subclassFeatureRepository,
    StartingEquipmentBlockRepository? startingEquipmentBlockRepository,
    StartingEquipmentOptionRepository? startingEquipmentOptionRepository,
    StartingEquipmentLineRepository? startingEquipmentLineRepository,
  })  : _raceRepository = raceRepository ?? RaceRepository(),
        _classRepository = classRepository ?? ClassRepository(),
        _backgroundRepository = backgroundRepository ?? BackgroundRepository(),
        _itemRepository = itemRepository ?? ItemRepository(),
        _weaponRepository = weaponRepository ?? WeaponRepository(),
        _armorRepository = armorRepository ?? ArmorRepository(),
        _magicItemRepository = magicItemRepository ?? MagicItemRepository(),
        _featRepository = featRepository ?? FeatRepository(),
        _spellRepository = spellRepository ?? SpellRepository(),
        _subclassRepository = subclassRepository ?? SubclassRepository(),
        _raceFeatureRepository =
            raceFeatureRepository ?? RaceFeatureRepository(),
        _raceChoiceSetRepository =
            raceChoiceSetRepository ?? RaceChoiceSetRepository(),
        _raceChoiceOptionRepository =
            raceChoiceOptionRepository ?? RaceChoiceOptionRepository(),
        _raceFeatureSpellGrantRepository = raceFeatureSpellGrantRepository ??
            RaceFeatureSpellGrantRepository(),
        _classFeatureRepository =
            classFeatureRepository ?? ClassFeatureRepository(),
        _classLevelRepository = classLevelRepository ?? ClassLevelRepository(),
        _classChoiceGroupRepository =
            classChoiceGroupRepository ?? ClassChoiceGroupRepository(),
        _classChoiceOptionRepository =
            classChoiceOptionRepository ?? ClassChoiceOptionRepository(),
        _subclassFeatureRepository =
            subclassFeatureRepository ?? SubclassFeatureRepository(),
        _startingEquipmentBlockRepository = startingEquipmentBlockRepository ??
            StartingEquipmentBlockRepository(),
        _startingEquipmentOptionRepository =
            startingEquipmentOptionRepository ??
                StartingEquipmentOptionRepository(),
        _startingEquipmentLineRepository = startingEquipmentLineRepository ??
            StartingEquipmentLineRepository();

  final RaceRepository _raceRepository;
  final ClassRepository _classRepository;
  final BackgroundRepository _backgroundRepository;
  final ItemRepository _itemRepository;
  final WeaponRepository _weaponRepository;
  final ArmorRepository _armorRepository;
  final MagicItemRepository _magicItemRepository;
  final FeatRepository _featRepository;
  final SpellRepository _spellRepository;
  final SubclassRepository _subclassRepository;
  final RaceFeatureRepository _raceFeatureRepository;
  final RaceChoiceSetRepository _raceChoiceSetRepository;
  final RaceChoiceOptionRepository _raceChoiceOptionRepository;
  final RaceFeatureSpellGrantRepository _raceFeatureSpellGrantRepository;
  final ClassFeatureRepository _classFeatureRepository;
  final ClassLevelRepository _classLevelRepository;
  final ClassChoiceGroupRepository _classChoiceGroupRepository;
  final ClassChoiceOptionRepository _classChoiceOptionRepository;
  final SubclassFeatureRepository _subclassFeatureRepository;
  final StartingEquipmentBlockRepository _startingEquipmentBlockRepository;
  final StartingEquipmentOptionRepository _startingEquipmentOptionRepository;
  final StartingEquipmentLineRepository _startingEquipmentLineRepository;

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
        _magicItemRepository.getAll(),
        _featRepository.getAll(),
        _spellRepository.getAll(),
        _raceFeatureRepository.getAll(),
        _raceChoiceSetRepository.getAll(),
        _raceChoiceOptionRepository.getAll(),
        _raceFeatureSpellGrantRepository.getAll(),
        _classFeatureRepository.getAll(),
        _classLevelRepository.getAll(),
        _classChoiceGroupRepository.getAll(),
        _classChoiceOptionRepository.getAll(),
        _subclassFeatureRepository.getAll(),
        _startingEquipmentBlockRepository.getAll(),
        _startingEquipmentOptionRepository.getAll(),
        _startingEquipmentLineRepository.getAll(),
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
