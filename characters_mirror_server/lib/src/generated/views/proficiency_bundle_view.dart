/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../enums/ability.dart' as _i26h74c2;
import '../enums/armor_category.dart' as _iiuv7335;
import '../enums/language.dart' as _icxu1xck;
import '../enums/skill.dart' as _ic5go03x;
import '../enums/weapon_category.dart' as _i2jqpeh4;

abstract class ProficiencyBundleView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ProficiencyBundleView._({
    this.savingThrows,
    this.skills,
    this.armorTraining,
    this.weaponTraining,
    this.weaponProficiencyKeys,
    this.toolKeys,
    this.languageChoices,
  });

  factory ProficiencyBundleView({
    List<_i26h74c2.Ability>? savingThrows,
    List<_ic5go03x.Skill>? skills,
    List<_iiuv7335.ArmorCategory>? armorTraining,
    List<_i2jqpeh4.WeaponCategory>? weaponTraining,
    List<String>? weaponProficiencyKeys,
    List<String>? toolKeys,
    List<_icxu1xck.Language>? languageChoices,
  }) = _ProficiencyBundleViewImpl;

  factory ProficiencyBundleView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ProficiencyBundleView(
      savingThrows: jsonSerialization['savingThrows'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_i26h74c2.Ability>>(
              jsonSerialization['savingThrows'],
            ),
      skills: jsonSerialization['skills'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ic5go03x.Skill>>(
              jsonSerialization['skills'],
            ),
      armorTraining: jsonSerialization['armorTraining'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iiuv7335.ArmorCategory>>(
              jsonSerialization['armorTraining'],
            ),
      weaponTraining: jsonSerialization['weaponTraining'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_i2jqpeh4.WeaponCategory>>(
              jsonSerialization['weaponTraining'],
            ),
      weaponProficiencyKeys: jsonSerialization['weaponProficiencyKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['weaponProficiencyKeys'],
            ),
      toolKeys: jsonSerialization['toolKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['toolKeys'],
            ),
      languageChoices: jsonSerialization['languageChoices'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_icxu1xck.Language>>(
              jsonSerialization['languageChoices'],
            ),
    );
  }

  List<_i26h74c2.Ability>? savingThrows;

  List<_ic5go03x.Skill>? skills;

  List<_iiuv7335.ArmorCategory>? armorTraining;

  List<_i2jqpeh4.WeaponCategory>? weaponTraining;

  List<String>? weaponProficiencyKeys;

  List<String>? toolKeys;

  List<_icxu1xck.Language>? languageChoices;

  /// Returns a shallow copy of this [ProficiencyBundleView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProficiencyBundleView copyWith({
    List<_i26h74c2.Ability>? savingThrows,
    List<_ic5go03x.Skill>? skills,
    List<_iiuv7335.ArmorCategory>? armorTraining,
    List<_i2jqpeh4.WeaponCategory>? weaponTraining,
    List<String>? weaponProficiencyKeys,
    List<String>? toolKeys,
    List<_icxu1xck.Language>? languageChoices,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProficiencyBundleView',
      if (savingThrows != null)
        'savingThrows': savingThrows?.toJson(valueToJson: (v) => v.toJson()),
      if (skills != null)
        'skills': skills?.toJson(valueToJson: (v) => v.toJson()),
      if (armorTraining != null)
        'armorTraining': armorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (weaponTraining != null)
        'weaponTraining': weaponTraining?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (weaponProficiencyKeys != null)
        'weaponProficiencyKeys': weaponProficiencyKeys?.toJson(),
      if (toolKeys != null) 'toolKeys': toolKeys?.toJson(),
      if (languageChoices != null)
        'languageChoices': languageChoices?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProficiencyBundleView',
      if (savingThrows != null)
        'savingThrows': savingThrows?.toJson(valueToJson: (v) => v.toJson()),
      if (skills != null)
        'skills': skills?.toJson(valueToJson: (v) => v.toJson()),
      if (armorTraining != null)
        'armorTraining': armorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (weaponTraining != null)
        'weaponTraining': weaponTraining?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (weaponProficiencyKeys != null)
        'weaponProficiencyKeys': weaponProficiencyKeys?.toJson(),
      if (toolKeys != null) 'toolKeys': toolKeys?.toJson(),
      if (languageChoices != null)
        'languageChoices': languageChoices?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProficiencyBundleViewImpl extends ProficiencyBundleView {
  _ProficiencyBundleViewImpl({
    List<_i26h74c2.Ability>? savingThrows,
    List<_ic5go03x.Skill>? skills,
    List<_iiuv7335.ArmorCategory>? armorTraining,
    List<_i2jqpeh4.WeaponCategory>? weaponTraining,
    List<String>? weaponProficiencyKeys,
    List<String>? toolKeys,
    List<_icxu1xck.Language>? languageChoices,
  }) : super._(
         savingThrows: savingThrows,
         skills: skills,
         armorTraining: armorTraining,
         weaponTraining: weaponTraining,
         weaponProficiencyKeys: weaponProficiencyKeys,
         toolKeys: toolKeys,
         languageChoices: languageChoices,
       );

  /// Returns a shallow copy of this [ProficiencyBundleView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProficiencyBundleView copyWith({
    Object? savingThrows = _Undefined,
    Object? skills = _Undefined,
    Object? armorTraining = _Undefined,
    Object? weaponTraining = _Undefined,
    Object? weaponProficiencyKeys = _Undefined,
    Object? toolKeys = _Undefined,
    Object? languageChoices = _Undefined,
  }) {
    return ProficiencyBundleView(
      savingThrows: savingThrows is List<_i26h74c2.Ability>?
          ? savingThrows
          : this.savingThrows?.map((e0) => e0).toList(),
      skills: skills is List<_ic5go03x.Skill>?
          ? skills
          : this.skills?.map((e0) => e0).toList(),
      armorTraining: armorTraining is List<_iiuv7335.ArmorCategory>?
          ? armorTraining
          : this.armorTraining?.map((e0) => e0).toList(),
      weaponTraining: weaponTraining is List<_i2jqpeh4.WeaponCategory>?
          ? weaponTraining
          : this.weaponTraining?.map((e0) => e0).toList(),
      weaponProficiencyKeys: weaponProficiencyKeys is List<String>?
          ? weaponProficiencyKeys
          : this.weaponProficiencyKeys?.map((e0) => e0).toList(),
      toolKeys: toolKeys is List<String>?
          ? toolKeys
          : this.toolKeys?.map((e0) => e0).toList(),
      languageChoices: languageChoices is List<_icxu1xck.Language>?
          ? languageChoices
          : this.languageChoices?.map((e0) => e0).toList(),
    );
  }
}
