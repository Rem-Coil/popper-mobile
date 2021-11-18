import 'package:dio/dio.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/models/auth/token.dart';
import 'package:popper_mobile/models/qr_code/bobbin.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/operator/sign_in')
  Future<Token> singIn(@Body() Map<String, dynamic> user);

  @POST('/action')
  Future<Action> saveAction(@Body() Map<String, dynamic> action);

  @GET('/bobbin/{id}')
  Future<Bobbin> getBobbinInfo(@Path('id') int id);
}
