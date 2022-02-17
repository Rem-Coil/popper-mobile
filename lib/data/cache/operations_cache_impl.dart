import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/cache/operations_cache.dart';
import 'package:popper_mobile/models/operation/operation.dart';

@Singleton(as: OperationsCache)
class OperationsCacheImpl implements OperationsCache {
  static const String _SAVED_OPERATIONS_BOX = 'saved_operations';
  static const String _CACHED_OPERATIONS_BOX = 'cached_operations';

  Future<Box<OperationLocal>> get _savedOperations =>
      Hive.openBox(_SAVED_OPERATIONS_BOX);

  Future<Box<OperationLocal>> get _cachedOperations =>
      Hive.openBox(_CACHED_OPERATIONS_BOX);

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
  Future<ValueListenable<Box<OperationLocal>>>
  get savedActionListenable async => (await _savedOperations).listenable();

  @override
  Future<ValueListenable<Box<OperationLocal>>>
      get cachedActionListenable async =>
          (await _cachedOperations).listenable();

  @disposeMethod
  @override
  Future<void> dispose() async {
    await (await _savedOperations).close();
    await (await _cachedOperations).close();
  }

  @override
  Future<void> deleteCacheOperation(Operation operation) {
    // TODO: implement deleteCacheOperation
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSavedOperation(Operation operation) {
    // TODO: implement deleteSavedOperation
    throw UnimplementedError();
  }
}
