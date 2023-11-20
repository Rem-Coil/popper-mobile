import 'package:flutter/material.dart';
import 'package:popper_mobile/ui/kit_selection/bloc/bloc.dart';
import 'package:popper_mobile/ui/kit_selection/ui/widgets/kit_expansion_tile.dart';

class KitScrollView extends StatelessWidget {
  const KitScrollView({
    super.key,
    required this.state,
  });

  final SaveKitSelectionState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: state.kitList
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: KitExpansionTile(
                    kit: e,
                    selected: state.selectedBatches,
                  ),
                ),
              )
              .toList()),
    );
  }
}
