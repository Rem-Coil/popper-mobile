part of 'action.dart';

@HiveType(typeId: 3)
class ActionLocal extends Action {
  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final int userId;
  @override
  @HiveField(2)
  final BobbinLocal bobbin;
  @override
  @HiveField(3)
  final ActionType? type;
  @override
  @HiveField(4)
  final DateTime time;

  ActionLocal({
    required this.id,
    required this.userId,
    required this.bobbin,
    required this.type,
    required this.time,
  }) : super(
          id: id,
          userId: userId,
          bobbin: bobbin,
          type: type,
          time: time,
        );
}
