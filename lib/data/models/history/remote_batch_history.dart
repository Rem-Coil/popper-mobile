import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/data/models/history/remote_bobbin_history.dart';

part 'remote_batch_history.g.dart';

@JsonSerializable(createToJson: false)
class RemoteBatchHistory {
  const RemoteBatchHistory({
    required this.id,
    required this.number,
    required this.bobbins,
  });

  final int id;
  @JsonKey(name: 'batch_number')
  final String number;
  @JsonKey(name: 'bobbins')
  final List<RemoteBobbinHistory> bobbins;

  factory RemoteBatchHistory.fromJson(Map<String, dynamic> json) =>
      _$RemoteBatchHistoryFromJson(json);
}
