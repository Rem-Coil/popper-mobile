import 'package:flutter/material.dart';
import 'package:popper_mobile/screen/operations_sync/ui/widgets/synchronization_operation.dart';

class OperationsSyncScreen extends StatelessWidget {
  const OperationsSyncScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Синхронизация операций')),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SynchronizationOperation(
              title: 'Bobbin 1',
              status: SynchronizationStatus.success,
            ),
            SynchronizationOperation(
              title: 'Bobbin 2',
              status: SynchronizationStatus.error,
            ),
            SynchronizationOperation(
              title: 'Bobbin 3',
              status: SynchronizationStatus.load,
            ),
            SynchronizationOperation(
              title: 'Bobbin 4',
              status: SynchronizationStatus.wait,
            ),
          ],
        ),
      ),
    );
  }
}
