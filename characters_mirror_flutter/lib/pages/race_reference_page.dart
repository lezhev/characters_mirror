import 'package:characters_mirror_flutter/data/view_models/race_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';

class RaceReferencePage extends ConsumerStatefulWidget {
  const RaceReferencePage({super.key});

  @override
  ConsumerState<RaceReferencePage> createState() => _RaceReferencePageState();
}

class _RaceReferencePageState extends ConsumerState<RaceReferencePage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final sourceController = TextEditingController();
  final sizeController = TextEditingController();
  final speedController = TextEditingController();

  final abilityController = TextEditingController();
  final abilityValueController = TextEditingController();
  final traitController = TextEditingController();
  final languageController = TextEditingController();

  Map<String, int> abilityBonuses = {};
  List<String> traits = [];
  List<String> languages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(raceViewModelProvider.notifier).loadRaces();
    });
  }

  void _startEditing(RaceData race) {
    final vm = ref.read(raceViewModelProvider.notifier);

    vm.startEditing(race);
    setState(() {
      nameController.text = race.name ?? '';
      descriptionController.text = race.description ?? '';
      sourceController.text = race.source ?? '';
      sizeController.text = race.size ?? '';
      speedController.text = (race.speed ?? 0).toString();
      abilityBonuses = Map.from(race.abilityBonuses ?? {});
      traits = List.from(race.traits ?? []);
      languages = List.from(race.languages ?? []);
    });
  }

  void _clearForm() {
    nameController.clear();
    descriptionController.clear();
    sourceController.clear();
    sizeController.clear();
    speedController.clear();
    abilityController.clear();
    abilityValueController.clear();
    traitController.clear();
    languageController.clear();
    setState(() {
      abilityBonuses.clear();
      traits.clear();
      languages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(raceViewModelProvider);
    final vm = ref.read(raceViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Справочник рас')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Название'),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Введите название' : null,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(labelText: 'Описание'),
                      maxLines: 2,
                    ),
                    TextFormField(
                      controller: sourceController,
                      decoration: const InputDecoration(labelText: 'Источник'),
                    ),
                    TextFormField(
                      controller: sizeController,
                      decoration: const InputDecoration(labelText: 'Размер'),
                    ),
                    TextFormField(
                      controller: speedController,
                      decoration:
                          const InputDecoration(labelText: 'Скорость (ft)'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    const Text('Бонусы к характеристикам',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: abilityController,
                            decoration: const InputDecoration(
                                hintText: 'Характеристика'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: abilityValueController,
                            decoration:
                                const InputDecoration(hintText: 'Значение'),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            final key = abilityController.text.trim();
                            final value =
                                int.tryParse(abilityValueController.text) ?? 0;
                            if (key.isNotEmpty) {
                              setState(() {
                                abilityBonuses[key] = value;
                              });
                              abilityController.clear();
                              abilityValueController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 6,
                      children: abilityBonuses.entries
                          .map((e) => Chip(
                                label: Text('${e.key}: ${e.value}'),
                                onDeleted: () => setState(() {
                                  abilityBonuses.remove(e.key);
                                }),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    const Text('Черты',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: traitController,
                            decoration:
                                const InputDecoration(hintText: 'Новая черта'),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            final t = traitController.text.trim();
                            if (t.isNotEmpty) {
                              setState(() => traits.add(t));
                              traitController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 6,
                      children: traits
                          .map((t) => Chip(
                                label: Text(t),
                                onDeleted: () =>
                                    setState(() => traits.remove(t)),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    const Text('Языки',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: languageController,
                            decoration:
                                const InputDecoration(hintText: 'Новый язык'),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            final l = languageController.text.trim();
                            if (l.isNotEmpty) {
                              setState(() => languages.add(l));
                              languageController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 6,
                      children: languages
                          .map((l) => Chip(
                                label: Text(l),
                                onDeleted: () =>
                                    setState(() => languages.remove(l)),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      vm.saveRace(
                        name: nameController.text,
                        description: descriptionController.text,
                        source: sourceController.text,
                        size: sizeController.text,
                        speed: int.tryParse(speedController.text),
                        abilityBonuses: abilityBonuses,
                        traits: traits,
                        languages: languages,
                      );
                      _clearForm();
                    },
                    child: Text(
                        state.editingRace == null ? 'Добавить' : 'Сохранить'),
                  ),
                  const SizedBox(width: 8),
                  if (state.editingRace != null)
                    TextButton(
                      onPressed: () {
                        vm.cancelEditing();
                        _clearForm();
                      },
                      child: const Text('Отмена'),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: state.races.length,
                        itemBuilder: (context, i) {
                          final race = state.races[i];
                          return ListTile(
                            title: Text(
                                '${race.id ?? 0}. ${race.name ?? 'Без имени'}'),
                            subtitle: Text(
                              race.description ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _startEditing(race),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => vm.deleteRace(race.id!),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
