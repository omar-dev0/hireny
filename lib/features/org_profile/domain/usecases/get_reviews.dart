import 'package:hireny/features/org_profile/domain/entities/org_review_entity.dart';
import 'package:hireny/features/org_profile/domain/repositories/org_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetReviews{
  final OrgProfileRepo profileRepo;

  GetReviews({required this.profileRepo});
  Future<List<OrgReviewEntity>> call(int orgID) async {
    return await profileRepo.getReviews(orgID);
  }
}