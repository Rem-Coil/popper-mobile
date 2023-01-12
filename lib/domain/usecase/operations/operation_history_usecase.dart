import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/history/bobbin_history.dart';
import 'package:popper_mobile/domain/repository/bobbins_repository.dart';

@singleton
class BobbinHistoryUsecase {
  const BobbinHistoryUsecase(this._repository);

  final BobbinsRepository _repository;

  Future<Either<Failure, BobbinHistory>> call(Bobbin bobbin) async {
    final history = await _repository.getHistoryById(bobbin.id);
    if (history.isLeft) return Left(history.left);

    final rawHistory = history.right;
    final operations = rawHistory.operations;
    operations.sort((o1, o2) => o2.time.compareTo(o1.time));

    return Right(BobbinHistory(
      bobbin: rawHistory.bobbin,
      operations: operations,
    ));
  }
}
