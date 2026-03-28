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
        case 'character':
        case 'characterdata':
          await CharacterData.db
              .insertRow(session, CharacterData.fromJson(data));
          break;

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
          await ClassLevelData.db.insertRow(session, ClassLevelData.fromJson(data));
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

        case 'race':
        case 'racedata':
          await RaceData.db.insertRow(session, RaceData.fromJson(data));
          break;

        case 'subrace':
        case 'subracedata':
          await SubraceData.db.insertRow(session, SubraceData.fromJson(data));
          break;

        case 'subclass':
        case 'subclassdata':
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
