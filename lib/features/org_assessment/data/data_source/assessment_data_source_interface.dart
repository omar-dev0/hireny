import 'package:hireny/result.dart';

abstract class AssessmentDataSourceInterface {

  Future<Result<void>> getAssessments();
}