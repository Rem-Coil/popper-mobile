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
    required this.kit,
  });

  final FullKitInfo kit;

  @override
  State<DeletedKitExpansionTile> createState() =>
      _DeletedKitExpansionTileState();
}

class _DeletedKitExpansionTileState extends State<DeletedKitExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.kit.kit.number,
        style: const TextStyle(color: Colors.redAccent),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.redAccent,
        ),
        onPressed: () {
          _showAcceptanceDialog(widget.kit.batches, mounted, context);
        },
      ),
      children: widget.kit.batches
          .map((b) => DeletedBatchListTile(batch: b))
          .toList(),
    );
  }
}

class DeletedBatchListTile extends StatefulWidget {
  const DeletedBatchListTile({super.key, required this.batch});

  final Batch batch;

  @override
  State<DeletedBatchListTile> createState() => _DeletedBatchListTileState();
}

class _DeletedBatchListTileState extends State<DeletedBatchListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(24, 4, 4, 4),
      leading: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.redAccent,
        ),
        onPressed: () {
          _showAcceptanceDialog([widget.batch], mounted, context);
        },
      ),
      title: Text(
        '${widget.batch.kitId.toString()} - ${widget.batch.id.toString()}',
        style: const TextStyle(color: Colors.redAccent),
      ),
    );
  }
}

Future<void> _showAcceptanceDialog(
  List<Batch> batches,
  bool mounted,
  BuildContext context,
) async {
  final isSaveInCache = await _showDeleteDialog(context);

  if (!mounted) return;
  if (isSaveInCache == true) {
    context
        .read<KitSelectionBloc>()
        .add(UpdateDeletedBatches(batchesToDelete: batches));
  }
}

Future<bool?> _showDeleteDialog(BuildContext context) {
  return showCupertinoDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return const DecisionDialog(
        title: 'Удалить набор?',
        message: 'Набор сохранён в кеше но отсутствует на сервере. '
            'Удалить из кеша? ',
        cancelActionTitle: 'Отмена',
        acceptActionTitle: 'Удалить',
      );
    },
  );
}
