import 'package:injectable/injectable.dart';

import '../../domain/entities/org_entity.dart';
import '../../domain/repositories/org_repo.dart';
import '../data_sources/org_data_interface.dart';

@Injectable(as: OrgRepo)
class OrgRepoImpl implements OrgRepo {
  final OrgDataInterface dataSource;

  OrgRepoImpl(this.dataSource);

  @override
  Future<List<OrgEntity>> getOrg() async {
    return await dataSource.getOrg();
  }

  @override
  Future<OrgEntity> verifyOrg(OrgEntity org, bool orgState) async {
    return await dataSource.verifyOrg(org, orgState);
  }
}
