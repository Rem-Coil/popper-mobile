import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/base_repository.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/cache/operations_cache.dart';
import 'package:popper_mobile/data/models/batch/local_batch.dart';
import 'package:popper_mobile/domain/models/kit/batch.dart';

@Singleton()
class BatchesRepository extends BaseRepository {
  const BatchesRepository(super.apiProvider, this._cache);

  final BatchesCache _cache;


  FResult<List<Batch>> getAllBatches() async {
    try {
      final service = apiProvider.getApiService();
      final batches = await service.getAllBatches();

      return Right(batches);
    } on DioException catch (e) {
      return handleDioException(e);
    }
  }

  Future<List<Batch>> getAllSaved() async {
    final batches = await _cache.getAll();
    return batches;
  }

  FResult<void> cache(Batch batch) async {
    try {
      await _cache.save(LocalBatch.from(batch));
      return const Right(null);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  FResult<void> cacheAll(List<Batch> batches) async {
    try {
      final localBatches = batches.map((b) => LocalBatch.from(b));
      await _cache.saveAll(localBatches);
      return const Right(null);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  Future<void> delete(Batch batch) async {
    final local = LocalBatch.from(batch);
    await _cache.delete(local.key);
  }

  Future<void> deleteAll(List<Batch> batches) async {
    for (var batch in batches) {
      await _cache.delete(LocalBatch.from(batch).key);
    }
  }
}