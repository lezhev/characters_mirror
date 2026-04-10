import 'package:characters_mirror_server/src/endpoints/models/general/starting_equipment_endpoints.dart';
import 'package:characters_mirror_server/src/endpoints/models/items/armor_data_endpoint.dart';
import 'package:characters_mirror_server/src/endpoints/models/items/item_data_endpoint.dart';
import 'package:characters_mirror_server/src/endpoints/models/items/weapon_data_endpoint.dart';
import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

Future<void> ensureWarlockStartingEquipmentData(
  Session session,
  ClassData classData,
) async {
  final classId = classData.id;
  if (classId == null || !_looksLikeWarlock(classData.name)) {
    return;
  }

  final itemEndpoint = ItemDataEndpoint();
  final weaponEndpoint = WeaponDataEndpoint();
  final armorEndpoint = ArmorDataEndpoint();
  final blockEndpoint = StartingEquipmentBlockDataEndpoint();
  final optionEndpoint = StartingEquipmentOptionDataEndpoint();
  final lineEndpoint = StartingEquipmentLineDataEndpoint();

  await itemEndpoint.upsert(
    session,
    ItemData(
      referenceKey: 'component_pouch',
      name: 'Component Pouch',
      category: 'Gear',
    ),
  );
  await itemEndpoint.upsert(
    session,
    ItemData(
      referenceKey: 'scholar_pack',
      name: 'Scholar Pack',
      category: 'Pack',
    ),
  );
  await itemEndpoint.upsert(
    session,
    ItemData(
      referenceKey: 'dungeoneer_pack',
      name: 'Dungeoneer Pack',
      category: 'Pack',
    ),
  );
  await itemEndpoint.upsert(
    session,
    ItemData(
      referenceKey: 'bolts',
      name: 'Crossbow Bolts',
      category: 'Ammunition',
    ),
  );
  await itemEndpoint.upsert(
    session,
    ItemData(
      referenceKey: 'crystal_focus',
      name: 'Crystal Focus',
      category: 'Focus',
    ),
  );

  for (final weapon in _simpleWeapons) {
    await weaponEndpoint.upsert(
      session,
      WeaponData(
        referenceKey: weapon.referenceKey,
        name: weapon.name,
        category: weapon.category,
      ),
    );
  }

  await armorEndpoint.upsert(
    session,
    ArmorData(
      referenceKey: 'leather_armor',
      name: 'Leather Armor',
      categoryValue: ArmorCategory.light,
    ),
  );

  final weaponChoiceBlock = await blockEndpoint.upsert(
    session,
    StartingEquipmentBlockData(
      blockKey: 'warlock_weapon_choice',
      orderIndex: 0,
      kind: StartingEquipmentBlockKind.choice,
      selectionCount: 1,
      sourceClassId: classId,
      name: 'Выбор оружия',
    ),
  );
  final crossbowOption = await optionEndpoint.upsert(
    session,
    StartingEquipmentOptionData(
      blockId: weaponChoiceBlock.id!,
      optionKey: 'warlock_crossbow_option',
      orderIndex: 0,
      name: 'Лёгкий арбалет и 20 болтов',
    ),
  );
  await lineEndpoint.upsert(
    session,
    StartingEquipmentLineData(
      optionId: crossbowOption.id!,
      lineKey: 'warlock_crossbow_line',
      orderIndex: 0,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.weapon,
      referenceKey: 'light_crossbow',
      displayText: 'Лёгкий арбалет',
      quantity: 1,
    ),
  );
  await lineEndpoint.upsert(
    session,
    StartingEquipmentLineData(
      optionId: crossbowOption.id!,
      lineKey: 'warlock_bolts_line',
      orderIndex: 1,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.item,
      referenceKey: 'bolts',
      displayText: 'Болты',
      quantity: 20,
    ),
  );
  final simpleWeaponOption = await optionEndpoint.upsert(
    session,
    StartingEquipmentOptionData(
      blockId: weaponChoiceBlock.id!,
      optionKey: 'warlock_simple_weapon_option',
      orderIndex: 1,
      name: 'Любое простое оружие',
    ),
  );
  await lineEndpoint.upsert(
    session,
    StartingEquipmentLineData(
      optionId: simpleWeaponOption.id!,
      lineKey: 'warlock_any_simple_weapon_line',
      orderIndex: 0,
      kind: StartingEquipmentLineKind.weaponCategory,
      displayText: 'Любое простое оружие',
      quantity: 1,
      allowedWeaponCategories: const [
        WeaponCategory.simpleMelee,
        WeaponCategory.simpleRanged,
      ],
    ),
  );

  final focusBlock = await blockEndpoint.upsert(
    session,
    StartingEquipmentBlockData(
      blockKey: 'warlock_focus_choice',
      orderIndex: 1,
      kind: StartingEquipmentBlockKind.choice,
      selectionCount: 1,
      sourceClassId: classId,
      name: 'Выбор фокусировки',
    ),
  );
  final componentOption = await optionEndpoint.upsert(
    session,
    StartingEquipmentOptionData(
      blockId: focusBlock.id!,
      optionKey: 'warlock_component_pouch_option',
      orderIndex: 0,
      name: 'Мешочек с компонентами',
    ),
  );
  await lineEndpoint.upsert(
    session,
    StartingEquipmentLineData(
      optionId: componentOption.id!,
      lineKey: 'warlock_component_pouch_line',
      orderIndex: 0,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.item,
      referenceKey: 'component_pouch',
      displayText: 'Мешочек с компонентами',
      quantity: 1,
    ),
  );
  final focusOption = await optionEndpoint.upsert(
    session,
    StartingEquipmentOptionData(
      blockId: focusBlock.id!,
      optionKey: 'warlock_arcane_focus_option',
      orderIndex: 1,
      name: 'Магическая фокусировка',
    ),
  );
  await lineEndpoint.upsert(
    session,
    StartingEquipmentLineData(
      optionId: focusOption.id!,
      lineKey: 'warlock_arcane_focus_line',
      orderIndex: 0,
      kind: StartingEquipmentLineKind.itemCategory,
      displayText: 'Магическая фокусировка',
      quantity: 1,
      allowedItemCategories: const ['Focus'],
    ),
  );

  final packBlock = await blockEndpoint.upsert(
    session,
    StartingEquipmentBlockData(
      blockKey: 'warlock_pack_choice',
      orderIndex: 2,
      kind: StartingEquipmentBlockKind.choice,
      selectionCount: 1,
      sourceClassId: classId,
      name: 'Выбор набора',
    ),
  );
  final scholarOption = await optionEndpoint.upsert(
    session,
    StartingEquipmentOptionData(
      blockId: packBlock.id!,
      optionKey: 'warlock_scholar_pack_option',
      orderIndex: 0,
      name: 'Набор учёного',
    ),
  );
  await lineEndpoint.upsert(
    session,
    StartingEquipmentLineData(
      optionId: scholarOption.id!,
      lineKey: 'warlock_scholar_pack_line',
      orderIndex: 0,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.item,
      referenceKey: 'scholar_pack',
      displayText: 'Набор учёного',
      quantity: 1,
    ),
  );
  final dungeoneerOption = await optionEndpoint.upsert(
    session,
    StartingEquipmentOptionData(
      blockId: packBlock.id!,
      optionKey: 'warlock_dungeoneer_pack_option',
      orderIndex: 1,
      name: 'Набор исследователя подземелий',
    ),
  );
  await lineEndpoint.upsert(
    session,
    StartingEquipmentLineData(
      optionId: dungeoneerOption.id!,
      lineKey: 'warlock_dungeoneer_pack_line',
      orderIndex: 0,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.item,
      referenceKey: 'dungeoneer_pack',
      displayText: 'Набор исследователя подземелий',
      quantity: 1,
    ),
  );

  final fixedBlock = await blockEndpoint.upsert(
    session,
    StartingEquipmentBlockData(
      blockKey: 'warlock_fixed_equipment',
      orderIndex: 3,
      kind: StartingEquipmentBlockKind.fixedGrant,
      selectionCount: 1,
      sourceClassId: classId,
      name: 'Остальное стартовое снаряжение',
    ),
  );
  await lineEndpoint.upsert(
    session,
    StartingEquipmentLineData(
      blockId: fixedBlock.id!,
      lineKey: 'warlock_fixed_leather_armor',
      orderIndex: 0,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.armor,
      referenceKey: 'leather_armor',
      displayText: 'Кожаный доспех',
      quantity: 1,
    ),
  );
  await lineEndpoint.upsert(
    session,
    StartingEquipmentLineData(
      blockId: fixedBlock.id!,
      lineKey: 'warlock_fixed_simple_weapon',
      orderIndex: 1,
      kind: StartingEquipmentLineKind.weaponCategory,
      displayText: 'Любое простое оружие',
      quantity: 1,
      allowedWeaponCategories: const [
        WeaponCategory.simpleMelee,
        WeaponCategory.simpleRanged,
      ],
    ),
  );
  await lineEndpoint.upsert(
    session,
    StartingEquipmentLineData(
      blockId: fixedBlock.id!,
      lineKey: 'warlock_fixed_daggers',
      orderIndex: 2,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.weapon,
      referenceKey: 'dagger',
      displayText: 'Кинжал',
      quantity: 2,
    ),
  );
}

bool _looksLikeWarlock(String? className) {
  final normalized = className?.trim().toLowerCase();
  if (normalized == null || normalized.isEmpty) {
    return false;
  }
  return normalized == 'warlock' ||
      normalized == 'колдун' ||
      normalized == 'fixture warlock';
}

const _simpleWeapons = <({
  String referenceKey,
  String name,
  WeaponCategory category,
})>[
  (
    referenceKey: 'club',
    name: 'Club',
    category: WeaponCategory.simpleMelee,
  ),
  (
    referenceKey: 'dagger',
    name: 'Dagger',
    category: WeaponCategory.simpleMelee,
  ),
  (
    referenceKey: 'greatclub',
    name: 'Greatclub',
    category: WeaponCategory.simpleMelee,
  ),
  (
    referenceKey: 'handaxe',
    name: 'Handaxe',
    category: WeaponCategory.simpleMelee,
  ),
  (
    referenceKey: 'javelin',
    name: 'Javelin',
    category: WeaponCategory.simpleMelee,
  ),
  (
    referenceKey: 'light_hammer',
    name: 'Light Hammer',
    category: WeaponCategory.simpleMelee,
  ),
  (
    referenceKey: 'mace',
    name: 'Mace',
    category: WeaponCategory.simpleMelee,
  ),
  (
    referenceKey: 'quarterstaff',
    name: 'Quarterstaff',
    category: WeaponCategory.simpleMelee,
  ),
  (
    referenceKey: 'sickle',
    name: 'Sickle',
    category: WeaponCategory.simpleMelee,
  ),
  (
    referenceKey: 'spear',
    name: 'Spear',
    category: WeaponCategory.simpleMelee,
  ),
  (
    referenceKey: 'light_crossbow',
    name: 'Light Crossbow',
    category: WeaponCategory.simpleRanged,
  ),
  (
    referenceKey: 'dart',
    name: 'Dart',
    category: WeaponCategory.simpleRanged,
  ),
  (
    referenceKey: 'shortbow',
    name: 'Shortbow',
    category: WeaponCategory.simpleRanged,
  ),
  (
    referenceKey: 'sling',
    name: 'Sling',
    category: WeaponCategory.simpleRanged,
  ),
];
