import 'package:flutter/material.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_text.dart';

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
            builder: (context) {
              return CommentDialog(initial: comment);
            },
          );

          onCommentEntered!(type);
        }
      },
      child: ValueInfoText(comment ?? 'Нет комментария'),
    );
  }
}

class CommentDialog extends StatefulWidget {
  const CommentDialog({super.key, required this.initial});

  final String? initial;

  @override
  State<CommentDialog> createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.initial ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Введите комментарий'),
      content: SizedBox(
        height: 150,
        child: TextField(
          controller: _controller,
          maxLines: null,
          expands: true,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, _controller.text);
          },
          child: const Text('Сохранить'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

typedef OnCommentEntered = void Function(String?);
