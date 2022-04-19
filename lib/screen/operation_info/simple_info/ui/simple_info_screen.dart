import 'package:flutter/material.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/operation_info.dart';

class SimpleInfoScreen extends StatelessWidget {
  final Operation operation;

  const SimpleInfoScreen({Key? key, required this.operation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Информация об операции')),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OperationInfo(
              operation: operation,
              isImmutable: true,
            )
          ],
        ),
      ),
    );
  }
}
