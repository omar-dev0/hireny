import 'dart:io';

import '../../../../result.dart';
import '../modules/assessment/assessment.dart';
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

  Future<Result<void>> updateUserInfo(Seeker seeker);

  Future<Result<void>?> sendOtp(String email);

  Future<Result<void>?> verifyOtp(String email, String otp);

  Future<Result<void>?> resetPassword(String email, String newPassword);
  Future<Result<AssessmentModel?>?> getAssessmentDetailes(int id);
  Future<Result<Seeker?>?> extractFromSeekerCV(File cv);

  Future<Result<List<AssessmentModel>?>?> getAssessments();
  Future<Result<void>?> submitAssessment(num id, List<dynamic> answers);
}
