enum Status { initial, load, error, success }

extension StatusCheck on Status {
  bool get isSuccessful => this == Status.success;

  bool get isError => this == Status.error;

  bool get isLoad => this == Status.load;
}
