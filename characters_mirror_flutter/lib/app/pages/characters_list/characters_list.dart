import 'package:characters_mirror_flutter/app/pages/characters_list/widgets/character_tile_view.dart';
import 'package:characters_mirror_flutter/app/pages/characters_list/widgets/add_character_button.dart';
import 'package:characters_mirror_flutter/auth/src/auth_provider.dart';
import 'package:characters_mirror_flutter/src/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CharactersList extends ConsumerWidget {
  const CharactersList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    return Scaffold(
      body: Column(
        children: [
          Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Gap(16),
              Text('Characters List',
                  style: Theme.of(context).textTheme.headlineLarge),
              Spacer(),
              if (user!.scopeNames.contains('admin'))
                IconButton(
                  icon: const Icon(Icons.admin_panel_settings_outlined),
                  tooltip: 'Админка',
                  onPressed: () async {
                    context.go('/admin');
                  },
                ),
              Gap(8),
              AddCharacterButton(onPressed: () {}),
              Gap(16),
            ],
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: 800,
              child: CharacterTileView(),
            ),
          ),
        ],
      ),
    );
  }
}
