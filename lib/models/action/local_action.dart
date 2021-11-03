import 'package:hive/hive.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';
import 'package:popper_mobile/models/action/action_type.dart';

part 'local_action.g.dart';

@HiveType(typeId: 0)
class LocalAction extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int userId;
  @HiveField(2)
  final int bobbinId;
  @HiveField(3)
  final ActionType type;
  @HiveField(4)
  final DateTime time;
  @HiveField(5)
  bool isSynchronized;

  LocalAction({
    required this.id,
    required this.userId,
    required this.bobbinId,
    required this.type,
    required this.time,
    required this.isSynchronized,
  });

  String get formattedDate {
    final formattedDateTime = FormattedDateTime(time);
    return formattedDateTime.formattedDate;
  }
}
