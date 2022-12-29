import 'package:popper_mobile/domain/models/batch/batch.dart';

abstract class BatchesRepository {
  Future<Batch> getBatchInfo(int id);
}
