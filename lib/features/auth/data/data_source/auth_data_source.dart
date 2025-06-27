import 'dart:io';

import 'package:hireny/features/auth/domain/modules/org/org_admin.dart';

import '../../../../result.dart';
import '../../domain/modules/seeker/seeker.dart';
import '../../domain/modules/user/user.dart';

abstract class AuthDataSource {
  Future<Result<Seeker?>?> regSeeker(Seeker seeker, String password, File? cv);

  Future<Result<OrgAdmin?>?> regOrg(OrgAdmin orgAdmin, String password, File? orgProf);

  Future<Result<Map<String, dynamic>>?> login(
      String email,
      String password,
      );

  Future<Result<User?>?> getUserInfo(String token);

  Future<Result<void>?> sendOtp(String email);
  Future<Result<void>?> verifyOtp(String email, String otp);
  Future<Result<void>?> resetPassword(String email, String newPassword);
  Future<Result<void>> changePassword(String token, String oldPassword, String newPassword);
}
