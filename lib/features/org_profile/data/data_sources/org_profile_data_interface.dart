import 'package:hireny/features/org_profile/domain/entities/org_post_entity.dart';
import 'package:hireny/features/org_profile/domain/entities/org_review_entity.dart';

import '../../domain/entities/org_profile_entity.dart';

abstract class OrgProfileDataInterface {
  Future<OrgProfileEntity> getProfile(int orgID);
  Future<void> addReview(String userReview);
  List<OrgPostCardEntity> getPosts();
  OrgPostCardEntity getPost(int postID);
  List<OrgReviewEntity> getReviews();
}
