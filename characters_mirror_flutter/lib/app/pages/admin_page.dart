import 'dart:convert';
import 'package:characters_mirror_flutter/src/serverpod_client.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _jsonController = TextEditingController();
  String? _selectedEntity;
  bool _isLoading = false;

  final List<String> _entities = const [
    'character',
    'class',
    'classFeature',
    'race',
    'subrace',
    'subclass',
    'item',
    'weapon',
    'armor',
    'magicItem',
    'background',
    'feat',
    'spell',
  ];

  Future<void> _submit(BuildContext context) async {
    if (_selectedEntity == null || _jsonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите сущность и введите JSON')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      // Проверим, что JSON валиден до отправки
      jsonDecode(_jsonController.text);

      await client.referenceData.insertJson(
        _selectedEntity!,
        _jsonController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ ${_selectedEntity!} успешно добавлена')),
      );
      _jsonController.clear();
    } on FormatException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ошибка: неверный формат JSON')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при добавлении: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Добавить данные в справочник')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Выбор сущности ---
            DropdownButtonFormField<String>(
              value: _selectedEntity,
              decoration: const InputDecoration(
                labelText: 'Сущность',
                border: OutlineInputBorder(),
              ),
              items: _entities
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedEntity = value),
            ),
            const SizedBox(height: 16),

            // --- Поле JSON ---
            Expanded(
              child: TextField(
                controller: _jsonController,
                expands: true,
                maxLines: null,
                minLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'JSON данных',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 16),

            // --- Кнопка ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : () => _submit(context),
                icon: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.add),
                label: const Text('Добавить'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
