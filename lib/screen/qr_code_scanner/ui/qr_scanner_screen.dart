import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/models/auth/user.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_event.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_state.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_bloc.dart';
import 'package:popper_mobile/screen/qr_code_scanner/ui/widgets/qr_scanner_view.dart';

class QrScannerScreen extends StatelessWidget {
  static const route = '/qr_scanner';

  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrScannerBloc, QrScannerState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: ActionSelector(
              currentAction: state.action,
              onPressed: (ActionType? value) =>
                  BlocProvider.of<QrScannerBloc>(context)
                      .add(OnActionEntered(value!)),
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(flex: 6, child: QrScannerView()),
              Expanded(
                flex: 1,
                child: Center(child: _CodePlaceHolder(state: state)),
              ),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    child: Text("Сохранить"),
                    onPressed: state.isReady
                        ? () => BlocProvider.of<QrScannerBloc>(context)
                            .add(OnSaveButtonClicked(User.testUser))
                        : null,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _CodePlaceHolder extends StatelessWidget {
  final QrScannerState state;

  const _CodePlaceHolder({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String text;
    if (state.code != null) {
      text = 'Считано значение: ${state.code}';
    } else {
      text = 'Scan a code';
    }
    return Text(text, style: TextStyle(fontSize: 25));
  }
}

class ActionSelector extends StatelessWidget {
  final ActionType? currentAction;
  final ValueChanged<ActionType?> onPressed;

  const ActionSelector({
    Key? key,
    required this.currentAction,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<ActionType>(
      value: currentAction,
      dropdownColor: Theme.of(context).primaryColor,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      iconSize: 24,
      underline: SizedBox(),
      hint: Text('Выбирете действие', style: TextStyle(color: Colors.white)),
      onChanged: onPressed,
      items: ActionType.values
          .map(
            (e) => DropdownMenuItem<ActionType>(
              value: e,
              child: Text(
                describeEnum(e),
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
          .toList(),
    );
  }
}
