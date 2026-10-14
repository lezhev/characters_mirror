import 'package:flutter/material.dart';
import '../../application/dm_import_report.dart';

class DmImportReportDialog extends StatelessWidget {
  const DmImportReportDialog({super.key, required this.report});
  final DmImportReport report;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Результаты импорта'),
        content: SizedBox(
            width: 600,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(report.summary),
              const SizedBox(height: 12),
              Flexible(
                  child: SizedBox(
                      height: 320,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: report.files.length,
                        itemBuilder: (context, index) {
                          final file = report.files[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                                switch (file.status) {
                                  DmFileImportStatus.imported =>
                                    Icons.check_circle_outline,
                                  DmFileImportStatus.duplicate =>
                                    Icons.content_copy_outlined,
                                  DmFileImportStatus.failed =>
                                    Icons.error_outline,
                                },
                                color: file.status == DmFileImportStatus.failed
                                    ? Theme.of(context).colorScheme.error
                                    : null),
                            title: Text(file.fileName),
                            subtitle:
                                Text('${file.statusLabel}\n${file.message}'),
                          );
                        },
                      ))),
            ])),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Закрыть'))
        ],
      );
}
