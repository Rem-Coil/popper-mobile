import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/repository/base_repository.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/data/cache/batches_box.dart';
import 'package:popper_mobile/data/factories/history_factory.dart';
import 'package:popper_mobile/data/factories/scanned_entity_factory.dart';
import 'package:popper_mobile/domain/models/batch/batch.dart';
import 'package:popper_mobile/domain/models/history/batch_history.dart';
import 'package:popper_mobile/domain/repository/batches_repository.dart';

@Singleton(as: BatchesRepository)
class BobbinsRepositoryImpl extends BaseRepository
    implements BatchesRepository {
  const BobbinsRepositoryImpl(this._apiProvider, this._cache);

  final ApiProvider _apiProvider;
  final BatchesCache _cache;

  @override
  Future<Batch> getBatchInfo(int id) async {
    final local = await _cache.getByKey(id);
    if (local != null) return ScannedEntityFactory.mapToBatch(local);

    try {
      final service = _apiProvider.getApiService();
      final remote = await service.getBatchInfo(id);

      final local = ScannedEntityFactory.mapToLocalBatch(remote);
      await _cache.save(local);

      final batch = ScannedEntityFactory.mapToBatch(local);
      return batch;
    } on DioError {
      return Batch.unknown(id);
    }
  }

  @override
  FResult<BatchHistory> getHistoryById(int id) async {
    try {
      final api = _apiProvider.getApiService();
      final history = await api.getBatchHistory(id);
      return Right(HistoryFactory.mapBatchHistory(history));
    } on DioError catch (e) {
      final failure = handleError(e, {
        HttpStatus.notFound: const BatchNotContainOperationsFailure(),
      });
      return Left(failure);
    }
  }
}
