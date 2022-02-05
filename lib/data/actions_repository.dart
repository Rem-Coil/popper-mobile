import 'package:injectable/injectable.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class ActionsRepository {
  static const String _ACTION_TYPE_KEY = 'action_type';

  Future<ActionType?> getLastActionType() async {
    final prefs = await SharedPreferences.getInstance();
    final action = prefs.getString(_ACTION_TYPE_KEY);
    if (action == null) return null;
    return ActionType.values.firstWhere((a) => a.name == action, orElse: null);
  }

  Future<void> setLastActionType(ActionType? actionType) async {
    if (actionType == null) return;
    final prefs = await SharedPreferences.getInstance();
    final action = actionType.name;
    prefs.setString(_ACTION_TYPE_KEY, action);
  }
}
