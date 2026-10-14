import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/dungeon_master.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/dm_creature_file_picker.dart';
import '../data/dm_creature_repository.dart';
import 'dm_import_report.dart';

final dmLibraryProvider =
    StateNotifierProvider.autoDispose<DmLibraryController, DmLibraryState>(
        (ref) => DmLibraryController(ref.watch(dmCreatureRepositoryProvider),
            ref.watch(dmCreatureFilePickerProvider)));

final dmCreatureDetailProvider =
    FutureProvider.autoDispose.family<DmCreatureDetail, int>((ref, id) async {
  final record = await ref.watch(dmCreatureRepositoryProvider).get(id);
  return DmCreatureDetail(
      record, NormalizedCreature.decode(record.normalizedJson));
});

class DmCreatureDetail {
  DmCreatureDetail(this.record, this.creature);
  final DmCreatureRecord record;
  final NormalizedCreature creature;
}

class DmLibraryState {
  const DmLibraryState(
      {this.creatures = const AsyncLoading(),
      this.busy = false,
      this.importProgress});
  final AsyncValue<List<DmCreatureSummary>> creatures;
  final bool busy;
  final DmImportProgress? importProgress;
}

class DmActionResult {
  const DmActionResult(
      {required this.success,
      this.message,
      this.creatureId,
      this.importReport});
  final bool success;
  final String? message;
  final int? creatureId;
  final DmImportReport? importReport;
  static const cancelled = DmActionResult(success: false);
}

class DmLibraryController extends StateNotifier<DmLibraryState> {
  DmLibraryController(this._repository, this._picker)
      : super(const DmLibraryState()) {
    unawaited(reload());
  }
  final DmCreatureRepository _repository;
  final DmCreatureFilePicker _picker;
  int _loadVersion = 0;

  Future<void> reload() async {
    final version = ++_loadVersion;
    if (!state.creatures.hasValue) {
      state = DmLibraryState(
          busy: state.busy, importProgress: state.importProgress);
    }
    final loaded = await AsyncValue.guard(_repository.list);
    if (mounted && version == _loadVersion) {
      state = DmLibraryState(
          creatures: loaded,
          busy: state.busy,
          importProgress: state.importProgress);
    }
  }

  Future<DmActionResult> importFile() async {
    if (state.busy) return DmActionResult.cancelled;
    state = DmLibraryState(creatures: state.creatures, busy: true);
    try {
      final files = await _picker.pickJsonFiles();
      if (!mounted || files.isEmpty) return DmActionResult.cancelled;
      final results = <DmFileImportResult>[];
      for (final file in files) {
        if (!mounted) return DmActionResult.cancelled;
        state = DmLibraryState(
            creatures: state.creatures,
            busy: true,
            importProgress: DmImportProgress(
                completed: results.length,
                total: files.length,
                fileName: file.name));
        try {
          final raw = await readDmCreatureJsonFile(file);
          if (!mounted) return DmActionResult.cancelled;
          final result = await _repository.import(raw);
          results.add(DmFileImportResult(
              fileName: file.name,
              status: result.duplicate
                  ? DmFileImportStatus.duplicate
                  : DmFileImportStatus.imported,
              creatureId: result.creature.id,
              message: result.duplicate
                  ? 'Это существо уже есть в библиотеке.'
                  : 'Существо импортировано.'));
        } catch (error) {
          results.add(DmFileImportResult(
              fileName: file.name,
              status: DmFileImportStatus.failed,
              message: dmErrorMessage(error)));
        }
        if (!mounted) return DmActionResult.cancelled;
        state = DmLibraryState(
            creatures: state.creatures,
            busy: true,
            importProgress: DmImportProgress(
                completed: results.length,
                total: files.length,
                fileName: file.name));
      }
      final report = DmImportReport(results);
      if (report.hasSuccess) await reload();
      return DmActionResult(
          success: report.hasSuccess,
          importReport: report,
          creatureId: results.length == 1 ? results.single.creatureId : null,
          message:
              results.length == 1 ? results.single.message : report.summary);
    } catch (error) {
      return DmActionResult(success: false, message: dmErrorMessage(error));
    } finally {
      if (mounted) state = DmLibraryState(creatures: state.creatures);
    }
  }

  Future<DmActionResult> deleteCreature(int id) async {
    if (state.busy) return DmActionResult.cancelled;
    state = DmLibraryState(creatures: state.creatures, busy: true);
    try {
      await _repository.delete(id);
      if (mounted) {
        ++_loadVersion;
        state = DmLibraryState(
            creatures: AsyncData([
              for (final creature
                  in state.creatures.valueOrNull ?? <DmCreatureSummary>[])
                if (creature.id != id) creature,
            ]),
            busy: true);
      }
      return const DmActionResult(success: true, message: 'Существо удалено.');
    } catch (error) {
      return DmActionResult(success: false, message: dmErrorMessage(error));
    } finally {
      if (mounted) state = DmLibraryState(creatures: state.creatures);
    }
  }
}

String dmErrorMessage(Object error) {
  if (error is DmCreatureException) return error.message;
  if (error is DmFileException) return error.message;
  return 'Не удалось загрузить данные. Проверьте соединение с сервером и попробуйте снова.';
}
