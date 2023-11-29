import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/widgets/dialogs/decision_dialog.dart';
import 'package:popper_mobile/domain/entities/full_kit_info.dart';
import 'package:popper_mobile/domain/models/kit/batch.dart';
import 'package:popper_mobile/ui/kit_selection/bloc/bloc.dart';

class DeletedKitExpansionTile extends StatefulWidget {
  const DeletedKitExpansionTile({
    super.key,
    required this.data,
  });

  final FullKitInfo data;

  @override
  State<DeletedKitExpansionTile> createState() =>
      _DeletedKitExpansionTileState();
}

class _DeletedKitExpansionTileState extends State<DeletedKitExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.data.kit.number,
        style: const TextStyle(color: Colors.redAccent),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.redAccent,
        ),
        onPressed: () {
          _showAcceptanceDialog(widget.data.batches);
        },
      ),
      children: widget.data.batches
          .map((b) => DeletedBatchListTile(
                batch: b,
                onPressed:() {
                  _showAcceptanceDialog([b]);
                },
              ))
          .toList(),
    );
  }

  Future<void> _showAcceptanceDialog(List<Batch> batches) async {
    final isSaveInCache = await _showDeleteDialog();

    if (!mounted) return;
    if (isSaveInCache!) {
      context
          .read<KitSelectionBloc>()
          .add(UpdateDeletedBatches(batchesToDelete: batches));
    }
  }

  Future<bool?> _showDeleteDialog() {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const DecisionDialog(
          title: 'Удалить набор?',
          message: 'Набор сохранён в кеше но отсутствует на сервере. '
              'Отменить действие будет невозможно. '
              'Удалить из кеша? ',
          cancelActionTitle: 'Отмена',
          acceptActionTitle: 'Удалить',
        );
      },
    );
  }
}

class DeletedBatchListTile extends StatelessWidget {
  const DeletedBatchListTile({
    super.key,
    required this.batch,
    required this.onPressed,
  });

  final Batch batch;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(24, 4, 4, 4),
      leading: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.redAccent,
        ),
        onPressed: onPressed,
      ),
      title: Text(
        '${batch.kitId.toString()} - ${batch.id.toString()}',
        style: const TextStyle(color: Colors.redAccent),
      ),
    );
  }
}
