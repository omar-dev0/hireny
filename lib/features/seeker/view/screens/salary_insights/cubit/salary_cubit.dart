import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/seeker/domain/repo_contract/seeker_repository.dart';
import 'package:hireny/features/seeker/view/screens/salary_insights/cubit/state/salary_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../result.dart';

@injectable
class SalaryCubit extends Cubit<SalaryState> {
  final SeekerRepository seekerRepository;

  @factoryMethod
  SalaryCubit(this.seekerRepository) : super(InitSalary());
  String? location;
  String? jobTitle;
  String? experience;

  Future<void> findGoodSalary() async {
    try {
      emit(LoadingSalary());
      final Result<num?>? result = await seekerRepository.showInsight({
        "Job": jobTitle!,
        "Country": location!,
        "Experience": experience!,
      });
      emit(HideDialogSalary());
      switch (result) {
        case null:
          {
            emit(FailSalary(error: 'some thing went wrong'));
          }
        case Success<num?>():
          emit(SuccessSalary(salary: result.response));
        case Error<num?>():
          emit(FailSalary(error: 'some thing went wrong'));
      }
    } catch (e) {
      emit(HideDialogSalary());
      emit(FailSalary(error: 'some thing went wrong'));
    }
  }

  bool checkValidation() {
    return (location != null && jobTitle != null && experience != null);
  }
}
