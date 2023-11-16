import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/models/operation_type/local_operation_type.dart';
import 'package:popper_mobile/data/models/operation_type/remote_operation_type.dart';
import 'package:popper_mobile/data/models/specification/local_specification.dart';
import 'package:popper_mobile/data/models/specification/remote_specification.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/models/specification/specification.dart';

@singleton
class SpecificationFactory {
  Specification mapToSpec(LocalSpecification specification) {
    return Specification(
      id: specification.id,
      productType: specification.productType,
    );
  }

  LocalSpecification mapToLocal(RemoteSpecification specification) {
    final localTypes = specification.operationTypes.map(_mapType);
    return LocalSpecification(
      id: specification.id,
      productType: specification.productType,
      operationTypes: localTypes.toList(),
    );
  }

  LocalOperationType _mapType(RemoteOperationType type) {
    return LocalOperationType(
      id: type.id,
      name: type.name,
      sequenceNumber: type.sequenceNumber,
      specificationId: type.specificationId,
    );
  }

  LocalSimpleOperationType mapToSimpleLocalType(ActionType type) {
    return LocalSimpleOperationType(
      id: type.id,
      name: type.name,
    );
  }
}
