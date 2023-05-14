import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/core/widgets/circular_loader.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/models/specification/specification.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_text.dart';
import 'package:popper_mobile/ui/operation_info/general/operation_type_field/bloc/bloc.dart';
import 'package:popper_mobile/ui/operation_info/general/operation_type_field/ui/select_operation_dialog.dart';

class SelectOperationTypeButton extends StatefulWidget {
  const SelectOperationTypeButton({
    Key? key,
    required this.selected,
    required this.onTypeSelected,
    required this.specification,
  }) : super(key: key);

  final OperationType? selected;
  final OnTypeSelected onTypeSelected;
  final Specification specification;

  @override
  State<SelectOperationTypeButton> createState() =>
      _SelectOperationTypeButtonState();
}

class _SelectOperationTypeButtonState extends State<SelectOperationTypeButton> {
  @override
  void initState() {
    super.initState();
    context.read<LoadTypesBloc>().add(LoadTypesEvent(widget.specification.id));
  }

  String get _label => widget.selected?.name ?? 'Выберете операцию';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoadTypesBloc, LoadTypesState>(
      listener: (context, state) {
        if (state is LoadingFailureState) {
          context.showErrorSnackBar(state.failure.toString());
        }
      },
      builder: (context, state) {
        final labelWidget = ValueInfoText(_label);
        if (state is! TypesLoadedState) {
          return Row(
            children: [
              labelWidget,
              const CircularLoader(),
            ],
          );
        }

        return GestureDetector(
          onTap: () async {
            final type = await showCupertinoModalPopup<OperationType>(
              context: context,
              builder: (_) => SelectOperationDialog(types: state.types),
            );
            widget.onTypeSelected(type);
          },
          child: labelWidget,
        );
      },
    );
  }
}

typedef OnTypeSelected = void Function(OperationType?);
