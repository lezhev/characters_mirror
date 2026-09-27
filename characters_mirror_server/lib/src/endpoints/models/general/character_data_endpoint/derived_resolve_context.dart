part of '../character_data_endpoint.dart';

class _CharacterResolveContext {
  _CharacterResolveContext(
    this.session, {
    void Function(String key)? onReferenceLoad,
  }) : _onReferenceLoad = onReferenceLoad;

  final Session session;
  final void Function(String key)? _onReferenceLoad;

  Future<List<ChoiceGroupData>>? _choiceGroups;
  Future<List<ClassSpellGrantData>>? _classSpellGrants;
  final Map<int, Future<List<ChoiceOptionData>>> _choiceOptions = {};
  final Map<String, Future<List<ClassFeatureData>>> _classFeatures = {};
  final Map<String, Future<List<SubclassFeatureData>>> _subclassFeatures = {};
  final Map<String, Future<List<StartingEquipmentBlockView>>>
      _startingEquipmentBlocks = {};
  final Map<String, Future<WeaponData?>> _weapons = {};
  final Map<String, Future<ArmorData?>> _armor = {};
  final Map<String, Future<ItemData?>> _items = {};
  final Map<String, Future<SpellSlotProgressionData?>> _spellSlotProgressions =
      {};
  final Map<int, Future<FeatData?>> _feats = {};

  Future<List<ChoiceGroupData>> choiceGroups({
    Transaction? transaction,
  }) {
    return _choiceGroups ??= _load(
      'choiceGroups',
      () => ChoiceGroupData.db.find(
        session,
        orderBy: (t) => t.referenceKey,
        transaction: transaction,
      ),
    );
  }

  Future<List<ChoiceOptionData>> choiceOptions(
    Set<int> groupIds, {
    Transaction? transaction,
  }) {
    if (groupIds.isEmpty) {
      return Future.value(const <ChoiceOptionData>[]);
    }
    final missingIds = groupIds.difference(_choiceOptions.keys.toSet());
    if (missingIds.isNotEmpty) {
      final batch = _load(
        'choiceOptions:${_sortedKey(missingIds)}',
        () => ChoiceOptionData.db.find(
          session,
          where: (t) => t.choiceGroupId.inSet(missingIds),
          orderBy: (t) => t.sortOrder,
          transaction: transaction,
        ),
      );
      for (final groupId in missingIds) {
        _choiceOptions[groupId] = batch.then(
          (options) => [
            for (final option in options)
              if (option.choiceGroupId == groupId) option,
          ],
        );
      }
    }
    return Future.wait([
      for (final groupId in groupIds) _choiceOptions[groupId]!,
    ]).then((groups) => [for (final options in groups) ...options]);
  }

  Future<List<ClassFeatureData>> classFeatures(
    int classId,
    int level, {
    Transaction? transaction,
  }) {
    final cacheKey = '$classId:$level';
    return _classFeatures.putIfAbsent(
      cacheKey,
      () => _load(
        'classFeatures:$cacheKey',
        () => ClassFeatureData.db.find(
          session,
          where: (t) => t.parentClassId.equals(classId) & (t.level <= level),
          orderBy: (t) => t.level,
          include: _classFeatureInclude(),
          transaction: transaction,
        ),
      ),
    );
  }

  Future<List<SubclassFeatureData>> subclassFeatures(
    int subclassId,
    int level, {
    Transaction? transaction,
  }) {
    final cacheKey = '$subclassId:$level';
    return _subclassFeatures.putIfAbsent(
      cacheKey,
      () => _load(
        'subclassFeatures:$cacheKey',
        () => SubclassFeatureData.db.find(
          session,
          where: (t) =>
              t.parentSubclassId.equals(subclassId) & (t.level <= level),
          orderBy: (t) => t.level,
          include: _subclassFeatureInclude(),
          transaction: transaction,
        ),
      ),
    );
  }

  Future<List<ClassSpellGrantData>> classSpellGrants({
    Transaction? transaction,
  }) {
    return _classSpellGrants ??= _load(
      'classSpellGrants',
      () => ClassSpellGrantData.db.find(
        session,
        include: ClassSpellGrantData.include(spell: SpellData.include()),
        orderBy: (t) => t.grantedAtLevel,
        transaction: transaction,
      ),
    );
  }

  Future<List<StartingEquipmentBlockView>> startingEquipmentBlocks({
    int? sourceClassId,
    int? sourceBackgroundId,
    Transaction? transaction,
  }) {
    final cacheKey = '${sourceClassId ?? ''}:${sourceBackgroundId ?? ''}';
    return _startingEquipmentBlocks.putIfAbsent(
      cacheKey,
      () => _load(
        'startingEquipmentBlocks:$cacheKey',
        () => startingEquipmentBlockViews(
          session,
          sourceClassId: sourceClassId,
          sourceBackgroundId: sourceBackgroundId,
          transaction: transaction,
        ),
      ),
    );
  }

  Future<WeaponData?> weapon(
    String referenceKey, {
    Transaction? transaction,
  }) {
    return _weapons.putIfAbsent(
      referenceKey,
      () => _load('weapon:$referenceKey', () async {
        final rows = await WeaponData.db.find(
          session,
          where: (t) => t.referenceKey.equals(referenceKey),
          limit: 1,
          transaction: transaction,
        );
        return rows.isEmpty ? null : rows.first;
      }),
    );
  }

  Future<ArmorData?> armor(
    String referenceKey, {
    Transaction? transaction,
  }) {
    return _armor.putIfAbsent(
      referenceKey,
      () => _load('armor:$referenceKey', () async {
        final rows = await ArmorData.db.find(
          session,
          where: (t) => t.referenceKey.equals(referenceKey),
          limit: 1,
          transaction: transaction,
        );
        return rows.isEmpty ? null : rows.first;
      }),
    );
  }

  Future<ItemData?> item(
    String referenceKey, {
    Transaction? transaction,
  }) {
    return _items.putIfAbsent(
      referenceKey,
      () => _load('item:$referenceKey', () async {
        final rows = await ItemData.db.find(
          session,
          where: (t) => t.referenceKey.equals(referenceKey),
          limit: 1,
          transaction: transaction,
        );
        return rows.isEmpty ? null : rows.first;
      }),
    );
  }

  Future<SpellSlotProgressionData?> spellSlotProgression(
    String tableKey,
    int level, {
    Transaction? transaction,
  }) {
    final cacheKey = '$tableKey:$level';
    return _spellSlotProgressions.putIfAbsent(
      cacheKey,
      () => _load('spellSlotProgression:$cacheKey', () async {
        final rows = await SpellSlotProgressionData.db.find(
          session,
          where: (t) => t.tableKey.equals(tableKey) & t.level.equals(level),
          limit: 1,
          transaction: transaction,
        );
        return rows.isEmpty ? null : rows.first;
      }),
    );
  }

  Future<List<FeatData>> feats(
    Set<int> featIds, {
    Transaction? transaction,
  }) {
    if (featIds.isEmpty) {
      return Future.value(const <FeatData>[]);
    }
    final missingIds = featIds.difference(_feats.keys.toSet());
    if (missingIds.isNotEmpty) {
      final batch = _load(
        'feats:${_sortedKey(missingIds)}',
        () => FeatData.db.find(
          session,
          where: (t) => t.id.inSet(missingIds),
          transaction: transaction,
        ),
      );
      for (final featId in missingIds) {
        _feats[featId] = batch.then((feats) {
          for (final feat in feats) {
            if (feat.id == featId) return feat;
          }
          return null;
        });
      }
    }
    return Future.wait([
      for (final featId in featIds) _feats[featId]!,
    ]).then((feats) => [
          for (final feat in feats)
            if (feat != null) feat
        ]);
  }

  Future<T> _load<T>(String key, Future<T> Function() loader) {
    _onReferenceLoad?.call(key);
    return loader();
  }

  String _sortedKey(Set<int> ids) {
    final sortedIds = ids.toList()..sort();
    return sortedIds.join(',');
  }
}
