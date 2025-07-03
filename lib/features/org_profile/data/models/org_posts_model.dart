import 'package:hireny/features/org_profile/domain/entities/org_post_entity.dart';

class OrgPostsModel extends OrgPostCardEntity {
  OrgPostsModel({
    required super.postID,
    required super.postTitle,
    required super.publishedTime,
    required super.jobType,
    required super.jobTime,
    required super.salary,
    required super.location,
  });
}
