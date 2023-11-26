import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/base_repository.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/kit/kit.dart';

@Singleton()
class KitsRepository extends BaseRepository {
  const KitsRepository(super.apiProvider);


  FResult<List<Kit>> getAllKits() async {
    try {
      final service = apiProvider.getApiService();
      final kits = await service.getAllKits();

      return Right(kits);
    } on DioException catch (e) {
      return handleDioException(e);
    }
  }
}