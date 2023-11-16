import 'package:hive_flutter/hive_flutter.dart';
import 'package:popper_mobile/core/data/cache.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';

part 'local_operation.g.dart';

@HiveType(typeId: 16)
enum LocalOperationStatus {
  @HiveField(0)
  draft,
  @HiveField(1)
  sync,
  @HiveField(2)
  notSync,
}

const defaultOperationId = -1;

abstract class LocalOperation implements Cacheable<String> {
  const LocalOperation({
    required this.id,
    required this.userId,
    required this.productId,
    required this.time,
    required this.status,
  });

  @HiveField(0)
  final int id;
  @HiveField(2)
  final int userId;
  @HiveField(3)
  final int productId;
  @HiveField(4)
  final DateTime time;
  @HiveField(5)
  final LocalOperationStatus status;
}

@HiveType(typeId: 23)
class LocalAcceptanceOperation extends LocalOperation {
  LocalAcceptanceOperation({
    required super.id,
    required super.userId,
    required super.productId,
    required super.time,
    required super.status,
  });

  @override
  String get key {
    if (status == LocalOperationStatus.sync) return '$id';

    final timeFormatted = Formatters.operation.format(time);
    return '$productId-$timeFormatted';
  }
}

abstract class LocalOperationWithType extends LocalOperation {
  const LocalOperationWithType({
    required super.id,
    required super.userId,
    required super.productId,
    required super.time,
    required super.status,
    required this.operationId,
  });

  @HiveField(1)
  final int operationId;

  @override
  String get key {
    if (status == LocalOperationStatus.sync) return '$id';

    final timeFormatted = Formatters.operation.format(time);
    return '$productId-$operationId-$timeFormatted';
  }
}

@HiveType(typeId: 17)
class LocalOperatorOperation extends LocalOperationWithType {
  const LocalOperatorOperation({
    required super.id,
    required super.operationId,
    required super.userId,
    required super.productId,
    required super.time,
    required super.status,
    required this.isRepair,
  });

  @HiveField(10)
  final bool isRepair;
}

@HiveType(typeId: 18)
class LocalCheckOperation extends LocalOperationWithType {
  const LocalCheckOperation({
    required super.id,
    required super.operationId,
    required super.userId,
    required super.productId,
    required super.time,
    required super.status,
    required this.isSuccessful,
    required this.checkType,
    required this.comment,
    required this.isNeedRepair,
  });

  @HiveField(11)
  final bool isSuccessful;
  @HiveField(12)
  final String checkType;
  @HiveField(13)
  final String? comment;
  @HiveField(14)
  final bool isNeedRepair;
}
