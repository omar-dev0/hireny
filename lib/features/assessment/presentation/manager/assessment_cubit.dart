import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/manage_org_account/reviews_tab/presentation/manager/review_states.dart';
import 'package:injectable/injectable.dart';

// @injectable
class AssessmentCubit extends Cubit<ReviewStates> {
  AssessmentCubit() : super(InitialState());

  int currentStep = 1;

  void goToNextStep(int totalSteps) {
    if (currentStep < totalSteps) {
      currentStep++;
      emit(StepChangedState(currentStep));
    }
  }

  void goToPrevStep() {
    if (currentStep > 1) {
      currentStep--;
      emit(StepChangedState(currentStep));
    }
  }
}
