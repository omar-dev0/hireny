import 'package:hireny/features/org_profile/domain/entities/org_post_entity.dart';

import '../entities/org_profile_entity.dart';
import '../entities/org_review_entity.dart';

abstract class OrgProfileRepo{
  Future<OrgProfileEntity> getOrg(int orgID);
  Future<List<OrgPostCardEntity>> getPosts(int orgID);
  Future<List<OrgReviewEntity>> getReviews(int orgID);
  Future<void> addReview(String userReview);
}