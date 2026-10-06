import 'package:flutter/material.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_app_bar.dart';

class InvalidCharacterSheetPage extends StatelessWidget {
  const InvalidCharacterSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageSizeAppBar(
        title: Text('Лист персонажа'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Некорректный идентификатор персонажа.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
