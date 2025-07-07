import 'package:hireny/result.dart';
import 'package:hireny/features/org_assessment/data/api/assessment_api_manager.dart';

import 'Assessment_data_source_interface.dart';

class AssessmentDataSourceImp extends AssessmentDataSource {
  final OrgAssessmentApi apiManager;
  AssessmentDataSourceImp(this.apiManager);

  @override
  Future<Result<void>> getAssessment() {
    return apiManager.getAssessments();
  }

}
