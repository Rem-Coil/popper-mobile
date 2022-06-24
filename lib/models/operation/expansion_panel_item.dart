import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';

class OperationHistoryItem {
  List<FullOperation> operations;
  OperationType type;
  bool isExpanded;

  OperationHistoryItem({
    required this.operations,
    required this.type,
    this.isExpanded = false,
  });
}
