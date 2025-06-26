import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../utils/data_shared/app_shared_data.dart';
import '../../../../domain/modules/job_post.dart';
import '../../../../domain/repo_contract/seeker_repository.dart';
import 'explore_job_states.dart';

@injectable
@injectable
class JobPostCubit extends Cubit<JobPostState> {
  final SeekerRepository jobPostRepository;

  JobPostCubit(this.jobPostRepository) : super(JobPostInitial());

  Future<void> fetchNotAppliedJobPosts() async {
    emit(JobPostLoading());
    try {
      final result = await jobPostRepository.getNotAppliedJobPosts();

      if (result is Success<List<JobPost>>) {
        AppSharedData.jobPosts = result.response ?? [];

        emit(JobPostLoaded(jobPosts: result.response ?? []));
      } else if (result is Error<List<JobPost>>) {
        emit(JobPostError(message: result.error ?? "An error occurred"));
      }
    } catch (e) {
      emit(JobPostError(message: e.toString()));
    }
  }

  void filterJobPosts(String query) {
    if (query.isEmpty) {
      emit(JobPostLoaded(jobPosts: AppSharedData.jobPosts));
      return;
    }

    final filteredList = AppSharedData.jobPosts
        .where((jobPost) =>
        jobPost.jobTitle.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(JobPostLoaded(jobPosts: filteredList));
  }
}