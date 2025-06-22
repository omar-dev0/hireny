import 'package:hireny/features/org_profile/domain/entities/org_post_entity.dart';
import 'package:hireny/features/org_profile/domain/entities/org_profile_entity.dart';
import 'package:hireny/features/org_profile/domain/entities/org_review_entity.dart';
import 'package:hireny/features/org_profile/domain/repositories/org_profile_repo.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/org_profile_data_interface.dart';

@Injectable(as: OrgProfileRepo)
class OrgProfileRepoImpl implements OrgProfileRepo {
  final OrgProfileDataInterface dataSource;

  OrgProfileRepoImpl(this.dataSource);

  @override
  Future<void> addReview(String userReview) async {
    await dataSource.addReview(userReview);
  }

  @override
  Future<OrgProfileEntity> getOrg(int orgID) async {
    return await dataSource.getProfile(orgID);
  }

  @override
  Future<List<OrgPostCardEntity>> getPosts(int orgID) async {
    return dataSource.getPosts();
  }

  @override
  Future<List<OrgReviewEntity>> getReviews(int orgID) async {
    return dataSource.getReviews();
  }
}
