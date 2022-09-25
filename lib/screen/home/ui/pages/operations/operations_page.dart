import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/home/ui/pages/operations/bloc/bloc.dart';
import 'package:popper_mobile/screen/home/ui/pages/operations/ui/body.dart';
import 'package:popper_mobile/screen/home/ui/pages/operations/ui/header.dart';
import 'package:popper_mobile/screen/home/ui/widgets/navigation_bar.dart';

class OperationsPage extends StatefulWidget {
  static const model = PageModel(
    icon: Icons.home,
    label: 'Главная',
    page: OperationsPage(),
  );

  const OperationsPage({super.key});

  @override
  State<OperationsPage> createState() => _OperationsPageState();
}

class _OperationsPageState extends State<OperationsPage> {
  @override
  void initState() {
    super.initState();
    context.read<OperationsBloc>().add(const InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<OperationsBloc, OperationsState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(total: state.todayTotal),
              const SizedBox(height: 16),
              Body(operations: state.operations),
            ],
          );
        },
      ),
    );
  }
}
