import '../../domain/entities/org_entity.dart';

class OrgResponse extends OrgEntity {
  OrgResponse({
    required super.orgID,
    required super.orgPresenterName,
    required super.orgEmail,
    required super.joinDate,
    required super.status,
  });
}
