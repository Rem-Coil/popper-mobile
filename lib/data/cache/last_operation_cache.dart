import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/models/operation_type/local_operation_type.dart';

const _lastOperationBox = 'last_operation';

@singleton
class LastOperationCache {
  const LastOperationCache();

  Future<Box<LocalSimpleOperationType>> get boxFuture =>
      Hive.openBox(_lastOperationBox);

  Future<LocalSimpleOperationType?> get(int specificationId) async {
    final box = await boxFuture;
    return box.get(specificationId);
  }

  Future<void> save(LocalSimpleOperationType type, int specificationId) async {
    final box = await boxFuture;
    await box.put(specificationId, type);
  }
}
