import 'package:flutter/material.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';
import 'package:popper_mobile/widgets/widget_with_warning.dart';

class OperationItem extends StatelessWidget {
  final Operation operation;
  final OperationCallback? onTap;
  final Widget? trailing;

  const OperationItem({
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
    return ListTile(
      onTap: onTap != null ? () => onTap!(operation) : null,
      trailing: trailing,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _Title(
              title: bobbinName,
              isSync: operation.id != Operation.defaultId,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            operation.time.formatted,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
      subtitle: Text(typeName),
    );
  }
}

class _Title extends StatelessWidget {
  final bool isSync;
  final String title;

  const _Title({required this.isSync, required this.title});

  @override
  Widget build(BuildContext context) {
    final text = Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    if (isSync) {
      return text;
    }

    return WidgetWithWarning(
      warningTitle: 'Данная опреация не синхронизированна',
      warningMessage:
          'Данная операция не была синхронизированна и храниться только '
          'на текущем устройстве. Данная операция может быть утерена.',
      child: Text(title),
    );
  }
}
