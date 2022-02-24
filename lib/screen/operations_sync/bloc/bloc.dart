import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/operations_sync/models/operation_with_status.dart';

part 'event.dart';

part 'state.dart';

@injectable
class OperationSyncBloc extends Bloc<OperationSyncEvent, OperationSyncState> {
  OperationSyncBloc(@factoryParam List<Operation>? operations)
      : super(OperationSyncState.initial(operations!));
}
