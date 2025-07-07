import 'package:hireny/features/org_assessment/domain/repo/assessment_repo_interface.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAssessments {
  final AssessmentRepoInterface assessmentRepo;
  GetAssessments(this.assessmentRepo);

  Future<Result<void>> call()  {
    return  assessmentRepo.getAssessment();
  }

}
