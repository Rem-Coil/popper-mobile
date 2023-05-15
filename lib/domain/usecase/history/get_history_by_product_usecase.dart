import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/history/product_history.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';
import 'package:popper_mobile/domain/repository/products_repository.dart';

@singleton
class GetHistoryByProductUsecase {
  const GetHistoryByProductUsecase(
    this._checkOperationsRepository,
    this._operatorOperationsRepository,
    this._productsRepository,
  );

  final CheckOperationsRepository _checkOperationsRepository;
  final OperatorOperationsRepository _operatorOperationsRepository;
  final ProductsRepository _productsRepository;

  FResult<ProductHistory> call(int productId) async {
    final product = await _productsRepository.getInfo(productId);

    final operatorOperations =
        await _operatorOperationsRepository.getByProduct(productId);

    if (operatorOperations.isLeft) {
      final failure = operatorOperations.left;
      return Left(failure);
    }

    final checkOperations =
        await _checkOperationsRepository.getByProduct(productId);

    if (checkOperations.isLeft) {
      final failure = checkOperations.left;
      return Left(failure);
    }

    final operations = <Operation>[];
    operations.addAll(operatorOperations.right);
    operations.addAll(checkOperations.right);
    operations.sort((o1, o2) => o2.time.compareTo(o1.time));

    return Right(ProductHistory(
      product: product,
      operations: operations,
    ));
  }
}
