import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/data/models/batch/remote_batch.dart';
import 'package:popper_mobile/data/models/kit/remote_kit.dart';
import 'package:popper_mobile/data/models/product/local_product.dart';
import 'package:popper_mobile/data/models/product/remote_product.dart';
import 'package:popper_mobile/data/repository/specifications_repository.dart';
import 'package:popper_mobile/domain/models/product/product_info.dart';

@singleton
class ProductFactory {
  const ProductFactory(this._specs, this._apiProvider);

  final SpecificationsRepository _specs;
  final ApiProvider _apiProvider;

  Future<ProductInfo> mapToInfo(LocalProduct product) async {
    final spec = await _specs.getSpecificationById(product.specificationId);
    return ProductInfo(
      id: product.id,
      kitNumber: product.kitNumber,
      batchNumber: product.batchNumber,
      productNumber: product.productNumber,
      specification: spec,
    );
  }

  Future<LocalProduct> mapRemoteToLocal(RemoteProduct product) async {
    final batch = await _fetchBatch(product.batchId);
    final kit = batch != null ? await _fetchKit(batch.kitId) : null;

    return LocalProduct(
      id: product.id,
      kitNumber: kit?.number,
      batchNumber: batch?.number,
      productNumber: product.number,
      specificationId: kit?.specificationId ?? -1,
      isActive: product.isActive,
    );
  }

  Future<RemoteBatch?> _fetchBatch(int id) async {
    try {
      final service = _apiProvider.getApiService();
      return await service.getBatchById(id);
    } on DioError {
      return null;
    }
  }

  Future<RemoteKit?> _fetchKit(int id) async {
    try {
      final service = _apiProvider.getApiService();
      return await service.getKitById(id);
    } on DioError {
      return null;
    }
  }
}
