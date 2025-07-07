import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hireny/features/auth/data/data_source/auth_data_source.dart';
import 'package:hireny/features/auth/domain/modules/auto_fill/auto_fill_org_admin.dart';
import 'package:hireny/features/auth/domain/modules/org/org_admin.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/features/auth/domain/modules/user/user.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/result.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/data_shared/data_const.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../domain/modules/assessment/assessment.dart';
import '../../domain/modules/auto_fill/autofill_seeker.dart';

@Injectable(as: RepoAuth)
class RepoAuthImp implements RepoAuth {
  AuthDataSource dataSource;
  @factoryMethod
  RepoAuthImp(this.dataSource);

  @override
  Future<Result<Seeker?>?> regSeeker(
    Seeker seeker,
    String password,
    File? cv,
  ) async {
    return dataSource.regSeeker(seeker, password, cv);
  }

  @override
  Future<Result<OrgAdmin?>?> regOrg(
    OrgAdmin orgAdmin,
    String password,
    File? orgProf,
  ) {
    return dataSource.regOrg(orgAdmin, password, orgProf);
  }

  @override
  Future<Result<void>> login(String email, String password) async {
    try {
      var result = await dataSource.login(email, password);
      if (result is Success) {
        Success<Map<String, dynamic>> response =
            result as Success<Map<String, dynamic>>;
        String accessToken = response.response?['access'];
        String refreshToken = response.response?['refresh'];
        var userInfo = await getUserInfo(accessToken);
        if (userInfo is Success) {
          Success<User?> response = userInfo as Success<User?>;
          AppSharedData.user = response.response;
          print(AppSharedData.user?.firstName);

          AppSharedData.user?.accessToken = accessToken;
          AppSharedData.user?.refreshToken = refreshToken;
          if (AppSharedData.user is Seeker) {
            Seeker seeker = AppSharedData.user as Seeker;
            AppSharedData.rememberMe
                ? Hive.box(CashingData.appBox).put(CashingData.user, seeker)
                : null;
            return Success();
          } else if (AppSharedData.user is OrgAdmin) {
            OrgAdmin orgAdmin = AppSharedData.user as OrgAdmin;
            AppSharedData.rememberMe
                ? Hive.box(CashingData.appBox).put(CashingData.user, orgAdmin)
                : null;
            print(AppSharedData.user?.firstName);
            return Success();
          }
        }
      } else if (result is Error) {
        return Error(error: 'some thing went wrong');
      }
    } on DioException catch (e) {
      return Error(error: e.toString());
    } catch (e) {
      return Error(error: e.toString());
    }
    return Error(error: 'error');
  }

  @override
  Future<Result<User?>?> getUserInfo(String token) {
    return dataSource.getUserInfo(token);
  }

  @override
  Future<Result<void>> changePassword(
    String token,
    String oldPassword,
    String newPassword,
  ) {
    return dataSource.changePassword(token, oldPassword, newPassword);
  }

  @override
  Future<Result<void>> updateUserInfo(Seeker seeker) {
    return dataSource.updateUserInfo(seeker);
  }

  @override
  Future<Result<void>?> sendOtp(String email) {
    return dataSource.sendOtp(email);
  }

  @override
  Future<Result<void>?> verifyOtp(String email, String otp) {
    return dataSource.verifyOtp(email, otp);
  }

  @override
  Future<Result<void>?> resetPassword(String email, String newPassword) {
    return dataSource.resetPassword(email, newPassword);
  }

  @override
  Future<Result<AssessmentModel?>?> getAssessmentDetailes(int id) async {
    return dataSource.getAssessmentDetailes(id);
  }

  @override
  Future<Result<AutoFillSeeker?>?> extractFromSeekerCV(File cv) {
    return dataSource.extractFromSeekerCV(cv);
  }

  @override
  Future<Result<List<AssessmentModel>?>?> getAssessments() {
    return dataSource.getAssessments();
  }

  @override
  Future<Result<void>?> submitAssessment(num id, List<dynamic> answers) {
    return dataSource.submitAssessment(id, answers);
  }

  @override
  Future<Result<void>?> generateAndDownloadCoverLetter(File file) {
    return dataSource.generateAndDownloadCoverLetter(file);
  }

  @override
  Future<Result<void>?> generateAndDownloadResume() {
    return dataSource.generateAndDownloadResume();
  }

  @override
  Future<Result<List<String>?>?> recommendTitles() {
    return dataSource.recommendTitles();
  }

  @override
  Future<Result<AutoFillOrg?>?> extractFromOrgProf(File cv) {
    return dataSource.extractFromOrgProf(cv);
  }
}
