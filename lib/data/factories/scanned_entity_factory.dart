import 'package:popper_mobile/core/error/no_such_entity_type.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/data/models/scanned_entity/local_batch.dart';
import 'package:popper_mobile/data/models/scanned_entity/local_bobbin.dart';
import 'package:popper_mobile/data/models/scanned_entity/local_scanned_entity.dart';
import 'package:popper_mobile/data/models/scanned_entity/remote_batch.dart';
import 'package:popper_mobile/data/models/scanned_entity/remote_bobbin.dart';
import 'package:popper_mobile/domain/models/batch/batch.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';

class ScannedEntityFactory {
  static EntityType mapToType(ScannedEntity entity) {
    if (entity is Bobbin) {
      return EntityType.bobbin;
    }

    if (entity is Batch) {
      return EntityType.batch;
    }

    throw const NoSuchEntityTypeException();
  }

  static LocalScannedEntity mapToLocal(ScannedEntity entity) {
    if (entity is Bobbin) {
      return LocalBobbin(
        id: entity.id,
        batchId: entity.batchId,
        number: entity.rawNumber,
      );
    }

    if (entity is Batch) {
      return LocalBatch(
        id: entity.id,
        taskId: entity.taskId,
        number: entity.rawNumber,
      );
    }

    throw Exception('Error: No such local entity type');
  }

  static LocalBobbin mapToLocalBobbin(RemoteBobbin bobbin) {
    return LocalBobbin(
      id: bobbin.id,
      batchId: bobbin.batchId,
      number: bobbin.number,
    );
  }

  static LocalBatch mapToLocalBatch(RemoteBatch batch) {
    return LocalBatch(
      id: batch.id,
      taskId: batch.taskId,
      number: batch.number,
    );
  }

  static Bobbin mapToBobbin(LocalBobbin bobbin) {
    return Bobbin(
      id: bobbin.id,
      batchId: bobbin.batchId,
      number: bobbin.number,
    );
  }

  static Batch mapToBatch(LocalBatch batch) {
    return Batch(
      id: batch.id,
      taskId: batch.taskId,
      number: batch.number,
    );
  }
}
