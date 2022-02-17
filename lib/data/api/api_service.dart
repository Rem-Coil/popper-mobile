import 'package:dio/dio.dart';
import 'package:popper_mobile/models/auth/token.dart';
import 'package:popper_mobile/models/auth/user_credentials.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/operator/sign_in')
  Future<Token> singIn(@Body() UserCredentials user);

  @GET('/bobbin/{id}')
  Future<BobbinRemote> getBobbinInfo(@Path('id') int id);

  @POST('/action')
  Future<OperationRemote> saveOperation(@Body() OperationRemote action);

  @PUT('/action')
  Future<void> updateOperation(@Body() OperationRemote action);

  @DELETE('/action/{id}')
  Future<void> deleteOperation(@Path('id') int id);
}
