import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/models/action/action.dart';

@singleton
class ActionsCache {
  static const String _SAVED_ACTIONS_BOX = 'saved_actions';
  static const String _NOT_SAVED_ACTIONS_BOX = 'not_saved_actions';

  Future<void> saveAction(Action action) async =>
      _saveAction(action, _SAVED_ACTIONS_BOX);

  Future<void> saveNoSavedAction(Action action) async =>
      _saveAction(action, _NOT_SAVED_ACTIONS_BOX);

  Future<void> _saveAction(Action action, String boxName) async {
    final localAction = ActionLocal.fromAction(action);
    final box = await Hive.openBox<ActionLocal>(boxName);
    await box.add(localAction);
    await box.close();
  }

  Future<List<ActionLocal>> getActions() async =>
      _getActions(_SAVED_ACTIONS_BOX);

  Future<List<ActionLocal>> getNotSavedActions() async =>
      _getActions(_NOT_SAVED_ACTIONS_BOX);

  Future<List<ActionLocal>> _getActions(String boxName) async {
    final box = await Hive.openBox<ActionLocal>(boxName);
    final actions = box.values;
    await box.close();
    return actions.toList();
  }
}
