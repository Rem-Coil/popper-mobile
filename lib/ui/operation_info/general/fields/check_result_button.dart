import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/domain/models/operation/modify_event.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_text.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/bloc/bloc.dart';

class CheckResultButton extends StatefulWidget {
  const CheckResultButton({
    Key? key,
    required this.isSuccessful,
    required this.isImmutable,
  }) : super(key: key);

  final bool isSuccessful;
  final bool isImmutable;

  @override
  State<CheckResultButton> createState() => _CheckResultButtonState();
}

class _CheckResultButtonState extends State<CheckResultButton> {
  Widget get _label {
    if (widget.isSuccessful) {
      return const ValueInfoText('Успешно', color: Colors.green);
    }

    return const ValueInfoText('Неуспешно', color: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isImmutable) {
      return _label;
    }

    return GestureDetector(
      onTap: _changeCheckResult,
      child: _label,
    );
  }

  Future<void> _changeCheckResult() async {
    final checkResult = await showCupertinoModalPopup<bool>(
      context: context,
      builder: (_) => const _CheckResultDialog(),
    );

    if (checkResult == null) return;
    final event = ChangeCheckResultEvent(checkResult);

    if (context.mounted) {
      context.read<OperationSaveBloc>().add(ModifyOperationEvent(event));
    }
  }
}

class _CheckResultDialog extends StatelessWidget {
  const _CheckResultDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: const Text('Успешная проверка'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Неуспешная проверка'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ],
    );
  }
}
