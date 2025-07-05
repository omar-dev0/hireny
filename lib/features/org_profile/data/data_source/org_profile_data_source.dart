import '../../../../result.dart';
import '../../../seeker/domain/modules/job_details.dart';
import '../../domain/models/reviews.dart';

abstract class OrgProfileDataSource {
  Future<Result<List<ReviewModel>>?> getOrgReviews(num id);
  Future<Result<ReviewModel>?> createReview(String review, num id);
  Future<Result<void>?> deleteReview(num id);
  Future<Result<void>?> updateReview(String review, num id);
  Future<Result<List<JobDetailsModel>>?> getOrgJobs(num id);
}
