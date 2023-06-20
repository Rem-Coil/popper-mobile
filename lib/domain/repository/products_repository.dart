import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/product/product_code_data.dart';
import 'package:popper_mobile/domain/models/product/product_info.dart';

abstract class ProductsRepository {
  Future<ProductInfo> getInfo(int id);

  Future<ProductInfo> getInfoByCode(ProductCodeData code);

  FResult<void> deactivateProduct(int id);
}
