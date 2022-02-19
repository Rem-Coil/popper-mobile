import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/models/operation/operation.dart';

abstract class OperationsCache {
  Future<List<Operation>> getSavedOperation();

  Future<List<Operation>> getCachedOperation();

  Future<void> saveOperation(Operation operation);

  Future<void> cacheOperation(Operation operation);

  Future<void> updateSavedOperation(Operation operation);

  Future<void> deleteSavedOperation(Operation operation);

  Future<void> deleteCacheOperation(Operation operation);

  Future<void> subscribeToSavedOperations(ListCallback<Operation> listener);

  Future<void> subscribeToCachedOperations(ListCallback<Operation> listener);

  @disposeMethod
  Future<void> dispose();
}
