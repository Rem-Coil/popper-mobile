import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
import 'package:popper_mobile/screen/bobbin_loading/ui/bobbin_loading_screen.dart';
import 'package:popper_mobile/screen/home/bloc/bloc.dart';
import 'package:popper_mobile/screen/home/ui/widgets/home_header.dart';
import 'package:popper_mobile/screen/home/ui/widgets/operations_list_button.dart';
import 'package:popper_mobile/screen/scanned_list/models/operation_status.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
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
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Column(
              children: [
                HomeHeader(),
                SizedBox(height: 47),
                Row(
                  children: [
                    Expanded(
                      child: OperationsListButton(
                        status: OperationStatus.saved,
                        count: state.countSavedActions,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: OperationsListButton(
                        status: OperationStatus.cached,
                        count: state.countCachedActions,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16),
                SimpleButton(
                  width: double.infinity,
                  height: 67,
                  borderRadius: 16,
                  onPressed: () {
                    final scanned = ScannedEntity.fromString('bobbin:9');
                    context.push(BobbinLoadingScreen.route, args: scanned);
                    // BlocProvider.of<HomeBloc>(context).add(Initial());
                    // context.push(ScannerScreen.route);
                  },
                  child: Row(
                    children: [
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
