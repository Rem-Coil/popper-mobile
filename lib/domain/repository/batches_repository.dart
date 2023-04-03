import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/batch/batch.dart';
import 'package:popper_mobile/domain/models/history/batch_history.dart';

abstract class BatchesRepository {
  Future<Batch> getBatchInfo(int id);

  FResult<BatchHistory> getHistoryById(int id);
}
