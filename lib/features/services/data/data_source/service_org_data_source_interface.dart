import 'package:hireny/features/services/domain/models/request/service_post_request.dart';
import 'package:hireny/features/services/domain/models/response/service_post_response.dart';
import 'package:hireny/result.dart';

abstract class ServiceOrgDataSourceInterface {

  Future<Result<ServiceResponse>>addServicePost(ServiceRequestModel service);
  Future<Result<void>> getServices(int id);
  Future<Result<void>> deleteService(int id);
  Future<Result<void>> updateService(int id,ServiceRequestModel service);
  }