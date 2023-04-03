import 'package:flutter/material.dart';
import 'package:popper_mobile/core/theme/fonts.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_with_comment.dart';

class HistoryOperationWidget extends StatelessWidget {
  const HistoryOperationWidget(
    this.operation, {
    Key? key,
  }) : super(key: key);

  final Operation operation;

  @override
  Widget build(BuildContext context) {
    final comment = operation is OperationWithComment
        ? (operation as OperationWithComment).comment
        : null;

    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 16, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                operation.user.fullName,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const Spacer(),
              Text(
                operation.time.formatted,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            operation.type?.localizedName ?? 'Unknown',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (comment != null) ...[
            const SizedBox(height: 8),
            _CommentView(comment),
          ],
        ],
      ),
    );
  }
}

class _CommentView extends StatelessWidget {
  const _CommentView(this.comment);

  final String comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Комментарий:',
          style: Theme.of(context).textTheme.bodySmall.bold,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            comment,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
