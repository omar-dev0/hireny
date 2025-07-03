import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/cubit/state/assissment_states.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplicationDeatailesCubit extends Cubit<AssissmentState> {
  @factoryMethod
  ApplicationDeatailesCubit(this.repoAuth) : super(InitAssissment());
  PageController pageController = PageController();
  RepoAuth repoAuth;
  int currentPage = 0;
  int totalQuestions = 0;
  late List<dynamic> answaers;
  int? selectedAnswer;
  void nexQuestion(int totalQuestions) {
    print(answaers);
    if (pageController.page == totalQuestions - 1) return;
    if (answaers[pageController.page!.toInt()] == null ||
        (answaers[pageController.page!.toInt()] is String &&
            answaers[pageController.page!.toInt()].isEmpty)) {
      Fluttertoast.showToast(
        msg: "Please answer the question",
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }
    pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void prev() {
    print(answaers);
    if (pageController.page == 0) return;
    if (answaers[pageController.page!.toInt()] == null ||
        (answaers[pageController.page!.toInt()] is String &&
            answaers[pageController.page!.toInt()].isEmpty)) {
      Fluttertoast.showToast(
        msg: "Please answer the question",
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }
    pageController.previousPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void submitAssessment(num id) async {
    try {
      emit(LoadingSubmitAssessment());
      var res = await repoAuth.submitAssessment(id, answaers);
      switch (res) {
        case null:
          {
            emit(HideLoadingSubmitAssessment());
            emit(ErrorSubmitAssessment());
          }
        case Success<void>():
          {
            emit(HideLoadingSubmitAssessment());
            emit(SuccessSubmitAssessment());
          }
        case Error<void>():
          {
            emit(HideLoadingSubmitAssessment());
            emit(ErrorSubmitAssessment());
          }
      }
    } catch (e) {
      emit(HideLoadingSubmitAssessment());
      emit(ErrorSubmitAssessment());

    }
  }

  void onTimeFinished() {
    emit(OnTimeFinished());
  }
}
