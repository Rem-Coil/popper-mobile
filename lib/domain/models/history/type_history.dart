import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';

class TypeHistory {
  const TypeHistory({required this.type, required this.operations});

  final OperationType type;
  final List<Operation> operations;
}
