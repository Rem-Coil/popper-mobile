import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/cache/operations_cache.dart';
import 'package:popper_mobile/models/operation/operation.dart';

@Singleton(as: OperationsCache)
class OperationsCacheImpl implements OperationsCache {
  static const String _savedOperationsBox = 'saved_operations';
  static const String _cachedOperationsBox = 'cached_operations';

  Future<Box<OperationLocal>> get _savedOperations =>
      Hive.openBox(_savedOperationsBox);

  Future<Box<OperationLocal>> get _cachedOperations =>
      Hive.openBox(_cachedOperationsBox);

  @override
  Future<void> saveOperation(Operation operation) async =>
      _saveInCacheOperation(operation, await _savedOperations);

  @override
  Future<void> cacheOperation(Operation operation) async =>
      _saveInCacheOperation(operation, await _cachedOperations);

  Future<void> _saveInCacheOperation(Operation operation, Box box) async {
    final localOperation = operation.toLocal();
    await box.add(localOperation);
  }

  @override
  Future<void> updateSavedOperation(Operation operation) async {
    final box = await _savedOperations;
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
  Future<List<Operation>> getSavedOperation() async =>
      _getOperation(await _savedOperations);

  @override
  Future<List<Operation>> getCachedOperation() async =>
      _getOperation(await _cachedOperations);

  Future<List<OperationLocal>> _getOperation(Box<OperationLocal> box) async {
    final operation = box.values;
    return operation.toList();
  }

  @override
  Future<void> subscribeToCachedOperations(
          ListCallback<Operation> listener) async =>
      _subscribeToBox(listener, await _cachedOperations);

  @override
  Future<void> subscribeToSavedOperations(
          ListCallback<Operation> listener) async =>
      _subscribeToBox(listener, await _savedOperations);

  Future<void> _subscribeToBox(
    ListCallback<Operation> listener,
    Box<OperationLocal> box,
  ) async {
    final listenable = box.listenable();
    listenable.addListener(() => listener(listenable.value.values.toList()));
  }

  @override
  Future<void> deleteCacheOperation(Operation operation) async =>
      _deleteByCondition(await _cachedOperations, operation,
          (o1, o2) => o1.isEqualWithoutId(o2));

  @override
  Future<void> deleteSavedOperation(Operation operation) async =>
      _deleteByCondition(
          await _savedOperations, operation, (o1, o2) => o1.id == o2.id);

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
    await (await _savedOperations).close();
    await (await _cachedOperations).close();
  }
}
