import 'package:characters_mirror_flutter/features/auth/application/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DmEntryButton extends ConsumerWidget {
  const DmEntryButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    if (!auth.hasScope('gm') && !auth.hasScope('admin')) {
      return const SizedBox.shrink();
    }
    return TextButton.icon(
        key: const ValueKey('dm-entry'),
        onPressed: () => context.push('/dm'),
        icon: const Icon(Icons.auto_stories_outlined),
        label: const Text('Мастер'));
  }
}
