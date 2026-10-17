import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/dm_library_controller.dart';
import 'widgets/dm_error_view.dart';
import 'widgets/dm_statblock_view.dart';
import 'widgets/dm_technical_section.dart';

class DmCreaturePage extends ConsumerWidget {
  const DmCreaturePage({super.key, required this.creatureId});
  final int creatureId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(dmCreatureDetailProvider(creatureId));
    return Scaffold(
      appBar: AppBar(
          title: const Text('Карточка существа'),
          leading: IconButton(
              tooltip: 'К библиотеке',
              onPressed: () => context.go('/dm'),
              icon: const Icon(Icons.arrow_back))),
      body: PageSizeLimiter(
          maxWidth: 1000,
          child: detail.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => DmErrorView(
                message: dmErrorMessage(error),
                onRetry: () =>
                    ref.invalidate(dmCreatureDetailProvider(creatureId))),
            data: (detail) => SingleChildScrollView(
                key: PageStorageKey('dm-creature-$creatureId'),
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DmStatblockView(statblock: detail.statblock),
                      const SizedBox(height: 12),
                      DmTechnicalSection(
                          key: ValueKey(detail.record.id), detail: detail),
                    ])),
          )),
    );
  }
}
