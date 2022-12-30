import 'package:flutter/cupertino.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/select_operation_dialog.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_text.dart';

class SelectOperationButton extends StatelessWidget {
  const SelectOperationButton({
    Key? key,
    required this.type,
    required this.onTypeSelected,
    required this.isImmutable,
  })  : assert(isImmutable || onTypeSelected != null),
        super(key: key);

  final String type;
  final OnTypeSelected? onTypeSelected;
  final bool isImmutable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!isImmutable) {
          final type = await showCupertinoModalPopup<OperationType>(
            context: context,
            builder: (_) => const SelectOperationDialog(),
          );
          onTypeSelected!(type);
        }
      },
      child: ValueInfoText(type),
    );
  }
}

typedef OnTypeSelected = void Function(OperationType?);
