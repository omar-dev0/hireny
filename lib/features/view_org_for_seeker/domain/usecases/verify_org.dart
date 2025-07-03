import 'package:injectable/injectable.dart';

import '../entities/org_entity.dart';
import '../repositories/org_repo.dart';

@injectable
class VerifyOrg {
  OrgRepo orgRepo;

  VerifyOrg({required this.orgRepo});
  Future<OrgEntity> call(OrgEntity org, bool orgState) async {
    return await orgRepo.verifyOrg(org, orgState);
  }
}
