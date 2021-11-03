import 'package:flutter/foundation.dart';

@immutable
class ActionsEvent {}

class UpdateListEvent extends ActionsEvent {}

class SyncActionsEvent extends ActionsEvent {}
