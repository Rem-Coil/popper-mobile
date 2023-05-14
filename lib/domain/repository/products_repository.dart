import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/product/product_info.dart';

abstract class ProductsRepository {
  Future<ProductInfo> getInfo(int id);

  FResult<void> deactivateProduct(int id);
}
