import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/models/operation/operation.dart';

@singleton
class OperationsCache {
  static const String _SAVED_OPERATIONS_BOX = 'saved_operations';
  static const String _CACHED_OPERATIONS_BOX = 'cached_operations';

  Future<Box<OperationLocal>> get _savedOperations =>
      Hive.openBox(_SAVED_OPERATIONS_BOX);

  Future<Box<OperationLocal>> get _cachedOperations =>
      Hive.openBox(_CACHED_OPERATIONS_BOX);

  Future<void> saveOperation(Operation operation) async =>
      _saveInCacheOperation(operation, await _savedOperations);

  Future<void> cacheOperation(Operation operation) async =>
      _saveInCacheOperation(operation, await _cachedOperations);

  Future<void> _saveInCacheOperation(Operation operation, Box box) async {
    final localOperation = operation.toLocal();
    await box.add(localOperation);
  }

  Future<void> updateOperation(Operation operation) async {
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

  Future<List<Operation>> getSavedOperation() async =>
      _getOperation(await _savedOperations);

  Future<List<Operation>> getCachedOperation() async =>
      _getOperation(await _cachedOperations);

  Future<List<OperationLocal>> _getOperation(Box<OperationLocal> box) async {
    final operation = box.values;
    return operation.toList();
  }

  Future<ValueListenable<Box<OperationLocal>>>
      get savedActionListenable async => (await _savedOperations).listenable();

  Future<ValueListenable<Box<OperationLocal>>>
      get cachedActionListenable async =>
          (await _cachedOperations).listenable();

  @disposeMethod
  Future<void> dispose() async {
    await (await _savedOperations).close();
    await (await _cachedOperations).close();
  }
}
