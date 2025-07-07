import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/seeker/domain/modules/job_post.dart';
import 'package:hireny/result.dart';

import 'package:injectable/injectable.dart';

import '../../../../domain/modules/job_details.dart';
import '../../../../domain/repo_contract/seeker_repository.dart';
import 'job_detailes_state.dart';

@injectable
class JobDetailsCubit extends Cubit<JobDatailesState> {
  List<JobPost> relatedJobs = [];
  late JobDetailsModel jobPost;
  final SeekerRepository seekerRepository;

  JobDetailsCubit(this.seekerRepository) : super(InitJobDetailes());

  Future<void> fetchJobDetails(int jobId) async {
    emit(JobDetailsLoading());
    try {
      final result = await seekerRepository.getJobPostDetails(jobId);

      if (result is Success<JobDetailsModel>) {
        jobPost = result.response!;
        emit(JobDetailsLoaded(jobDetails: result.response));
      } else if (result is Error<JobDetailsModel>) {
        emit(JobDetailsError(message: result.error ?? "An error occurred"));
      }
    } catch (e) {
      emit(JobDetailsError(message: e.toString()));
    }
  }

  Future<void> applyJob(num jobId, bool haveApplication) async {
    try {
      emit(SubmitApplicationLoading());
      final result = await seekerRepository.applyJob(
        jobId,
        haveApplication,
        [],
      );
      switch (result) {
        case null:
          {
            emit(HideSubmitApplicationLoading());
            emit(SubmitApplicationError());
          }
        case Success<void>():
          {
            emit(HideSubmitApplicationLoading());
            emit(SubmitApplicationSuccess());
          }
        case Error<void>():
          {
            emit(HideSubmitApplicationLoading());
            emit(SubmitApplicationError());
          }
      }
    } catch (e) {
      emit(HideSubmitApplicationLoading());
      emit(SubmitApplicationError());
    }
  }

  Future<void> getRelatedJobs(int jobId) async {
    try {
      emit(LoadRelatedJobs());
      final result = await seekerRepository.getRelatedJobs(jobId);
      switch (result) {
        case Success<List<JobPost>>():
          {
            relatedJobs = result.response ?? [];
            emit(JobDetailsLoaded());
          }
        case Error<List<JobPost>>():
          {
            emit(RelatedJobsError(message: result.error ?? ""));
          }
      }
    } catch (e) {
      emit(RelatedJobsError(message: e.toString()));
    }
  }
}
