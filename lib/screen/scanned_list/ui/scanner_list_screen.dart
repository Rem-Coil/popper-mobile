import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/scanned_list/bloc/bloc.dart';
import 'package:popper_mobile/screen/scanned_list/models/operation_status.dart';
import 'package:popper_mobile/screen/scanned_list/ui/widgets/center_text_with_image.dart';
import 'package:popper_mobile/screen/scanned_list/ui/widgets/operation_widget.dart';

class ScannerListScreen extends StatefulWidget {
  static const route = "/scanner_screen";
  final OperationStatus status;

  const ScannerListScreen({Key? key, required this.status}) : super(key: key);

  @override
  State<ScannerListScreen> createState() => _ScannerListScreenState();
}

class _ScannerListScreenState extends State<ScannerListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.status.title),
        backgroundColor: widget.status.color,
      ),
      body: BlocBuilder<OperationListBloc, OperationsListState>(
        builder: (context, state) {
          if (state is ErrorState) {
            return CenterTextWithImage(
              image: 'assets/images/load_exception.png',
              title: state.failure.message,
            );
          }

          if (state is ActionsList) {
            if (state.operations.isEmpty) {
              return CenterTextWithImage(
                image: 'assets/images/worker.png',
                title: 'Тут пока ничего нет',
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.operations.length,
                itemBuilder: (context, i) {
                  return OperationWidget(operation: state.operations[i]);
                },
              ),
            );
          }

          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OperationListBloc>(context)
      ..add(LoadOperations(widget.status));
  }
}
