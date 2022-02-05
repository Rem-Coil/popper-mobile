import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/screen/scanned_info/bloc/bloc.dart';
import 'package:popper_mobile/screen/scanned_info/ui/widgets/scanned_info_field.dart';
import 'package:popper_mobile/screen/scanned_info/ui/widgets/scanned_info_text.dart';
import 'package:popper_mobile/screen/scanned_info/ui/widgets/select_action_dialog.dart';

class ScannedInfoScreen extends StatelessWidget {
  static const String route = '/scannedInfo';

  const ScannedInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Сохранить операцию?')),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: BlocBuilder<SaveActionBloc, SaveActionState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ScannedInfoField(
                    title: 'Номер катушки',
                    value: ScannedInfoText(state.bobbinNumber),
                  ),
                  SizedBox(height: 24),
                  ScannedInfoField(
                    title: 'Сотрудник',
                    value: ScannedInfoText(_getUserName(context)),
                  ),
                  SizedBox(height: 24),
                  ScannedInfoField(
                    title: 'Операция',
                    value: GestureDetector(
                      onTap: () async {
                        final type = await showCupertinoModalPopup<ActionType?>(
                          context: context,
                          builder: (_) => SelectActionDialog(),
                        );
                        BlocProvider.of<SaveActionBloc>(context)
                            .add(OnActionChanged(type));
                      },
                      child: ScannedInfoText(state.actionType),
                    ),
                  ),
                  SizedBox(height: 24),
                  ScannedInfoField(
                    title: 'Дата сканирования',
                    value: ScannedInfoText(state.formattedDate),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String _getUserName(BuildContext context) {
    final authState = BlocProvider.of<AuthBloc>(context).state;
    return authState.user!.fullName;
  }
}
