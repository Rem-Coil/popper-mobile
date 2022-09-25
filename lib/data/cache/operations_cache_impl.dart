import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/cache/operations_cache.dart';
import 'package:popper_mobile/models/operation/operation.dart';

@Singleton(as: OperationsCache)
class OperationsCacheImpl implements OperationsCache {
  static const String _completedOperationsBox = 'saved_operations';
  static const String _cachedOperationsBox = 'cached_operations';

  Future<Box<OperationLocal>> get _completedOperations =>
      Hive.openBox(_completedOperationsBox);

  Future<Box<OperationLocal>> get _cachedOperations =>
      Hive.openBox(_cachedOperationsBox);

  @override
  Future<void> addCompletedOperation(Operation operation) async =>
      _saveInCacheOperation(operation, await _completedOperations);

  @override
  Future<void> addCachedOperation(Operation operation) async =>
      _saveInCacheOperation(operation, await _cachedOperations);

  Future<void> _saveInCacheOperation(Operation operation, Box box) async {
    final localOperation = operation.toLocal();
    await box.add(localOperation);
  }

  @override
  Future<void> moveCachedToCompleted(Operation operation) async {
    final box = await _completedOperations;
    final localOperation = operation.toLocal();
    final operations = box.toMap();
    int updateOperationIndex = -1;
    operations.forEach((key, value) {
      if (localOperation.id == value.id) {
        updateOperationIndex = key;
      }
    });
    await box.putAt(updateOperationIndex, localOperation);
  }

  @override
  Future<List<Operation>> getCompletedOperations() async =>
      _getOperation(await _completedOperations);

  @override
  Future<List<Operation>> getCachedOperations() async =>
      _getOperation(await _cachedOperations);

  Future<List<OperationLocal>> _getOperation(Box<OperationLocal> box) async {
    final operation = box.values;
    return operation.toList();
  }

  @override
  Future<void> subscribeToCachedOperations(VoidCallback listener) =>
      _subscribeToBox(listener, _cachedOperations);

  @override
  Future<void> subscribeToCompletedOperations(VoidCallback listener) =>
      _subscribeToBox(listener, _completedOperations);

  Future<void> _subscribeToBox(
    VoidCallback listener,
    Future<Box<OperationLocal>> box,
  ) async {
    final listenable = (await box).listenable();
    listenable.addListener(listener);
  }

  @override
  Future<void> unsubscribeToCachedOperations(VoidCallback listener) =>
      _unsubscribeToBox(listener, _cachedOperations);

  @override
  Future<void> unsubscribeToCompletedOperations(VoidCallback listener) =>
      _unsubscribeToBox(listener, _completedOperations);

  Future<void> _unsubscribeToBox(
    VoidCallback listener,
    Future<Box<OperationLocal>> box,
  ) async {
    final listenable = (await box).listenable();
    listenable.removeListener(listener);
  }

  @override
  Future<void> deleteCacheOperation(Operation operation) async =>
      _deleteByCondition(await _cachedOperations, operation,
          (o1, o2) => o1.isEqualWithoutId(o2));

  @override
  Future<void> deleteCompletedOperation(Operation operation) async =>
      _deleteByCondition(
          await _completedOperations, operation, (o1, o2) => o1.id == o2.id);

  Future<void> _deleteByCondition(
    Box<OperationLocal> box,
    Operation operation,
    bool Function(Operation o1, Operation o2) condition,
  ) async {
    final operations = box.toMap();
    int deleteIndex = -1;

    operations.forEach((key, value) {
      if (condition(operation, value)) {
        deleteIndex = key;
      }
    });

    await box.delete(deleteIndex);
  }

  @disposeMethod
  @override
  Future<void> dispose() async {
    await (await _completedOperations).close();
    await (await _cachedOperations).close();
  }
}
