import 'package:popper_mobile/domain/models/product/product_info.dart';
import 'package:popper_mobile/domain/models/history/history.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';

class ProductHistory implements History {
  const ProductHistory({required this.product, required this.operations});

  final ProductInfo product;
  final List<Operation> operations;

  @override
  String get number => product.number;
}
