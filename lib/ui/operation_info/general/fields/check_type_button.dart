import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/domain/models/operation/check_operation.dart';
import 'package:popper_mobile/domain/models/operation/modify_event.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_text.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/bloc/bloc.dart';

extension CheckTypeNames on CheckType {
  String get name {
    switch (this) {
      case CheckType.testing:
        return 'Испытания';
      case CheckType.otk:
        return 'ОТК';
    }
  }
}

class CheckTypeButton extends StatefulWidget {
  const CheckTypeButton({
    Key? key,
    required this.selected,
    required this.isImmutable,
  }) : super(key: key);

  final CheckType selected;
  final bool isImmutable;

  @override
  State<CheckTypeButton> createState() => _CheckTypeButtonState();
}

class _CheckTypeButtonState extends State<CheckTypeButton> {
  String get _label => widget.selected.name;

  @override
  Widget build(BuildContext context) {
    if (widget.isImmutable) {
      return ValueInfoText(_label);
    }

    return GestureDetector(
      onTap: _changeCheckType,
      child: ValueInfoText(_label),
    );
  }

  Future<void> _changeCheckType() async {
    final type = await showCupertinoModalPopup<CheckType>(
      context: context,
      builder: (_) => const _CheckTypeDialog(),
    );

    if (type == null) return;
    final event = ChangeCheckTypeEvent(type);

    if (context.mounted) {
      context.read<OperationSaveBloc>().add(ModifyOperationEvent(event));
    }
  }
}

class _CheckTypeDialog extends StatelessWidget {
  const _CheckTypeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: CheckType.values.map((t) {
        return CupertinoActionSheetAction(
          child: Text(t.name),
          onPressed: () {
            Navigator.pop(context, t);
          },
        );
      }).toList(),
    );
  }
}
