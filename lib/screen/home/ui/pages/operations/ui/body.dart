import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/home/ui/pages/operations/ui/operations_list.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.operations});

  final List<Operation> operations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Последение операции',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        OperationsList(
          operations: operations,
          onTap: (o) => context.router.push(
            UpdateOperationRoute(operation: o),
          ),
        ),
      ],
    );
  }
}
