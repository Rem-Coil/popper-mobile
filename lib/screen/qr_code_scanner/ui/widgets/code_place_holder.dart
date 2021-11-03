import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_bloc.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_event.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_state.dart';
import 'package:popper_mobile/screen/qr_code_scanner/ui/widgets/action_selector.dart';

class CodePlaceHolder extends StatelessWidget {
  const CodePlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrScannerBloc, QrScannerState>(
      builder: (context, state) {
        return Column(
          children: [
            Text('Сохранить операцию', style: TextStyle(fontSize: 25)),
            SizedBox(height: 5),
            _ColumnDivider(),
            _LineInfo(
              label: 'Счатанное значение:',
              infoValue: Text(
                state.code != null ? state.code! : '...',
                style: TextStyle(fontSize: 25),
              ),
            ),
            _ColumnDivider(),
            _LineInfo(
              label: 'Выбирете действие:',
              infoValue: ActionSelector(
                currentAction: state.action,
                onPressed: (action) {
                  BlocProvider.of<QrScannerBloc>(context)
                    ..add(OnActionEntered(action!));
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text("Сохранить"),
              onPressed: state.isReady
                  ? () {
                      BlocProvider.of<QrScannerBloc>(context)
                        ..add(OnSaveButtonClicked());
                      Navigator.pop(context);
                    }
                  : null,
            ),
          ],
        );
      },
    );
  }
}

class _LineInfo extends StatelessWidget {
  final String label;
  final Widget infoValue;

  const _LineInfo({
    Key? key,
    required this.label,
    required this.infoValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 25)),
        Spacer(),
        infoValue
      ],
    );
  }
}

class _ColumnDivider extends StatelessWidget {
  const _ColumnDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        Divider(height: 1),
        SizedBox(height: 5),
      ],
    );
  }
}
