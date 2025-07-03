import '../../domain/entities/org_entity.dart';
import '../models/org_response.dart';

abstract class OrgDataInterface {
  Future<List<OrgResponse>> getOrg();
  Future<OrgResponse> verifyOrg(OrgEntity orgData, bool orgState);
}
