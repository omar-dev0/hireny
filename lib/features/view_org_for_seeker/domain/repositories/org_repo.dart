import '../entities/org_entity.dart';

abstract class OrgRepo{
  Future<OrgEntity>verifyOrg(OrgEntity org, bool orgState);
  Future<List<OrgEntity>>getOrg();


}