import 'package:dio/dio.dart';
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

  FResult<User> getById(int id) async {
    final user = await _authRepository.getCurrentUserOrNull();
    if (user == null || user.id != id) return _fetchUserInfo(id);
    return Right(user);
  }

  FResult<User> _fetchUserInfo(int id) async {
    try {
      final service = apiProvider.getApiService();
      final users = await service.getAllUsers();
      final userById = users.where((u) => u.id == id).map((u) {
        return User(id: u.id, firstName: u.firstName, secondName: u.secondName);
      }).toList();

      if (userById.length > 1 || userById.isEmpty) {
        return const Left(NoSuchUserFailure());
      }
      return Right(userById.first);
    } on DioException catch (e) {
      return handleDioException(e);
    }
  }
}
