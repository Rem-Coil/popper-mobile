import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/cache.dart';
import 'package:popper_mobile/data/models/batch/local_batch.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';

const _checkOperationsBox = 'check_operations';
const _operatorOperationsBox = 'operator_operations';
const _acceptanceOperationsBox = 'acceptance_operations';
const _batchesBox = 'batches_box';

@singleton
class OperatorOperationsCache extends Cache<String, LocalOperatorOperation> {
  const OperatorOperationsCache() : super(_operatorOperationsBox);
}

@singleton
class CheckOperationsCache extends Cache<String, LocalCheckOperation> {
  const CheckOperationsCache() : super(_checkOperationsBox);
}

@singleton
class AcceptanceOperationsCache
    extends Cache<String, LocalAcceptanceOperation> {
  const AcceptanceOperationsCache() : super(_acceptanceOperationsBox);
}

@singleton
class BatchesCache extends Cache<int, LocalBatch> {
  const BatchesCache() : super(_batchesBox);
}