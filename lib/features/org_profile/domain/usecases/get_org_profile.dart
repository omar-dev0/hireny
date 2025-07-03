import 'package:hireny/features/org_profile/domain/entities/org_profile_entity.dart';
import 'package:hireny/features/org_profile/domain/repositories/org_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrgProfile {
  final OrgProfileRepo profileRepo;

  GetOrgProfile({required this.profileRepo});
  Future<OrgProfileEntity> call(int orgID) async {
    return await profileRepo.getOrg(orgID);
  }
}
