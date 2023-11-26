import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/base_repository.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/kit/batch.dart';

@Singleton()
class BatchesRepository extends BaseRepository {
  const BatchesRepository(super.apiProvider);


  FResult<List<Batch>> getAllBatches() async {
    try {
      final service = apiProvider.getApiService();
      final batches = await service.getAllBatches();

      return Right(batches);
    } on DioException catch (e) {
      return handleDioException(e);
    }
  }
}