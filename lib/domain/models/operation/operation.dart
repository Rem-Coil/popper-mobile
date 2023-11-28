import 'package:flutter/foundation.dart';
import 'package:popper_mobile/domain/models/product/product_info.dart';
import 'package:popper_mobile/domain/models/user/user.dart';

enum OperationStatus { draft, sync, notSync }

@immutable
abstract class Operation {
  @protected
  static const defaultId = -1;

  const Operation({
    required this.id,
    required this.user,
    required this.products,
    required this.time,
    required this.status,
  });

  final int id;
  final User user;
  final List<ProductInfo> products;
  final OperationStatus status;
  final DateTime time;

  Operation setId(int id) => copy(id: id, status: OperationStatus.sync);

  Operation setStatus(OperationStatus status) => copy(status: status);

  @protected
  Operation copy({
    int? id,
    OperationStatus? status,
  });

  String? get typeName;

  bool get savable;

  String get productsName => products.length > 1
      ? '${products.first.number} - ${products.last.number}'
      : products.first.number;
}
