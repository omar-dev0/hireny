import 'package:hireny/result.dart';

abstract class AssessmentDataSource{
  Future<Result<void>> getAssessment();
}