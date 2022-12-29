import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/repository/base_repository.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/domain/models/batch/batch.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';
import 'package:popper_mobile/domain/repository/batches_repository.dart';
import 'package:popper_mobile/domain/repository/bobbins_repository.dart';
import 'package:popper_mobile/domain/repository/scanned_entities_repository.dart';

abstract class LocalScannedEntitiesRepository {
  Future<ScannedEntity> getLocalEntityInfo(int id, EntityType type);
}

@module
abstract class ScannedEntitiesRepositoryModule {
  LocalScannedEntitiesRepository getLocal(
    BobbinsRepository bobbin,
    BatchesRepository batches,
  ) =>
      ScannedEntitiesRepositoryImpl(bobbin, batches);

  ScannedEntitiesRepository getDomain(
    BobbinsRepository bobbin,
    BatchesRepository batches,
  ) =>
      ScannedEntitiesRepositoryImpl(bobbin, batches);
}

class ScannedEntitiesRepositoryImpl extends BaseRepository
    implements LocalScannedEntitiesRepository, ScannedEntitiesRepository {
  const ScannedEntitiesRepositoryImpl(
      this.bobbinsRepository, this.batchesRepository);

  final BobbinsRepository bobbinsRepository;
  final BatchesRepository batchesRepository;

  @override
  Future<ScannedEntity> getLocalEntityInfo(int id, EntityType type) {
    if (type == EntityType.bobbin) {
      return bobbinsRepository.getBobbinInfo(id);
    }

    if (type == EntityType.batch) {
      return batchesRepository.getBatchInfo(id);
    }

    throw Exception('Error: No such entity type');
  }

  @override
  Future<ScannedEntity> getEntityInfo(ScannedEntity entity) {
    if (entity is Bobbin) {
      return bobbinsRepository.getBobbinInfo(entity.id);
    }

    if (entity is Batch) {
      return batchesRepository.getBatchInfo(entity.id);
    }

    throw Exception('Error: No such entity type');
  }
}
