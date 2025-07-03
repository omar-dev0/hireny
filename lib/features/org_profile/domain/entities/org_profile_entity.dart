import 'org_post_entity.dart';
import 'org_review_entity.dart';

class OrgProfileEntity {
  int orgID;
  String description;
  String ceoName;
  String foundedDate;
  int employeesNum;
  String industry;
  String location;
  List<OrgPostCardEntity> postCard;
  List<OrgReviewEntity> reviewCard;

  OrgProfileEntity({
    required this.orgID,
    required this.description,
    required this.ceoName,
    required this.foundedDate,
    required this.employeesNum,
    required this.industry,
    required this.location,
    required this.postCard,
    required this.reviewCard,
  });
}
