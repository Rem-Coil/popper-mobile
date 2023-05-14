import 'package:flutter/material.dart';

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
