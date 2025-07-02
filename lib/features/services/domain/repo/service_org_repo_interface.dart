import 'package:hireny/features/services/domain/models/request/service_post_request.dart';
import 'package:hireny/features/services/domain/models/response/service_post_response.dart';
import 'package:hireny/result.dart';

abstract class ServiceOrgRepoInterface {
  Future<Result<ServiceResponse>> addServicePost(ServiceRequestModel service);
}
