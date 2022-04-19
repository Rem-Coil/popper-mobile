import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/screen/home/bloc/bloc.dart';
import 'package:popper_mobile/screen/home/ui/widgets/home_header.dart';
import 'package:popper_mobile/screen/home/ui/widgets/operations_list_button.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';
import 'package:popper_mobile/screen/scanned_list/models/operation_status.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';

class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  static const route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => getIt<HomeBloc>(),
      child: this,
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(Initial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Column(
              children: [
                const HomeHeader(),
                const SizedBox(height: 47),
                Row(
                  children: [
                    Expanded(
                      child: OperationsListButton(
                        status: OperationStatus.saved,
                        count: state.countSavedActions,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OperationsListButton(
                        status: OperationStatus.cached,
                        count: state.countCachedActions,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                SimpleButton(
                  width: double.infinity,
                  height: 67,
                  borderRadius: 16,
                  onPressed: () {
                    // final scanned = ScannedEntity.fromString('bobbin:18');
                    // context.router.push(BobbinLoadingRoute(bobbin: scanned));
                    context.router.push(const ScannerRoute());
                  },
                  child: Row(
                    children: const [
                      Text(
                        'Сканировать',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
