import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/screen/actions/ui/actions_screen.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_bloc.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_event.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_state.dart';
import 'package:popper_mobile/screen/qr_code_scanner/ui/widgets/action_selector.dart';
import 'package:popper_mobile/screen/qr_code_scanner/ui/widgets/qr_scanner_view.dart';

class QrScannerScreen extends StatelessWidget {
  static const route = '/qr_scanner';

  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QrScannerBloc, QrScannerState>(
      listenWhen: (previous, current) => current.errorMessage != null,
      listener: (context, state) {
        context.errorSnackBar(state.errorMessage!);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: ActionSelector(
              currentAction: state.action,
              onPressed: (ActionType? value) =>
                  BlocProvider.of<QrScannerBloc>(context)
                      .add(OnActionEntered(value!)),
            ),
            actions: [
              IconButton(
                onPressed: () => context.push(ActionsScreen.route),
                icon: Icon(
                  Icons.history,
                  color: Colors.white,
                ),
              ),
            ],
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
                            .add(OnSaveButtonClicked())
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
