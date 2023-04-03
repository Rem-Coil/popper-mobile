import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/repository/base_repository.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/data/cache/bobbins_cache.dart';
import 'package:popper_mobile/data/factories/history_factory.dart';
import 'package:popper_mobile/data/factories/scanned_entity_factory.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/history/bobbin_history.dart';
import 'package:popper_mobile/domain/repository/bobbins_repository.dart';

@Singleton(as: BobbinsRepository)
class BobbinsRepositoryImpl extends BaseRepository
    implements BobbinsRepository {
  const BobbinsRepositoryImpl(this._apiProvider, this._cache);

  final ApiProvider _apiProvider;
  final BobbinsCache _cache;

  @override
  Future<Bobbin> getBobbinInfo(int id, {bool isHard = false}) async {
    final isCached = await _cache.contains(id);

    if (isHard || !isCached) {
      await _updateBobbinInfo(id);
    }

    final local = await _cache.getByKey(id);
    if (local == null) {
      return Bobbin.unknown(id);
    }
    return ScannedEntityFactory.mapToBobbin(local);
  }

  Future<void> _updateBobbinInfo(int id) async {
    try {
      final service = _apiProvider.getApiService();
      final remote = await service.getBobbinInfo(id);

      final local = ScannedEntityFactory.mapToLocalBobbin(remote);
      await _cache.save(local);
    } on DioError catch (e) {
      log(e.error.toString());
    }
  }

  @override
  FResult<BobbinHistory> getHistoryById(int id) async {
    try {
      final api = _apiProvider.getApiService();
      final history = await api.getBobbinHistory(id);
      return Right(HistoryFactory.mapBobbinHistory(history));
    } on DioError catch (e) {
      final failure = await handleError(e, {
        HttpStatus.notFound: const BobbinNotContainOperationsFailure(),
      });
      return Left(failure);
    }
  }

  @override
  FResult<void> defectBobbin(Bobbin bobbin) async {
    try {
      final api = _apiProvider.getApiService();
      await api.defectBobbin(bobbin.id);
      await _updateBobbinInfo(bobbin.id);
      return const Right(null);
    } on DioError catch (e) {
      final failure = await handleError(e);
      return Left(failure);
    }
  }
}
