import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';
import 'package:popper_mobile/screen/scanned_list/models/operation_status.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';

class OperationsListButton extends StatelessWidget {
  final int count;
  final OperationStatus status;

  const OperationsListButton({
    Key? key,
    required this.count,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleButton(
      height: 176,
      color: status.color,
      borderRadius: 16,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          Text(
            '${status.title}:',
            style: TextStyle(fontSize: 18, color: Colors.white, height: 1.2),
          ),
          Spacer(),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 64,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onPressed: () => status == OperationStatus.saved
          ? context.router.push(const SavedOperationsRoute())
          : context.router.push(const CachedOperationsRoute()),
    );
  }
}
