part of 'bloc.dart';

final formatter = DateFormat('d MMM yyyy, HH:mm', 'ru_RU');

@immutable
abstract class SaveActionState {
  final Action action;

  bool get isActionSaved => action.id != Action.defaultId;

  bool get isCanSave => this is SelectTypeState && action.type != null;

  bool get isBobbinNotLoaded => action.bobbin.isUnknown;

  String get currentType =>
      action.type?.getLocalizedName() ?? 'Выберете операцию';

  String get bobbinNumber => action.bobbin.bobbinNumber;

  String get bobbinId => action.bobbin.id.toString();

  String get formattedDate => formatter.format(action.time);

  SaveActionState._({required this.action});
}

class SelectTypeState extends SaveActionState {
  SelectTypeState._({required Action action}) : super._(action: action);

  factory SelectTypeState.initial(Action action) {
    return SelectTypeState._(action: action);
  }

  SelectTypeState changeType(ActionType? type) {
    return SelectTypeState._(action: action.changeType(type));
  }
}

class ProcessSaveState extends SaveActionState {
  final Status status;
  final Failure? failure;

  bool get isSaveError =>
      failure is NoInternetFailure || failure is ServerFailure;

  ProcessSaveState._({
    required Action action,
    required this.status,
    required this.failure,
  }) : super._(action: action);

  ProcessSaveState _copyWith({
    Action? action,
    Status? status,
    Failure? failure,
  }) {
    return ProcessSaveState._(
      action: action ?? this.action,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  factory ProcessSaveState.load(Action action) {
    return ProcessSaveState._(
      action: action,
      status: Status.load,
      failure: null,
    );
  }

  ProcessSaveState error(Failure failure) {
    return _copyWith(status: Status.error, failure: failure);
  }

  ProcessSaveState success() {
    return _copyWith(status: Status.success);
  }
}

class SaveInCacheState extends SaveActionState {
  final Status status;

  SaveInCacheState._({
    required Action action,
    required this.status,
  }) : super._(action: action);

  SaveInCacheState _copyWith({
    Action? action,
    Status? status,
  }) {
    return SaveInCacheState._(
      action: action ?? this.action,
      status: status ?? this.status,
    );
  }

  factory SaveInCacheState.load(Action action) {
    return SaveInCacheState._(action: action, status: Status.load);
  }

  SaveInCacheState error() {
    return _copyWith(status: Status.error);
  }

  SaveInCacheState success() {
    return _copyWith(status: Status.success);
  }
}
