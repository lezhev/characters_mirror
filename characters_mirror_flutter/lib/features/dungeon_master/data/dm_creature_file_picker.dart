import 'dart:convert';
import 'package:characters_mirror_shared/dungeon_master.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DmCreatureFilePicker {
  Future<List<XFile>> pickJsonFiles();
}

final dmCreatureFilePickerProvider =
    Provider<DmCreatureFilePicker>((ref) => SystemDmCreatureFilePicker());

class SystemDmCreatureFilePicker implements DmCreatureFilePicker {
  @override
  Future<List<XFile>> pickJsonFiles() => openFiles(acceptedTypeGroups: [
        const XTypeGroup(
            label: 'JSON',
            extensions: ['json'],
            uniformTypeIdentifiers: ['public.json'])
      ]);
}

/// Read one selected file at a time so a batch never holds every JSON in memory.
Future<String> readDmCreatureJsonFile(XFile file) async {
  try {
    if (await file.length() > creatureImportMaxBytes) {
      throw const DmFileException('Размер JSON превышает 5 МиБ.');
    }
    final bytes = await file.readAsBytes();
    if (bytes.length > creatureImportMaxBytes) {
      throw const DmFileException('Размер JSON превышает 5 МиБ.');
    }
    return utf8.decode(bytes);
  } on DmFileException {
    rethrow;
  } on FormatException {
    throw const DmFileException('Файл должен быть сохранён в UTF-8.');
  } catch (_) {
    throw const DmFileException('Не удалось прочитать выбранный файл.');
  }
}

class DmFileException implements Exception {
  const DmFileException(this.message);
  final String message;
}
