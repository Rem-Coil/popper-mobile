import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
import 'package:popper_mobile/screen/loading/bloc/bloc.dart';
import 'package:popper_mobile/widgets/failed_screen.dart';
import 'package:popper_mobile/widgets/loading_widget.dart';

class BobbinLoadingScreen extends StatefulWidget {
  static const String route = '/bobbinLoading';

  final ScannedEntity bobbin;

  const BobbinLoadingScreen({Key? key, required this.bobbin}) : super(key: key);

  @override
  State<BobbinLoadingScreen> createState() => _BobbinLoadingScreenState();
}

class _BobbinLoadingScreenState extends State<BobbinLoadingScreen> {
  @override
  void initState() {
    // BlocProvider.of<BobbinLoadingBloc>(context).add(LoadInfo(widget.bobbin));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<BobbinLoadingBloc, BobbinLoadingState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: LoadingWidget(
                    message: 'Загружаем информацию по катушке...'),
              );
            }

            if (state.hasError) {
              return FailedScreen(
                failText: state.failure!.message,
                imagePath: 'assets/images/load_exception.png',
                dropText: 'Пропустить',
                dropAction: () => context.pop(),
                saveText: 'Сохранить в незагржунные',
                saveAction: () {},
              );
            }

            if (state.hasData) {
              return Center(child: Text(state.bobbin!.bobbinNumber));
            }

            return Center(child: Text('Initialization'));
          },
        ),
      ),
    );
  }
}
