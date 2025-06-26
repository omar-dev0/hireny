
import 'package:hireny/features/seeker/domain/modules/job_post.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/modules/course.dart';
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
}