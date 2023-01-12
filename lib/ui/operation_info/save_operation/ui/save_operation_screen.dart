import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';
import 'package:popper_mobile/ui/operation_info/general/widgets/views/info_loading_view.dart';
import 'package:popper_mobile/ui/operation_info/general/widgets/views/result_view.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/bloc/bloc.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/ui/widgets/select_operation_type_view.dart';
import 'package:popper_mobile/core/widgets/dialogs/decision_dialog.dart';

class SaveOperationScreen extends StatefulWidget implements AutoRouteWrapper {
  const SaveOperationScreen({Key? key, required this.entity}) : super(key: key);

  final ScannedEntity entity;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OperationSaveBloc>(
          create: (_) => getIt.get<OperationSaveBloc>(param1: entity),
        ),
      ],
      child: this,
    );
  }

  @override
  State<SaveOperationScreen> createState() => _SaveOperationScreenState();
}

class _SaveOperationScreenState extends State<SaveOperationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OperationSaveBloc, OperationSaveState>(
      listenWhen: (_, state) => state is CanCacheState,
      listener: (context, state) async => await _showCacheDialog(),
      builder: (context, state) {
        if (state is FetchInfoState) {
          return const InfoLoadingView();
        }

        if (state is SuccessState) {
          return ResultView(message: state.message);
        }

        if (state is FailedState) {
          return ResultView(
            message: state.failure.message,
            isSuccess: false,
          );
        }

        return SelectOperationTypeView(state: state as WithOperationState);
      },
    );
  }

  Future<void> _showCacheDialog() async {
    final isSaveInCache = await _showSaveDialog();

    if (isSaveInCache == true) {
      if (!mounted) return;
      context.read<OperationSaveBloc>().add(const CacheOperation());
    } else {
      context.router.navigate(const HomeRoute());
    }
  }

  Future<bool?> _showSaveDialog() {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const DecisionDialog(
          title: 'Операция не была сохранена',
          message: 'Произошла ошибка сохранения операции. '
              'Сохранить на устройстве? '
              '(необходимо будет позже произвести ручную синхронизацию)',
        );
      },
    );
  }
}
