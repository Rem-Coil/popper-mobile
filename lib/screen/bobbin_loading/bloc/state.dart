part of 'bloc.dart';

@immutable
class BobbinLoadingState {
  final Status status;
  final Bobbin? bobbin;
  final Failure? failure;

  const BobbinLoadingState._({
    required this.status,
    required this.bobbin,
    required this.failure,
  });

  bool get isSuccessful => status.isSuccessful;

  bool get hasError => status == Status.error;

  bool get isLoading => status == Status.load;

  factory BobbinLoadingState.initial() {
    return const BobbinLoadingState._(
      status: Status.initial,
      bobbin: null,
      failure: null,
    );
  }

  BobbinLoadingState copyWith({
    Status? status,
    Bobbin? bobbin,
    Failure? failure,
  }) {
    return BobbinLoadingState._(
      status: status ?? this.status,
      bobbin: bobbin ?? this.bobbin,
      failure: failure ?? this.failure,
    );
  }

  BobbinLoadingState setLoad() {
    return copyWith(status: Status.load);
  }

  BobbinLoadingState setSuccess(Bobbin bobbin) {
    return copyWith(status: Status.success, bobbin: bobbin);
  }

  BobbinLoadingState setFailure(Failure failure) {
    return copyWith(status: Status.error, failure: failure);
  }
}
