import 'package:flutter/foundation.dart';
import 'package:popper_mobile/models/action/local_action.dart';

@immutable
class ActionsState {
  final List<LocalAction> actions;
  final bool isLoad;
  final String? errorMessage;

  ActionsState._(this.actions, this.isLoad, this.errorMessage);

  factory ActionsState.initial() => ActionsState._(List.empty(), false, null);

  factory ActionsState.load() => ActionsState._(List.empty(), true, null);

  factory ActionsState.error(String message) =>
      ActionsState._(List.empty(), false, message);

  factory ActionsState.withActions(List<LocalAction> actions) =>
      ActionsState._(actions, false, null);
}
