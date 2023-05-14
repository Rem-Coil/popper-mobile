import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class Cacheable<T> {
  T get key;
}

abstract class Cache<K, T extends Cacheable<K>> {
  const Cache(this._boxName);

  final String _boxName;

  @protected
  Future<Box<T>> get boxFuture => Hive.openBox<T>(_boxName);

  Future<List<T>> getAll() async {
    final box = await boxFuture;
    final items = box.values;
    return items.toList();
  }

  Future<T?> getByKey(K key) async {
    final box = await boxFuture;
    return box.get(key);
  }

  Future<bool> contains(K key) async {
    final box = await boxFuture;
    return box.containsKey(key);
  }

  Future<void> save(T item) async {
    final box = await boxFuture;
    await box.put(item.key, item);
  }

  Future<void> saveAll(Iterable<T> items) async {
    final box = await boxFuture;
    final pairs = {for (var i in items) i.key: i};
    await box.putAll(pairs);
  }

  Future<void> delete(K key) async {
    final box = await boxFuture;
    await box.delete(key);
  }

  Future<void> clear() async {
    final box = await boxFuture;
    await box.clear();
  }

  Future<void> dispose() async {
    final box = await boxFuture;
    await box.close();
  }
}
