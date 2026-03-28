import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/state/attribute_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/attribute_selection.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/common/selection_type.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_nav_bar.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AttributesStep extends ConsumerWidget {
  const AttributesStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: CreationAppBar(
          title: "Создание персонажа",
          onBack: () => context.go('/characters'),
          onStepTap: (target) => _syncAndGo(
            context: context,
            ref: ref,
            target: target,
          ),
        ),
      ),
      body: PageSizeLimiter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SelectionType(type: SelectType.defaultType),
                  SelectionType(type: SelectType.random),
                  SelectionType(type: SelectType.purchace),
                  SelectionType(type: SelectType.manual),
                ],
              ),
              const Gap(8),
              Divider(
                color: Theme.of(context).colorScheme.outline,
              ),
              const Gap(8),
              AttributeSelection()
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: CreationNavBar(
            onPressedNext: () {
              final notifier = ref.read(characterCreationProvider.notifier);
              notifier.syncAttributesDraft(_mergedAttributes(ref));
              notifier.nextStep(context);
            },
            route: 'personal',
          ),
        ),
      ),
    );
  }
}

Map<String, int> _mergedAttributes(WidgetRef ref) {
  return ref
      .read(attributeStateProvider.notifier)
      .mergeStatsAndBonuses()
      .map((key, value) => MapEntry(key.name, value));
}

void _syncAndGo({
  required BuildContext context,
  required WidgetRef ref,
  required Step target,
}) {
  final notifier = ref.read(characterCreationProvider.notifier);
  notifier.syncAttributesDraft(_mergedAttributes(ref));
  notifier.goToStep(context, target);
}
