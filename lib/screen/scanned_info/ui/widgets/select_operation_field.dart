import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';
import 'package:popper_mobile/screen/scanned_info/bloc/bloc.dart';
import 'package:popper_mobile/screen/scanned_info/ui/widgets/scanned_info_text.dart';
import 'package:popper_mobile/screen/scanned_info/ui/widgets/select_operation_dialog.dart';

class SelectOperationButton extends StatelessWidget {
  final String type;

  const SelectOperationButton({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final type = await showCupertinoModalPopup<OperationType?>(
          context: context,
          builder: (_) => SelectOperationDialog(),
        );
        BlocProvider.of<OperationSaveBloc>(context).add(ChangeOperation(type));
      },
      child: ScannedInfoText(type),
    );
  }
}
