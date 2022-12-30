import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';

abstract class BobbinsRepository {
  Future<Bobbin> getBobbinInfo(int id);

  FResult<void> defectBobbin(int id);
}
