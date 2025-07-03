import 'package:hireny/result.dart';

import '../../../auth/domain/modules/seeker/seeker.dart';
import '../../domain/modules/organization.dart';
import '../../domain/modules/seeker.dart';
import '../../domain/modules/service.dart';


abstract class OrgDataSource {
  Future<Result<List<SeekerModel>>> getAllSeekers();
  Future<Result<List<ServiceModel>>> getNotAppliedServicePosts();
  Future<Result<List<OrgPostOrg>>> getAllOrganizations();


}