import 'dart:async';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_app_bar.dart';
import '../application/level_up_controller.dart';
import '../data/level_up_gateway.dart';
import '../data/level_up_repository.dart';
import 'level_up_hub.dart';

final levelUpGatewayProvider = Provider<LevelUpGateway>(
    (ref) => LevelUpRepository(ref.watch(characterRepositoryProvider)));
final levelUpControllerProvider = StateNotifierProvider.autoDispose
    .family<LevelUpController, LevelUpFlowState, LevelUpRequest>(
        (ref, request) {
  final controller =
      LevelUpController(ref.watch(levelUpGatewayProvider), request);
  unawaited(controller.refresh());
  return controller;
});

class LevelUpPage extends ConsumerWidget {
  const LevelUpPage({super.key, required this.request});
  final LevelUpRequest request;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(levelUpControllerProvider(request));
    final controller = ref.read(levelUpControllerProvider(request).notifier);
    if (state.preview == null) {
      return Scaffold(
          appBar: const PageSizeAppBar(title: Text('Повышение уровня')),
          body: state.error == null
              ? const Center(child: CircularProgressIndicator())
              : errorWidget(
                  e: state.error!,
                  s: StackTrace.empty,
                  refresh: controller.refresh,
                  context: context));
    }
    return PopScope(
        canPop: !state.busy,
        child: LevelUpHub(
            state: state,
            onRoll: controller.setRoll,
            onAbilityTap: controller.cycleAbility,
            onChoice: controller.choose,
            onSubclass: controller.chooseSubclass,
            onSpells: (kind, ids, replaces) => controller
                .chooseSpells(kind, ids, replacesSelectionId: replaces),
            onApply: () async {
              final saved = await controller.apply();
              if (saved != null && context.mounted) {
                Navigator.of(context).pop(saved);
              }
            }));
  }
}
