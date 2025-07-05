import 'package:hireny/features/org_profile/data/api/api_manger.dart';
import 'package:hireny/features/org_profile/data/data_source/org_profile_data_source.dart';
import 'package:hireny/features/org_profile/domain/models/reviews.dart';
import 'package:hireny/features/seeker/domain/modules/job_details.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrgProfileDataSource)
class OrgProfileDataSourceImp extends OrgProfileDataSource {
  OrgProfileApi orgProfileApi;
  @factoryMethod
  OrgProfileDataSourceImp(this.orgProfileApi);

  @override
  Future<Result<ReviewModel>?> createReview(String review, num id) {
    return orgProfileApi.createReview(review, id);
  }

  @override
  Future<Result<void>?> deleteReview(num id) {
    return orgProfileApi.deleteReview(id);
  }

  @override
  Future<Result<List<JobDetailsModel>>?> getOrgJobs(num id) {
    return orgProfileApi.getOrgJobs(id);
  }

  @override
  Future<Result<List<ReviewModel>>?> getOrgReviews(num id) {
    return orgProfileApi.getOrgReviews(id);
  }

  @override
  Future<Result<void>?> updateReview(String review, num id) {
    return orgProfileApi.updateReview(review, id);
  }
}
