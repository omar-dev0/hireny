import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/cubit/state/assissment_states.dart';
import 'package:hireny/features/seeker/domain/repo_contract/seeker_repository.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/application_deatailes/cubit/state/application_detailes_state.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplicationDeatailesCubit extends Cubit<ApplicationDetailesState> {
  @factoryMethod
  ApplicationDeatailesCubit(this.seekerRepository)
    : super(InitApplicationDetailesState());
  PageController pageController = PageController();
  final SeekerRepository seekerRepository;
  int currentPage = 0;
  int totalQuestions = 0;
  late List<dynamic> answaers;
  int? selectedAnswer;

  Future<void> applyJob(num jobId, bool haveApplication) async {
    try {
      emit(SubmitApplicationLoading());
      final result = await seekerRepository.applyJob(
        jobId,
        haveApplication,
        answaers,
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
}
