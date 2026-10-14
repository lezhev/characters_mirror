enum DmFileImportStatus { imported, duplicate, failed }

class DmFileImportResult {
  const DmFileImportResult({
    required this.fileName,
    required this.status,
    required this.message,
    this.creatureId,
  });

  final String fileName;
  final DmFileImportStatus status;
  final String message;
  final int? creatureId;

  String get statusLabel => switch (status) {
        DmFileImportStatus.imported => 'Импортировано',
        DmFileImportStatus.duplicate => 'Уже в библиотеке',
        DmFileImportStatus.failed => 'Ошибка',
      };
}

class DmImportReport {
  DmImportReport(List<DmFileImportResult> files)
      : files = List.unmodifiable(files);

  final List<DmFileImportResult> files;

  int get imported => _count(DmFileImportStatus.imported);
  int get duplicates => _count(DmFileImportStatus.duplicate);
  int get failed => _count(DmFileImportStatus.failed);
  bool get hasSuccess => imported + duplicates > 0;
  String get summary =>
      'Импортировано: $imported · Уже в библиотеке: $duplicates · Ошибок: $failed';

  int _count(DmFileImportStatus status) =>
      files.where((file) => file.status == status).length;
}

class DmImportProgress {
  const DmImportProgress({
    required this.completed,
    required this.total,
    required this.fileName,
  });

  final int completed;
  final int total;
  final String fileName;
  double get fraction => total == 0 ? 0 : completed / total;
}
