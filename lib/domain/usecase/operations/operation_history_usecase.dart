import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/history/type_history.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';

@singleton
class BobbinHistoryUsecase {
  const BobbinHistoryUsecase(this._repository);

  final OperationsRepository _repository;

  Future<Either<Failure, List<TypeHistory>>> call(Bobbin bobbin) async {
    final operations = await _repository.getByBobbin(bobbin);
    if (operations.isLeft) return Left(operations.left);

    return Right(_groupByType(operations.right));
  }

  List<TypeHistory> _groupByType(List<Operation> operations) {
    return OperationType.values.map((t) {
      final groupedOperations = operations.where((o) => o.type == t).toList();
      groupedOperations.sort((o1, o2) => o1.time.compareTo(o2.time));
      return TypeHistory(type: t, operations: groupedOperations);
    }).toList();
  }
}
