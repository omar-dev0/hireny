import 'package:hireny/features/org_profile/data/data_source/org_profile_data_source.dart';
import 'package:hireny/features/org_profile/domain/models/reviews.dart';
import 'package:hireny/features/org_profile/domain/repo_contract/org_profile_repo_contratc.dart';
import 'package:hireny/features/seeker/domain/modules/job_details.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrgProfileRepoContract)
class OrgProfileRepoImp extends OrgProfileRepoContract {
  OrgProfileDataSource orgProfileDataSource;
  @factoryMethod
  OrgProfileRepoImp(this.orgProfileDataSource);

  @override
  Future<Result<ReviewModel>?> createReview(String review, num id) {
    return orgProfileDataSource.createReview(review, id);
  }

  @override
  Future<Result<void>?> deleteReview(num id) {
    return orgProfileDataSource.deleteReview(id);
  }

  @override
  Future<Result<List<JobDetailsModel>>?> getOrgJobs(num id) {
    return orgProfileDataSource.getOrgJobs(id);
  }

  @override
  Future<Result<List<ReviewModel>>?> getOrgReviews(num id) {
    return orgProfileDataSource.getOrgReviews(id);
  }

  @override
  Future<Result<void>?> updateReview(String review, num id) {
    return orgProfileDataSource.updateReview(review, id);
  }
}
