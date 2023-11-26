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

    List<FullKitInfo> result = kits.right.expand<FullKitInfo>((kit) {
      final batchesInKit =
          batches.right.where((b) => b.kitId == kit.id).toList();
      return [FullKitInfo(kit: kit, batches: batchesInKit)];
    }).toList();

    return Right(result);
  }
}
