import 'package:dio/dio.dart';
import 'package:popper_mobile/models/token.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
  
  @POST('/operator/sign_in')
  Future<Token> singIn(@Body() Map<String, dynamic> map);
}