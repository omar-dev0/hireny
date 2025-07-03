import 'package:hireny/features/org_profile/domain/repositories/org_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddReview {
  final OrgProfileRepo profileRepo;

  AddReview({required this.profileRepo});
  Future<void> call(String review) async {
    return await profileRepo.addReview(review);
  }
}
