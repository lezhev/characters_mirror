import 'package:characters_mirror_client/characters_mirror_client.dart';

class GenericRepository<T> {
  final Client client;
  final dynamic Function(Client) endpointSelector;

  GenericRepository(this.client, this.endpointSelector);

  dynamic get _endpoint => endpointSelector(client);

  Future<List<T>> getAll() async => await _endpoint.getAll();
  Future<T?> getById(int id) async => await _endpoint.getById(id);
  Future<T> add(T item) async => await _endpoint.add(item);
  Future<T> update(T item) async => await _endpoint.update(item);
  Future<void> delete(int id) async => await _endpoint.delete(id);
}
