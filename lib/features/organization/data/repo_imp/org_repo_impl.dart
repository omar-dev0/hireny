import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/modules/organization.dart';
import '../../domain/modules/seeker.dart';
import '../../domain/modules/service.dart';
import '../../domain/repo_contract/org_repository.dart';
import '../data_source/org_data_source.dart';

@Injectable(as: OrgRepository)
class OrgRepoImpl implements OrgRepository {
  final OrgDataSource _dataSource;

  @factoryMethod
  OrgRepoImpl(this._dataSource);

  @override
  Future<Result<List<SeekerModel>>> getAllSeekers() {
    return _dataSource.getAllSeekers();
  }
  Future<Result<List<ServiceModel>>> getNotAppliedServicePosts() {
    return _dataSource.getNotAppliedServicePosts() ;
  }
  Future<Result<List<OrgPostOrg>>> getAllOrganizations() {
    return _dataSource.getAllOrganizations() ;
  }


}