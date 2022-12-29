import 'package:flutter/material.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/widgets/circle_view.dart';

class OperationItem extends StatelessWidget {
  const OperationItem({
    Key? key,
    required this.operation,
    required this.onTap,
  }) : super(key: key);

  final Operation operation;
  final OperationCallback? onTap;

  String get typeName => operation.type?.localizedName ?? 'Unknown';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!(operation) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  operation.item.type.toLowerCase(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  operation.time.formatted,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 4),
            _TitleView(title: operation.item.number),
            const SizedBox(height: 8),
            Text(
              typeName,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (operation.status == OperationStatus.notSync) ...[
              const SizedBox(height: 4),
              const _NotSyncView(),
            ],
          ],
        ),
      ),
    );
  }
}

class _TitleView extends StatelessWidget {
  const _TitleView({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(width: 16),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
        ),
      ],
    );
  }
}

class _NotSyncView extends StatelessWidget {
  const _NotSyncView();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleView(size: 8),
        const SizedBox(width: 8),
        Text(
          'не синхронизированно',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
