import 'package:hireny/features/seeker/domain/modules/job_post.dart';

import '../../../../domain/modules/job_details.dart';

abstract class JobDatailesState {}

class InitJobDetailes extends JobDatailesState {}

class JobDetailsLoading extends JobDatailesState {}

class JobDetailsLoaded extends JobDatailesState {
  final JobDetailsModel? jobDetails;

  JobDetailsLoaded({ this.jobDetails});
}

class JobDetailsError extends JobDatailesState {
  final String message;

  JobDetailsError({required this.message});
}

class SubmitApplicationLoading extends JobDatailesState {}

class HideSubmitApplicationLoading extends JobDatailesState {}

class SubmitApplicationSuccess extends JobDatailesState {}

class SubmitApplicationError extends JobDatailesState {}

class LoadRelatedJobs extends JobDatailesState {}

class RelatedJobsLoaded extends JobDatailesState {
  final List<JobPost> relatedJobs;
  RelatedJobsLoaded({required this.relatedJobs});
}

class RelatedJobsError extends JobDatailesState {
  final String message;
  RelatedJobsError({required this.message});
}
