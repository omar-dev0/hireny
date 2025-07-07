import 'package:hireny/result.dart';

abstract class AssessmentRepoInterface{

  Future<Result<void>> getAssessment();

}