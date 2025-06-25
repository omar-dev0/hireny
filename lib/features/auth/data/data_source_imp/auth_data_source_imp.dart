import 'dart:io';

import 'package:hireny/features/auth/data/api/api_manger.dart';
import 'package:hireny/features/auth/data/data_source/auth_data_source.dart';
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
  Future<Result<OrgAdmin?>?> regOrg(OrgAdmin orgAdmin, String password, File? orgProf) {
    return apiManger.regOrg(orgAdmin, password, orgProf);
  }

  @override
  Future<Result<Map<String, dynamic>>?> login(String email, String password) {
    return apiManger.login(email, password);
  }

  @override
  Future<Result<User?>?> getUserInfo(String token) {
    return apiManger.getUserInfo(token);
  }

  @override
  Future<Result<void>> changePassword(String token, String oldPassword, String newPassword) {
    return apiManger.changePassword(token,oldPassword,newPassword);

  }


}
