import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/level_up_gateway.dart';
import 'level_up_choices.dart';
import 'level_up_optimistic_preview.dart';

class LevelUpFlowState {
  LevelUpFlowState(
      {required this.request,
      this.preview,
      this.busy = false,
      this.error,
      this.previewCurrent = false,
      this.asi = const {}});
  final LevelUpRequest request;
  final LevelUpPreview? preview;
  final bool busy;
  final Object? error;
  final bool previewCurrent;
  final Map<String, Map<Ability, int>> asi;
  bool get canApply =>
      !busy &&
      previewCurrent &&
      preview != null &&
      preview!.missingDecisions.isEmpty;
}

class LevelUpController extends StateNotifier<LevelUpFlowState> {
  LevelUpController(this.gateway, LevelUpRequest request)
      : super(LevelUpFlowState(request: request));
  final LevelUpGateway gateway;
  int _revision = 0;
  bool _disposed = false;
  bool _applying = false;
  LevelUpPreview? _confirmedPreview;
  LevelUpRequest? _confirmedRequest;

  Future<void> refresh() async {
    if (_applying) return;
    final revision = ++_revision;
    final request = state.request;
    state = LevelUpFlowState(
        request: state.request,
        preview: state.preview,
        busy: state.preview == null,
        asi: state.asi);
    try {
      final preview = await gateway.preview(request);
      if (_disposed || revision != _revision) return;
      _confirmedPreview = preview;
      _confirmedRequest = request;
      state = LevelUpFlowState(
          request: state.request,
          preview: preview,
          previewCurrent: true,
          asi: state.asi);
    } catch (error) {
      if (_disposed || revision != _revision) return;
      state = LevelUpFlowState(
          request: state.request,
          preview: state.preview,
          error: error,
          asi: state.asi);
    }
  }

  Future<void> _change(LevelUpRequest request,
      {Map<String, Map<Ability, int>>? asi}) {
    if (_applying) return Future.value();
    final preview = _confirmedPreview == null
        ? state.preview
        : optimisticLevelUpPreview(
            _confirmedPreview!, _confirmedRequest!, request);
    state = LevelUpFlowState(
        request: request, preview: preview, asi: asi ?? state.asi);
    return refresh();
  }

  Future<void> replaceChoice(LevelUpChoiceReplacementData replacement) =>
      _change(state.request.copyWith(choiceReplacements: [
        for (final row in state.request.choiceReplacements ??
            <LevelUpChoiceReplacementData>[])
          if (row.selectionId != replacement.selectionId) row,
        replacement,
      ]));

  Future<void> clearChoiceReplacement(String id) =>
      _change(state.request.copyWith(choiceReplacements: [
        for (final row in state.request.choiceReplacements ??
            <LevelUpChoiceReplacementData>[])
          if (row.selectionId != id) row
      ]));

  Future<void> setRoll(int? roll) =>
      _change(state.request.copyWith(hitDieRoll: roll));

  Future<void> chooseSubclass(int id) {
    if (state.request.subclassId == id) return Future.value();
    final preview = state.preview!;
    final subclassKeys = {
      for (final g in preview.choiceGroups)
        if (g.group!.sourceSubclassId != null ||
            g.group!.sourceSubclassFeatureId != null)
          g.group!.referenceKey
    };
    final choices = {
      for (final e in state.request.choices?.entries ??
          const <MapEntry<String, List<String>>>[])
        if (!subclassKeys.contains(e.key)) e.key: e.value
    };
    final classId = preview.classStep.classData?.id;
    final classSpellIds = {
      for (final group in preview.classStep.spellSelectionGroups ??
          const <ClassSpellSelectionGroupView>[])
        for (final spell in group.options ?? const <SpellData>[])
          if (spell.availableForClassIds?.contains(classId) == true) spell.id
    };
    final spells = [
      for (final s in state.request.spells ?? const <LevelUpSpellChoice>[])
        if (classSpellIds.contains(s.spellId)) s
    ];
    return _change(
        state.request
            .copyWith(subclassId: id, choices: choices, spells: spells),
        asi: {
          for (final e in state.asi.entries)
            if (!subclassKeys.contains(e.key)) e.key: e.value
        });
  }

  Future<void> choose(String groupKey, List<String> keys) {
    final choices = {...?state.request.choices};
    final group = state.preview!.choiceGroups
        .firstWhere((g) => g.group!.referenceKey == groupKey)
        .group!;
    if (keys.isNotEmpty && group.exclusiveKey != null) {
      for (final other in state.preview!.choiceGroups) {
        if (other.group!.exclusiveKey == group.exclusiveKey) {
          choices.remove(other.group!.referenceKey);
        }
      }
    }
    choices[groupKey] = keys;
    final asi = {...state.asi};
    if (group.type == ChoiceType.feat && keys.isNotEmpty) {
      for (final other in state.preview!.choiceGroups) {
        if (other.group!.exclusiveKey == group.exclusiveKey) {
          asi.remove(other.group!.referenceKey);
        }
      }
    }
    return _change(state.request.copyWith(choices: choices), asi: asi);
  }

  Future<void> cycleAbility(String groupKey, Ability ability) {
    final preview = state.preview!;
    final group = preview.choiceGroups
        .firstWhere((g) => g.group!.referenceKey == groupKey);
    final allocation = cycleAsi(state.asi[groupKey] ?? {}, ability,
        preview.before.derived?.abilityScores ?? {});
    final keys = asiOptionKeys(group, allocation);
    final choices = {...?state.request.choices};
    if (group.group!.exclusiveKey != null && allocation.isNotEmpty) {
      for (final other in preview.choiceGroups) {
        if (other.group!.exclusiveKey == group.group!.exclusiveKey) {
          choices.remove(other.group!.referenceKey);
        }
      }
    }
    choices[groupKey] = keys ?? [];
    return _change(state.request.copyWith(choices: choices),
        asi: {...state.asi, groupKey: allocation});
  }

  Future<void> chooseSpells(CharacterSpellSelectionKind kind, List<int> ids,
      {String? replacesSelectionId}) {
    final spells = [
      for (final s in state.request.spells ?? const <LevelUpSpellChoice>[])
        if (replacesSelectionId != null
            ? s.replacesSelectionId != replacesSelectionId
            : s.kind != kind || s.replacesSelectionId != null)
          s,
      for (final id in ids)
        LevelUpSpellChoice(
            spellId: id, kind: kind, replacesSelectionId: replacesSelectionId)
    ];
    return _change(state.request.copyWith(spells: spells));
  }

  Future<CharacterData?> apply() async {
    if (!state.canApply) return null;
    _applying = true;
    state = LevelUpFlowState(
        request: state.request,
        preview: state.preview,
        busy: true,
        previewCurrent: true,
        asi: state.asi);
    try {
      final result = await gateway.apply(state.request);
      if (!_disposed) {
        state = LevelUpFlowState(
            request: state.request, preview: state.preview, asi: state.asi);
      }
      return result;
    } catch (error) {
      if (!_disposed) {
        state = LevelUpFlowState(
            request: state.request,
            preview: state.preview,
            error: error,
            previewCurrent: true,
            asi: state.asi);
      }
      return null;
    } finally {
      _applying = false;
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _revision++;
    super.dispose();
  }
}
