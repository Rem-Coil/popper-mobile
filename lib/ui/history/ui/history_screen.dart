import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/core/widgets/center_text_with_image.dart';
import 'package:popper_mobile/core/widgets/circular_loader.dart';
import 'package:popper_mobile/domain/models/history/batch_history.dart';
import 'package:popper_mobile/domain/models/history/bobbin_history.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';
import 'package:popper_mobile/ui/history/bloc/bloc.dart';
import 'package:popper_mobile/ui/history/ui/widgets/history_timeline.dart';

class HistoryScreen extends StatefulWidget implements AutoRouteWrapper {
  const HistoryScreen({Key? key, required this.item}) : super(key: key);

  final ScannedEntity item;

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
    BlocProvider.of<HistoryBloc>(context).add(GetHistory(widget.item));
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

          final history = (state as SuccessHistoryState).history;

          if (history is BobbinHistory) {
            return _BobbinHistoryView(history);
          }

          return _BatchHistoryView(history as BatchHistory);
        },
      ),
    );
  }
}

class _BatchHistoryView extends StatefulWidget {
  const _BatchHistoryView(this.history);

  final BatchHistory history;

  @override
  State<_BatchHistoryView> createState() => _BatchHistoryViewState();
}

class _BatchHistoryViewState extends State<_BatchHistoryView> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    late final Widget body;
    late final Widget title;

    if (selected != -1) {
      final bobbinHistory = widget.history.bobbins[selected];
      title = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TitleView(
                  title: 'Катушка:',
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
                ),
                _TitleView(
                  title: bobbinHistory.number,
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => setState(() {
              selected = -1;
            }),
            child: const _TitleView(
              title: 'Сбросить',
              textColor: Colors.blue,
              isSmall: true,
            ),
          )
        ],
      );
      body = HistoryTimeLine(operations: bobbinHistory.operations);
    } else {
      title = const _TitleView(title: 'Катушка:');
      body = _SelectBobbinView(
        bobbins: widget.history.bobbins,
        onTap: (item) => setState(() {
          selected = item;
        }),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleView(title: 'Партия: ${widget.history.number}'),
        const Divider(height: 1.0),
        title,
        const Divider(height: 1.0),
        Expanded(child: body),
      ],
    );
  }
}

class _SelectBobbinView extends StatelessWidget {
  const _SelectBobbinView({required this.bobbins, required this.onTap});

  final List<BobbinHistory> bobbins;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bobbins.length,
      itemBuilder: (context, i) {
        return ListTile(
          onTap: () => onTap(i),
          title: Text(bobbins[i].number),
        );
      },
    );
  }
}

class _BobbinHistoryView extends StatelessWidget {
  const _BobbinHistoryView(this.history);

  final BobbinHistory history;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleView(title: 'Катушка: ${history.number}'),
        const Divider(height: 1.0),
        Expanded(child: HistoryTimeLine(operations: history.operations)),
      ],
    );
  }
}

class _TitleView extends StatelessWidget {
  const _TitleView({
    required this.title,
    this.textColor,
    this.isSmall = false,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
  });

  final String title;
  final Color? textColor;
  final bool isSmall;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final textTheme = isSmall ? theme.subtitle1 : theme.headlineSmall;

    return Padding(
      padding: padding,
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme?.copyWith(color: textColor),
      ),
    );
  }
}
