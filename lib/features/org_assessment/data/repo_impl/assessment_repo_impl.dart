import 'package:hireny/features/org_assessment/data/data_source/Assessment_data_source_interface.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo/assessment_repo_interface.dart';
import '../data_source/assessment_data_source.dart';


@Injectable(as: AssessmentRepoInterface)

class AssessmentRepoImpl implements AssessmentRepoInterface {

  AssessmentDataSource dataSource;
  AssessmentRepoImpl(this.dataSource);

  @override
  Future<Result<void>> getAssessment() {
    return dataSource.getAssessments();
  }




}
