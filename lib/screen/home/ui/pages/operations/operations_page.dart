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
    color: Colors.white,
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
    final theme = Theme.of(context);
    return Container(
      color: theme.backgroundColor,
      child: BlocBuilder<OperationsBloc, OperationsState>(
        builder: (context, state) {
          return NestedScrollView(
            headerSliverBuilder: (context, _) => [
              Header(total: state.todayTotal),
            ],
            body: Body(operations: state.operations),
          );
        },
      ),
    );
  }
}
