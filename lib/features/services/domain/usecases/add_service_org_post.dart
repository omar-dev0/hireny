import 'package:hireny/features/services/domain/models/request/service_post_request.dart';
import 'package:hireny/features/services/domain/models/response/service_post_response.dart';
import 'package:hireny/features/services/domain/repo/service_org_repo_interface.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddServiceOrgPost {
  final ServiceOrgRepoInterface serviceRepo;
  AddServiceOrgPost(this.serviceRepo);

  Future<Result<ServiceResponse>> call(ServiceRequestModel service)  {
    return  serviceRepo.addServicePost(service);
  }

}
