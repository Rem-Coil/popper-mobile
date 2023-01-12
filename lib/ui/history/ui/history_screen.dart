import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/core/widgets/center_text_with_image.dart';
import 'package:popper_mobile/core/widgets/circular_loader.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/history/bobbin_history.dart';
import 'package:popper_mobile/ui/history/bloc/bloc.dart';
import 'package:popper_mobile/ui/history/ui/widgets/history_timeline.dart';

class HistoryScreen extends StatefulWidget implements AutoRouteWrapper {
  const HistoryScreen({Key? key, required this.bobbin}) : super(key: key);

  final Bobbin bobbin;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<HistoryBloc>(
      create: (_) => getIt<HistoryBloc>(),
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
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is LoadHistoryState) {
            return const Center(
              child: CircularLoader(size: 100, strokeWidth: 5),
            );
          }

          if (state is FailureHistoryState) {
            return CenterTextWithImage(
              image: 'assets/images/load_exception.png',
              title: state.failure.message,
            );
          }

          return _HistoryState((state as SuccessHistoryState).history);
        },
      ),
    );
  }
}

class _HistoryState extends StatelessWidget {
  const _HistoryState(this.history);

  final BobbinHistory history;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Катушка: ${history.bobbin.number}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const Divider(height: 1.0),
        Expanded(child: HistoryTimeLine(operations: history.operations)),
      ],
    );
  }
}
