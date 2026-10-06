import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_app_bar.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_personal_editor.dart';
import 'package:flutter/material.dart';

class CharacterPersonalEditorPage extends StatelessWidget {
  const CharacterPersonalEditorPage({
    required this.character,
    required this.onChanged,
    super.key,
  });

  final CharacterData character;
  final SavePersonalInfo onChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageSizeAppBar(title: Text('Личные данные')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: PageSizeLimiter(
            child: ListView(
              children: [
                CharacterPersonalEditor(
                  character: character,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
