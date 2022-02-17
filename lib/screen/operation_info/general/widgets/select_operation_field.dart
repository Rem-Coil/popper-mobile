import 'package:flutter/cupertino.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/select_operation_dialog.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_text.dart';

class SelectOperationButton extends StatelessWidget {
  final String type;
  final OnTypeSelected onTypeSelected;

  const SelectOperationButton({
    Key? key,
    required this.type,
    required this.onTypeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final type = await showCupertinoModalPopup<OperationType?>(
          context: context,
          builder: (_) => SelectOperationDialog(),
        );
        onTypeSelected(type);
        // BlocProvider.of<OperationSaveBloc>(context).add(ChangeOperation(type));
      },
      child: ValueInfoText(type),
    );
  }
}

typedef OnTypeSelected = void Function(OperationType?);
