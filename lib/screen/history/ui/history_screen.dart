import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:popper_mobile/models/operation/expansion_panel_item.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';
import 'package:popper_mobile/screen/history/bloc/bloc.dart';
import 'package:popper_mobile/screen/history/ui/widgets/history_operation_widget.dart';
import 'package:popper_mobile/widgets/center_text_with_image.dart';
import 'package:popper_mobile/widgets/circular_loader.dart';

class HistoryScreen extends StatefulWidget implements AutoRouteWrapper {
  final Bobbin bobbin;

  const HistoryScreen({Key? key, required this.bobbin}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<HistoryBloc>(
      create: (_) => getIt.get<HistoryBloc>(param1: bobbin),
      child: this,
    );
  }
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryBloc>(context).add(GetHistory(widget.bobbin));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('История операций'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, s) {
          if (s is LoadHistoryState) {
            return const Center(
              child: CircularLoader(size: 100, strokeWidth: 5),
            );
          }

          if (s is FailureHistoryState) {
            return CenterTextWithImage(
              image: 'assets/images/load_exception.png',
              title: s.failure.message,
            );
          }

          final state = s as SuccessHistoryState;
          return SingleChildScrollView(
            child: ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                BlocProvider.of<HistoryBloc>(context).add(ShowHistory(index));
              },
              children:
                  state.items.map<ExpansionPanel>((OperationHistoryItem item) {
                return ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(item.type.localizedName),
                    );
                  },
                  body: item.operations.isNotEmpty
                      ? Column(
                          children: item.operations
                              .map((o) => HistoryOperationWidget(operation: o))
                              .toList(),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Здесь пока ничего нет',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                  isExpanded: item.isExpanded,
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}