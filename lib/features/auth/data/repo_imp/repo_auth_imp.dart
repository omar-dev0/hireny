import 'dart:io';

import 'package:hireny/features/auth/data/data_source/auth_data_source.dart';
import 'package:hireny/features/auth/domain/modules/org/org_admin.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/features/auth/domain/modules/user/user.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/result.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/data_shared/data_const.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

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
  Future<void> login(String email, String password) async {
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
        AppSharedData.user?.accessToken = accessToken;
        AppSharedData.user?.refreshToken = refreshToken;
        if (AppSharedData.user is Seeker) {
          Seeker seeker = AppSharedData.user as Seeker;
          AppSharedData.rememberMe
              ? Hive.box(CashingData.appBox).put(CashingData.user, seeker)
              : null;
        } else if (AppSharedData.user is OrgAdmin) {
          OrgAdmin orgAdmin = AppSharedData.user as OrgAdmin;
          AppSharedData.rememberMe
              ? Hive.box(CashingData.appBox).put(CashingData.user, orgAdmin)
              : null;
        }
      }
    }
  }

  @override
  Future<Result<User?>?> getUserInfo(String token) {
    return dataSource.getUserInfo(token);
  }
}
