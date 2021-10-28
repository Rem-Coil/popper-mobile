import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/models/action/local_action.dart';

@singleton
class LocalActionsRepository {
  static const actionsKey = 'actions repo';

  Future<void> saveAction(LocalAction action) async {
    final actions = await Hive.openBox<LocalAction>(actionsKey);
    await actions.add(action);
    actions.close();
  }

  Future<Iterable<LocalAction>> getActions() async {
    final actionsBox = await Hive.openBox<LocalAction>(actionsKey);
    final actions = actionsBox.values;
    actionsBox.close();
    return actions;
  }
}