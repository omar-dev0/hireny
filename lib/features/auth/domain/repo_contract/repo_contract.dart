import 'dart:io';

import '../../../../result.dart';
import '../modules/org/org_admin.dart';
import '../modules/seeker/seeker.dart';
import '../modules/user/user.dart';

abstract class RepoAuth {
  Future<Result<Seeker?>?> regSeeker(Seeker seeker, String password , File? cv);

  Future<Result<OrgAdmin?>?> regOrg(OrgAdmin orgAdmin, String password, File? orgProf);

  Future<void> login(
      String email,
      String password,
      );

  Future<Result<User?>?> getUserInfo(String token);
}
