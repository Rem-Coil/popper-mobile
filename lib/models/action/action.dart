import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';

part 'action.g.dart';
part 'action_local.dart';
part 'action_remote.dart';

final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');

@immutable
class Action {
  static const defaultId = -1;

  final int id;
  final int userId;
  final Bobbin bobbin;
  final ActionType? type;
  final DateTime time;

  Action({
    required this.id,
    required this.userId,
    required this.bobbin,
    required this.type,
    required this.time,
  });

  factory Action.create({
    required int userId,
    required Bobbin bobbin,
    required DateTime date,
  }) {
    return Action(
      id: defaultId,
      userId: userId,
      bobbin: bobbin,
      type: null,
      time: date,
    );
  }

  Action changeType(ActionType? type) {
    return Action(
      id: this.id,
      userId: this.userId,
      bobbin: this.bobbin,
      type: type,
      time: this.time,
    );
  }

  ActionLocal toLocal() {
    final localBobbin = bobbin.toLocal();
    return ActionLocal(
      id: id,
      userId: userId,
      bobbin: localBobbin,
      type: type,
      time: time,
    );
  }

  ActionRemote toRemote() {
    return ActionRemote(
      id: id,
      userId: userId,
      bobbin: bobbin,
      type: type!,
      time: time,
    );
  }
}
