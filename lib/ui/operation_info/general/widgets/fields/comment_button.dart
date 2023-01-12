import 'package:flutter/material.dart';
import 'package:popper_mobile/ui/operation_info/general/widgets/dialogs/comment_dialog.dart';
import 'package:popper_mobile/ui/operation_info/general/widgets/fields/value_info_text.dart';

class CommentButton extends StatelessWidget {
  const CommentButton({
    super.key,
    required this.comment,
    required this.isImmutable,
    required this.onCommentEntered,
  });

  final String? comment;
  final bool isImmutable;
  final OnCommentEntered? onCommentEntered;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!isImmutable) {
          final type = await showDialog<String>(
            context: context,
            builder: (context) => CommentDialog(initial: comment),
          );

          onCommentEntered!(type);
        }
      },
      child: ValueInfoText(comment ?? 'Нет комментария'),
    );
  }
}

typedef OnCommentEntered = void Function(String?);
