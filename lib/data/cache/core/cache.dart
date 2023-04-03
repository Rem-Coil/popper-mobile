import 'package:hive_flutter/hive_flutter.dart';

abstract class Cacheable<T> {
  T get key;
}

abstract class Cache<K, T extends Cacheable<K>> {
  const Cache(this._boxName);

  final String _boxName;

  Future<Box<T>> get _box => Hive.openBox<T>(_boxName);

  Future<List<T>> getAll() async {
    final box = await _box;
    final items = box.values;
    return items.toList();
  }

  Future<T?> getByKey(K key) async {
    final box = await _box;
    return box.get(key);
  }

  Future<bool> contains(K key) async {
    final box = await _box;
    return box.containsKey(key);
  }

  Future<void> save(T item) async {
    final box = await _box;
    await box.put(item.key, item);
  }

  Future<void> saveAll(List<T> items) async {
    final box = await _box;
    final pairs = {for (var i in items) i.key: i};
    await box.putAll(pairs);
  }

  Future<void> delete(K key) async {
    final box = await _box;
    await box.delete(key);
  }

  Future<void> dispose() async {
    final box = await _box;
    await box.close();
  }
}
