import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/domain/models/operation/modify_event.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/models/specification/specification.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_text.dart';
import 'package:popper_mobile/ui/operation_info/general/operation_type_field/bloc/bloc.dart';
import 'package:popper_mobile/ui/operation_info/general/operation_type_field/ui/select_operation_type_button.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/bloc/bloc.dart';

class OperationTypeField extends StatelessWidget {
  const OperationTypeField({
    Key? key,
    required this.selected,
    required this.specification,
    required this.isImmutable,
  })  : assert(isImmutable || specification != null),
        super(key: key);

  final OperationType? selected;
  final bool isImmutable;
  final Specification? specification;

  String get _label => selected?.name ?? 'Выберете операцию';

  @override
  Widget build(BuildContext context) {
    if (isImmutable) {
      return ValueInfoText(_label);
    }

    return BlocProvider(
      create: (_) => getIt<LoadTypesBloc>(),
      child: SelectOperationTypeButton(
        selected: selected,
        onTypeSelected: (t) async {
          final event = ChangeOperationTypeEvent(t);
          context.read<OperationSaveBloc>().add(ModifyOperationEvent(event));
        },
        specification: specification!,
      ),
    );
  }
}
