import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/repository/base_repository.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/domain/repository/bobbins_repository.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';

@Singleton(as: BobbinsRepository)
class BobbinsRepositoryImpl extends BaseRepository
    implements BobbinsRepository {
  final ApiProvider _apiProvider;

  BobbinsRepositoryImpl(this._apiProvider);

  @override
  Future<Either<Failure, Bobbin>> getBobbinInfo(int id) async {
    try {
      final service = _apiProvider.getApiService();
      final bobbin = await service.getBobbinInfo(id);
      return Right(bobbin);
    } on DioError catch (e) {
      final failure = handleError(e, {
        HttpStatus.unauthorized: NoSuchBobbinFailure(),
      });

      return Left(failure);
    }
  }
}
