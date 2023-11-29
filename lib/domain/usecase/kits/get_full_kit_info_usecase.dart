import 'package:collection/collection.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/repository/batches_reposiotory.dart';
import 'package:popper_mobile/data/repository/kits_repository.dart';
import 'package:popper_mobile/domain/entities/full_kit_info.dart';

@singleton
class GetFullKitInfoUsecase {
  const GetFullKitInfoUsecase(
    this._batchesRepository,
    this._kitsRepository,
  );

  final BatchesRepository _batchesRepository;
  final KitsRepository _kitsRepository;

  FResult<List<FullKitInfo>> call() async {
    final kits = await _kitsRepository.getAllKits();

    if (kits.isLeft) {
      final failure = kits.left;
      return Left(failure);
    }

    final batches = await _batchesRepository.getAllBatches();

    if (batches.isLeft) {
      final failure = batches.left;
      return Left(failure);
    }

    final groupedBatches = groupBy(batches.right, (p0) => p0.kitId);

    List<FullKitInfo> result = kits.right
        .map((k) => FullKitInfo(
            kit: k,
            batches:
                groupedBatches.containsKey(k.id) ? groupedBatches[k.id]! : []))
        .toList();

    return Right(result);
  }
}
