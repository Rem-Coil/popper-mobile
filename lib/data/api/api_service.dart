import 'package:dio/dio.dart';
import 'package:popper_mobile/data/models/batch/remote_batch.dart';
import 'package:popper_mobile/data/models/kit/remote_kit.dart';
import 'package:popper_mobile/data/models/operation/remote_operation.dart';
import 'package:popper_mobile/data/models/operation/remote_operation_body.dart';
import 'package:popper_mobile/data/models/product/remote_product.dart';
import 'package:popper_mobile/data/models/specification/remote_specification.dart';
import 'package:popper_mobile/data/models/user/credentials_json.dart';
import 'package:popper_mobile/data/models/user/token.dart';
import 'package:popper_mobile/data/models/user/user_json.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/v2/employee/sign_in')
  Future<Token> singIn(@Body() CredentialsJson credentials);

  @POST('/v2/employee/sign_up')
  Future<Token> singUp(@Body() UserJson user);

  @GET('/v2/employee?active_only=true')
  Future<List<UserJson>> getAllUsers();

  @GET('/v2/product/{id}')
  Future<RemoteProduct> getProductInfo(@Path('id') int id);

  @GET('/v2/specification')
  Future<List<RemoteSpecification>> getAllSpecifications();

  @GET('/v2/kit/{id}')
  Future<RemoteKit> getKitById(@Path('id') int id);

  @GET('/v2/batch/{id}')
  Future<RemoteBatch> getBatchById(@Path('id') int id);

  @GET('/v2/action/product/{id}')
  Future<List<RemoteOperatorOperation>> getOperatorOperationsByProduct(
    @Path('id') int id,
  );

  @POST('/v2/action')
  Future<RemoteOperatorOperation> saveOperatorOperation(
    @Body() RemoteOperatorOperationBody operation,
  );

  @DELETE('/v2/action/{id}')
  Future<void> deleteOperatorOperation(@Path('id') int id);

  @GET('/v2/control_action')
  Future<List<RemoteCheckOperation>> getAllCheckOperation();

  @POST('/v2/control_action')
  Future<RemoteCheckOperation> saveCheckOperation(
    @Body() RemoteCheckOperationBody operation,
  );

  @DELETE('/v2/control_action/{id}')
  Future<void> deleteCheckOperation(@Path('id') int id);

  @PATCH('/v2/product/{id}/deactivate')
  Future<void> deactivateProduct(@Path('id') int id);
}
