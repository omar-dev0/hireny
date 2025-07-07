import 'package:hireny/features/manage_org_account/service_request_tab/data/data_source/service_applications_DS_interface.dart';
import 'package:hireny/features/manage_org_account/service_request_tab/data/requests_api/service_request_api.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:ServiceApplicationsDSInterface)
class ServiceApplicationsDS extends ServiceApplicationsDSInterface{
  ServiceRequestApi serviceApi;

  ServiceApplicationsDS(this.serviceApi);

  @override
  Future<Result<void>> getServiceApplications() {
    return serviceApi.getServiceApplications();
  }

  @override
  Future<Result<void>> deleteServiceApplication(int id) {
    return serviceApi.deleteServiceApplication(id);
  }

}