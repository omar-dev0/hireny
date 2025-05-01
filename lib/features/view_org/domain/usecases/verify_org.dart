import 'package:hireny/features/view_org/domain/entities/org_entity.dart';
import 'package:hireny/features/view_org/domain/repositories/org_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class VerifyOrg{
  OrgRepo orgRepo;

  VerifyOrg({required this.orgRepo});
  Future<OrgEntity>call(OrgEntity org, bool orgState) async {
    return await orgRepo.verifyOrg(org, orgState);
  }
}