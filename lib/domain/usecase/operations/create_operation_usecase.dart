import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/operation/acceptance_operation.dart';
import 'package:popper_mobile/domain/models/operation/check_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operator_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
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

  FResult<Operation> call(
    ProductCodeData code, {
    OperationType? operationType,
  }) async {
    final user = await _authRepository.getCurrentUser();
    final product = await _productsRepository.getInfoByCode(code);
    final time = DateTime.now();

    late final Operation operation;

    if (user.role == Role.qualityEngineer) {
      if (operationType == null) {
        return const Left(OperationTypeNotSelectedFailure());
      } else if (operationType == OperationType.acceptance) {
        operation = AcceptanceOperation.create(
          user: user,
          product: product,
          time: time,
        );
      } else {
      operation = CheckOperation.create(
          user: user,
          product: product,
          time: time,
        );
      }

    } else {
      final spec = code.specificationId;
      final type = await _operationsTypesRepository.getLastType(spec);

      operation = OperatorOperation.create(
        user: user,
        product: product,
        type: type,
        time: time,
      );
    }

    return Right(operation);
  }
}
