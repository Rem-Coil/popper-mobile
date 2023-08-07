import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/cache.dart';
import 'package:popper_mobile/data/models/product/local_product.dart';

const _productsBox = 'products';

@singleton
class ProductsCache extends Cache<int, LocalProduct> {
    const ProductsCache() : super(_productsBox);
}
