import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/models/operation/check_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operator_operation.dart';
import 'package:popper_mobile/domain/models/product/product_code_data.dart';
import 'package:popper_mobile/domain/models/user/role.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';
import 'package:popper_mobile/domain/repository/operations_types_repository.dart';
import 'package:popper_mobile/domain/repository/products_repository.dart';

@injectable
class CreateOperationUseCase {
  const CreateOperationUseCase(
    this._productsRepository,
    this._authRepository,
    this._operationsTypesRepository,
  );

  final ProductsRepository _productsRepository;
  final AuthRepository _authRepository;
  final OperationTypesRepository _operationsTypesRepository;

  Future<Operation> call(ProductCodeData code) async {
    final product = await _productsRepository.getInfoByCode(code);
    final user = await _authRepository.getCurrentUser();
    final time = DateTime.now();

    if (user.role == Role.qualityEngineer) {
      return CheckOperation.create(
        user: user,
        product: product,
        time: time,
      );
    }

    final spec = code.specificationId;
    final type = await _operationsTypesRepository.getLastType(spec);
    return OperatorOperation.create(
      user: user,
      product: product,
      type: type,
      time: time,
    );
  }
}
