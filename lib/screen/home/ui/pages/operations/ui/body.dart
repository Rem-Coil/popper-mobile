import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/core/theme/fonts.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/screen/home/ui/pages/operations/ui/operations_list.dart';

class BodyWithList extends StatelessWidget {
  const BodyWithList({super.key, required this.operations});

  final List<Operation> operations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Последение операции',
          style: Theme.of(context).textTheme.headlineSmall.bold,
        ),
        Flexible(
          child: OperationsList(
            operations: operations,
            onTap: (o) => context.router.push(
              SimpleInfoRoute(operation: o),
            ),
          ),
        ),
      ],
    );

  }
}
