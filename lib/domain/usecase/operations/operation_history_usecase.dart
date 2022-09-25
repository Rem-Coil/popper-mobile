import 'package:injectable/injectable.dart';
import 'package:popper_mobile/models/operation/expansion_panel_item.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';

@singleton
class OperationHistoryUsecase {
  List<OperationHistoryItem> call(List<FullOperation> operations) {
    return OperationType.values.map((o) {
      final operationsByType = operations.where((e) => e.type == o).toList();
      operationsByType.sort((op1, op2) => op1.time.compareTo(op2.time));
      return OperationHistoryItem(
        operations: operationsByType,
        type: o,
      );
    }).toList();
  }
}
