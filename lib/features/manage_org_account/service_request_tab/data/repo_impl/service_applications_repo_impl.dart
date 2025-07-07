import 'package:hireny/features/manage_org_account/service_request_tab/domain/repo/service_applications_repo_interface.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../data_source/service_applications_DS_interface.dart';

@Injectable(as:ServiceApplicationsRepoInterface)
class ServiceApplicationsRepoImpl extends ServiceApplicationsRepoInterface {
  ServiceApplicationsDSInterface serviceDS;

  ServiceApplicationsRepoImpl(this.serviceDS);

  @override
  Future<Result<void>> getServiceApplications() {
    return serviceDS.getServiceApplications();
  }

  @override
  Future<Result<void>> deleteServiceApplication(int id) {
    return serviceDS.deleteServiceApplication(id);
  }
}