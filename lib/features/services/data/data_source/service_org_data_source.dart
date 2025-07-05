import 'package:flutter/cupertino.dart';
import 'package:hireny/features/services/data/data_source/service_org_data_source_interface.dart';
import 'package:hireny/features/services/data/service_api/service_api_manager.dart';
import 'package:hireny/features/services/domain/models/request/service_post_request.dart';
import 'package:hireny/features/services/domain/models/response/service_post_response.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ServiceOrgDataSourceInterface)


class ServiceOrgDataSource implements ServiceOrgDataSourceInterface {
  ServiceApiManager apiManger;

  ServiceOrgDataSource(this.apiManger);

  @override
  Future<Result<ServiceResponse>> addServicePost(ServiceRequestModel service) {
    return apiManger.addServicePost(service);
  }

  @override
  Future<Result<void>> getServices(int id) {

    return apiManger.getServices(id);

  }
  @override
  Future<Result<void>> deleteService(int id){
    return apiManger.deleteService(id);
  }

  @override
  Future<Result<void>> updateService(int id,ServiceRequestModel service) {
    return apiManger.updateService(id,service);
  }
}
