import 'package:flutter/cupertino.dart';
import 'package:hireny/features/services/domain/models/request/service_post_request.dart';
import 'package:hireny/features/services/domain/models/response/service_post_response.dart';
import 'package:hireny/features/services/domain/repo/service_org_repo_interface.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteService {
  final ServiceOrgRepoInterface serviceRepo;
  DeleteService(this.serviceRepo);

  Future<Result<void>> call(int id)  {
    return  serviceRepo.deleteService(id);
  }

}
