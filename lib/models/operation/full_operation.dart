part of 'operation.dart';

@JsonSerializable()
class FullOperation {
  @JsonKey(name: 'bobbin_id')
  final int bobbinId;
  @JsonKey(name: 'bobbin_number')
  final String bobbinNumber;
  @JsonKey(name: 'firstname')
  final String firstName;
  @JsonKey(name: 'second_name')
  final String secondName;
  final String surname;
  @JsonKey(name: 'action_type')
  final OperationType type;
  @JsonKey(name: 'done_time', fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime time;
  @JsonKey(name: 'successful')
  final bool isSuccessful;

  const FullOperation({
    required this.bobbinId,
    required this.bobbinNumber,
    required this.firstName,
    required this.secondName,
    required this.surname,
    required this.type,
    required this.time,
    required this.isSuccessful,
  });

  factory FullOperation.fromJson(Map<String, dynamic> json) =>
      _$FullOperationFromJson(json);

  Map<String, dynamic> toJson() => _$FullOperationToJson(this);

  static DateTime _dateFromJson(String date) => formatter.parse(date);

  static String _dateToJson(DateTime time) => formatter.format(time);

  String get operatorName => '$firstName $secondName';
}
