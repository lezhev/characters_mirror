import 'package:flutter/material.dart';

class InvalidCharacterSheetPage extends StatelessWidget {
  const InvalidCharacterSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лист персонажа'),
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
