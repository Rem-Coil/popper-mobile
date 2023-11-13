import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/core/widgets/widget_with_warning.dart';
import 'package:popper_mobile/domain/models/operation/modify_event.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/models/specification/specification.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_text.dart';
import 'package:popper_mobile/ui/operation_info/general/operation_type_field/bloc/bloc.dart';
import 'package:popper_mobile/ui/operation_info/general/operation_type_field/ui/select_operation_type_button.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/bloc/bloc.dart';

class OperationTypeField extends StatelessWidget {
  const OperationTypeField({
    super.key,
    required this.selected,
    required this.specification,
    required this.isImmutable,
  });

  final OperationType? selected;
  final bool isImmutable;
  final Specification? specification;

  Widget get _label {
    if (selected == null) {
      return const WidgetWithWarning(child: ValueInfoText('Не выбрана'));
    }

    return ValueInfoText(selected!.name);
  }

  @override
  Widget build(BuildContext context) {
    if (isImmutable) {
      return _label;
    }

    if (specification == null) {
      return const WidgetWithWarning(
        warningTitle: 'Для изделия нет информации по ТЗ',
        child: ValueInfoText('Нет возможности выбрать'),
      );
    }

    return BlocProvider(
      create: (_) => getIt<LoadTypesBloc>(),
      child: SelectOperationTypeButton(
        label: _label,
        onTypeSelected: (t) async {
          final event = ChangeOperationTypeEvent(t);
          context.read<OperationSaveBloc>().add(ModifyOperationEvent(event));
        },
        specification: specification!,
      ),
    );
  }
}
