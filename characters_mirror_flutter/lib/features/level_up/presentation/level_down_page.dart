import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_app_bar.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LevelDownPage extends ConsumerStatefulWidget {
  const LevelDownPage({super.key, required this.request});

  final LevelDownRequest request;

  @override
  ConsumerState<LevelDownPage> createState() => _LevelDownPageState();
}

class _LevelDownPageState extends ConsumerState<LevelDownPage> {
  bool _busy = false;

  Future<void> _apply() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final saved = await ref
          .read(characterRepositoryProvider)
          .applyLevelDown(widget.request);
      if (mounted) Navigator.of(context).pop(saved);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(humanReadableError(error))),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_busy,
      child: Scaffold(
        appBar: const PageSizeAppBar(title: Text('Понижение уровня')),
        body: Center(
          child: PageSizeLimiter(
            maxWidth: 680,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  key: const ValueKey('level-down-apply'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                  ),
                  onPressed: _busy ? null : _apply,
                  child: const Text('Понизить уровень'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
