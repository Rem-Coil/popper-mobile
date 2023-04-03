import 'package:json_annotation/json_annotation.dart';

part 'remote_comment.g.dart';

@JsonSerializable()
class RemoteComment {
  const RemoteComment({
    required this.operationId,
    required this.comment,
  });

  @JsonKey(name: 'action_id')
  final int operationId;
  @JsonKey(name: 'comment')
  final String comment;

  Map<String, dynamic> toJson() => _$RemoteCommentToJson(this);
}
