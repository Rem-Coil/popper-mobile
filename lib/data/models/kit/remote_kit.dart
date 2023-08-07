import 'package:json_annotation/json_annotation.dart';

part 'remote_kit.g.dart';

@JsonSerializable(createToJson: false)
class RemoteKit {
  const RemoteKit({
    required this.id,
    required this.number,
    required this.specificationId,
  });

  final int id;
  @JsonKey(name: 'kit_number')
  final String number;
  @JsonKey(name: 'specification_id')
  final int specificationId;

  factory RemoteKit.fromJson(Map<String, dynamic> json) =>
      _$RemoteKitFromJson(json);
}
