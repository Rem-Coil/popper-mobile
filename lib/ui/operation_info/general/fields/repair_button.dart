import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/domain/models/operation/modify_event.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_text.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/bloc/bloc.dart';

class RepairButton extends StatefulWidget {
  const RepairButton({
    Key? key,
    required this.isRepair,
    required this.isImmutable,
  }) : super(key: key);

  final bool isRepair;
  final bool isImmutable;

  @override
  State<RepairButton> createState() => _RepairButtonState();
}

class _RepairButtonState extends State<RepairButton> {
  String get _label => widget.isRepair ? 'Ремонт' : 'Обычная операция';

  @override
  Widget build(BuildContext context) {
    if (widget.isImmutable) {
      return ValueInfoText(_label);
    }

    return GestureDetector(
      onTap: _setRepair,
      child: ValueInfoText(_label),
    );
  }

  Future<void> _setRepair() async {
    final isRepair = await showCupertinoModalPopup<bool>(
      context: context,
      builder: (_) => const _RepairDialog(),
    );

    if (!mounted || isRepair == null) return;
    final event = ChangeRepairStatusEvent(isRepair);
    context.read<OperationSaveBloc>().add(ModifyOperationEvent(event));
  }
}

class _RepairDialog extends StatelessWidget {
  const _RepairDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: const Text('Ремонт'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Обычная операция'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ],
    );
  }
}
