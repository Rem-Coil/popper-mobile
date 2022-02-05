import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/models/action/action_type.dart';

part 'action.g.dart';

part 'action_remote.dart';

part 'action_local.dart';

final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');

@immutable
class Action {
  final int id;
  final int userId;
  final int bobbinId;
  final ActionType type;
  final DateTime time;

  Action({
    required this.id,
    required this.userId,
    required this.bobbinId,
    required this.type,
    required this.time,
  });
}
