import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/data/api/api_manger.dart';
import '../../domain/modules/course.dart';
import '../../domain/modules/job_details.dart';
import '../../domain/modules/job_post.dart';
import '../../domain/modules/org_post.dart';
import '../api/seeker_api.dart';
import '../data_source/seeker_data_source.dart';



@Injectable(as: SeekerDataSource)
class SeekerDataSourceImpl implements SeekerDataSource {
  final SeekerApi seekerApi;

  @factoryMethod
  SeekerDataSourceImpl(this.seekerApi);

  @override
  Future<Result<List<Course>>> getNotRegisteredCourses() async {
    return seekerApi.getNotRegisteredCourses();
  }
  @override
  Future<Result<List<JobPost>>> getNotAppliedJobPosts() async {
    return seekerApi.getNotAppliedJobPosts();
  }

  @override
  Future<Result<num>?> showInsight(Map<String, String> data) {
    return seekerApi.showInsight(data);
  }
  Future<Result<JobDetailsModel>> getJobPostDetails(int jobId){
    return seekerApi.getJobPostDetails(jobId);
  }
  Future<Result<List<OrgPost>>> getAllOrganizations() {
    return seekerApi.getAllOrganizations();
  }
  Future<Result<Course>> getCourseDetails(int courseId) {
    return seekerApi.getCourseDetails(courseId);
  }
}