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

  @POST('/employee/sign_in')
  Future<Token> singIn(@Body() CredentialsJson credentials);

  @POST('/employee/sign_up')
  Future<Token> singUp(@Body() UserJson user);

  @GET('/employee?active_only=true')
  Future<List<UserJson>> getAllUsers();

  @GET('/product/{id}')
  Future<RemoteProduct> getProductInfo(@Path('id') int id);

  @GET('/specification')
  Future<List<RemoteSpecification>> getAllSpecifications();

  @GET('/kit')
  Future<List<RemoteKit>> getAllKits();

  @GET('/kit/{id}')
  Future<RemoteKit> getKitById(@Path('id') int id);

  @GET('/batch')
  Future<List<RemoteBatch>> getAllBatches();

  @GET('/batch/{id}')
  Future<RemoteBatch> getBatchById(@Path('id') int id);

  @GET('/action/product/{id}')
  Future<List<RemoteOperatorOperation>> getOperatorOperationsByProduct(
    @Path('id') int id,
  );

  @POST('/action')
  Future<RemoteOperatorOperation> saveOperatorOperation(
    @Body() RemoteOperatorOperationBody operation,
  );

  @DELETE('/action/{id}')
  Future<void> deleteOperatorOperation(@Path('id') int id);

  @GET('/control_action')
  Future<List<RemoteCheckOperation>> getAllCheckOperation();

  @GET('/control_action/product/{id}')
  Future<List<RemoteCheckOperation>> getCheckOperationsByProduct(
    @Path('id') int id,
  );

  @POST('/control_action')
  Future<RemoteCheckOperation> saveCheckOperation(
    @Body() RemoteCheckOperationBody operation,
  );

  @DELETE('/control_action/{id}')
  Future<void> deleteCheckOperation(@Path('id') int id);

  @PATCH('/product/{id}/deactivate')
  Future<void> deactivateProduct(@Path('id') int id);

  @POST('/acceptance_action')
  Future<List<RemoteAcceptanceOperation>> saveAcceptanceOperation(
    @Body() RemoteAcceptanceOperationBody operation,
  );

  @GET('/acceptance_action/product/{id}')
  Future<RemoteAcceptanceOperation> getAcceptanceOperationsByProduct(
    @Path('id') int id,
  );

  @DELETE('/acceptance_action/{id}')
  Future<void> deleteAcceptanceOperation(@Path('id') int id);
}
