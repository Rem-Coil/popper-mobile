import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/models/operation/operation.dart';

abstract class OperationsCache {
  Future<List<Operation>> getSavedOperation();

  Future<List<Operation>> getCachedOperation();

  Future<void> saveOperation(Operation operation);

  Future<void> cacheOperation(Operation operation);

  Future<void> updateSavedOperation(Operation operation);

  Future<void> deleteSavedOperation(Operation operation);

  Future<void> deleteCacheOperation(Operation operation);

  // TODO - боксы не должны вылезать за этот класс
  // TODO - надо сделать подписку на обновление через наблюдателя
  Future<ValueListenable<Box<OperationLocal>>> get savedActionListenable;

  Future<ValueListenable<Box<OperationLocal>>> get cachedActionListenable;

  @disposeMethod
  Future<void> dispose();
}
