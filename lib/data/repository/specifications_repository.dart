import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/base_repository.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/data/cache/last_operation_cache.dart';
import 'package:popper_mobile/data/cache/specifications_cache.dart';
import 'package:popper_mobile/data/factories/specification_factory.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/models/specification/specification.dart';
import 'package:popper_mobile/domain/repository/operations_types_repository.dart';

@module
abstract class SpecificationModule {
  SpecificationsRepository specification(
    ApiProvider apiProvider,
    SpecificationsCache cache,
    SpecificationFactory factory,
    LastOperationCache lastOperationCache,
  ) =>
      SpecificationsRepository(
        apiProvider,
        cache,
        factory,
        lastOperationCache,
      );

  OperationTypesRepository operationsTypes(
    ApiProvider apiProvider,
    SpecificationsCache cache,
    SpecificationFactory factory,
    LastOperationCache lastOperationCache,
  ) =>
      SpecificationsRepository(
        apiProvider,
        cache,
        factory,
        lastOperationCache,
      );
}

class SpecificationsRepository extends BaseRepository
    implements OperationTypesRepository {
  const SpecificationsRepository(
    super.apiProvider,
    this._cache,
    this._factory,
    this._lastOperationCache,
  );

  final SpecificationsCache _cache;
  final SpecificationFactory _factory;
  final LastOperationCache _lastOperationCache;

  Future<Specification?> getSpecificationById(int id) async {
    final cached = await _cache.getByKey(id);
    if (cached != null) return _factory.mapToSpec(cached);
    return null;
  }

  @override
  FResult<ActionType?> getTypeById(int typeId) async {
    final spec = await _cache.getAll();
    final type = spec
        .map((s) => s.operationTypes)
        .expand((t) => t)
        .where((t) => t.id == typeId);

    if (type.length != 1) return const Right(null);
    final local = type.first;
    return Right(ActionType(local.id, local.name));
  }

  @override
  FResult<List<ActionType>> getTypesBySpec(int specificationId) async {
    final spec = await _cache.getByKey(specificationId);
    final types =
        spec?.operationTypes.map((o) => ActionType(o.id, o.name)) ?? [];
    return Right(types.toList());
  }

  @override
  Future<void> syncTypes() async {
    try {
      final service = apiProvider.getApiService();
      final specifications = await service.getAllSpecifications();
      final local = specifications.map(_factory.mapToLocal);
      await _cache.clear();
      await _cache.saveAll(local);
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<ActionType?> getLastType(int specificationId) async {
    final type = await _lastOperationCache.get(specificationId);
    if (type == null) return null;
    return ActionType(type.id, type.name);
  }

  @override
  Future<void> setLastType(
    int specificationId,
    ActionType type,
  ) async {
    final local = _factory.mapToSimpleLocalType(type);
    await _lastOperationCache.save(local, specificationId);
  }
}
