import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/base_repository.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/user/user.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';

@singleton
class UsersRepository extends BaseRepository {
  const UsersRepository(super.apiProvider, this._authRepository);

  final AuthRepository _authRepository;

  /// Throws NoSuchUserFailure if the ID of the requested user differs from the current
  FResult<User> getById(int id) async {
    final user = await _authRepository.getCurrentUserOrNull();
    if (user == null || user.id != id) return const Left(NoSuchUserFailure());
    return Right(user);
  }
}
