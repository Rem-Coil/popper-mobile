import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/cache/operations_cache.dart';
import 'package:popper_mobile/models/operation/operation.dart';

@singleton
class GetAllOperationsUsecase {
  GetAllOperationsUsecase(this._cache);

  final OperationsCache _cache;

  Future<List<Operation>> call() async {
    final operationsByGroup = await Future.wait([
      _cache.getCompletedOperations(),
      _cache.getCachedOperations(),
    ]);

    final operations = operationsByGroup.expand((e) => e).toList();
    operations.sort((a, b) => -a.time.compareTo(b.time));
    return operations;
  }
}
