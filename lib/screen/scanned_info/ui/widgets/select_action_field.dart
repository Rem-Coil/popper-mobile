import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:popper_mobile/screen/scanned_info/bloc/bloc.dart';
import 'package:popper_mobile/screen/scanned_info/ui/widgets/scanned_info_text.dart';
import 'package:popper_mobile/screen/scanned_info/ui/widgets/select_action_dialog.dart';

class SelectActionButton extends StatelessWidget {
  final String type;

  const SelectActionButton({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final type = await showCupertinoModalPopup<ActionType?>(
          context: context,
          builder: (_) => SelectActionDialog(),
        );
        BlocProvider.of<SaveActionBloc>(context).add(OnActionChanged(type));
      },
      child: ScannedInfoText(type),
    );
  }
}
