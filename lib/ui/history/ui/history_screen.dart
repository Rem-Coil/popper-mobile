import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/core/widgets/center_text_with_image.dart';
import 'package:popper_mobile/core/widgets/circular_loader.dart';
import 'package:popper_mobile/domain/models/history/product_history.dart';
import 'package:popper_mobile/domain/models/product/product_info.dart';
import 'package:popper_mobile/ui/history/bloc/bloc.dart';
import 'package:popper_mobile/ui/history/ui/widgets/history_timeline.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget implements AutoRouteWrapper {
  const HistoryScreen({Key? key, required this.product}) : super(key: key);

  final ProductInfo product;

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
    BlocProvider.of<HistoryBloc>(context).add(GetHistory(widget.product));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('История операций'),
        backgroundColor: Theme.of(context).colorScheme.background,
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
              title: state.failure.toString(),
            );
          }

          final stateWithHistory = state as SuccessHistoryState;
          final history = stateWithHistory.history as ProductHistory;
          return _ProductHistoryView(history);
        },
      ),
    );
  }
}

class _ProductHistoryView extends StatelessWidget {
  const _ProductHistoryView(this.history);

  final ProductHistory history;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleView(product: history.product),
        const Divider(height: 1.0),
        Expanded(
            child: history.operations.isEmpty
                ? const _NoOperationsText()
                : HistoryTimeLine(operations: history.operations)),
      ],
    );
  }
}

class _NoOperationsText extends StatelessWidget {
  const _NoOperationsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'По данному изделию не выполнено операций',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class _TitleView extends StatelessWidget {
  const _TitleView({
    required this.product,
  });

  final ProductInfo product;

  String get _title {
    final type = product.specification?.productType ?? 'Изделие';
    return '$type: ${product.number}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Text(
        _title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
