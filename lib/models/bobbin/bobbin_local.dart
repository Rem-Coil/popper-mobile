part of 'bobbin.dart';

@HiveType(typeId: 2)
class BobbinLocal extends Bobbin {
  @override
  @HiveField(0)
  final int id;

  @override
  @HiveField(1)
  final int batchId;

  @override
  @HiveField(2)
  final String bobbinNumber;

  const BobbinLocal({
    required this.bobbinNumber,
    required this.id,
    required this.batchId,
  }) : super(id: id, batchId: batchId, bobbinNumber: bobbinNumber);
}
