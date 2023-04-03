import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/data/models/operation/remote_operation.dart';

part 'remote_bobbin_history.g.dart';

@JsonSerializable(createToJson: false)
class RemoteBobbinHistory {
  const RemoteBobbinHistory({
    required this.id,
    required this.number,
    required this.operations,
  });

  final int id;
  @JsonKey(name: 'bobbin_number')
  final String number;
  @JsonKey(name: 'actions')
  final List<RemoteOperationInfo> operations;

  factory RemoteBobbinHistory.fromJson(Map<String, dynamic> json) =>
      _$RemoteBobbinHistoryFromJson(json);
}
