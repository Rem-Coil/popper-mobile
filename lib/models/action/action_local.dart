part of 'action.dart';

@HiveType(typeId: 0)
class ActionLocal extends Action {
  @override
  @HiveField(0)
  final int? id;
  @override
  @HiveField(1)
  final int userId;
  @override
  @HiveField(2)
  final int bobbinId;
  @override
  @HiveField(3)
  final ActionType type;
  @override
  @HiveField(4)
  final DateTime time;

  ActionLocal({
    required this.id,
    required this.userId,
    required this.bobbinId,
    required this.type,
    required this.time,
  }) : super(
          id: id,
          userId: userId,
          bobbinId: bobbinId,
          type: type,
          time: time,
        );

  factory ActionLocal.fromAction(Action action) {
    return ActionLocal(
        id: action.id,
        userId: action.userId,
        bobbinId: action.bobbinId,
        type: action.type,
        time: action.time);
  }
}
