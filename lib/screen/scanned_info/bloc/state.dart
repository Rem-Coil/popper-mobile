part of 'bloc.dart';

final formatter = DateFormat('d MMM yyyy, HH:mm', 'ru_RU');

@immutable
abstract class OperationSaveState {
  final Operation operation;

  bool get isOperationSaved => operation.id != Operation.defaultId;

  bool get isCanSave => this is SelectTypeState && operation.type != null;

  bool get isBobbinNotLoaded => operation.bobbin.isUnknown;

  String get currentType =>
      operation.type?.localizedName ?? 'Выберете операцию';

  String get bobbinNumber => operation.bobbin.bobbinNumber;

  String get bobbinId => operation.bobbin.id.toString();

  String get formattedDate => formatter.format(operation.time);

  OperationSaveState._({required this.operation});
}

class SelectTypeState extends OperationSaveState {
  SelectTypeState._({required Operation operation})
      : super._(operation: operation);

  factory SelectTypeState.initial(Operation action) {
    return SelectTypeState._(operation: action);
  }

  SelectTypeState changeType(OperationType? type) {
    return SelectTypeState._(operation: operation.changeType(type));
  }
}

class ProcessSaveState extends OperationSaveState {
  final Status status;
  final Failure? failure;

  bool get isSaveError =>
      failure is NoInternetFailure || failure is ServerFailure;

  ProcessSaveState._({
    required Operation operation,
    required this.status,
    required this.failure,
  }) : super._(operation: operation);

  ProcessSaveState _copyWith({
    Operation? operation,
    Status? status,
    Failure? failure,
  }) {
    return ProcessSaveState._(
      operation: operation ?? this.operation,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  factory ProcessSaveState.load(Operation operation) {
    return ProcessSaveState._(
      operation: operation,
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

class SaveInCacheState extends OperationSaveState {
  final Status status;

  SaveInCacheState._({
    required Operation operation,
    required this.status,
  }) : super._(operation: operation);

  SaveInCacheState _copyWith({
    Operation? operation,
    Status? status,
  }) {
    return SaveInCacheState._(
      operation: operation ?? this.operation,
      status: status ?? this.status,
    );
  }

  factory SaveInCacheState.load(Operation operation) {
    return SaveInCacheState._(operation: operation, status: Status.load);
  }

  SaveInCacheState error() {
    return _copyWith(status: Status.error);
  }

  SaveInCacheState success() {
    return _copyWith(status: Status.success);
  }
}
