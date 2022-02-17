import 'package:dartz/dartz.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';

abstract class BobbinsRepository {
  Future<Either<Failure, Bobbin>> getBobbinInfo(int id);
}
