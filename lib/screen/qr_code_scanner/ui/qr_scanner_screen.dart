import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/models/auth/user.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_state.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scenner_bloc.dart';
import 'package:popper_mobile/screen/qr_code_scanner/ui/widgets/qr_scanner_view.dart';

class QrScannerScreen extends StatelessWidget {
  static const route = '/qr_scanner';
  final User user = User.testUser;

  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.surname} ${user.firstname}'),
      ),
      body: BlocBuilder<QrScannerBloc, QrScannerState>(
        builder: (context, state) => Column(
        children: <Widget>[
          Expanded(flex: 6, child: QrScannerView()),
          Expanded(
            flex: 1,
            child: Center(child: _CodePlaceHolder(state: state)),
          ),
        ],
      ),
    ),
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
    if (state is QrCodeEntered) {
      final code = (state as QrCodeEntered).code;
      text = 'Считано значение: $code';
    } else {
      text = 'Scan a code';
    }
    return Text(text, style: TextStyle(fontSize: 25));
  }
}
