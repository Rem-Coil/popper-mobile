// ignore_for_file: overridden_fields

part of 'operation.dart';

@HiveType(typeId: 3)
class OperationLocal extends Operation {
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
  final OperationType? type;
  @override
  @HiveField(4)
  final DateTime time;
  @override
  @HiveField(5, defaultValue: true)
  final bool isSuccessful;

  const OperationLocal({
    required this.id,
    required this.userId,
    required this.bobbin,
    required this.type,
    required this.time,
    required this.isSuccessful,
  }) : super(
          id: id,
          userId: userId,
          bobbin: bobbin,
          type: type,
          time: time,
          isSuccessful: isSuccessful,
        );
}
