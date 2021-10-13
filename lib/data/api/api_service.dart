import 'package:dio/dio.dart';
import 'package:popper_mobile/models/auth/token.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
  
  @POST('/operator/sign_in')
  Future<Token> singIn(@Body() Map<String, dynamic> user);

  @POST('/action')
  Future<void> saveAction(@Body() Map<String, dynamic> action);
}