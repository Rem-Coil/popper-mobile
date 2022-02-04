part of 'bloc.dart';

@immutable
class BobbinLoadingState {
  final Status status;
  final Bobbin? bobbin;
  final Failure? failure;

  BobbinLoadingState._(this.status, this.bobbin, this.failure);

  bool get hasData => status == Status.success;

  bool get hasError => status == Status.error;

  bool get isLoading => status == Status.load;

  factory BobbinLoadingState.initial() {
    return BobbinLoadingState._(Status.initial, null, null);
  }

  factory BobbinLoadingState.load() {
    return BobbinLoadingState._(Status.load, null, null);
  }

  factory BobbinLoadingState.success(Bobbin bobbin) {
    return BobbinLoadingState._(Status.success, bobbin, null);
  }

  factory BobbinLoadingState.failure(Failure failure) {
    return BobbinLoadingState._(Status.error, null, failure);
  }
}
