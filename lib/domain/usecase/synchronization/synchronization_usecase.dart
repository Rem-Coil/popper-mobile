import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/repository/operations_types_repository.dart';

@injectable
class SynchronizationUseCase {
  const SynchronizationUseCase(this._specificationsRepository);

  final OperationTypesRepository _specificationsRepository;

  Future<void> call() async {
    await _specificationsRepository.syncTypes();
  }
}
