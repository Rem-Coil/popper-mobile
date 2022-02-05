part of 'bloc.dart';

@immutable
class SaveActionState {
  static final formatter = DateFormat('d MMM yyyy, HH:mm', 'ru_RU');

  final Bobbin bobbin;
  final ActionType? action;
  final DateTime time;

  SaveActionState._(this.bobbin, this.action, this.time);

  String get bobbinNumber => bobbin.bobbinNumber;

  String get actionType => action?.getLocalizedName() ?? 'Выбрать операцию';

  String get formattedDate => formatter.format(time);

  factory SaveActionState.initial(Bobbin bobbin) {
    return SaveActionState._(bobbin, null, DateTime.now());
  }

  SaveActionState changeAction(ActionType? action) {
    return SaveActionState._(bobbin, action, time);
  }
}
