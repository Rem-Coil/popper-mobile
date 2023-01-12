import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/history/batch_history.dart';
import 'package:popper_mobile/domain/models/history/bobbin_history.dart';
import 'package:popper_mobile/domain/models/history/history.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';
import 'package:popper_mobile/domain/repository/batches_repository.dart';
import 'package:popper_mobile/domain/repository/bobbins_repository.dart';

@singleton
class BobbinHistoryUsecase {
  const BobbinHistoryUsecase(this._bobbinsRepository, this._batchesRepository);

  final BobbinsRepository _bobbinsRepository;
  final BatchesRepository _batchesRepository;

  Future<Either<Failure, History>> call(ScannedEntity item) async {
    final history = item is Bobbin
        ? await _bobbinsRepository.getHistoryById(item.id)
        : await _batchesRepository.getHistoryById(item.id);

    if (history.isLeft) return Left(history.left);

    final rawHistory = history.right;

    if (rawHistory is BobbinHistory) {
      return Right(_sortOperations(rawHistory));
    }

    if (rawHistory is BatchHistory) {
      final bobbins = rawHistory.bobbins.map(_sortOperations).toList();
      return Right(BatchHistory(batch: rawHistory.batch, bobbins: bobbins));
    }

    throw UnimplementedError();
  }

  BobbinHistory _sortOperations(BobbinHistory old) {
    final operations = old.operations;
    operations.sort((o1, o2) => o2.time.compareTo(o1.time));

    return BobbinHistory(
      bobbin: old.bobbin,
      operations: operations,
    );
  }
}
