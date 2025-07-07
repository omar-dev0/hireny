import 'dart:io';

import 'package:hireny/features/auth/domain/modules/auto_fill/autofill_seeker.dart';

import '../../../../result.dart';
import '../modules/assessment/assessment.dart';
import '../modules/auto_fill/auto_fill_org_admin.dart';
import '../modules/org/org_admin.dart';
import '../modules/seeker/seeker.dart';
import '../modules/user/user.dart';

abstract class RepoAuth {
  Future<Result<Seeker?>?> regSeeker(Seeker seeker, String password, File? cv);

  Future<Result<OrgAdmin?>?> regOrg(
    OrgAdmin orgAdmin,
    String password,
    File? orgProf,
  );

  Future<Result<void>> login(String email, String password);

  Future<Result<User?>?> getUserInfo(String token);
  Future<Result<void>> changePassword(
    String token,
    String oldPassword,
    String newPassword,
  );

  Future<Result<void>> updateUserInfo(User seeker);

  Future<Result<void>?> sendOtp(String email);

  Future<Result<void>?> verifyOtp(String email, String otp);

  Future<Result<void>?> resetPassword(String email, String newPassword);
  Future<Result<AssessmentModel?>?> getAssessmentDetailes(int id);
  Future<Result<AutoFillSeeker?>?> extractFromSeekerCV(File cv);

  Future<Result<List<AssessmentModel>?>?> getAssessments();
  Future<Result<void>?> submitAssessment(num id, List<dynamic> answers);

  Future<Result<void>?> generateAndDownloadResume();
  Future<Result<void>?> generateAndDownloadCoverLetter(File file);
  Future<Result<List<String>?>?> recommendTitles();
  Future<Result<AutoFillOrg?>?> extractFromOrgProf(File cv);

}
