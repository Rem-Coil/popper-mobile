import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/screen/bobbin_loading/bloc/bloc.dart';
import 'package:popper_mobile/screen/operation_info/save_operation/ui/save_operation_screen.dart';
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
    BlocProvider.of<BobbinLoadingBloc>(context).add(LoadInfo(widget.bobbin));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<BobbinLoadingBloc, BobbinLoadingState>(
          listenWhen: (_, s) => !s.isLoading,
          listener: (context, state) {
            if (state.isSuccessful || state.hasError) {
              final bobbin = state.bobbin ?? Bobbin.unknown(widget.bobbin.id);
              final operation = generateOperation(context, bobbin);
              context.pushReplacement(
                OperationSaveScreen.route,
                args: operation,
              );
            }
          },
          builder: (_, __) {
            return Center(
              child: LoadingWidget(
                message: 'Загружаем информацию по катушке...',
              ),
            );
          },
        ),
      ),
    );
  }

  Operation generateOperation(BuildContext context, Bobbin bobbin) {
    final userId = BlocProvider.of<AuthBloc>(context).state.user!.id;
    return Operation.create(
      userId: userId,
      bobbin: bobbin,
      date: DateTime.now(),
    );
  }
}
