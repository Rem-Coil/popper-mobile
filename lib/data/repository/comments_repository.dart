import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/repository/base_repository.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/data/cache/comments_cache.dart';
import 'package:popper_mobile/data/models/comment/local_comment.dart';
import 'package:popper_mobile/data/models/comment/remote_comment.dart';

@singleton
class CommentsRepository extends BaseRepository {
  const CommentsRepository(this._apiProvider, this._cache);

  final ApiProvider _apiProvider;
  final CommentsCache _cache;

  Future<String?> getByOperation(String operationId) async {
    final local = await _cache.getByKey(operationId);
    return local?.comment;
  }

  Future<void> save(int operationId, String? comment) async {
    if (comment == null || comment.isEmpty) return;
    try {
      final service = _apiProvider.getApiService(isSafe: true);
      final json = RemoteComment(operationId: operationId, comment: comment);
      await service.saveComment(json);
    } on DioError catch (e) {
      log(e.error.toString());
      await FirebaseCrashlytics.instance.recordError(e.error, e.stackTrace,
          reason: 'Error on saving comment with id = $operationId');
    } finally {
      await _cache.save(
        LocalComment(operationId: operationId.toString(), comment: comment),
      );
    }
  }

  Future<void> cache(String operationId, String? comment) async {
    if (comment == null || comment.isEmpty) return;
    await _cache.save(LocalComment(operationId: operationId, comment: comment));
  }

  FResult<void> delete(int operationId) async {
    try {
      final service = _apiProvider.getApiService(isSafe: true);
      await service.deleteComment(operationId);
      return const Right(null);
    } on DioError catch (e) {
      log(e.error.toString());
      await FirebaseCrashlytics.instance.recordError(e.error, e.stackTrace,
          reason: 'Error on deleting comment with id = $operationId');
      return Left(await handleError(e));
    }
  }

  Future<void> deleteFromCache(String operationId) async {
    await _cache.delete(operationId);
  }
}
