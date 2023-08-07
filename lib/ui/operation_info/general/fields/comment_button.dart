import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/domain/models/operation/modify_event.dart';
import 'package:popper_mobile/ui/operation_info/general/dialogs/comment_dialog.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_text.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/bloc/bloc.dart';

class CommentButton extends StatefulWidget {
  const CommentButton({
    super.key,
    required this.comment,
    required this.isImmutable,
  });

  final String? comment;
  final bool isImmutable;

  @override
  State<CommentButton> createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !widget.isImmutable ? _changeComment : null,
      child: ValueInfoText(widget.comment ?? 'Нет комментария'),
    );
  }

  Future<void> _changeComment() async {
    final comment = await showDialog<String>(
      context: context,
      builder: (context) => CommentDialog(initial: widget.comment),
    );

    if (!mounted) return;
    final event = ChangeCommentEvent(comment);
    context.read<OperationSaveBloc>().add(ModifyOperationEvent(event));
  }
}
