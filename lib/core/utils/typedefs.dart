import 'package:either_dart/either.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';

typedef ListCallback<T> = void Function(List<T>);

typedef OperationCallback = void Function(Operation);

typedef Result<T> = Either<Failure, T>;

typedef FResult<T> = Future<Either<Failure, T>>;
