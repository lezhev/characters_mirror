import 'dart:convert';
import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ReferenceDataEndpoint extends Endpoint {
  Future<void> insertJson(
      Session session, String entityType, String jsonString) async {
    try {
      final Map<String, dynamic> data = jsonDecode(jsonString);

      switch (entityType.toLowerCase()) {
        // --- General ---
        case 'class':
        case 'classdata':
          await ClassData.db.insertRow(session, ClassData.fromJson(data));
          break;

        case 'classfeature':
        case 'class_feature':
          await ClassFeatureData.db
              .insertRow(session, ClassFeatureData.fromJson(data));
          break;

        case 'classlevel':
        case 'class_level':
          await ClassLevelData.db
              .insertRow(session, ClassLevelData.fromJson(data));
          break;

        case 'spellslotprogression':
        case 'spell_slot_progression':
          await SpellSlotProgressionData.db
              .insertRow(session, SpellSlotProgressionData.fromJson(data));
          break;

        case 'classchoicegroup':
        case 'class_choice_group':
          await ClassChoiceGroupData.db
              .insertRow(session, ClassChoiceGroupData.fromJson(data));
          break;

        case 'classchoiceoption':
        case 'class_choice_option':
          await ClassChoiceOptionData.db
              .insertRow(session, ClassChoiceOptionData.fromJson(data));
          break;

        case 'classspellgrant':
        case 'class_spell_grant':
          final item = ClassSpellGrantData.fromJson(data);
          await _prepareClassSpellGrantForImport(session, item);
          await ClassSpellGrantData.db.insertRow(session, item);
          break;

        case 'race':
        case 'racedata':
          await RaceData.db.insertRow(session, RaceData.fromJson(data));
          break;

        case 'subrace':
        case 'subracedata':
          await SubraceData.db.insertRow(session, SubraceData.fromJson(data));
          break;

        case 'racefeature':
        case 'race_feature':
          await RaceFeatureData.db
              .insertRow(session, RaceFeatureData.fromJson(data));
          break;

        case 'racechoiceset':
        case 'race_choice_set':
          await RaceChoiceSetData.db
              .insertRow(session, RaceChoiceSetData.fromJson(data));
          break;

        case 'racechoiceoption':
        case 'race_choice_option':
          await RaceChoiceOptionData.db
              .insertRow(session, RaceChoiceOptionData.fromJson(data));
          break;

        case 'racefeaturespellgrant':
        case 'race_feature_spell_grant':
          await RaceFeatureSpellGrantData.db
              .insertRow(session, RaceFeatureSpellGrantData.fromJson(data));
          break;

        case 'subclass':
        case 'subclassdata':
          data['subclassName'] ??= data['subclass' 'name'];
          await SubclassData.db.insertRow(session, SubclassData.fromJson(data));
          break;

        case 'subclassfeature':
        case 'subclass_feature':
          await SubclassFeatureData.db
              .insertRow(session, SubclassFeatureData.fromJson(data));
          break;

        // --- Items ---
        case 'item':
        case 'itemdata':
          await ItemData.db.insertRow(session, ItemData.fromJson(data));
          break;

        case 'weapon':
        case 'weapondata':
          await WeaponData.db.insertRow(session, WeaponData.fromJson(data));
          break;

        case 'armor':
        case 'armordata':
          await ArmorData.db.insertRow(session, ArmorData.fromJson(data));
          break;

        case 'magicitem':
        case 'magic_item':
        case 'magicitemdata':
          await MagicItemData.db
              .insertRow(session, MagicItemData.fromJson(data));
          break;

        // --- Backgrounds, Feats, Spells ---
        case 'background':
        case 'backgrounddata':
          await BackgroundData.db
              .insertRow(session, BackgroundData.fromJson(data));
          break;

        case 'feat':
        case 'featdata':
          await FeatData.db.insertRow(session, FeatData.fromJson(data));
          break;

        case 'spell':
        case 'spelldata':
          _emptyStringToNull(data, 'durationType');
          await SpellData.db.insertRow(session, SpellData.fromJson(data));
          break;

        default:
          throw Exception('Unknown entity type: $entityType');
      }
    } catch (e, st) {
      session.log('Failed to insert entity: $e');
      session.log(st.toString());
      throw Exception('Invalid JSON or entity type: $entityType');
    }
  }
}

void _emptyStringToNull(Map<String, dynamic> data, String key) {
  final value = data[key];
  if (value is String && value.trim().isEmpty) {
    data[key] = null;
  }
}

Future<void> _prepareClassSpellGrantForImport(
  Session session,
  ClassSpellGrantData item,
) async {
  final spellReferenceKey = item.spellReferenceKey?.trim();
  if ((item.spellId == null || item.spellId! <= 0) &&
      spellReferenceKey != null &&
      spellReferenceKey.isNotEmpty) {
    final spells = await SpellData.db.find(
      session,
      where: (t) => t.referenceKey.equals(spellReferenceKey),
      limit: 1,
    );
    if (spells.isEmpty || spells.first.id == null) {
      throw Exception(
        'SpellData with referenceKey="$spellReferenceKey" was not found.',
      );
    }
    item.spellId = spells.first.id;
  }

  if (item.spellId == null || item.spellId! <= 0) {
    throw Exception(
      'ClassSpellGrantData must reference a spell by spellId or spellReferenceKey.',
    );
  }
}
