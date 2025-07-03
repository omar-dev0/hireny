import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';

import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/modules/organization.dart';
import '../../domain/modules/seeker.dart';
import '../../domain/modules/service.dart';
import '../api/org_api.dart';
import '../data_source/org_data_source.dart';


@Injectable(as: OrgDataSource)
class OrgDataSourceImpl implements OrgDataSource {
  final OrgApi orgApi;

  @factoryMethod
  OrgDataSourceImpl(this.orgApi);

  @override
  Future<Result<List<SeekerModel>>> getAllSeekers() {
    return orgApi.getAllSeekers();
  }
  Future<Result<List<ServiceModel>>> getNotAppliedServicePosts() {
    return orgApi.getNotAppliedServicePosts();
  }
  Future<Result<List<OrgPostOrg>>> getAllOrganizations() {
    return orgApi.getAllOrganizations();
  }

}