import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/data/models/operation_type/local_operation_type.dart';
import 'package:popper_mobile/data/models/product/local_product.dart';
import 'package:popper_mobile/data/models/specification/local_specification.dart';

@singleton
class AppCache {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(LocalCheckOperationAdapter())
      ..registerAdapter(LocalOperationStatusAdapter())
      ..registerAdapter(LocalOperatorOperationAdapter())
      ..registerAdapter(LocalOperationTypeAdapter())
      ..registerAdapter(LocalProductAdapter())
      ..registerAdapter(LocalSimpleOperationTypeAdapter())
      ..registerAdapter(LocalSpecificationAdapter());
  }

  static Future<void> clear() async {
    await Hive.deleteFromDisk();
  }
}
