import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/user/credentials.dart';
import 'package:popper_mobile/domain/models/user/user.dart';

abstract class AuthRepository {
  FResult<void> singIn(Credentials credentials);

  FResult<void> singUp(User user, String password);

  Future<void> logOut();

  Future<User?> getCurrentUserOrNull();
}
