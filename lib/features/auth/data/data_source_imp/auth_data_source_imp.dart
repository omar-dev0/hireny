import 'dart:io';

import 'package:hireny/features/auth/data/api/api_manger.dart';
import 'package:hireny/features/auth/data/data_source/auth_data_source.dart';
import 'package:hireny/features/auth/domain/modules/assessment/assessment.dart';
import 'package:hireny/features/auth/domain/modules/org/org_admin.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/features/auth/domain/modules/user/user.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthDataSource)
class DataSourcAuthImp implements AuthDataSource {
  ApiManger apiManger;
  @factoryMethod
  DataSourcAuthImp(this.apiManger);

  @override
  Future<Result<Seeker?>?> regSeeker(
    Seeker seeker,
    String password,
    File? cv,
  ) async {
    return await apiManger.regSeeker(seeker, password, cv);
  }

  @override
  Future<Result<OrgAdmin?>?> regOrg(
    OrgAdmin orgAdmin,
    String password,
    File? orgProf,
  ) {
    return apiManger.regOrg(orgAdmin, password, orgProf);
  }

  @override
  Future<Result<Map<String, dynamic>>?> login(String email, String password) {
    return apiManger.login(email, password);
  }

  @override
  Future<Result<User?>?> getUserInfo(String token)async {
    return apiManger.getUserInfo(token);
  }

  @override
  Future<Result<void>?> sendOtp(String email) {
    return apiManger.sendOtp(email);
  }

  @override
  Future<Result<void>?> verifyOtp(String email, String otp) {
    return apiManger.verifyOtp(email, otp);
  }

  @override
  Future<Result<void>?> resetPassword(String email, String newPassword) {
    return apiManger.resetPassword(email, newPassword);
  }

  @override
  Future<Result<void>> changePassword(
    String token,
    String oldPassword,
    String newPassword,
  ) {
    return apiManger.changePassword(token, oldPassword, newPassword);
  }

  @override
  Future<Result<AssessmentModel?>?> getAssessmentDetailes(int id) {
    return apiManger.getAssessmentDetailes(id);
  }

  @override
  Future<Result<void>> updateUserInfo(Seeker seeker) {
    return apiManger.updateUserInfo(seeker);
  }

  @override
  Future<Result<Seeker?>?> extractFromSeekerCV(File cv) {
    return apiManger.extractFromSeekerCV(cv);
  }

  @override
  Future<Result<List<AssessmentModel>?>?> getAssessments() {
    return apiManger.getAssessments();
  }

  @override
  Future<Result<void>?> submitAssessment(num id, List<dynamic> answers) {
    return apiManger.submitAssessment(id, answers);
  }
}
