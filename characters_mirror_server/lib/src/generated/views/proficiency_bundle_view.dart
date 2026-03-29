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
import '../enums/ability.dart' as _i2;
import '../enums/skill.dart' as _i3;
import '../enums/armor_category.dart' as _i4;
import '../enums/weapon_category.dart' as _i5;
import '../enums/language.dart' as _i6;

abstract class ProficiencyBundleView
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ProficiencyBundleView._({
    this.savingThrows,
    this.skills,
    this.armorTraining,
    this.weaponTraining,
    this.toolKeys,
    this.languageChoices,
  });

  factory ProficiencyBundleView({
    List<_i2.Ability>? savingThrows,
    List<_i3.Skill>? skills,
    List<_i4.ArmorCategory>? armorTraining,
    List<_i5.WeaponCategory>? weaponTraining,
    List<String>? toolKeys,
    List<_i6.Language>? languageChoices,
  }) = _ProficiencyBundleViewImpl;

  factory ProficiencyBundleView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ProficiencyBundleView(
      savingThrows: (jsonSerialization['savingThrows'] as List?)
          ?.map((e) => _i2.Ability.fromJson((e as String)))
          .toList(),
      skills: (jsonSerialization['skills'] as List?)
          ?.map((e) => _i3.Skill.fromJson((e as String)))
          .toList(),
      armorTraining: (jsonSerialization['armorTraining'] as List?)
          ?.map((e) => _i4.ArmorCategory.fromJson((e as String)))
          .toList(),
      weaponTraining: (jsonSerialization['weaponTraining'] as List?)
          ?.map((e) => _i5.WeaponCategory.fromJson((e as String)))
          .toList(),
      toolKeys: (jsonSerialization['toolKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      languageChoices: (jsonSerialization['languageChoices'] as List?)
          ?.map((e) => _i6.Language.fromJson((e as String)))
          .toList(),
    );
  }

  List<_i2.Ability>? savingThrows;

  List<_i3.Skill>? skills;

  List<_i4.ArmorCategory>? armorTraining;

  List<_i5.WeaponCategory>? weaponTraining;

  List<String>? toolKeys;

  List<_i6.Language>? languageChoices;

  /// Returns a shallow copy of this [ProficiencyBundleView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProficiencyBundleView copyWith({
    List<_i2.Ability>? savingThrows,
    List<_i3.Skill>? skills,
    List<_i4.ArmorCategory>? armorTraining,
    List<_i5.WeaponCategory>? weaponTraining,
    List<String>? toolKeys,
    List<_i6.Language>? languageChoices,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (savingThrows != null)
        'savingThrows': savingThrows?.toJson(valueToJson: (v) => v.toJson()),
      if (skills != null)
        'skills': skills?.toJson(valueToJson: (v) => v.toJson()),
      if (armorTraining != null)
        'armorTraining': armorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (weaponTraining != null)
        'weaponTraining':
            weaponTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (toolKeys != null) 'toolKeys': toolKeys?.toJson(),
      if (languageChoices != null)
        'languageChoices':
            languageChoices?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (savingThrows != null)
        'savingThrows': savingThrows?.toJson(valueToJson: (v) => v.toJson()),
      if (skills != null)
        'skills': skills?.toJson(valueToJson: (v) => v.toJson()),
      if (armorTraining != null)
        'armorTraining': armorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (weaponTraining != null)
        'weaponTraining':
            weaponTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (toolKeys != null) 'toolKeys': toolKeys?.toJson(),
      if (languageChoices != null)
        'languageChoices':
            languageChoices?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProficiencyBundleViewImpl extends ProficiencyBundleView {
  _ProficiencyBundleViewImpl({
    List<_i2.Ability>? savingThrows,
    List<_i3.Skill>? skills,
    List<_i4.ArmorCategory>? armorTraining,
    List<_i5.WeaponCategory>? weaponTraining,
    List<String>? toolKeys,
    List<_i6.Language>? languageChoices,
  }) : super._(
          savingThrows: savingThrows,
          skills: skills,
          armorTraining: armorTraining,
          weaponTraining: weaponTraining,
          toolKeys: toolKeys,
          languageChoices: languageChoices,
        );

  /// Returns a shallow copy of this [ProficiencyBundleView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProficiencyBundleView copyWith({
    Object? savingThrows = _Undefined,
    Object? skills = _Undefined,
    Object? armorTraining = _Undefined,
    Object? weaponTraining = _Undefined,
    Object? toolKeys = _Undefined,
    Object? languageChoices = _Undefined,
  }) {
    return ProficiencyBundleView(
      savingThrows: savingThrows is List<_i2.Ability>?
          ? savingThrows
          : this.savingThrows?.map((e0) => e0).toList(),
      skills: skills is List<_i3.Skill>?
          ? skills
          : this.skills?.map((e0) => e0).toList(),
      armorTraining: armorTraining is List<_i4.ArmorCategory>?
          ? armorTraining
          : this.armorTraining?.map((e0) => e0).toList(),
      weaponTraining: weaponTraining is List<_i5.WeaponCategory>?
          ? weaponTraining
          : this.weaponTraining?.map((e0) => e0).toList(),
      toolKeys: toolKeys is List<String>?
          ? toolKeys
          : this.toolKeys?.map((e0) => e0).toList(),
      languageChoices: languageChoices is List<_i6.Language>?
          ? languageChoices
          : this.languageChoices?.map((e0) => e0).toList(),
    );
  }
}
