part of 'bloc.dart';

@immutable
class SaveActionState {
  static final formatter = DateFormat('d MMM yyyy, HH:mm', 'ru_RU');

  final Bobbin bobbin;
  final ActionType? action;
  final DateTime time;

  final Status status;
  final Failure? failure;

  String get bobbinNumber => bobbin.bobbinNumber;

  String get actionType => action?.getLocalizedName() ?? 'Выбрать операцию';

  String get formattedDate => formatter.format(time);

  SaveActionState._({
    required this.status,
    required this.bobbin,
    required this.time,
    this.failure = null,
    this.action = null,
  });

  SaveActionState _copyWith({
    Status? status,
    Failure? failure,
    Bobbin? bobbin,
    ActionType? action,
    DateTime? time,
  }) {
    return SaveActionState._(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      bobbin: bobbin ?? this.bobbin,
      action: action ?? this.action,
      time: time ?? this.time,
    );
  }

  factory SaveActionState.initial(Bobbin bobbin) {
    return SaveActionState._(
      bobbin: bobbin,
      time: DateTime.now(),
      status: Status.success,
    );
  }

  SaveActionState changeAction(ActionType? action) {
    return _copyWith(action: action);
  }

  SaveActionState load() {
    return _copyWith(status: Status.load);
  }

  SaveActionState saveError(Failure failure) {
    return _copyWith(status: Status.error, failure: failure);
  }

  SaveActionState saveSuccessful() {
    return _copyWith(status: Status.success);
  }
}
