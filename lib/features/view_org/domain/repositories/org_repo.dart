import 'package:hireny/features/view_org/domain/entities/org_entity.dart';

abstract class OrgRepo{
  Future<OrgEntity>verifyOrg(OrgEntity org, bool orgState);
  Future<List<OrgEntity>>getOrg();


}