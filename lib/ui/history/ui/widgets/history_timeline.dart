import 'package:flutter/material.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
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
              indicatorBuilder: (_, i) {
                late final IconData icon;
                late final Color color;

                if (operations[i].isSuccessful) {
                  icon = Icons.check;
                  color = const Color(0xff66c97f);
                } else {
                  icon = Icons.close;
                  color = Colors.redAccent;
                }

                return DotIndicator(
                  color: color,
                  child: Icon(icon, color: Colors.white, size: 12.0),
                );
              },
              connectorBuilder: (_, i, ___) => SolidLineConnector(
                color: operations[i - 1].isSuccessful
                    ? const Color(0xff66c97f)
                    : Colors.redAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
