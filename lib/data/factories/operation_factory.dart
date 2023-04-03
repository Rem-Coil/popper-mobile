import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/data/factories/scanned_entity_factory.dart';
import 'package:popper_mobile/data/models/operation/cached_operation.dart';
import 'package:popper_mobile/data/models/operation/completed_operation.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/data/models/operation/remote_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/models/operation/operation_with_comment.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';
import 'package:popper_mobile/domain/models/user/user.dart';

const _typeLocalRelations = {
  OperationType.winding: LocalOperationType.winding,
  OperationType.output: LocalOperationType.output,
  OperationType.isolation: LocalOperationType.isolation,
  OperationType.molding: LocalOperationType.molding,
  OperationType.crimping: LocalOperationType.crimping,
  OperationType.quality: LocalOperationType.quality,
  OperationType.testing: LocalOperationType.testing,
};

const _typeRemoteRelations = {
  OperationType.winding: RemoteOperationType.winding,
  OperationType.output: RemoteOperationType.output,
  OperationType.isolation: RemoteOperationType.isolation,
  OperationType.molding: RemoteOperationType.molding,
  OperationType.crimping: RemoteOperationType.crimping,
  OperationType.quality: RemoteOperationType.quality,
  OperationType.testing: RemoteOperationType.testing,
};

class OperationFactory {
  static LocalOperation mapToLocal(Operation operation) {
    final entityType = ScannedEntityFactory.mapToType(operation.item);
    final entityId = operation.item.id;
    final type = _typeLocalRelations[operation.type!];

    if (type == null) {
      throw Exception('Error: OperationType must not be null');
    }

    if (operation.status == OperationStatus.sync) {
      return CompletedOperation(
        id: operation.id,
        entityType: entityType,
        entityId: entityId,
        type: type,
        time: operation.time,
        isSuccessful: operation.isSuccessful,
      );
    }

    if (operation.status == OperationStatus.notSync) {
      return CachedOperation(
        entityType: entityType,
        entityId: entityId,
        type: type,
        time: operation.time,
        isSuccessful: operation.isSuccessful,
      );
    }

    throw Exception('Error: This status not support');
  }

  static RemoteOperation mapToRemote(Operation operation) {
    final entityType = ScannedEntityFactory.mapToType(operation.item);
    final entityId = operation.item.id;
    final type = _typeRemoteRelations[operation.type!];

    if (type == null) {
      throw Exception('Error: OperationType must not be null');
    }

    if (entityType == EntityType.batch) {
      return RemoteBatchOperation(
        id: operation.id,
        batchId: entityId,
        type: type,
        time: operation.time,
        successful: operation.isSuccessful,
      );
    }

    if (entityType == EntityType.bobbin) {
      return RemoteBobbinOperation(
        id: operation.id,
        bobbinId: entityId,
        type: type,
        time: operation.time,
        successful: operation.isSuccessful,
      );
    }

    throw Exception('Error: This entity type not support');
  }

  static Operation mapFromRemoteToOperation(
    User user,
    RemoteOperation operation,
    ScannedEntity item, [
    String? comment,
  ]) {
    final id = operation.id;
    const status = OperationStatus.sync;
    final type = $enumDecode(_typeRemoteRelations, operation.type);

    if (comment != null) {
      return OperationWithComment(
        id: id,
        user: user,
        item: item,
        type: type,
        time: operation.time,
        status: status,
        isSuccessful: operation.successful,
        comment: comment,
      );
    }

    return Operation(
      id: id,
      status: status,
      user: user,
      item: item,
      type: type,
      isSuccessful: operation.successful,
      time: operation.time,
    );
  }

  static Operation mapToOperation(
    User user,
    LocalOperation operation,
    ScannedEntity item,
    String? comment,
  ) {
    late final int id;
    late final OperationStatus status;
    final type = $enumDecode(_typeLocalRelations, operation.type);

    if (operation is CompletedOperation) {
      id = operation.id;
      status = OperationStatus.sync;
    }

    if (operation is CachedOperation) {
      id = -1;
      status = OperationStatus.notSync;
    }

    if (comment != null) {
      return OperationWithComment(
        id: id,
        user: user,
        item: item,
        type: type,
        time: operation.time,
        status: status,
        isSuccessful: operation.isSuccessful,
        comment: comment,
      );
    }

    return Operation(
      id: id,
      status: status,
      user: user,
      item: item,
      type: type,
      isSuccessful: operation.isSuccessful,
      time: operation.time,
    );
  }
}
