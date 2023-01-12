import 'package:popper_mobile/data/factories/operation_factory.dart';
import 'package:popper_mobile/data/models/history/remote_bobbin_history.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/history/bobbin_history.dart';
import 'package:popper_mobile/domain/models/user/user.dart';

class HistoryFactory {
  static BobbinHistory mapToHistory(RemoteBobbinHistory history) {
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
}
