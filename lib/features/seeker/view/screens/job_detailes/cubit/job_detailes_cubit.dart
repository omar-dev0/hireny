import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/result.dart';

import 'package:injectable/injectable.dart';

import '../../../../domain/modules/job_details.dart';
import '../../../../domain/repo_contract/seeker_repository.dart';
import 'job_detailes_state.dart';

@injectable
class JobDetailsCubit extends Cubit<JobDatailesState> {
  final SeekerRepository seekerRepository;

  JobDetailsCubit(this.seekerRepository) : super(InitJobDetailes());

  Future<void> fetchJobDetails(int jobId) async {
    emit(JobDetailsLoading());
    try {
      final result = await seekerRepository.getJobPostDetails(jobId);

      if (result is Success<JobDetailsModel>) {
        emit(JobDetailsLoaded(jobDetails: result.response));
      } else if (result is Error<JobDetailsModel>) {
        emit(JobDetailsError(message: result.error ?? "An error occurred"));
      }
    } catch (e) {
      emit(JobDetailsError(message: e.toString()));
    }
  }
}
