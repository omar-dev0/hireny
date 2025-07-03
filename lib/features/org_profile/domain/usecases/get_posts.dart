import 'package:hireny/features/org_profile/domain/entities/org_post_entity.dart';
import 'package:hireny/features/org_profile/domain/repositories/org_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPosts {
  final OrgProfileRepo profileRepo;

  GetPosts({required this.profileRepo});
  Future<List<OrgPostCardEntity>> call(int orgID) async {
    return await profileRepo.getPosts(orgID);
  }
}
