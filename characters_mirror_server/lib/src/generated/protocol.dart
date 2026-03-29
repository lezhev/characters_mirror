/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i3;
import 'data/general/race/race_feature_spell_grant_data.dart' as _i4;
import 'data/background_data.dart' as _i5;
import 'data/feat_data.dart' as _i6;
import 'data/general/character/character_choice_data.dart' as _i7;
import 'data/general/character/character_class_entry_data.dart' as _i8;
import 'data/general/character/character_data.dart' as _i9;
import 'data/general/character/character_sheet_snapshot_data.dart' as _i10;
import 'data/general/class/class_choice_group_data.dart' as _i11;
import 'data/general/class/class_choice_option_data.dart' as _i12;
import 'data/general/class/class_data.dart' as _i13;
import 'data/general/class/class_feature_data.dart' as _i14;
import 'data/general/class/class_level_data.dart' as _i15;
import 'data/general/class/subclass_data.dart' as _i16;
import 'data/general/class/subclass_feature_data.dart' as _i17;
import 'data/general/race/dragonborn_ancestry_data.dart' as _i18;
import 'data/general/race/race_choice_set_data.dart' as _i19;
import 'data/general/race/race_data.dart' as _i20;
import 'data/general/race/race_feature_data.dart' as _i21;
import 'auth/auth_action_result.dart' as _i22;
import 'data/general/race/subrace_data.dart' as _i23;
import 'data/items/armor_data.dart' as _i24;
import 'data/items/item_data.dart' as _i25;
import 'data/items/magic_item_data.dart' as _i26;
import 'data/items/weapon_data.dart' as _i27;
import 'data/spell_class_availability_data.dart' as _i28;
import 'data/spell_data.dart' as _i29;
import 'data/spell_scaling_data.dart' as _i30;
import 'enums/ability.dart' as _i31;
import 'enums/armor_category.dart' as _i32;
import 'enums/character_alignment.dart' as _i33;
import 'enums/choice_source_type.dart' as _i34;
import 'enums/class_choice_type.dart' as _i35;
import 'enums/creature_size.dart' as _i36;
import 'enums/damage_type.dart' as _i37;
import 'enums/feature_tag.dart' as _i38;
import 'enums/hit_point_mode.dart' as _i39;
import 'views/proficiency_bundle_view.dart' as _i40;
import 'enums/race_choice_kind.dart' as _i41;
import 'enums/rest_type.dart' as _i42;
import 'enums/skill.dart' as _i43;
import 'enums/spell/area_of_effect_type.dart' as _i44;
import 'enums/spell/condition_type.dart' as _i45;
import 'enums/spell/spell_attack_type.dart' as _i46;
import 'enums/spell/spell_duration_type.dart' as _i47;
import 'enums/spell/spell_scaling_mode.dart' as _i48;
import 'enums/spell/spell_school.dart' as _i49;
import 'enums/spell/spell_target_type.dart' as _i50;
import 'enums/spellcasting_progression.dart' as _i51;
import 'enums/weapon_category.dart' as _i52;
import 'views/character_build_data.dart' as _i53;
import 'views/character_sheet_view.dart' as _i54;
import 'views/class_choice_group_view.dart' as _i55;
import 'views/class_step_subclass_choice_view.dart' as _i56;
import 'views/class_step_view.dart' as _i57;
import 'enums/language.dart' as _i58;
import 'package:characters_mirror_server/src/generated/data/background_data.dart'
    as _i59;
import 'package:characters_mirror_server/src/generated/data/feat_data.dart'
    as _i60;
import 'package:characters_mirror_server/src/generated/data/general/character/character_data.dart'
    as _i61;
import 'package:characters_mirror_server/src/generated/data/general/class/class_data.dart'
    as _i62;
import 'package:characters_mirror_server/src/generated/data/general/class/class_feature_data.dart'
    as _i63;
import 'package:characters_mirror_server/src/generated/data/general/class/class_level_data.dart'
    as _i64;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_data.dart'
    as _i65;
import 'package:characters_mirror_server/src/generated/data/general/class/class_choice_group_data.dart'
    as _i66;
import 'package:characters_mirror_server/src/generated/data/general/class/class_choice_option_data.dart'
    as _i67;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_feature_data.dart'
    as _i68;
import 'package:characters_mirror_server/src/generated/data/general/race/race_data.dart'
    as _i69;
import 'package:characters_mirror_server/src/generated/data/general/race/race_feature_data.dart'
    as _i70;
import 'package:characters_mirror_server/src/generated/data/general/race/subrace_data.dart'
    as _i71;
import 'package:characters_mirror_server/src/generated/data/general/race/dragonborn_ancestry_data.dart'
    as _i72;
import 'package:characters_mirror_server/src/generated/data/general/race/race_choice_set_data.dart'
    as _i73;
import 'package:characters_mirror_server/src/generated/data/general/race/race_feature_spell_grant_data.dart'
    as _i74;
import 'package:characters_mirror_server/src/generated/data/items/armor_data.dart'
    as _i75;
import 'package:characters_mirror_server/src/generated/data/items/item_data.dart'
    as _i76;
import 'package:characters_mirror_server/src/generated/data/items/magic_item_data.dart'
    as _i77;
import 'package:characters_mirror_server/src/generated/data/items/weapon_data.dart'
    as _i78;
import 'package:characters_mirror_server/src/generated/data/spell_data.dart'
    as _i79;
export 'auth/auth_action_result.dart';
export 'data/background_data.dart';
export 'data/feat_data.dart';
export 'data/general/character/character_choice_data.dart';
export 'data/general/character/character_class_entry_data.dart';
export 'data/general/character/character_data.dart';
export 'data/general/character/character_sheet_snapshot_data.dart';
export 'data/general/class/class_choice_group_data.dart';
export 'data/general/class/class_choice_option_data.dart';
export 'data/general/class/class_data.dart';
export 'data/general/class/class_feature_data.dart';
export 'data/general/class/class_level_data.dart';
export 'data/general/class/subclass_data.dart';
export 'data/general/class/subclass_feature_data.dart';
export 'data/general/race/dragonborn_ancestry_data.dart';
export 'data/general/race/race_choice_set_data.dart';
export 'data/general/race/race_data.dart';
export 'data/general/race/race_feature_data.dart';
export 'data/general/race/race_feature_spell_grant_data.dart';
export 'data/general/race/subrace_data.dart';
export 'data/items/armor_data.dart';
export 'data/items/item_data.dart';
export 'data/items/magic_item_data.dart';
export 'data/items/weapon_data.dart';
export 'data/spell_class_availability_data.dart';
export 'data/spell_data.dart';
export 'data/spell_scaling_data.dart';
export 'enums/ability.dart';
export 'enums/armor_category.dart';
export 'enums/character_alignment.dart';
export 'enums/choice_source_type.dart';
export 'enums/class_choice_type.dart';
export 'enums/creature_size.dart';
export 'enums/damage_type.dart';
export 'enums/feature_tag.dart';
export 'enums/hit_point_mode.dart';
export 'enums/language.dart';
export 'enums/race_choice_kind.dart';
export 'enums/rest_type.dart';
export 'enums/skill.dart';
export 'enums/spell/area_of_effect_type.dart';
export 'enums/spell/condition_type.dart';
export 'enums/spell/spell_attack_type.dart';
export 'enums/spell/spell_duration_type.dart';
export 'enums/spell/spell_scaling_mode.dart';
export 'enums/spell/spell_school.dart';
export 'enums/spell/spell_target_type.dart';
export 'enums/spellcasting_progression.dart';
export 'enums/weapon_category.dart';
export 'views/character_build_data.dart';
export 'views/character_sheet_view.dart';
export 'views/class_choice_group_view.dart';
export 'views/class_step_subclass_choice_view.dart';
export 'views/class_step_view.dart';
export 'views/proficiency_bundle_view.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'armor_data',
      dartName: 'ArmorData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'armor_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'categoryValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:ArmorCategory?',
        ),
        _i2.ColumnDefinition(
          name: 'baseAC',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'dexBonus',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'dexBonusMax',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'strengthRequirement',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'stealthDisadvantage',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'weight',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'cost',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'armor_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'background_data',
      dartName: 'BackgroundData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'background_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'skillProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'toolProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'languages',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'items',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'coins',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'feature',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'suggestedPersonality',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'suggestedIdeal',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'suggestedBond',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'suggestedFlaw',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'background_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'character_choice_data',
      dartName: 'CharacterChoiceData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'character_choice_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'characterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'classEntryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceType',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:ChoiceSourceType?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'groupKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'optionKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'selectedSpellKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'selectedItemKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'selectedText',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'selectedCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'character_choice_data_fk_0',
          columns: ['characterId'],
          referenceTable: 'characters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_choice_data_fk_1',
          columns: ['classEntryId'],
          referenceTable: 'character_class_relation',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'character_choice_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'character_class_relation',
      dartName: 'CharacterClassEntryData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'character_class_relation_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'characterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'classDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'subclassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isStartingClass',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'classOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'hpMode',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:HitPointMode?',
        ),
        _i2.ColumnDefinition(
          name: 'hpRolledValues',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'character_class_relation_fk_0',
          columns: ['characterId'],
          referenceTable: 'characters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_class_relation_fk_1',
          columns: ['classDataId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_class_relation_fk_2',
          columns: ['subclassId'],
          referenceTable: 'subclass_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'character_class_relation_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'character_sheet_snapshot_data',
      dartName: 'CharacterSheetSnapshotData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'character_sheet_snapshot_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'characterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'totalLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'proficiencyBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'armorClass',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'initiative',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'speed',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'maxHp',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'passivePerception',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'passiveInvestigation',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'passiveInsight',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'savingThrowBonuses',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'skillBonuses',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'spellSlots',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<int,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'pactSlots',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<int,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'hitDiceSummary',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'senses',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'resistances',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:DamageType>?',
        ),
        _i2.ColumnDefinition(
          name: 'sheetVersion',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'rebuiltAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'character_sheet_snapshot_data_fk_0',
          columns: ['characterId'],
          referenceTable: 'characters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'character_sheet_snapshot_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'character_sheet_snapshot_character_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'characterId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'characters',
      dartName: 'CharacterData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'characters_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'age',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'height',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'weight',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'eyes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'skin',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'hair',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'appearance',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'backstory',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'goals',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'alliesOrganizations',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'personalityTraits',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'ideals',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'bonds',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'flaws',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'experience',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'alignmentValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:CharacterAlignment?',
        ),
        _i2.ColumnDefinition(
          name: 'raceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'subraceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'backgroundId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'baseAbilityScores',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'temporaryHp',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'currentHp',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'inspiration',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'characters_fk_0',
          columns: ['raceId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'characters_fk_1',
          columns: ['subraceId'],
          referenceTable: 'subrace_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'characters_fk_2',
          columns: ['backgroundId'],
          referenceTable: 'background_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'characters_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'class_choice_group_data',
      dartName: 'ClassChoiceGroupData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'class_choice_group_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceClassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceSubclassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceRaceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceSubraceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceBackgroundId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:ClassChoiceType?',
        ),
        _i2.ColumnDefinition(
          name: 'selectionCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'appliesAtCharacterLevel',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'exclusiveKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'allowDuplicates',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'class_choice_group_data_fk_0',
          columns: ['sourceClassId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'class_choice_group_data_fk_1',
          columns: ['sourceSubclassId'],
          referenceTable: 'subclass_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'class_choice_group_data_fk_2',
          columns: ['sourceFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'class_choice_group_data_fk_3',
          columns: ['sourceRaceId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'class_choice_group_data_fk_4',
          columns: ['sourceSubraceId'],
          referenceTable: 'subrace_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'class_choice_group_data_fk_5',
          columns: ['sourceBackgroundId'],
          referenceTable: 'background_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'class_choice_group_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'class_choice_option_data',
      dartName: 'ClassChoiceOptionData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'class_choice_option_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'choiceGroupId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'optionKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedAbilityBonuses',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedSkills',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedLanguages',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Language>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedArmorTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedWeaponTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:WeaponCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedToolKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedItemKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedSpellKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedFeatureTags',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'class_choice_option_data_fk_0',
          columns: ['choiceGroupId'],
          referenceTable: 'class_choice_group_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'class_choice_option_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'class_data',
      dartName: 'ClassData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'class_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'hitDieValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'primaryAbilities',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Ability>?',
        ),
        _i2.ColumnDefinition(
          name: 'savingThrowProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Ability>?',
        ),
        _i2.ColumnDefinition(
          name: 'armorTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'weaponTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:WeaponCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'toolTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'availableSkills',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _i2.ColumnDefinition(
          name: 'skillCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'subclassChoiceLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'spellcastingProgression',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:SpellcastingProgression?',
        ),
        _i2.ColumnDefinition(
          name: 'spellcastingAbilityValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _i2.ColumnDefinition(
          name: 'multiclassPrerequisites',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'multiclassArmorTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'multiclassWeaponTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:WeaponCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'multiclassToolTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'imageURL',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'class_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'class_feature_data',
      dartName: 'ClassFeatureData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'class_feature_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'parentClassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'tags',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
        _i2.ColumnDefinition(
          name: 'choiceGroupKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'class_feature_data_fk_0',
          columns: ['parentClassId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'class_feature_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'class_level_data',
      dartName: 'ClassLevelData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'class_level_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'classDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'featureIds',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
        _i2.ColumnDefinition(
          name: 'subclassFeatureIds',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
        _i2.ColumnDefinition(
          name: 'knownCantrips',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'knownSpells',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'preparedSpellFormula',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'resourceSummary',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'spellSlots',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<int,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'class_level_data_fk_0',
          columns: ['classDataId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'class_level_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'dragonborn_ancestry_data',
      dartName: 'DragonbornAncestryData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'dragonborn_ancestry_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'damageType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'breathShape',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'area',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'saveAbility',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _i2.ColumnDefinition(
          name: 'damageByLevel',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'dragonborn_ancestry_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'feat_data',
      dartName: 'FeatData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'feat_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'abilityBonuses',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'traits',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'tags',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
        _i2.ColumnDefinition(
          name: 'specialAbilities',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'proficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'prerequisites',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'feat_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'item_data',
      dartName: 'ItemData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'item_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'weight',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'cost',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'effects',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'item_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'magic_item_data',
      dartName: 'MagicItemData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'magic_item_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'rarity',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresAttunement',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'attunementCondition',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'bonus',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'charges',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'rechargeCondition',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'effects',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'magic_item_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'race_choice_set_data',
      dartName: 'RaceChoiceSetData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'race_choice_set_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'raceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'subraceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'featureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'kind',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:RaceChoiceKind?',
        ),
        _i2.ColumnDefinition(
          name: 'pickCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'options',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'optionValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'mustBeDistinct',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: '_raceDataChoicesetsRaceDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: '_raceFeatureDataChoicesetsRaceFeatureDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: '_subraceDataChoicesetsSubraceDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'race_choice_set_data_fk_0',
          columns: ['raceId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'race_choice_set_data_fk_1',
          columns: ['subraceId'],
          referenceTable: 'subrace_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'race_choice_set_data_fk_2',
          columns: ['featureId'],
          referenceTable: 'race_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'race_choice_set_data_fk_3',
          columns: ['_raceDataChoicesetsRaceDataId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'race_choice_set_data_fk_4',
          columns: ['_raceFeatureDataChoicesetsRaceFeatureDataId'],
          referenceTable: 'race_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'race_choice_set_data_fk_5',
          columns: ['_subraceDataChoicesetsSubraceDataId'],
          referenceTable: 'subrace_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'race_choice_set_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'race_data',
      dartName: 'RaceData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'race_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'speed',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'size',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'abilityBonuses',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'traits',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'languages',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'visionType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'visionRange',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'resistances',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'skillProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'armorProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'weaponProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'toolProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'spellcasting',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,protocol:SpellData>?',
        ),
        _i2.ColumnDefinition(
          name: 'imageURL',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'race_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'race_feature_data',
      dartName: 'RaceFeatureData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'race_feature_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'raceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'subraceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'spells',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'usesPerRest',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'usesFormula',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'tags',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'race_feature_data_fk_0',
          columns: ['raceId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'race_feature_data_fk_1',
          columns: ['subraceId'],
          referenceTable: 'subrace_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'race_feature_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'race_feature_spell_grant_data',
      dartName: 'RaceFeatureSpellGrantData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'race_feature_spell_grant_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'featureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'spellId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'grantedAtLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'castingAbility',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _i2.ColumnDefinition(
          name: 'freeCastsPerRest',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:RestType?',
        ),
        _i2.ColumnDefinition(
          name: 'freeCastsFormula',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'castAtSpellLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'canAlsoCastWithSpellSlots',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: '_raceFeatureDataSpellgrantsRaceFeatureDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'race_feature_spell_grant_data_fk_0',
          columns: ['featureId'],
          referenceTable: 'race_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'race_feature_spell_grant_data_fk_1',
          columns: ['spellId'],
          referenceTable: 'spell_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'race_feature_spell_grant_data_fk_2',
          columns: ['_raceFeatureDataSpellgrantsRaceFeatureDataId'],
          referenceTable: 'race_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'race_feature_spell_grant_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'spell_class_availability_data',
      dartName: 'SpellClassAvailabilityData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'spell_class_availability_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'spellId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'classDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'spell_class_availability_data_fk_0',
          columns: ['spellId'],
          referenceTable: 'spell_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'spell_class_availability_data_fk_1',
          columns: ['classDataId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'spell_class_availability_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'spell_class_availability_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'spellId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'classDataId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'spell_data',
      dartName: 'SpellData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'spell_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'schoolValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:SpellSchool?',
        ),
        _i2.ColumnDefinition(
          name: 'castingTime',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'range',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'duration',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'concentration',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'ritual',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'higherLevel',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'savingThrowAbility',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresSavingThrow',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'attackType',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:SpellAttackType?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresAttackRoll',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'damageType',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:DamageType?',
        ),
        _i2.ColumnDefinition(
          name: 'damageDice',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'damageScaling',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:SpellScalingData?',
        ),
        _i2.ColumnDefinition(
          name: 'conditions',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ConditionType>?',
        ),
        _i2.ColumnDefinition(
          name: 'targetType',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:SpellTargetType?',
        ),
        _i2.ColumnDefinition(
          name: 'areaOfEffectType',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:AreaOfEffectType?',
        ),
        _i2.ColumnDefinition(
          name: 'areaOfEffectSize',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'areaOfEffectSecondarySize',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'areaOfEffectHeight',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'materialDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'materialCost',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'materialConsumed',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'durationType',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:SpellDurationType?',
        ),
        _i2.ColumnDefinition(
          name: 'isHealing',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'healingDice',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresLineOfSight',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresVerbal',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresSomatic',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresMaterial',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'spell_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subclass_data',
      dartName: 'SubclassData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subclass_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'parentClassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'levelRequired',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subclass_data_fk_0',
          columns: ['parentClassId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subclass_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subclass_feature_data',
      dartName: 'SubclassFeatureData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subclass_feature_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'parentSubclassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'tags',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
        _i2.ColumnDefinition(
          name: 'choiceGroupKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subclass_feature_data_fk_0',
          columns: ['parentSubclassId'],
          referenceTable: 'subclass_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subclass_feature_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subrace_data',
      dartName: 'SubraceData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subrace_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'parentRaceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'abilityBonuses',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'traits',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'speedOverride',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'visionRangeOverride',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'skillProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'resistances',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'armorProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'weaponProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'toolProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subrace_data_fk_0',
          columns: ['parentRaceId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subrace_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'weapon_data',
      dartName: 'WeaponData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'weapon_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:WeaponCategory?',
        ),
        _i2.ColumnDefinition(
          name: 'damage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'damageTypeValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:DamageType?',
        ),
        _i2.ColumnDefinition(
          name: 'properties',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'weight',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'cost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'rangeNormal',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'rangeMax',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'weapon_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i4.RaceFeatureSpellGrantData) {
      return _i4.RaceFeatureSpellGrantData.fromJson(data) as T;
    }
    if (t == _i5.BackgroundData) {
      return _i5.BackgroundData.fromJson(data) as T;
    }
    if (t == _i6.FeatData) {
      return _i6.FeatData.fromJson(data) as T;
    }
    if (t == _i7.CharacterChoiceData) {
      return _i7.CharacterChoiceData.fromJson(data) as T;
    }
    if (t == _i8.CharacterClassEntryData) {
      return _i8.CharacterClassEntryData.fromJson(data) as T;
    }
    if (t == _i9.CharacterData) {
      return _i9.CharacterData.fromJson(data) as T;
    }
    if (t == _i10.CharacterSheetSnapshotData) {
      return _i10.CharacterSheetSnapshotData.fromJson(data) as T;
    }
    if (t == _i11.ClassChoiceGroupData) {
      return _i11.ClassChoiceGroupData.fromJson(data) as T;
    }
    if (t == _i12.ClassChoiceOptionData) {
      return _i12.ClassChoiceOptionData.fromJson(data) as T;
    }
    if (t == _i13.ClassData) {
      return _i13.ClassData.fromJson(data) as T;
    }
    if (t == _i14.ClassFeatureData) {
      return _i14.ClassFeatureData.fromJson(data) as T;
    }
    if (t == _i15.ClassLevelData) {
      return _i15.ClassLevelData.fromJson(data) as T;
    }
    if (t == _i16.SubclassData) {
      return _i16.SubclassData.fromJson(data) as T;
    }
    if (t == _i17.SubclassFeatureData) {
      return _i17.SubclassFeatureData.fromJson(data) as T;
    }
    if (t == _i18.DragonbornAncestryData) {
      return _i18.DragonbornAncestryData.fromJson(data) as T;
    }
    if (t == _i19.RaceChoiceSetData) {
      return _i19.RaceChoiceSetData.fromJson(data) as T;
    }
    if (t == _i20.RaceData) {
      return _i20.RaceData.fromJson(data) as T;
    }
    if (t == _i21.RaceFeatureData) {
      return _i21.RaceFeatureData.fromJson(data) as T;
    }
    if (t == _i22.AuthActionResult) {
      return _i22.AuthActionResult.fromJson(data) as T;
    }
    if (t == _i23.SubraceData) {
      return _i23.SubraceData.fromJson(data) as T;
    }
    if (t == _i24.ArmorData) {
      return _i24.ArmorData.fromJson(data) as T;
    }
    if (t == _i25.ItemData) {
      return _i25.ItemData.fromJson(data) as T;
    }
    if (t == _i26.MagicItemData) {
      return _i26.MagicItemData.fromJson(data) as T;
    }
    if (t == _i27.WeaponData) {
      return _i27.WeaponData.fromJson(data) as T;
    }
    if (t == _i28.SpellClassAvailabilityData) {
      return _i28.SpellClassAvailabilityData.fromJson(data) as T;
    }
    if (t == _i29.SpellData) {
      return _i29.SpellData.fromJson(data) as T;
    }
    if (t == _i30.SpellScalingData) {
      return _i30.SpellScalingData.fromJson(data) as T;
    }
    if (t == _i31.Ability) {
      return _i31.Ability.fromJson(data) as T;
    }
    if (t == _i32.ArmorCategory) {
      return _i32.ArmorCategory.fromJson(data) as T;
    }
    if (t == _i33.CharacterAlignment) {
      return _i33.CharacterAlignment.fromJson(data) as T;
    }
    if (t == _i34.ChoiceSourceType) {
      return _i34.ChoiceSourceType.fromJson(data) as T;
    }
    if (t == _i35.ClassChoiceType) {
      return _i35.ClassChoiceType.fromJson(data) as T;
    }
    if (t == _i36.CreatureSize) {
      return _i36.CreatureSize.fromJson(data) as T;
    }
    if (t == _i37.DamageType) {
      return _i37.DamageType.fromJson(data) as T;
    }
    if (t == _i38.FeatureTag) {
      return _i38.FeatureTag.fromJson(data) as T;
    }
    if (t == _i39.HitPointMode) {
      return _i39.HitPointMode.fromJson(data) as T;
    }
    if (t == _i40.ProficiencyBundleView) {
      return _i40.ProficiencyBundleView.fromJson(data) as T;
    }
    if (t == _i41.RaceChoiceKind) {
      return _i41.RaceChoiceKind.fromJson(data) as T;
    }
    if (t == _i42.RestType) {
      return _i42.RestType.fromJson(data) as T;
    }
    if (t == _i43.Skill) {
      return _i43.Skill.fromJson(data) as T;
    }
    if (t == _i44.AreaOfEffectType) {
      return _i44.AreaOfEffectType.fromJson(data) as T;
    }
    if (t == _i45.ConditionType) {
      return _i45.ConditionType.fromJson(data) as T;
    }
    if (t == _i46.SpellAttackType) {
      return _i46.SpellAttackType.fromJson(data) as T;
    }
    if (t == _i47.SpellDurationType) {
      return _i47.SpellDurationType.fromJson(data) as T;
    }
    if (t == _i48.SpellScalingMode) {
      return _i48.SpellScalingMode.fromJson(data) as T;
    }
    if (t == _i49.SpellSchool) {
      return _i49.SpellSchool.fromJson(data) as T;
    }
    if (t == _i50.SpellTargetType) {
      return _i50.SpellTargetType.fromJson(data) as T;
    }
    if (t == _i51.SpellcastingProgression) {
      return _i51.SpellcastingProgression.fromJson(data) as T;
    }
    if (t == _i52.WeaponCategory) {
      return _i52.WeaponCategory.fromJson(data) as T;
    }
    if (t == _i53.CharacterBuildData) {
      return _i53.CharacterBuildData.fromJson(data) as T;
    }
    if (t == _i54.CharacterSheetView) {
      return _i54.CharacterSheetView.fromJson(data) as T;
    }
    if (t == _i55.ClassChoiceGroupView) {
      return _i55.ClassChoiceGroupView.fromJson(data) as T;
    }
    if (t == _i56.ClassStepSubclassChoiceView) {
      return _i56.ClassStepSubclassChoiceView.fromJson(data) as T;
    }
    if (t == _i57.ClassStepView) {
      return _i57.ClassStepView.fromJson(data) as T;
    }
    if (t == _i58.Language) {
      return _i58.Language.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.RaceFeatureSpellGrantData?>()) {
      return (data != null
          ? _i4.RaceFeatureSpellGrantData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i5.BackgroundData?>()) {
      return (data != null ? _i5.BackgroundData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.FeatData?>()) {
      return (data != null ? _i6.FeatData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.CharacterChoiceData?>()) {
      return (data != null ? _i7.CharacterChoiceData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.CharacterClassEntryData?>()) {
      return (data != null ? _i8.CharacterClassEntryData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.CharacterData?>()) {
      return (data != null ? _i9.CharacterData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.CharacterSheetSnapshotData?>()) {
      return (data != null
          ? _i10.CharacterSheetSnapshotData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i11.ClassChoiceGroupData?>()) {
      return (data != null ? _i11.ClassChoiceGroupData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.ClassChoiceOptionData?>()) {
      return (data != null ? _i12.ClassChoiceOptionData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.ClassData?>()) {
      return (data != null ? _i13.ClassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.ClassFeatureData?>()) {
      return (data != null ? _i14.ClassFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.ClassLevelData?>()) {
      return (data != null ? _i15.ClassLevelData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.SubclassData?>()) {
      return (data != null ? _i16.SubclassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.SubclassFeatureData?>()) {
      return (data != null ? _i17.SubclassFeatureData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.DragonbornAncestryData?>()) {
      return (data != null ? _i18.DragonbornAncestryData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.RaceChoiceSetData?>()) {
      return (data != null ? _i19.RaceChoiceSetData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.RaceData?>()) {
      return (data != null ? _i20.RaceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.RaceFeatureData?>()) {
      return (data != null ? _i21.RaceFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.AuthActionResult?>()) {
      return (data != null ? _i22.AuthActionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.SubraceData?>()) {
      return (data != null ? _i23.SubraceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.ArmorData?>()) {
      return (data != null ? _i24.ArmorData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.ItemData?>()) {
      return (data != null ? _i25.ItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.MagicItemData?>()) {
      return (data != null ? _i26.MagicItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.WeaponData?>()) {
      return (data != null ? _i27.WeaponData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.SpellClassAvailabilityData?>()) {
      return (data != null
          ? _i28.SpellClassAvailabilityData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i29.SpellData?>()) {
      return (data != null ? _i29.SpellData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.SpellScalingData?>()) {
      return (data != null ? _i30.SpellScalingData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.Ability?>()) {
      return (data != null ? _i31.Ability.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.ArmorCategory?>()) {
      return (data != null ? _i32.ArmorCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.CharacterAlignment?>()) {
      return (data != null ? _i33.CharacterAlignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.ChoiceSourceType?>()) {
      return (data != null ? _i34.ChoiceSourceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.ClassChoiceType?>()) {
      return (data != null ? _i35.ClassChoiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.CreatureSize?>()) {
      return (data != null ? _i36.CreatureSize.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.DamageType?>()) {
      return (data != null ? _i37.DamageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.FeatureTag?>()) {
      return (data != null ? _i38.FeatureTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.HitPointMode?>()) {
      return (data != null ? _i39.HitPointMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.ProficiencyBundleView?>()) {
      return (data != null ? _i40.ProficiencyBundleView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.RaceChoiceKind?>()) {
      return (data != null ? _i41.RaceChoiceKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.RestType?>()) {
      return (data != null ? _i42.RestType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.Skill?>()) {
      return (data != null ? _i43.Skill.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.AreaOfEffectType?>()) {
      return (data != null ? _i44.AreaOfEffectType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.ConditionType?>()) {
      return (data != null ? _i45.ConditionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.SpellAttackType?>()) {
      return (data != null ? _i46.SpellAttackType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.SpellDurationType?>()) {
      return (data != null ? _i47.SpellDurationType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.SpellScalingMode?>()) {
      return (data != null ? _i48.SpellScalingMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.SpellSchool?>()) {
      return (data != null ? _i49.SpellSchool.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.SpellTargetType?>()) {
      return (data != null ? _i50.SpellTargetType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.SpellcastingProgression?>()) {
      return (data != null ? _i51.SpellcastingProgression.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i52.WeaponCategory?>()) {
      return (data != null ? _i52.WeaponCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.CharacterBuildData?>()) {
      return (data != null ? _i53.CharacterBuildData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.CharacterSheetView?>()) {
      return (data != null ? _i54.CharacterSheetView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.ClassChoiceGroupView?>()) {
      return (data != null ? _i55.ClassChoiceGroupView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.ClassStepSubclassChoiceView?>()) {
      return (data != null
          ? _i56.ClassStepSubclassChoiceView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i57.ClassStepView?>()) {
      return (data != null ? _i57.ClassStepView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.Language?>()) {
      return (data != null ? _i58.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i38.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i37.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i37.DamageType>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i43.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i43.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i58.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i58.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i32.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i32.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i52.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i38.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i31.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i31.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i32.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i32.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i52.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i43.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i43.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i32.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i32.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i52.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i38.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i38.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<String>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, _i29.SpellData>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<_i29.SpellData>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.RaceChoiceSetData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.RaceChoiceSetData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i38.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.RaceFeatureSpellGrantData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i4.RaceFeatureSpellGrantData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.RaceChoiceSetData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.RaceChoiceSetData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.RaceChoiceSetData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.RaceChoiceSetData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i45.ConditionType>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i45.ConditionType>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i28.SpellClassAvailabilityData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i28.SpellClassAvailabilityData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<int, String>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<String>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<Map<int, String>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<String>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i31.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i43.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i43.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i32.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i32.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i52.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i58.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i58.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i8.CharacterClassEntryData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i8.CharacterClassEntryData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.CharacterChoiceData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i7.CharacterChoiceData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i8.CharacterClassEntryData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i8.CharacterClassEntryData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.CharacterChoiceData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i7.CharacterChoiceData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.ClassChoiceOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i12.ClassChoiceOptionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.SubclassData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.SubclassData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i14.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i14.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i55.ClassChoiceGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i55.ClassChoiceGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.ClassLevelData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.ClassLevelData>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i3.UserInfo>) {
      return (data as List).map((e) => deserialize<_i3.UserInfo>(e)).toList()
          as T;
    }
    if (t == List<_i59.BackgroundData>) {
      return (data as List)
          .map((e) => deserialize<_i59.BackgroundData>(e))
          .toList() as T;
    }
    if (t == List<_i60.FeatData>) {
      return (data as List).map((e) => deserialize<_i60.FeatData>(e)).toList()
          as T;
    }
    if (t == List<_i61.CharacterData>) {
      return (data as List)
          .map((e) => deserialize<_i61.CharacterData>(e))
          .toList() as T;
    }
    if (t == List<_i62.ClassData>) {
      return (data as List).map((e) => deserialize<_i62.ClassData>(e)).toList()
          as T;
    }
    if (t == List<_i63.ClassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i63.ClassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i64.ClassLevelData>) {
      return (data as List)
          .map((e) => deserialize<_i64.ClassLevelData>(e))
          .toList() as T;
    }
    if (t == List<_i65.SubclassData>) {
      return (data as List)
          .map((e) => deserialize<_i65.SubclassData>(e))
          .toList() as T;
    }
    if (t == List<_i66.ClassChoiceGroupData>) {
      return (data as List)
          .map((e) => deserialize<_i66.ClassChoiceGroupData>(e))
          .toList() as T;
    }
    if (t == List<_i67.ClassChoiceOptionData>) {
      return (data as List)
          .map((e) => deserialize<_i67.ClassChoiceOptionData>(e))
          .toList() as T;
    }
    if (t == List<_i68.SubclassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i68.SubclassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i69.RaceData>) {
      return (data as List).map((e) => deserialize<_i69.RaceData>(e)).toList()
          as T;
    }
    if (t == List<_i70.RaceFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i70.RaceFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i71.SubraceData>) {
      return (data as List)
          .map((e) => deserialize<_i71.SubraceData>(e))
          .toList() as T;
    }
    if (t == List<_i72.DragonbornAncestryData>) {
      return (data as List)
          .map((e) => deserialize<_i72.DragonbornAncestryData>(e))
          .toList() as T;
    }
    if (t == List<_i73.RaceChoiceSetData>) {
      return (data as List)
          .map((e) => deserialize<_i73.RaceChoiceSetData>(e))
          .toList() as T;
    }
    if (t == List<_i74.RaceFeatureSpellGrantData>) {
      return (data as List)
          .map((e) => deserialize<_i74.RaceFeatureSpellGrantData>(e))
          .toList() as T;
    }
    if (t == List<_i75.ArmorData>) {
      return (data as List).map((e) => deserialize<_i75.ArmorData>(e)).toList()
          as T;
    }
    if (t == List<_i76.ItemData>) {
      return (data as List).map((e) => deserialize<_i76.ItemData>(e)).toList()
          as T;
    }
    if (t == List<_i77.MagicItemData>) {
      return (data as List)
          .map((e) => deserialize<_i77.MagicItemData>(e))
          .toList() as T;
    }
    if (t == List<_i78.WeaponData>) {
      return (data as List).map((e) => deserialize<_i78.WeaponData>(e)).toList()
          as T;
    }
    if (t == List<_i79.SpellData>) {
      return (data as List).map((e) => deserialize<_i79.SpellData>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i4.RaceFeatureSpellGrantData) {
      return 'RaceFeatureSpellGrantData';
    }
    if (data is _i5.BackgroundData) {
      return 'BackgroundData';
    }
    if (data is _i6.FeatData) {
      return 'FeatData';
    }
    if (data is _i7.CharacterChoiceData) {
      return 'CharacterChoiceData';
    }
    if (data is _i8.CharacterClassEntryData) {
      return 'CharacterClassEntryData';
    }
    if (data is _i9.CharacterData) {
      return 'CharacterData';
    }
    if (data is _i10.CharacterSheetSnapshotData) {
      return 'CharacterSheetSnapshotData';
    }
    if (data is _i11.ClassChoiceGroupData) {
      return 'ClassChoiceGroupData';
    }
    if (data is _i12.ClassChoiceOptionData) {
      return 'ClassChoiceOptionData';
    }
    if (data is _i13.ClassData) {
      return 'ClassData';
    }
    if (data is _i14.ClassFeatureData) {
      return 'ClassFeatureData';
    }
    if (data is _i15.ClassLevelData) {
      return 'ClassLevelData';
    }
    if (data is _i16.SubclassData) {
      return 'SubclassData';
    }
    if (data is _i17.SubclassFeatureData) {
      return 'SubclassFeatureData';
    }
    if (data is _i18.DragonbornAncestryData) {
      return 'DragonbornAncestryData';
    }
    if (data is _i19.RaceChoiceSetData) {
      return 'RaceChoiceSetData';
    }
    if (data is _i20.RaceData) {
      return 'RaceData';
    }
    if (data is _i21.RaceFeatureData) {
      return 'RaceFeatureData';
    }
    if (data is _i22.AuthActionResult) {
      return 'AuthActionResult';
    }
    if (data is _i23.SubraceData) {
      return 'SubraceData';
    }
    if (data is _i24.ArmorData) {
      return 'ArmorData';
    }
    if (data is _i25.ItemData) {
      return 'ItemData';
    }
    if (data is _i26.MagicItemData) {
      return 'MagicItemData';
    }
    if (data is _i27.WeaponData) {
      return 'WeaponData';
    }
    if (data is _i28.SpellClassAvailabilityData) {
      return 'SpellClassAvailabilityData';
    }
    if (data is _i29.SpellData) {
      return 'SpellData';
    }
    if (data is _i30.SpellScalingData) {
      return 'SpellScalingData';
    }
    if (data is _i31.Ability) {
      return 'Ability';
    }
    if (data is _i32.ArmorCategory) {
      return 'ArmorCategory';
    }
    if (data is _i33.CharacterAlignment) {
      return 'CharacterAlignment';
    }
    if (data is _i34.ChoiceSourceType) {
      return 'ChoiceSourceType';
    }
    if (data is _i35.ClassChoiceType) {
      return 'ClassChoiceType';
    }
    if (data is _i36.CreatureSize) {
      return 'CreatureSize';
    }
    if (data is _i37.DamageType) {
      return 'DamageType';
    }
    if (data is _i38.FeatureTag) {
      return 'FeatureTag';
    }
    if (data is _i39.HitPointMode) {
      return 'HitPointMode';
    }
    if (data is _i40.ProficiencyBundleView) {
      return 'ProficiencyBundleView';
    }
    if (data is _i41.RaceChoiceKind) {
      return 'RaceChoiceKind';
    }
    if (data is _i42.RestType) {
      return 'RestType';
    }
    if (data is _i43.Skill) {
      return 'Skill';
    }
    if (data is _i44.AreaOfEffectType) {
      return 'AreaOfEffectType';
    }
    if (data is _i45.ConditionType) {
      return 'ConditionType';
    }
    if (data is _i46.SpellAttackType) {
      return 'SpellAttackType';
    }
    if (data is _i47.SpellDurationType) {
      return 'SpellDurationType';
    }
    if (data is _i48.SpellScalingMode) {
      return 'SpellScalingMode';
    }
    if (data is _i49.SpellSchool) {
      return 'SpellSchool';
    }
    if (data is _i50.SpellTargetType) {
      return 'SpellTargetType';
    }
    if (data is _i51.SpellcastingProgression) {
      return 'SpellcastingProgression';
    }
    if (data is _i52.WeaponCategory) {
      return 'WeaponCategory';
    }
    if (data is _i53.CharacterBuildData) {
      return 'CharacterBuildData';
    }
    if (data is _i54.CharacterSheetView) {
      return 'CharacterSheetView';
    }
    if (data is _i55.ClassChoiceGroupView) {
      return 'ClassChoiceGroupView';
    }
    if (data is _i56.ClassStepSubclassChoiceView) {
      return 'ClassStepSubclassChoiceView';
    }
    if (data is _i57.ClassStepView) {
      return 'ClassStepView';
    }
    if (data is _i58.Language) {
      return 'Language';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'RaceFeatureSpellGrantData') {
      return deserialize<_i4.RaceFeatureSpellGrantData>(data['data']);
    }
    if (dataClassName == 'BackgroundData') {
      return deserialize<_i5.BackgroundData>(data['data']);
    }
    if (dataClassName == 'FeatData') {
      return deserialize<_i6.FeatData>(data['data']);
    }
    if (dataClassName == 'CharacterChoiceData') {
      return deserialize<_i7.CharacterChoiceData>(data['data']);
    }
    if (dataClassName == 'CharacterClassEntryData') {
      return deserialize<_i8.CharacterClassEntryData>(data['data']);
    }
    if (dataClassName == 'CharacterData') {
      return deserialize<_i9.CharacterData>(data['data']);
    }
    if (dataClassName == 'CharacterSheetSnapshotData') {
      return deserialize<_i10.CharacterSheetSnapshotData>(data['data']);
    }
    if (dataClassName == 'ClassChoiceGroupData') {
      return deserialize<_i11.ClassChoiceGroupData>(data['data']);
    }
    if (dataClassName == 'ClassChoiceOptionData') {
      return deserialize<_i12.ClassChoiceOptionData>(data['data']);
    }
    if (dataClassName == 'ClassData') {
      return deserialize<_i13.ClassData>(data['data']);
    }
    if (dataClassName == 'ClassFeatureData') {
      return deserialize<_i14.ClassFeatureData>(data['data']);
    }
    if (dataClassName == 'ClassLevelData') {
      return deserialize<_i15.ClassLevelData>(data['data']);
    }
    if (dataClassName == 'SubclassData') {
      return deserialize<_i16.SubclassData>(data['data']);
    }
    if (dataClassName == 'SubclassFeatureData') {
      return deserialize<_i17.SubclassFeatureData>(data['data']);
    }
    if (dataClassName == 'DragonbornAncestryData') {
      return deserialize<_i18.DragonbornAncestryData>(data['data']);
    }
    if (dataClassName == 'RaceChoiceSetData') {
      return deserialize<_i19.RaceChoiceSetData>(data['data']);
    }
    if (dataClassName == 'RaceData') {
      return deserialize<_i20.RaceData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureData') {
      return deserialize<_i21.RaceFeatureData>(data['data']);
    }
    if (dataClassName == 'AuthActionResult') {
      return deserialize<_i22.AuthActionResult>(data['data']);
    }
    if (dataClassName == 'SubraceData') {
      return deserialize<_i23.SubraceData>(data['data']);
    }
    if (dataClassName == 'ArmorData') {
      return deserialize<_i24.ArmorData>(data['data']);
    }
    if (dataClassName == 'ItemData') {
      return deserialize<_i25.ItemData>(data['data']);
    }
    if (dataClassName == 'MagicItemData') {
      return deserialize<_i26.MagicItemData>(data['data']);
    }
    if (dataClassName == 'WeaponData') {
      return deserialize<_i27.WeaponData>(data['data']);
    }
    if (dataClassName == 'SpellClassAvailabilityData') {
      return deserialize<_i28.SpellClassAvailabilityData>(data['data']);
    }
    if (dataClassName == 'SpellData') {
      return deserialize<_i29.SpellData>(data['data']);
    }
    if (dataClassName == 'SpellScalingData') {
      return deserialize<_i30.SpellScalingData>(data['data']);
    }
    if (dataClassName == 'Ability') {
      return deserialize<_i31.Ability>(data['data']);
    }
    if (dataClassName == 'ArmorCategory') {
      return deserialize<_i32.ArmorCategory>(data['data']);
    }
    if (dataClassName == 'CharacterAlignment') {
      return deserialize<_i33.CharacterAlignment>(data['data']);
    }
    if (dataClassName == 'ChoiceSourceType') {
      return deserialize<_i34.ChoiceSourceType>(data['data']);
    }
    if (dataClassName == 'ClassChoiceType') {
      return deserialize<_i35.ClassChoiceType>(data['data']);
    }
    if (dataClassName == 'CreatureSize') {
      return deserialize<_i36.CreatureSize>(data['data']);
    }
    if (dataClassName == 'DamageType') {
      return deserialize<_i37.DamageType>(data['data']);
    }
    if (dataClassName == 'FeatureTag') {
      return deserialize<_i38.FeatureTag>(data['data']);
    }
    if (dataClassName == 'HitPointMode') {
      return deserialize<_i39.HitPointMode>(data['data']);
    }
    if (dataClassName == 'ProficiencyBundleView') {
      return deserialize<_i40.ProficiencyBundleView>(data['data']);
    }
    if (dataClassName == 'RaceChoiceKind') {
      return deserialize<_i41.RaceChoiceKind>(data['data']);
    }
    if (dataClassName == 'RestType') {
      return deserialize<_i42.RestType>(data['data']);
    }
    if (dataClassName == 'Skill') {
      return deserialize<_i43.Skill>(data['data']);
    }
    if (dataClassName == 'AreaOfEffectType') {
      return deserialize<_i44.AreaOfEffectType>(data['data']);
    }
    if (dataClassName == 'ConditionType') {
      return deserialize<_i45.ConditionType>(data['data']);
    }
    if (dataClassName == 'SpellAttackType') {
      return deserialize<_i46.SpellAttackType>(data['data']);
    }
    if (dataClassName == 'SpellDurationType') {
      return deserialize<_i47.SpellDurationType>(data['data']);
    }
    if (dataClassName == 'SpellScalingMode') {
      return deserialize<_i48.SpellScalingMode>(data['data']);
    }
    if (dataClassName == 'SpellSchool') {
      return deserialize<_i49.SpellSchool>(data['data']);
    }
    if (dataClassName == 'SpellTargetType') {
      return deserialize<_i50.SpellTargetType>(data['data']);
    }
    if (dataClassName == 'SpellcastingProgression') {
      return deserialize<_i51.SpellcastingProgression>(data['data']);
    }
    if (dataClassName == 'WeaponCategory') {
      return deserialize<_i52.WeaponCategory>(data['data']);
    }
    if (dataClassName == 'CharacterBuildData') {
      return deserialize<_i53.CharacterBuildData>(data['data']);
    }
    if (dataClassName == 'CharacterSheetView') {
      return deserialize<_i54.CharacterSheetView>(data['data']);
    }
    if (dataClassName == 'ClassChoiceGroupView') {
      return deserialize<_i55.ClassChoiceGroupView>(data['data']);
    }
    if (dataClassName == 'ClassStepSubclassChoiceView') {
      return deserialize<_i56.ClassStepSubclassChoiceView>(data['data']);
    }
    if (dataClassName == 'ClassStepView') {
      return deserialize<_i57.ClassStepView>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i58.Language>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.BackgroundData:
        return _i5.BackgroundData.t;
      case _i6.FeatData:
        return _i6.FeatData.t;
      case _i7.CharacterChoiceData:
        return _i7.CharacterChoiceData.t;
      case _i8.CharacterClassEntryData:
        return _i8.CharacterClassEntryData.t;
      case _i9.CharacterData:
        return _i9.CharacterData.t;
      case _i10.CharacterSheetSnapshotData:
        return _i10.CharacterSheetSnapshotData.t;
      case _i11.ClassChoiceGroupData:
        return _i11.ClassChoiceGroupData.t;
      case _i12.ClassChoiceOptionData:
        return _i12.ClassChoiceOptionData.t;
      case _i13.ClassData:
        return _i13.ClassData.t;
      case _i14.ClassFeatureData:
        return _i14.ClassFeatureData.t;
      case _i15.ClassLevelData:
        return _i15.ClassLevelData.t;
      case _i16.SubclassData:
        return _i16.SubclassData.t;
      case _i17.SubclassFeatureData:
        return _i17.SubclassFeatureData.t;
      case _i18.DragonbornAncestryData:
        return _i18.DragonbornAncestryData.t;
      case _i19.RaceChoiceSetData:
        return _i19.RaceChoiceSetData.t;
      case _i20.RaceData:
        return _i20.RaceData.t;
      case _i21.RaceFeatureData:
        return _i21.RaceFeatureData.t;
      case _i4.RaceFeatureSpellGrantData:
        return _i4.RaceFeatureSpellGrantData.t;
      case _i23.SubraceData:
        return _i23.SubraceData.t;
      case _i24.ArmorData:
        return _i24.ArmorData.t;
      case _i25.ItemData:
        return _i25.ItemData.t;
      case _i26.MagicItemData:
        return _i26.MagicItemData.t;
      case _i27.WeaponData:
        return _i27.WeaponData.t;
      case _i28.SpellClassAvailabilityData:
        return _i28.SpellClassAvailabilityData.t;
      case _i29.SpellData:
        return _i29.SpellData.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'characters_mirror';
}
