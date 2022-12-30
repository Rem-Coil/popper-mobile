import 'package:dio/dio.dart';
import 'package:popper_mobile/data/models/operation/remote_operation.dart';
import 'package:popper_mobile/data/models/scanned_entity/remote_batch.dart';
import 'package:popper_mobile/data/models/scanned_entity/remote_bobbin.dart';
import 'package:popper_mobile/data/models/user/credentials_json.dart';
import 'package:popper_mobile/data/models/user/token.dart';
import 'package:popper_mobile/data/models/user/user_json.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/operator/sign_in')
  Future<Token> singIn(@Body() CredentialsJson credentials);

  @POST('/operator/sign_up')
  Future<Token> singUp(@Body() UserJson user);

  @GET('/bobbin/{id}')
  Future<RemoteBobbin> getBobbinInfo(@Path('id') int id);

  @GET('/batch/{id}')
  Future<RemoteBatch> getBatchInfo(@Path('id') int id);

  @POST('/action')
  Future<RemoteBobbinOperation> saveBobbinOperation(
    @Body() RemoteBobbinOperation operation,
  );

  @POST('/action/batch')
  Future<List<RemoteBobbinOperation>> saveBatchOperation(
    @Body() RemoteBatchOperation operation,
  );

  @DELETE('/bobbin/{id}')
  Future<void> defectBobbin(@Path('id') int id);

// @PUT('/action')
// Future<void> updateOperation(
//     @Header('Authorization') String token, @Body() OperationRemote action);
//
// @DELETE('/action/{id}')
// Future<void> deleteOperation(
//     @Header('Authorization') String token, @Path('id') int id);
//
// @GET('/action/full/bobbin/{id}')
// Future<List<FullOperation>> getBobbinHistory(@Path('id') int id);
}
