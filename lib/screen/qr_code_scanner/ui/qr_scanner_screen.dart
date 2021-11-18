import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/screen/actions/ui/actions_screen.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_bloc.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_event.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_state.dart';
import 'package:popper_mobile/screen/qr_code_scanner/ui/widgets/code_place_holder.dart';
import 'package:popper_mobile/screen/qr_code_scanner/ui/widgets/qr_scanner_view.dart';

class QrScannerScreen extends StatelessWidget {
  static const route = '/qr_scanner';

  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<QrScannerBloc, QrScannerState>(
      listenWhen: (previous, current) =>
          current.errorMessage != null ||
          (previous.bobbin == null && current.bobbin != null),
      listener: (context, state) {
        if (state.errorMessage != null) {
          context.errorSnackBar(state.errorMessage!);
        } else if (state.bobbin != null) {
          _showCodeView(context, state);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Отсканируйте код'),
          actions: [
            _ActionsHistoryButton(),
          ],
        ),
        body: QrScannerView(),
      ),
    );
  }

  void _showCodeView(BuildContext context, QrScannerState state) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.30,
          minChildSize: 0.30,
          maxChildSize: 0.30,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: const Radius.circular(20.0),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                controller: controller,
                child: CodePlaceHolder(),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      BlocProvider.of<QrScannerBloc>(context).add(OnBottomSheetClose());
    });
  }
}

class _ActionsHistoryButton extends StatelessWidget {
  const _ActionsHistoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.push(ActionsScreen.route),
      icon: Icon(
        Icons.history,
        color: Colors.white,
      ),
    );
  }
}
