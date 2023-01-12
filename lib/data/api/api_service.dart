import 'package:dio/dio.dart';
import 'package:popper_mobile/data/models/comment/remote_comment.dart';
import 'package:popper_mobile/data/models/history/remote_batch_history.dart';
import 'package:popper_mobile/data/models/history/remote_bobbin_history.dart';
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

  @POST('/comment')
  Future<void> saveComment(@Body() RemoteComment comment);

  @DELETE('/bobbin/{id}')
  Future<void> defectBobbin(@Path('id') int id);

  @GET('/action/bobbin/{id}/full')
  Future<RemoteBobbinHistory> getBobbinHistory(@Path('id') int id);

  @GET('/action/batch/{id}/full')
  Future<RemoteBatchHistory> getBatchHistory(@Path('id') int id);
}
