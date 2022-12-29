import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/models/operation/cached_operation.dart';
import 'package:popper_mobile/data/models/operation/completed_operation.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/data/models/scanned_entity/local_batch.dart';
import 'package:popper_mobile/data/models/scanned_entity/local_bobbin.dart';

@singleton
class AppCache {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(LocalBatchAdapter())
      ..registerAdapter(LocalBobbinAdapter())
      ..registerAdapter(CachedOperationAdapter())
      ..registerAdapter(CompletedOperationAdapter())
      ..registerAdapter(LocalOperationTypeAdapter())
      ..registerAdapter(EntityTypeAdapter());
  }

  static Future<void> clear() async {
    await Hive.deleteFromDisk();
  }
}
