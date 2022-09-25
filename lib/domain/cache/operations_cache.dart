import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/models/operation/operation.dart';

abstract class OperationsCache {
  Future<List<Operation>> getCompletedOperations();

  Future<List<Operation>> getCachedOperations();

  Future<void> addCompletedOperation(Operation operation);

  Future<void> addCachedOperation(Operation operation);

  Future<void> moveCachedToCompleted(Operation operation);

  Future<void> deleteCompletedOperation(Operation operation);

  Future<void> deleteCacheOperation(Operation operation);

  Future<void> subscribeToCompletedOperations(VoidCallback listener);

  Future<void> subscribeToCachedOperations(VoidCallback listener);

  Future<void> unsubscribeToCompletedOperations(VoidCallback listener);

  Future<void> unsubscribeToCachedOperations(VoidCallback listener);

  @disposeMethod
  Future<void> dispose();
}
