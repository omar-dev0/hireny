import 'package:injectable/injectable.dart';
import 'package:hireny/result.dart';
import 'package:hireny/features/org_assessment/data/api/assessment_api_manager.dart';
import 'package:hireny/features/org_assessment/data/data_source/assessment_data_source_interface.dart';

@Injectable(as: AssessmentDataSourceInterface)
class AssessmentDataSource implements AssessmentDataSourceInterface {
  final AssessmentApiManager apiManager;

  AssessmentDataSource(this.apiManager);

  @override
  Future<Result<void>> getAssessments() {
    return apiManager.getAssessments();
  }
}
