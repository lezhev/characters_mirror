abstract class Repository<T> {
  Future<List<T>> getAll();
  Future<T?> getById(int id);
  Future<T> upsert(T entity);
  Future<void> delete(int id);
}
