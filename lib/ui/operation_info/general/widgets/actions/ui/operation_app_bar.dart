import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/user/role.dart';
import 'package:popper_mobile/domain/models/user/user_identity.dart';
import 'package:popper_mobile/ui/current_user/bloc/bloc.dart';
import 'package:popper_mobile/ui/operation_info/general/widgets/actions/bloc/bloc.dart';
import 'package:popper_mobile/ui/operation_info/general/widgets/actions/ui/actions_button.dart';
import 'package:popper_mobile/core/widgets/dialogs/decision_dialog.dart';

class OperationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OperationAppBar({
    super.key,
    required this.title,
    required this.operation,
  });

  final String title;
  final Operation operation;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final userState = context.read<CurrentUserBloc>().state as WithUserState;

    return AppBar(
      title: Text(title),
      backgroundColor: Theme.of(context).backgroundColor,
      actions: [
        IconButton(
          icon: const Icon(Icons.history),
          splashRadius: 20.0,
          onPressed: () => context.router.push(
            HistoryRoute(item: operation.item),
          ),
        ),
        BlocProvider<OperationTasksBloc>(
          create: (_) => getIt<OperationTasksBloc>(),
          child: BobbinButtons(
            operation: operation,
            user: userState.user,
          ),
        ),
      ],
    );
  }
}

class BobbinButtons extends StatefulWidget {
  const BobbinButtons({
    super.key,
    required this.operation,
    required this.user,
  });

  final Operation operation;
  final UserIdentity user;

  @override
  State<BobbinButtons> createState() => _BobbinButtonsState();
}

class _BobbinButtonsState extends State<BobbinButtons> {
  @override
  Widget build(BuildContext context) {
    final buttons = <ActionButtonItemInfo>[];

    if (widget.user.role == Role.qualityEngineer &&
        widget.operation.item is Bobbin) {
      buttons.add(
        ActionButtonItemInfo(
          icon: Icons.block,
          onPressed: () async => _onDefectBobbin(),
          title: 'Заброковать катушку',
        ),
      );
    }

    if (widget.operation.status == OperationStatus.sync ||
        widget.operation.status == OperationStatus.notSync) {
      buttons.add(
        ActionButtonItemInfo(
          icon: Icons.delete,
          onPressed: () async => _onDeleteOperation(),
          title: 'Удалить операцию',
        ),
      );
    }

    if (buttons.isEmpty) {
      return const SizedBox.shrink();
    }

    return BlocListener<OperationTasksBloc, OperationTasksState>(
      listener: (context, state) {
        if (state is TaskStartState) {
          context.showLoadingSnackBar(message: 'Операция в процессе');
        }

        if (state is TaskFailedState) {
          context.hideCurrentSnackBar();
          context.showErrorSnackBar(state.failure.message);
        }

        if (state is TaskEndState) {
          context.hideCurrentSnackBar();
          context.showSuccessSnackBar('Успешно!');

          Future.delayed(const Duration(seconds: 1), () {
            context.router.pop();
          });
        }
      },
      child: ActionsButton(buttons: buttons),
    );
  }

  Future<void> _onDefectBobbin() async {
    final isClear = await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const DecisionDialog(
          title: 'Пометить катушку как отбракованную?',
          acceptActionTitle: 'Да',
          cancelActionTitle: 'Нет',
        );
      },
    );

    if (isClear == true && mounted) {
      final bobbin = widget.operation.item as Bobbin;
      context.read<OperationTasksBloc>().add(DefectBobbinEvent(bobbin.id));
    }
  }

  Future<void> _onDeleteOperation() async {
    final isClear = await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const DecisionDialog(
          title: 'Удалить данную операцию?',
          acceptActionTitle: 'Да',
          cancelActionTitle: 'Нет',
        );
      },
    );

    if (isClear == true && mounted) {
      context
          .read<OperationTasksBloc>()
          .add(DeleteOperationEvent(widget.operation));
    }
  }
}
