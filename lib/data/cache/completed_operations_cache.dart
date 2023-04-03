import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/cache/core/cache.dart';
import 'package:popper_mobile/data/models/operation/completed_operation.dart';

const _completedOperationsBox = 'saved_operations';

@singleton
class CompletedOperationsCache extends Cache<int, CompletedOperation> {
  const CompletedOperationsCache() : super(_completedOperationsBox);
}
