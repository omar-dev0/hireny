

import '../../../../result.dart';
import '../../../auth/domain/modules/seeker/seeker.dart';
import '../modules/organization.dart';
import '../modules/seeker.dart';
import '../modules/service.dart';

abstract class OrgRepository {
  Future<Result<List<SeekerModel>>> getAllSeekers();
  Future<Result<List<ServiceModel>>> getNotAppliedServicePosts();
  Future<Result<List<OrgPostOrg>>> getAllOrganizations();
}