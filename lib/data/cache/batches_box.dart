import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/cache/core/cache.dart';
import 'package:popper_mobile/data/models/scanned_entity/local_batch.dart';

const _batchesBox = 'batches_box';

@singleton
class BatchesCache extends Cache<int, LocalBatch> {
  const BatchesCache() : super(_batchesBox);
}