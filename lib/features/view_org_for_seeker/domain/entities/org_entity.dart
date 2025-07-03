enum OrgStatus { pending, approved, rejected }

class OrgEntity {
  int orgID;
  String orgPresenterName;
  String orgEmail;
  String joinDate;
  OrgStatus status;

  OrgEntity({
    required this.orgID,
    required this.orgPresenterName,
    required this.orgEmail,
    required this.joinDate,
    required this.status,
  });
}
