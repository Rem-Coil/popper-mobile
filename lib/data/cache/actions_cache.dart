import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/models/action/action.dart';

@singleton
class ActionsCache {
  static const String _SAVED_ACTIONS_BOX = 'saved_actions';
  static const String _CACHED_ACTIONS_BOX = 'cached_actions';

  Future<Box<ActionLocal>> get _savedActions =>
      Hive.openBox(_SAVED_ACTIONS_BOX);

  Future<Box<ActionLocal>> get _cachedActions =>
      Hive.openBox(_CACHED_ACTIONS_BOX);

  Future<void> saveAction(Action action) async =>
      _saveAction(action, await _savedActions);

  Future<void> saveNoSavedAction(Action action) async =>
      _saveAction(action, await _cachedActions);

  Future<void> _saveAction(Action action, Box box) async {
    final localAction = action.toLocal();
    await box.add(localAction);
  }

  Future<void> updateAction(Action action) async {
    final box = await _savedActions;
    final localAction = action.toLocal();
    final actions = box.toMap();
    int oldActionIndex = -1;
    actions.forEach((key, value) {
      if (localAction.id == value.id) {
        oldActionIndex = key;
      }
    });
    await box.putAt(oldActionIndex, localAction);
  }

  Future<List<ActionLocal>> getActions() async =>
      _getActions(await _savedActions);

  Future<List<ActionLocal>> getNotSavedActions() async =>
      _getActions(await _savedActions);

  Future<List<ActionLocal>> _getActions(Box<ActionLocal> box) async {
    final actions = box.values;
    return actions.toList();
  }

  Future<ValueListenable<Box<ActionLocal>>> get savedActionListenable async =>
      (await _savedActions).listenable();

  Future<ValueListenable<Box<ActionLocal>>> get cachedActionListenable async =>
      (await _cachedActions).listenable();

  @disposeMethod
  Future<void> dispose() async {
    await (await _savedActions).close();
    await (await _cachedActions).close();
  }
}
