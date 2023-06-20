import 'package:flutter/material.dart';
import 'package:popper_mobile/domain/models/operation/check_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operator_operation.dart';
import 'package:popper_mobile/ui/history/ui/widgets/history_operation_widget.dart';
import 'package:timelines/timelines.dart';

class HistoryTimeLine extends StatelessWidget {
  const HistoryTimeLine({super.key, required this.operations});

  final List<Operation> operations;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Color(0xff9b9b9b),
        fontSize: 12.5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: FixedTimeline.tileBuilder(
            theme: TimelineThemeData(
              nodePosition: 0,
              color: const Color(0xff989898),
              indicatorTheme: const IndicatorThemeData(
                position: 0,
                size: 25.0,
              ),
              connectorTheme: const ConnectorThemeData(
                thickness: 2.5,
              ),
            ),
            builder: TimelineTileBuilder.connected(
              connectionDirection: ConnectionDirection.before,
              itemCount: operations.length,
              contentsBuilder: (_, i) => HistoryOperationWidget(operations[i]),
              indicatorBuilder: (_, i) => _OperationIndicator(operations[i]),
              connectorBuilder: (_, i, ___) => SolidLineConnector(
                color: operations[i - 1].color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OperationIndicator extends StatelessWidget {
  const _OperationIndicator(
    this.operation, {
    Key? key,
  }) : super(key: key);

  final Operation operation;

  @override
  Widget build(BuildContext context) {
    late final IconData? icon;

    if (operation is OperatorOperation) {
      icon = null;
    } else {
      final checkOperation = operation as CheckOperation;
      icon = checkOperation.isSuccessful ? Icons.check : Icons.close;
    }

    return DotIndicator(
      color: operation.color,
      child: icon == null ? null : Icon(icon, color: Colors.white, size: 12.0),
    );
  }
}

extension OperationColor on Operation {
  Color get color {
    if (this is OperatorOperation) {
      final operatorOperation = this as OperatorOperation;
      return operatorOperation.isRepair
          ? Colors.orangeAccent
          : const Color(0xff66c97f);
    }

    final checkOperation = this as CheckOperation;
    return checkOperation.isSuccessful
        ? const Color(0xff66c97f)
        : Colors.redAccent;
  }
}
