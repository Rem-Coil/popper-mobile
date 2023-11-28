import 'package:flutter/material.dart';
import 'package:popper_mobile/ui/kit_selection/bloc/bloc.dart';
import 'package:popper_mobile/ui/kit_selection/ui/widgets/deleted_kit_expansion_tile.dart';
import 'package:popper_mobile/ui/kit_selection/ui/widgets/kit_expansion_tile.dart';

class KitScrollView extends StatelessWidget {
  const KitScrollView({
    super.key,
    required this.state,
  });

  final SaveKitSelectionState state;

  @override
  Widget build(BuildContext context) {
    final List<Padding> widgetList = [];
    if (state.deletedBatches.batches.isNotEmpty) {
      widgetList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: DeletedKitExpansionTile(kit: state.deletedBatches),
      ));
    }

    widgetList.addAll(state.kitList
        .map(
          (e) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: KitExpansionTile(
              kit: e,
              selected: state.selectedBatches,
            ),
          ),
        )
        .toList());

    return SingleChildScrollView(
      child: Column(children: widgetList),
    );
  }
}
