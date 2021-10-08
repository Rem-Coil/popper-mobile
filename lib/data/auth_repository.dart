import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/models/user_credentials.dart';

class AuthRepository {
  Future<String> singIn(UserCredentials credentials) async {
    final service = ApiProvider().getApiService();
    final token = await service.singIn(credentials.toJson());
    print('token generated');
    return token.token.substring(0, 5);
  }
}