import 'package:flutter/cupertino.dart';
import 'package:hireny/features/services/data/data_source/service_org_data_source_interface.dart';
import 'package:hireny/features/services/domain/models/request/service_post_request.dart';
import 'package:hireny/features/services/domain/models/response/service_post_response.dart';
import 'package:hireny/features/services/domain/repo/service_org_repo_interface.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ServiceOrgRepoInterface)


class ServiceOrgRepoImpl implements ServiceOrgRepoInterface{
  ServiceOrgDataSourceInterface dataSource;

  ServiceOrgRepoImpl(this.dataSource);

  Future<Result<ServiceResponse>>addServicePost(ServiceRequestModel service){
    return dataSource.addServicePost(service);
  }
  Future<Result<void>> getServices(int id) {

    return dataSource.getServices(id);

  }
  Future<Result<void>> deleteService (int id){
    return dataSource.deleteService(id);
  }

  @override
  Future<Result<void>> updateService( int id,ServiceRequestModel service) {
    return dataSource.updateService(id,service);
  }
}