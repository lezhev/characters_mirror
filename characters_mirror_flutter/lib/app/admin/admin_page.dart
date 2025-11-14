// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:characters_mirror_flutter/data/repositories/referense_tables_repositories.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';
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

  List<dynamic> _items = [];

  final Map<String, Repository<dynamic>> _repositories = {
    'class': ClassRepository(),
    'classfeature': ClassFeatureRepository(),
    'race': RaceRepository(),
    'subrace': SubraceRepository(),
    'subclass': SubclassRepository(),
    'item': ItemRepository(),
    'weapon': WeaponRepository(),
    'armor': ArmorRepository(),
    'magicitem': MagicItemRepository(),
    'background': BackgroundRepository(),
    'feat': FeatRepository(),
    'spell': SpellRepository(),
    'classoption': ClassOptionRepository(),
    'subclassFeature': SubclassFeatureRepository(),
  };

  final List<String> _entities = [
    'class',
    'classFeature',
    'classoption',
    'subclass',
    'subclassFeature',
    'race',
    'subrace',
    'item',
    'weapon',
    'armor',
    'magicItem',
    'background',
    'feat',
    'spell',
  ];

  Repository<dynamic>? get _currentRepo => _selectedEntity != null
      ? _repositories[_selectedEntity!.toLowerCase()]
      : null;

  Future<void> _loadItems() async {
    if (_currentRepo == null) return;
    setState(() => _isLoading = true);

    try {
      final loaded = await _currentRepo!.getAll();
      loaded.sort((a, b) => ((a.id ?? 0) as int).compareTo((b.id ?? 0) as int));
      setState(() => _items = loaded);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Ошибка загрузки: $e')));
      log('Ошибка загрузки: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _submit() async {
    if (_currentRepo == null || _jsonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите сущность и введите JSON')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final dataMap = jsonDecode(_jsonController.text) as Map<String, dynamic>;
      dynamic entity;

      switch (_selectedEntity!.toLowerCase()) {
        case 'class':
          entity = ClassData.fromJson(dataMap);
          break;
        case 'classfeature':
          entity = ClassFeatureData.fromJson(dataMap);
          break;
        case 'race':
          entity = RaceData.fromJson(dataMap);
          break;
        case 'subrace':
          entity = SubraceData.fromJson(dataMap);
          break;
        case 'subclass':
          entity = SubclassData.fromJson(dataMap);
          break;
        case 'item':
          entity = ItemData.fromJson(dataMap);
          break;
        case 'weapon':
          entity = WeaponData.fromJson(dataMap);
          break;
        case 'armor':
          entity = ArmorData.fromJson(dataMap);
          break;
        case 'magicitem':
          entity = MagicItemData.fromJson(dataMap);
          break;
        case 'background':
          entity = BackgroundData.fromJson(dataMap);
          break;
        case 'feat':
          entity = FeatData.fromJson(dataMap);
          break;
        case 'spell':
          entity = SpellData.fromJson(dataMap);
          break;
        case 'classoption':
          entity = ClassOptionData.fromJson(dataMap);
          break;
        default:
          throw Exception('Неизвестная сущность: $_selectedEntity');
      }

      await _currentRepo!.upsert(entity);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Объект добавлен / обновлён')),
      );

      _jsonController.clear();
      await _loadItems();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      log('Ошибка загрузки: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteItem(int id) async {
    if (_currentRepo == null) return;
    setState(() => _isLoading = true);

    try {
      await _currentRepo!.delete(id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Объект удалён')),
      );

      await _loadItems();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Ошибка удаления: $e')));
      log('Ошибка удаления: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              initialValue: _selectedEntity,
              decoration: const InputDecoration(
                labelText: 'Сущность',
                border: OutlineInputBorder(),
              ),
              items: _entities
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedEntity = value);
                _loadItems();
              },
            ),
            const SizedBox(height: 16),
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _submit,
                icon: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.add),
                label: const Text('Добавить / Обновить'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        final filteredMap = _filteredMap(item);

                        return Card(
                          child: ListTile(
                            title: Text(filteredMap['name']?.toString() ??
                                filteredMap['title']?.toString() ??
                                filteredMap['displayName']?.toString() ??
                                filteredMap['level']?.toString() ??
                                'Без имени'),
                            subtitle: Text('ID: ${item.id}'),
                            onTap: () {
                              _jsonController.text =
                                  JsonEncoder.withIndent('  ')
                                      .convert(filteredMap);
                            },
                            trailing: IconButton(
                              icon:
                                  Icon(Icons.delete, color: colorScheme.error),
                              onPressed: () {
                                final id = item.id as int?;
                                if (id != null) _deleteItem(id);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

const List<String> _hiddenFields = ['createdAt', 'updatedAt', 'version'];

Map<String, dynamic> _filteredMap(dynamic item) {
  final Map<String, dynamic> map = item is Map
      ? Map<String, dynamic>.from(item)
      : Map<String, dynamic>.from(item.toJson());
  map.removeWhere((key, _) => _hiddenFields.contains(key));
  return map;
}
