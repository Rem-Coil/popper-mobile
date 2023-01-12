import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';

@singleton
class GetAllOperationsUsecase {
  const GetAllOperationsUsecase(this._repository);

  final OperationsRepository _repository;

  Future<List<Operation>> getAll() async {
    final operations = await _repository.getAll();
    operations.sort((a, b) => b.time.compareTo(a.time));
    return operations;
  }
}
