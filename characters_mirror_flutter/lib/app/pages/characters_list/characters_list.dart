import 'package:characters_mirror_flutter/app/pages/characters_list/widgets/character_tile_view.dart';
import 'package:characters_mirror_flutter/app/pages/characters_list/widgets/button.dart';
import 'package:characters_mirror_flutter/app/auth/src/auth_provider.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(96),
        child: PageSizeLimiter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Gap(16),
                Text('Characters List',
                    style: Theme.of(context).textTheme.headlineLarge),
                Spacer(),
                if (user!.scopeNames.contains('admin'))
                  IconButton(
                    icon: const Icon(Icons.admin_panel_settings_outlined),
                    tooltip: 'Админ',
                    onPressed: () async {
                      context.go('/admin');
                    },
                  ),
                Gap(8),
                Button.filled(
                  width: 200,
                  title: 'Создать персонажа',
                  onPressed: () {
                    context.go('/create');
                  },
                ),
                Gap(16),
              ],
            ),
          ),
        ),
      ),
      body: PageSizeLimiter(
        child: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CharacterTileView(),
          )),
        ),
      ),
    );
  }
}
