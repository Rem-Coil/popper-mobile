import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/history/bobbin_history.dart';

abstract class BobbinsRepository {
  Future<Bobbin> getBobbinInfo(int id, {bool isHard = false});

  FResult<BobbinHistory> getHistoryById(int id);

  FResult<void> defectBobbin(Bobbin bobbin);
}
