import 'package:popper_mobile/data/factories/operation_factory.dart';
import 'package:popper_mobile/data/models/history/remote_batch_history.dart';
import 'package:popper_mobile/data/models/history/remote_bobbin_history.dart';
import 'package:popper_mobile/domain/models/batch/batch.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/history/batch_history.dart';
import 'package:popper_mobile/domain/models/history/bobbin_history.dart';
import 'package:popper_mobile/domain/models/user/user.dart';

class HistoryFactory {
  static BobbinHistory mapBobbinHistory(RemoteBobbinHistory history) {
    final bobbin = Bobbin(id: history.id, batchId: -1, number: history.number);

    final operations = history.operations.map((o) {
      final user = User(
        id: o.operatorId,
        firstName: o.firstName,
        surname: o.surname,
        secondName: o.secondName,
      );

      return OperationFactory.mapFromRemoteToOperation(
        user,
        o,
        bobbin,
        o.comment,
      );
    }).toList();

    return BobbinHistory(
      bobbin: bobbin,
      operations: operations,
    );
  }

  static BatchHistory mapBatchHistory(RemoteBatchHistory history) {
    final batch = Batch(id: history.id, taskId: -1, number: history.number);
    final bobbins = history.bobbins.map(mapBobbinHistory).toList();

    return BatchHistory(
      batch: batch,
      bobbins: bobbins,
    );
  }
}
