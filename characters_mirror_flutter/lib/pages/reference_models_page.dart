import 'package:flutter/material.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';

class ReferenceModelsPage extends StatefulWidget {
  final Client client;
  const ReferenceModelsPage({super.key, required this.client});

  @override
  State<ReferenceModelsPage> createState() => _ReferenceModelsPageState();
}

class _ReferenceModelsPageState extends State<ReferenceModelsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _type = 'class';

  Future<void> _addReferenceModel() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      if (_type == 'class') {
        await widget.client.classData
            .add(ClassData(name: _nameController.text));
      } else if (_type == 'race') {
        await widget.client.raceData.add(RaceData(name: _nameController.text));
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Модель успешно добавлена')),
      );
      _nameController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Справочные модели')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _type,
                items: const [
                  DropdownMenuItem(value: 'class', child: Text('Класс')),
                  DropdownMenuItem(value: 'race', child: Text('Раса')),
                ],
                onChanged: (v) => setState(() => _type = v ?? 'class'),
                decoration: const InputDecoration(labelText: 'Тип модели'),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Название'),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Введите название' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addReferenceModel,
                child: const Text('Добавить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
