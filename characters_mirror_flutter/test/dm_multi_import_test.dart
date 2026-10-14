import 'dart:async';
import 'dart:convert';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/application/dm_library_controller.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/application/dm_import_report.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/data/dm_creature_file_picker.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/data/dm_creature_repository.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('system dialog requests multiple JSON files and returns all handles',
      () async {
    const channel = MethodChannel('plugins.flutter.io/file_selector');
    MethodCall? request;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      request = call;
      return [
        path.join('C:', 'selection', 'Goblin.json'),
        path.join('C:', 'selection', 'Mage.json')
      ];
    });
    addTearDown(() => TestDefaultBinaryMessengerBinding
        .instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null));
    final picker = SystemDmCreatureFilePicker();
    final List<XFile> files = await picker.pickJsonFiles();
    expect(files.map((file) => file.name), ['Goblin.json', 'Mage.json']);
    expect(request!.method, 'openFile');
    expect(request!.arguments['multiple'], true);
    expect(request!.arguments['acceptedTypeGroups'][0]['extensions'], ['json']);
    expect(request!.arguments['initialDirectory'], null);
  });

  test('one selection imports every file sequentially and reloads once',
      () async {
    final repository = BatchRepository();
    final controller = DmLibraryController(
        repository,
        BatchPicker([
          jsonFile('Goblin.json', 'goblin'),
          jsonFile('Mage.json', 'mage'),
          jsonFile('Dragon.json', 'dragon'),
        ]));
    addTearDown(controller.dispose);
    await Future<void>.delayed(Duration.zero);
    final initialLoads = repository.listCalls;
    final result = await controller.importFile();
    expect(repository.inputs, ['goblin', 'mage', 'dragon']);
    expect(result.success, true);
    expect(controller.state.creatures.valueOrNull, hasLength(3));
    expect(repository.listCalls, initialLoads + 1);
    expect(repository.maxConcurrent, 1);
    expect(controller.state.busy, false);
  });

  test('bad UTF-8 and server rejection do not interrupt remaining files',
      () async {
    final repository = BatchRepository()..reject = {'rejected'};
    final controller = DmLibraryController(
        repository,
        BatchPicker([
          jsonFile('Goblin.json', 'goblin'),
          XFile.fromData(Uint8List.fromList([0xff]),
              path: 'bad-utf8.json', name: 'bad-utf8.json'),
          jsonFile('rejected.json', 'rejected'),
          jsonFile('Mage.json', 'mage'),
        ]));
    addTearDown(controller.dispose);
    final result = await controller.importFile();
    expect(repository.inputs, ['goblin', 'rejected', 'mage']);
    expect(result.success, true);
    expect(controller.state.creatures.valueOrNull, hasLength(2));
    expect(result.message, contains('Импортировано: 2'));
    expect(result.message, contains('Ошибок: 2'));
    expect(result.importReport!.files.map((file) => file.fileName),
        ['Goblin.json', 'bad-utf8.json', 'rejected.json', 'Mage.json']);
    expect(result.importReport!.files.map((file) => file.status), [
      DmFileImportStatus.imported,
      DmFileImportStatus.failed,
      DmFileImportStatus.failed,
      DmFileImportStatus.imported
    ]);
    expect(result.importReport!.files[1].message,
        'Файл должен быть сохранён в UTF-8.');
    expect(result.importReport!.files[2].message, 'Некорректный JSON.');
  });

  test('duplicate import is reported separately and creates no extra list row',
      () async {
    final repository = BatchRepository();
    final controller = DmLibraryController(
        repository,
        BatchPicker([
          jsonFile('Dragon.json', 'dragon'),
          jsonFile('Dragon (1).json', 'dragon'),
          jsonFile('Mage.json', 'mage'),
        ]));
    addTearDown(controller.dispose);
    final result = await controller.importFile();
    expect(repository.inputs, ['dragon', 'dragon', 'mage']);
    expect(controller.state.creatures.valueOrNull, hasLength(2));
    expect(result.message, contains('Импортировано: 2'));
    expect(result.message, contains('Уже в библиотеке: 1'));
    expect(result.importReport!.files[1].status, DmFileImportStatus.duplicate);
    expect(result.importReport!.files[1].creatureId,
        result.importReport!.files.first.creatureId);
  });

  test('cancelled multi-selection sends no requests', () async {
    final repository = BatchRepository();
    final controller = DmLibraryController(repository, BatchPicker([]));
    addTearDown(controller.dispose);
    final result = await controller.importFile();
    expect(repository.inputs, isEmpty);
    expect(result.message, null);
    expect(controller.state.busy, false);
  });

  test('busy batch does not start another picker or import', () async {
    final repository = BatchRepository()..gate = Completer<void>();
    final picker = BatchPicker(
        [jsonFile('Goblin.json', 'goblin'), jsonFile('Mage.json', 'mage')]);
    final controller = DmLibraryController(repository, picker);
    addTearDown(controller.dispose);
    final pending = controller.importFile();
    await Future<void>.delayed(Duration.zero);
    expect(controller.state.busy, true);
    expect(controller.state.importProgress!.completed, 0);
    expect(controller.state.importProgress!.total, 2);
    expect(controller.state.importProgress!.fileName, 'Goblin.json');
    final ignored = await controller.importFile();
    expect(ignored.message, null);
    repository.gate!.complete();
    await pending;
    expect(repository.inputs, ['goblin', 'mage']);
    expect(picker.calls, 1);
    expect(controller.state.busy, false);
    expect(controller.state.importProgress, null);
  });

  test('native multi-selection cancellation returns no file handles', () async {
    const channel = MethodChannel('plugins.flutter.io/file_selector');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (_) async => null);
    addTearDown(() => TestDefaultBinaryMessengerBinding
        .instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null));
    expect(await SystemDmCreatureFilePicker().pickJsonFiles(), isEmpty);
  });

  test('file reading preserves UTF-8 and enforces the per-file size limit',
      () async {
    expect(await readDmCreatureJsonFile(jsonFile('Маг.json', '{"name":"Маг"}')),
        '{"name":"Маг"}');
    final large = XFile.fromData(Uint8List(5 * 1024 * 1024 + 1),
        path: 'large.json', name: 'large.json');
    await expectLater(
        readDmCreatureJsonFile(large), throwsA(isA<DmFileException>()));
  });

  test('oversized file is reported while the next valid file imports',
      () async {
    final repository = BatchRepository();
    final controller = DmLibraryController(
        repository,
        BatchPicker([
          XFile.fromData(Uint8List(5 * 1024 * 1024 + 1),
              path: 'large.json', name: 'large.json'),
          jsonFile('Mage.json', 'mage'),
        ]));
    addTearDown(controller.dispose);
    final result = await controller.importFile();
    expect(repository.inputs, ['mage']);
    expect(result.importReport!.failed, 1);
    expect(result.importReport!.imported, 1);
    expect(result.importReport!.files.first.message,
        'Размер JSON превышает 5 МиБ.');
  });

  test('all failed files produce a failure report without a success reload',
      () async {
    final repository = BatchRepository()..reject = {'bad-a', 'bad-b'};
    final controller = DmLibraryController(
        repository,
        BatchPicker([
          jsonFile('a.json', 'bad-a'),
          jsonFile('b.json', 'bad-b'),
        ]));
    addTearDown(controller.dispose);
    await Future<void>.delayed(Duration.zero);
    final initialLoads = repository.listCalls;
    final result = await controller.importFile();
    expect(result.success, false);
    expect(result.importReport!.failed, 2);
    expect(result.importReport!.imported, 0);
    expect(controller.state.creatures.valueOrNull, isEmpty);
    expect(repository.listCalls, initialLoads);
    expect(controller.state.busy, false);
  });

  test('disposing during import stops future files after the in-flight request',
      () async {
    final repository = BatchRepository()..gate = Completer<void>();
    final controller = DmLibraryController(
        repository,
        BatchPicker([
          jsonFile('Goblin.json', 'goblin'),
          jsonFile('Mage.json', 'mage'),
        ]));
    final pending = controller.importFile();
    await Future<void>.delayed(Duration.zero);
    controller.dispose();
    repository.gate!.complete();
    await pending;
    expect(repository.inputs, ['goblin']);
  });
}

XFile jsonFile(String name, String content) =>
    XFile.fromData(Uint8List.fromList(utf8.encode(content)),
        path: name, name: name);

class BatchPicker extends DmCreatureFilePicker {
  BatchPicker(this.files);
  final List<XFile> files;
  int calls = 0;
  @override
  Future<List<XFile>> pickJsonFiles() async {
    calls++;
    return files;
  }
}

class BatchRepository implements DmCreatureRepository {
  final inputs = <String>[];
  final rows = <String, DmCreatureSummary>{};
  Set<String> reject = {};
  Completer<void>? gate;
  int listCalls = 0, active = 0, maxConcurrent = 0;
  @override
  Future<List<DmCreatureSummary>> list() async {
    listCalls++;
    return rows.values.toList();
  }

  @override
  Future<DmCreatureImportResult> import(String rawJson) async {
    inputs.add(rawJson);
    active++;
    if (active > maxConcurrent) maxConcurrent = active;
    try {
      if (gate != null) await gate!.future;
      if (reject.contains(rawJson)) {
        throw DmCreatureException(
            code: 'invalid_json', message: 'Некорректный JSON.');
      }
      final duplicate = rows.containsKey(rawJson);
      final summary = rows.putIfAbsent(
          rawJson,
          () => DmCreatureSummary(
              id: rows.length + 1,
              name: rawJson,
              hpMax: 40,
              createdAt: DateTime(2026)));
      return DmCreatureImportResult(creature: summary, duplicate: duplicate);
    } finally {
      active--;
    }
  }

  @override
  Future<DmCreatureRecord> get(int id) => throw UnimplementedError();
  @override
  Future<void> delete(int id) => throw UnimplementedError();
}
