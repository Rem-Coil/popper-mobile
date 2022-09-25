import 'package:flutter/material.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/operations_sync/models/operation_with_status.dart';
import 'package:popper_mobile/screen/operations_sync/models/synchronization_status.dart';
import 'package:popper_mobile/widgets/circular_loader.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';

class SynchronizationOperation extends StatelessWidget {
  final OperationWithStatus operation;

  const SynchronizationOperation({
    Key? key,
    required this.operation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OperationWidget(
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                _subtitle,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            _icon,
          ],
        ),
      ),
      operation: operation.operation,
      onTap: null,
    );
  }

  String get _subtitle {
    switch (operation.status) {
      case SynchronizationStatus.wait:
        return 'В очереди';
      case SynchronizationStatus.load:
        return 'Синхронизация';
      case SynchronizationStatus.success:
        return 'Успешно';
      case SynchronizationStatus.error:
        return operation.failure!.message;
    }
  }

  Widget get _icon {
    switch (operation.status) {
      case SynchronizationStatus.wait:
        return const Icon(Icons.file_upload_outlined, color: Colors.grey);
      case SynchronizationStatus.load:
        return const CircularLoader(size: 20, strokeWidth: 2);
      case SynchronizationStatus.success:
        return const Icon(Icons.done, color: Colors.green);
      case SynchronizationStatus.error:
        return const Icon(Icons.error, color: Colors.red);
    }
  }
}

class OperationWidget extends StatelessWidget {
  final Operation operation;
  final OperationCallback? onTap;
  final Widget? trailing;

  const OperationWidget({
    Key? key,
    this.trailing,
    required this.operation,
    required this.onTap,
  }) : super(key: key);

  String get typeName => operation.type?.localizedName ?? 'Unknown';

  String get bobbinName {
    if (operation.bobbin.isUnknown) return 'Катшука: ${operation.bobbin.id}';
    return operation.bobbin.bobbinNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 90,
          color: operation.id != -1 ? Colors.green : Colors.yellow,
        ),
        Expanded(
          child: ListTile(
            onTap: onTap != null ? () => onTap!(operation) : null,
            trailing: trailing,
            title: Text(bobbinName),
            isThreeLine: true,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(typeName),
                const SizedBox(height: 2),
                Text(operation.time.formatted),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
