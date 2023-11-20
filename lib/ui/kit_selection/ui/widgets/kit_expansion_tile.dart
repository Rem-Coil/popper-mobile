import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/domain/models/kit/batch.dart';
import 'package:popper_mobile/domain/models/kit/full_kit_info.dart';
import 'package:popper_mobile/ui/kit_selection/bloc/bloc.dart';

class KitExpansionTile extends StatelessWidget {
  const KitExpansionTile({
    super.key,
    required this.kit,
    required this.selected,
  });

  final FullKitInfo kit;
  final List<Batch> selected;

  bool? get value {
    if (kit.batches.every((b) => selected.contains(b))) {
      return true;
    }

    if (kit.batches.any((b) => selected.contains(b))) {
      return null;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(kit.kitName),
      leading: Checkbox(
        tristate: true,
        value: value,
        onChanged: (value) {
          context
              .read<KitSelectionBloc>()
              .add(UpdateKitSelection(kit: kit, selected: value));
        },
      ),
      children: kit.batches
          .map((batch) => BatchCheckboxListTile(
                batch: batch,
                selected: selected.contains(batch),
              ))
          .toList(),
    );
  }
}

class BatchCheckboxListTile extends StatelessWidget {
  const BatchCheckboxListTile({
    required this.batch,
    required this.selected,
    super.key,
  });

  final Batch batch;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: selected,
      contentPadding: const EdgeInsets.fromLTRB(24, 4, 4, 4),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (value) {
        context
            .read<KitSelectionBloc>()
            .add(UpdateBatchSelection(batch: batch));
      },
      title: Text(batch.batchNumber.toString()),
    );
  }
}
