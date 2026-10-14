import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import '../application/dm_library_controller.dart';
import 'widgets/dm_error_view.dart';
import 'widgets/dm_import_report_dialog.dart';

class DmLibraryPage extends ConsumerWidget {
  const DmLibraryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dmLibraryProvider);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Мастер'),
          leading: IconButton(
            tooltip: 'К персонажам',
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/characters'),
          )),
      body: PageSizeLimiter(
          maxWidth: 1120,
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: Wrap(spacing: 12, runSpacing: 8, children: [
                  FilledButton.icon(
                      key: const ValueKey('dm-import'),
                      onPressed:
                          state.busy ? null : () => _import(context, ref),
                      icon: const Icon(Icons.file_upload_outlined),
                      label: const Text('Импортировать')),
                  IconButton(
                      tooltip: 'Обновить',
                      onPressed: state.busy
                          ? null
                          : () => ref.read(dmLibraryProvider.notifier).reload(),
                      icon: const Icon(Icons.refresh)),
                ])),
            if (state.busy) ...[
              LinearProgressIndicator(value: state.importProgress?.fraction),
              if (state.importProgress != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: Text(
                      'Импорт: ${state.importProgress!.completed} из ${state.importProgress!.total} · ${state.importProgress!.fileName}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
            ],
            Expanded(
                child: state.creatures.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => DmErrorView(
                  message: dmErrorMessage(error),
                  onRetry: () => ref.read(dmLibraryProvider.notifier).reload()),
              data: (creatures) => creatures.isEmpty
                  ? const Center(
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Text('Библиотека пуста'),
                            SizedBox(height: 8),
                            Text('Импортируйте существо из JSON Foundry VTT.',
                                textAlign: TextAlign.center),
                          ])))
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      itemCount: creatures.length,
                      itemBuilder: (context, index) {
                        final creature = creatures[index];
                        final date = creature.createdAt.toLocal();
                        return Card(
                            child: ListTile(
                          title: Text(creature.name),
                          subtitle: Text(
                              'ПО ${creature.challengeRating ?? 'неизвестно'} · HP ${creature.hpMax ?? 'неизвестно'}\n'
                              '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}'),
                          isThreeLine: true,
                          onTap: () =>
                              context.push('/dm/creatures/${creature.id}'),
                          trailing: IconButton(
                              tooltip: 'Удалить',
                              onPressed: state.busy
                                  ? null
                                  : () => _delete(context, ref, creature),
                              icon: const Icon(Icons.delete_outline)),
                        ));
                      }),
            )),
          ])),
    );
  }

  Future<void> _import(BuildContext context, WidgetRef ref) async {
    final result = await ref.read(dmLibraryProvider.notifier).importFile();
    if (!context.mounted || result.message == null) return;
    final report = result.importReport;
    if (report != null && report.files.length > 1) {
      await showDialog<void>(
          context: context,
          builder: (_) => DmImportReportDialog(report: report));
      return;
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(result.message!)));
  }

  Future<void> _delete(
      BuildContext context, WidgetRef ref, DmCreatureSummary creature) async {
    final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Удалить существо?'),
              content:
                  Text('«${creature.name}» будет удалено из вашей библиотеки.'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Отмена')),
                FilledButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Удалить'))
              ],
            ));
    if (confirmed != true || !context.mounted) return;
    final result =
        await ref.read(dmLibraryProvider.notifier).deleteCreature(creature.id);
    if (!context.mounted) return;
    if (result.success) ref.invalidate(dmCreatureDetailProvider(creature.id));
    if (result.message != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(result.message!)));
    }
  }
}
