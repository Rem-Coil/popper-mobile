import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/ui/operation_info/general/actions/ui/operation_app_bar.dart';
import 'package:popper_mobile/ui/operation_info/general/views/operation_info.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/bloc/bloc.dart';
import 'package:popper_mobile/core/widgets/buttons/simple_button.dart';
import 'package:popper_mobile/core/widgets/circular_loader.dart';

class SelectOperationTypeView extends StatelessWidget {
  const SelectOperationTypeView({super.key, required this.state});

  final WithOperationState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OperationAppBar(
        title: 'Сохранить операцию?',
        operation: state.operation,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                child: OperationInfo.changeable(state.operation),
              ),
            ),
            const SizedBox(height: 16),
            _ActionButton(
              isActive: state.isCanSave,
              isLoad: isLoad(state),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  bool isLoad(OperationSaveState state) =>
      state is SaveProcessState || state is CacheProcessState;
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.isActive,
    required this.isLoad,
  });

  final bool isActive;
  final bool isLoad;

  @override
  Widget build(BuildContext context) {
    return SimpleButton(
      width: double.infinity,
      height: 55,
      color: Colors.green,
      onPressed: isActive
          ? () => context.read<OperationSaveBloc>().add(const SaveOperation())
          : null,
      child: isLoad
          ? const CircularLoader(size: 20, strokeWidth: 3)
          : const Text('Сохранить', style: TextStyle(fontSize: 18)),
    );
  }
}
