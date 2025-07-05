import 'package:hireny/features/seeker/domain/modules/job_post.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/modules/course.dart';
import '../../domain/modules/job_details.dart';
import '../../domain/modules/org_post.dart';
import '../../domain/repo_contract/seeker_repository.dart';
import '../data_source/seeker_data_source.dart';

@Injectable(as: SeekerRepository)
class SeekerRepoImpl implements SeekerRepository {
  final SeekerDataSource _dataSource;

  @factoryMethod
  SeekerRepoImpl(this._dataSource);

  @override
  Future<Result<List<Course>>> getNotRegisteredCourses() {
    return _dataSource.getNotRegisteredCourses();
  }

  @override
  Future<Result<List<JobPost>>> getNotAppliedJobPosts() {
    return _dataSource.getNotAppliedJobPosts();
  }

  @override
  Future<Result<num>?> showInsight(Map<String, String> data) {
    return _dataSource.showInsight(data);
  }

  @override
  Future<Result<JobDetailsModel>> getJobPostDetails(int jobId) {
    return _dataSource.getJobPostDetails(jobId);
  }

  @override
  Future<Result<List<OrgPost>>> getAllOrganizations() {
    return _dataSource.getAllOrganizations();
  }

  Future<Result<Course>> getCourseDetails(int courseId) {
    return _dataSource.getCourseDetails(courseId);
  }

  Future<Result<void>?> applyJob(
    num jobId,
    bool haveApplication,
    List<dynamic> answers,
  ) {
    return _dataSource.applyJob(jobId, haveApplication, answers);
  }
}
