import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Универсальная ViewModel для всех справочных моделей.
/// Работает с любым репозиторием, у которого есть методы:
/// getAll(), create(), update(), delete().
class GenericViewModel<T> extends StateNotifier<AsyncValue<List<T>>> {
  final dynamic repository;

  GenericViewModel(this.repository) : super(const AsyncLoading()) {
    loadAll();
  }

  Future<void> loadAll() async {
    state = const AsyncLoading();
    try {
      final items = await repository.getAll();
      state = AsyncData(items);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> addItem(T item) async {
    try {
      await repository.create(item);
      await loadAll();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateItem(T item) async {
    try {
      await repository.update(item);
      await loadAll();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      await repository.delete(id);
      await loadAll();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
