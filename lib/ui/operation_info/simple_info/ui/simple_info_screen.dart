import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/ui/operation_info/general/actions/ui/operation_app_bar.dart';
import 'package:popper_mobile/ui/operation_info/general/views/operation_info.dart';

@RoutePage()
class SimpleInfoScreen extends StatelessWidget {
  const SimpleInfoScreen({
    Key? key,
    required this.operation,
  }) : super(key: key);

  final Operation operation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OperationAppBar(
        title: 'Информация об операции',
        operation: operation,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OperationInfo.immutable(operation),
          ],
        ),
      ),
    );
  }
}
