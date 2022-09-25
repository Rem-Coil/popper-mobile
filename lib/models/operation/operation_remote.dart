part of 'operation.dart';

final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');

@JsonSerializable()
class OperationRemote extends Operation {
  @JsonKey(name: 'id')
  @override
  final int id;
  @JsonKey(name: 'operator_id', includeIfNull: false, toJson: _operatorIdToJson)
  @override
  final int userId;
  @JsonKey(name: 'bobbin_id', fromJson: _bobbinFromJson, toJson: _bobbinToJson)
  @override
  final Bobbin bobbin;
  @JsonKey(name: 'action_type')
  @override
  final OperationType type;
  @JsonKey(name: 'done_time', fromJson: _dateFromJson, toJson: _dateToJson)
  @override
  final DateTime time;
  @JsonKey(name: 'successful')
  @override
  final bool isSuccessful;

  const OperationRemote({
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

  factory OperationRemote.fromJson(Map<String, dynamic> json) =>
      _$OperationRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$OperationRemoteToJson(this);

  static DateTime _dateFromJson(String date) => formatter.parse(date);

  static Bobbin _bobbinFromJson(int id) => Bobbin.unknown(id);

  static String _dateToJson(DateTime time) => formatter.format(time);

  static int _bobbinToJson(Bobbin bobbin) => bobbin.id;

  static String? _operatorIdToJson(int id) => null;
}
