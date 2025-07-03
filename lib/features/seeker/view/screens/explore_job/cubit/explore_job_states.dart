import '../../../../domain/modules/job_post.dart';

abstract class JobPostState {}

class JobPostInitial extends JobPostState {}

class JobPostLoading extends JobPostState {}

class JobPostLoaded extends JobPostState {
  final List<JobPost> jobPosts;

  JobPostLoaded({required this.jobPosts});
}

class JobPostError extends JobPostState {
  final String message;

  JobPostError({required this.message});
}
