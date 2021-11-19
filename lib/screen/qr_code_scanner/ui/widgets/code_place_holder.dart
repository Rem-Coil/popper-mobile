import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_bloc.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_event.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_state.dart';
import 'package:popper_mobile/screen/qr_code_scanner/ui/widgets/action_selector.dart';
import 'package:popper_mobile/widgets/line_info.dart';
import 'package:popper_mobile/widgets/column_divider.dart';

class CodePlaceHolder extends StatelessWidget {
  const CodePlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QrScannerBloc, QrScannerState>(
      listenWhen: (previous, current) =>
          previous.bobbin != null && current.bobbin == null,
      listener: (context, state) => Navigator.pop(context),
      builder: (context, state) {
        if (state.isLoad) return _LoadWidget();

        if (state.hasError) {
          if (state.errorMessage is ActionAlreadyExistFailure) {
            return _ErrorState(error: state.errorMessage!);
          } else {
            return _SaveSubmitWidget(
              title: 'Сохранить операцию в кеш',
              secondTitle: 'Ошибка',
              value: state.errorMessage!.message,
              action: state.action,
              isReady: state.action != null,
              onPressed: () => BlocProvider.of<QrScannerBloc>(context)
                ..add(OnSaveToCacheButtonClicked()),
            );
          }
        }

        return _SaveSubmitWidget(
          title: 'Сохранить операцию',
          secondTitle: 'Счатанное значение',
          value: state.bobbin != null ? state.bobbin!.bobbinNumber : '...',
          action: state.action,
          isReady: state.isReady,
          onPressed: () => BlocProvider.of<QrScannerBloc>(context)
            ..add(OnSaveButtonClicked()),
        );
      },
    );
  }
}

class _ErrorState extends StatelessWidget {
  final Failure error;

  const _ErrorState({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Произошла ошибка:', style: TextStyle(fontSize: 25)),
        Text(error.message,
            style: TextStyle(fontSize: 25, color: Colors.red[400])),
        _TextAndButtonMessage(
          title: 'Отсканируйте катушку заново и выбирете другую операцию',
          buttonTitle: 'Закрыть',
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

class _TextAndButtonMessage extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final VoidCallback onPressed;

  const _TextAndButtonMessage({
    Key? key,
    required this.title,
    required this.buttonTitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 25)),
        ElevatedButton(
          child: Text(buttonTitle),
          onPressed: onPressed,
        ),
      ],
    );
  }
}

class _LoadWidget extends StatelessWidget {
  const _LoadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}

class _SaveSubmitWidget extends StatelessWidget {
  final String title;
  final String secondTitle;
  final String value;
  final ActionType? action;
  final bool isReady;
  final VoidCallback onPressed;

  const _SaveSubmitWidget({
    Key? key,
    required this.title,
    required this.secondTitle,
    required this.value,
    required this.action,
    required this.isReady,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 25)),
        SizedBox(height: 5),
        ColumnDivider(),
        LineInfo(
          label: '$secondTitle:',
          infoValue: Text(value, style: TextStyle(fontSize: 25)),
        ),
        ColumnDivider(),
        LineInfo(
          label: 'Выбирете действие:',
          infoValue: ActionSelector(
            currentAction: action,
            onPressed: (action) => BlocProvider.of<QrScannerBloc>(context)
              ..add(OnActionEntered(action!)),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          child: Text("Сохранить"),
          onPressed: isReady ? onPressed : null,
        ),
      ],
    );
  }
}
