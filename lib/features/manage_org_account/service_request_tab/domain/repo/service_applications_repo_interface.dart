import '../../../../../result.dart';

abstract class ServiceApplicationsRepoInterface{
  Future<Result<void>> getServiceApplications();
  Future<Result<void>> deleteServiceApplication(int id);

}