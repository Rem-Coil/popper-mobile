import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/base_repository.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/cache/products_cache.dart';
import 'package:popper_mobile/data/factories/product_factory.dart';
import 'package:popper_mobile/domain/models/product/product_code_data.dart';
import 'package:popper_mobile/domain/models/product/product_info.dart';
import 'package:popper_mobile/domain/models/specification/specification.dart';
import 'package:popper_mobile/domain/repository/products_repository.dart';

@Singleton(as: ProductsRepository)
class ProductsRepositoryImpl extends BaseRepository
    implements ProductsRepository {
  const ProductsRepositoryImpl(super.apiProvider, this._cache, this._factory);

  final ProductsCache _cache;
  final ProductFactory _factory;

  @override
  Future<ProductInfo> getInfo(int id) async {
    await _updateBobbinInfo(id);
    final local = await _cache.getByKey(id);

    if (local == null) return ProductInfo.unknown(id);
    return await _factory.mapToInfo(local);
  }

  @override
  Future<ProductInfo> getInfoByCode(ProductCodeData code) async {
    await _updateBobbinInfo(code.id);
    final local = await _cache.getByKey(code.id);

    if (local == null) {
      return ProductInfo.unknown(
        code.id,
        specification: Specification.unknown(id: code.specificationId),
      );
    }
    return await _factory.mapToInfo(local);
  }

  Future<void> _updateBobbinInfo(int id) async {
    try {
      final service = apiProvider.getApiService();
      final remote = await service.getProductInfo(id);
      final local = await _factory.mapRemoteToLocal(remote);
      await _cache.save(local);
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  FResult<void> deactivateProduct(int id) async {
    try {
      final api = apiProvider.getApiService();
      await api.deactivateProduct(id);
      await _updateBobbinInfo(id);
      return const Right(null);
    } on DioException catch (e) {
      return handleDioException(e);
    }
  }
}
