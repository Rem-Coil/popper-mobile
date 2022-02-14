part of 'bobbin.dart';

@HiveType(typeId: 2)
class BobbinLocal extends Bobbin {
  @override
  @HiveField(0)
  final int id;

  @override
  @HiveField(1)
  final int taskId;

  @override
  @HiveField(2)
  final String bobbinNumber;

  BobbinLocal({
    required this.bobbinNumber,
    required this.id,
    required this.taskId,
  }) : super(id: id, taskId: taskId, bobbinNumber: bobbinNumber);
}
