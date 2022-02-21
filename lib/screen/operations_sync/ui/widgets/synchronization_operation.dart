import 'package:flutter/material.dart';
import 'package:popper_mobile/widgets/circular_loader.dart';

class SynchronizationOperation extends StatelessWidget {
  final String title;
  final SynchronizationStatus status;

  const SynchronizationOperation({
    Key? key,
    required this.title,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(_subtitle),
      trailing: _icon,
    );
  }

  String get _subtitle {
    switch (status) {
      case SynchronizationStatus.wait:
        return 'Wait';
      case SynchronizationStatus.load:
        return 'Load';
      case SynchronizationStatus.success:
        return 'Success';
      case SynchronizationStatus.error:
        return 'Error';
    }
  }

  Widget get _icon {
    switch (status) {
      case SynchronizationStatus.wait:
        return Icon(Icons.file_upload_outlined, color: Colors.grey);
      case SynchronizationStatus.load:
        return CircularLoader(size: 20, strokeWidth: 2);
      case SynchronizationStatus.success:
        return Icon(Icons.done, color: Colors.green);
      case SynchronizationStatus.error:
        return Icon(Icons.error, color: Colors.red);
    }
  }
}

enum SynchronizationStatus { wait, load, success, error }
