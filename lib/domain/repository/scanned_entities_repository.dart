import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';

abstract class ScannedEntitiesRepository {
  Future<ScannedEntity> getEntityInfo(ScannedEntity entity);
}
