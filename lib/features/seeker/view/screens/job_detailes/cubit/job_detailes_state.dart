
import '../../../../domain/modules/job_details.dart';

abstract class JobDatailesState {}

class InitJobDetailes extends JobDatailesState {}

class JobDetailsLoading extends JobDatailesState {}

class JobDetailsLoaded extends JobDatailesState {
  final JobDetailsModel? jobDetails;

  JobDetailsLoaded({required this.jobDetails});
}

class JobDetailsError extends JobDatailesState {
  final String message;

  JobDetailsError({required this.message});

}