part of 'bobbin.dart';

@JsonSerializable(createToJson: false)
class BobbinRemote extends Bobbin {
  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'batch_id')
  final int batchId;
  @override
  @JsonKey(name: 'bobbin_number')
  final String bobbinNumber;

  const BobbinRemote({
    required this.id,
    required this.batchId,
    required this.bobbinNumber,
  }) : super(id: id, batchId: batchId, bobbinNumber: bobbinNumber);

  factory BobbinRemote.fromJson(Map<String, dynamic> json) =>
      _$BobbinRemoteFromJson(json);
}
