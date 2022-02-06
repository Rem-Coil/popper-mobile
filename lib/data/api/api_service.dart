import 'package:dio/dio.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/models/auth/token.dart';
import 'package:popper_mobile/models/auth/user_credentials.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/operator/sign_in')
  Future<Token> singIn(@Body() UserCredentials user);

  @POST('/action')
  Future<ActionRemote> saveAction(@Body() ActionRemote action);

  @GET('/bobbin/{id}')
  Future<BobbinRemoteModel> getBobbinInfo(@Path('id') int id);
}
