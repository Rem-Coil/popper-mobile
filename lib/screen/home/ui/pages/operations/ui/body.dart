import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/core/theme/fonts.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/home/ui/pages/operations/ui/operations_list.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.operations});

  final List<Operation> operations;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
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
                  UpdateOperationRoute(operation: o),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
